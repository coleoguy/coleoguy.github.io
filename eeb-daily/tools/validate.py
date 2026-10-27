#!/usr/bin/env python3
"""Validate a *new* EEB Daily issue without changing it or legacy issues.

The archive is context for numbering, dates and repetition checks, not input to
the new schema validator. Source-audit checks establish that evidence was
recorded; they do not establish that the evidence or scientific claims are true.
"""
import argparse
from datetime import date
from html import unescape
from html.parser import HTMLParser
import json
from pathlib import Path
import re
import sys
import unicodedata
from urllib.parse import parse_qsl, unquote, urlencode, urlsplit


DEFAULT_DATA = Path(__file__).resolve().parents[1] / "data"
WEEKDAYS = ("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
AUDIT_USES = {"lead", "person_1", "person_2", "slot2", "slot3"}
DOI_RE = re.compile(r"10\.\d{4,9}/[^\s<>\"]+", re.I)
TRACKING_PARAMS = {"fbclid", "gclid", "mc_cid", "mc_eid"}
# This small lexical allowlist runs before HTMLParser. Recent Python versions
# discard unfinished tags at EOF instead of passing them to handle_data, so
# parser callbacks alone cannot prove that interpolating the original is safe.
ALLOWED_TAG_TOKEN = re.compile(
    r'''(?:</?(?:em|sub|sup)\s*>|</a\s*>|<a\s+href\s*=\s*(?:"[^"<>]*"|'[^'<>]*')\s*>)''',
    re.IGNORECASE | re.ASCII,
)


def valid_url(value):
    """Only absolute HTTP(S) URLs without credentials or control characters."""
    if not isinstance(value, str) or not value or re.search(r"[\s\x00-\x1f\x7f\\]", value):
        return False
    try:
        parts = urlsplit(value)
        return (parts.scheme.lower() in {"http", "https"}
                and bool(parts.hostname) and parts.username is None
                and parts.password is None and (parts.port is None or 0 < parts.port < 65536))
    except ValueError:
        return False


def normalize_doi(value):
    if not isinstance(value, str):
        return ""
    value = unquote(unescape(value.strip()))
    value = re.sub(r"^(?:https?://(?:dx\.)?doi\.org/|doi:\s*)", "", value, flags=re.I)
    return value.casefold().rstrip("/") if DOI_RE.fullmatch(value) else ""


def normalize_url(value):
    """Collapse DOI resolver aliases and URL changes that do not identify a story."""
    if not valid_url(value):
        return ""
    parts = urlsplit(unescape(value))
    host = parts.hostname.lower().removeprefix("www.")
    if host in {"doi.org", "dx.doi.org"}:
        doi = normalize_doi(parts.path.lstrip("/"))
        if doi:
            return "doi:" + doi
    port = parts.port
    if port is not None and not ((parts.scheme.lower() == "http" and port == 80)
                                 or (parts.scheme.lower() == "https" and port == 443)):
        host += ":" + str(port)
    path = unquote(parts.path).rstrip("/")
    query = [(k, v) for k, v in parse_qsl(parts.query, keep_blank_values=True)
             if not k.lower().startswith("utm_") and k.lower() not in TRACKING_PARAMS]
    return host + path + ("?" + urlencode(sorted(query)) if query else "")


class InlineHTML(HTMLParser):
    """The renderer interpolates inline HTML, so reject anything not explicitly allowed."""
    def __init__(self):
        # Keep harmless escaped angle brackets distinct from raw markup.
        super().__init__(convert_charrefs=False)
        self.problems = []
        self.stack = []
        self.text = []
        self.links = []

    def handle_starttag(self, tag, attrs):
        if tag not in {"em", "sub", "sup", "a"}:
            self.problems.append("unsupported HTML tag <" + tag + ">")
            return
        if tag == "a":
            if len(attrs) != 1 or attrs[0][0] != "href" or not valid_url(attrs[0][1]):
                self.problems.append("links must have exactly one safe HTTP(S) href")
            else:
                self.links.append(attrs[0][1])
            if "a" in self.stack:
                self.problems.append("nested links are not allowed")
        elif attrs:
            self.problems.append("HTML attributes are only allowed for link hrefs")
        self.stack.append(tag)

    def handle_endtag(self, tag):
        if not self.stack or self.stack[-1] != tag:
            self.problems.append("unbalanced HTML closing tag </" + tag + ">")
        else:
            self.stack.pop()

    def handle_startendtag(self, tag, attrs):
        self.problems.append("self-closing HTML tags are not allowed")

    def handle_data(self, data):
        if "<" in data:
            self.problems.append("raw '<' outside a complete allowed HTML tag; use &lt; for text")
        self.text.append(data)

    def handle_entityref(self, name):
        self.text.append(unescape("&" + name + ";"))

    def handle_charref(self, name):
        self.text.append(unescape("&#" + name + ";"))

    def handle_comment(self, data):
        self.problems.append("HTML comments are not allowed")

    def handle_decl(self, decl):
        self.problems.append("HTML declarations are not allowed")

    def handle_pi(self, data):
        self.problems.append("HTML processing instructions are not allowed")

    def unknown_decl(self, data):
        self.problems.append("HTML declarations are not allowed")


def parse_inline(value):
    parser = InlineHTML()
    if "<" in ALLOWED_TAG_TOKEN.sub("", value):
        parser.problems.append("raw '<' outside a complete allowed HTML tag; use &lt; for text")
    try:
        parser.feed(value)
        parser.close()
    except (ValueError, AssertionError):
        parser.problems.append("malformed HTML")
    if parser.stack:
        parser.problems.append("unclosed HTML tags")
    return parser


def word_count(value):
    return len("".join(parse_inline(value).text).split()) if isinstance(value, str) else 0


def normalized_text(value):
    if not isinstance(value, str):
        return ""
    return " ".join(re.findall(r"\w+", unicodedata.normalize("NFKC", unescape(value)).casefold()))


def story_ids(story):
    """Collect identities from both canonical URLs and inline citation links."""
    if not isinstance(story, dict):
        return set()
    result = set()
    doi = normalize_doi(story.get("doi"))
    if doi:
        result.add("doi:" + doi)
    url = normalize_url(story.get("url"))
    if url:
        result.add(url)
    cite = story.get("cite")
    if isinstance(cite, str):
        result.update(filter(None, (normalize_url(url) for url in parse_inline(cite).links)))
    return result


def validate_record(record, existing, expected_date=None):
    """Return human-readable errors for one candidate; never mutate arguments."""
    errors = []
    if not isinstance(record, dict):
        return ["record must be a JSON object"]
    if not isinstance(existing, (list, tuple)) or any(not isinstance(r, dict) for r in existing):
        return ["archive context must be a list of issue objects"]

    def text(obj, key, where, required=True):
        value = obj.get(key)
        if value is None and not required:
            return ""
        if not isinstance(value, str) or not value.strip():
            errors.append(f"{where}.{key} must be a nonempty string")
            return ""
        return value

    def url(obj, key, where):
        value = text(obj, key, where)
        if value and not valid_url(value):
            errors.append(f"{where}.{key} must be an absolute HTTP(S) URL without credentials")
        return value

    def count(value, low, high, where):
        n = word_count(value)
        if not low <= n <= high:
            errors.append(f"{where} has {n} words; expected {low}-{high}")

    def inspect_strings(value, where="record"):
        if isinstance(value, str):
            if len(value) > 20000:
                errors.append(f"{where} is too long (maximum 20,000 characters)")
                return
            if "\u2014" in unescape(value):
                errors.append(f"{where} contains an em dash")
            for problem in parse_inline(value).problems:
                errors.append(f"{where}: {problem}")
        elif isinstance(value, dict):
            for key, item in value.items():
                inspect_strings(item, f"{where}.{key}")
        elif isinstance(value, list):
            for index, item in enumerate(value):
                inspect_strings(item, f"{where}[{index}]")

    inspect_strings(record)
    issue_no = record.get("no")
    prior_numbers = [r["no"] for r in existing if type(r.get("no")) is int]
    next_no = max(prior_numbers, default=0) + 1
    if type(issue_no) is not int or issue_no < 1:
        errors.append("record.no must be a positive integer")
    elif issue_no != next_no:
        errors.append(f"record.no must be the next issue number ({next_no})")

    issue_date = None
    raw_date = text(record, "date", "record")
    if re.fullmatch(r"\d{4}-\d{2}-\d{2}", raw_date):
        try:
            issue_date = date.fromisoformat(raw_date)
        except ValueError:
            pass
    if issue_date is None:
        errors.append("record.date must be a real calendar date in YYYY-MM-DD format")
    if expected_date is not None and raw_date != expected_date:
        errors.append(f"record.date must match the expected date ({expected_date})")
    prior_dates = [r["date"] for r in existing if isinstance(r.get("date"), str)]
    if raw_date in prior_dates:
        errors.append("record.date already exists in the archive")
    elif issue_date and prior_dates and raw_date <= max(prior_dates):
        errors.append("record.date must be later than the latest archived date")
    weekday = text(record, "weekday", "record")
    if issue_date and weekday != WEEKDAYS[issue_date.weekday()]:
        errors.append("record.weekday does not match record.date")
    text(record, "tomorrow", "record")
    for key in ("producer", "motto"):
        if key in record:
            text(record, key, "record")

    stories = {}
    for key in ("lead", "slot2", "slot3"):
        value = record.get(key)
        if not isinstance(value, dict):
            errors.append(f"record.{key} must be an object")
            value = {}
        stories[key] = value
        text(value, "headline", key)
        url(value, "url", key)
        for optional in ("topic", "kicker"):
            if optional in value:
                text(value, optional, key)
        if key != "lead" and "doi" in value:
            optional_doi = text(value, "doi", key)
            if optional_doi and not DOI_RE.fullmatch(optional_doi):
                errors.append(f"{key}.doi must be a bare DOI (10.xxxx/...), without a resolver URL")
            normalized_url = normalize_url(value.get("url"))
            if optional_doi and normalized_url.startswith("doi:"):
                if normalized_url != "doi:" + normalize_doi(optional_doi):
                    errors.append(f"{key}.doi does not match its DOI URL")

    lead = stories["lead"]
    for key in ("topic", "deck", "authors", "journal", "pubdate"):
        text(lead, key, "lead")
    doi = text(lead, "doi", "lead")
    if doi and not DOI_RE.fullmatch(doi):
        errors.append("lead.doi must be a bare DOI (10.xxxx/...), without a resolver URL")
    if doi and normalize_url(lead.get("url")).startswith("doi:"):
        if normalize_url(lead.get("url")) != "doi:" + normalize_doi(doi):
            errors.append("lead.doi does not match its DOI URL")
    paragraphs = lead.get("paragraphs")
    if (not isinstance(paragraphs, list) or len(paragraphs) != 2
            or any(not isinstance(p, str) or not p.strip() for p in paragraphs)):
        errors.append("lead.paragraphs must contain exactly two nonempty strings")
    else:
        count(" ".join(paragraphs), 170, 210, "lead.paragraphs")
    count(text(lead, "push", "lead"), 45, 60, "lead.push")

    recent = sorted(existing, key=lambda r: r.get("no", 0) if type(r.get("no")) is int else 0)
    recent_topics = {normalized_text(r.get("lead", {}).get("topic")) for r in recent[-2:]
                     if isinstance(r.get("lead"), dict)}
    if normalized_text(lead.get("topic")) and normalized_text(lead.get("topic")) in recent_topics:
        errors.append("lead.topic repeats one of the previous two issues")

    people = record.get("people")
    if not isinstance(people, list) or len(people) != 2:
        errors.append("record.people must contain first and last author objects")
        people = []
    for index, person in enumerate(people):
        where = f"people[{index}]"
        if not isinstance(person, dict):
            errors.append(where + " must be an object")
            continue
        if person.get("role") != ("First author" if index == 0 else "Last author"):
            errors.append(where + ".role must identify the first/last author in order")
        text(person, "name", where)
        count(text(person, "bio", where), 10, 90, where + ".bio")
        links = person.get("links")
        if not isinstance(links, list) or not links:
            errors.append(where + ".links must include at least one public professional source")
            links = []
        for j, link in enumerate(links):
            location = f"{where}.links[{j}]"
            if not isinstance(link, dict):
                errors.append(location + " must be an object")
            else:
                text(link, "label", location)
                url(link, "url", location)

    s2, s3 = stories["slot2"], stories["slot3"]
    for key, slot in (("slot2", s2), ("slot3", s3)):
        citation = text(slot, "cite", key)
        if citation and not parse_inline(citation).links:
            errors.append(key + ".cite must include a source link")
        text(slot, "body", key)
    kind2 = s2.get("kind") if isinstance(s2.get("kind"), str) else ""
    if kind2 not in {"CLASSIC", "BEYOND"}:
        errors.append("slot2.kind must be CLASSIC or BEYOND")
    if issue_date:
        expected_kind = "CLASSIC" if issue_date.weekday() in (1, 5) else "BEYOND"
        if kind2 != expected_kind:
            errors.append(f"slot2.kind must be {expected_kind} for this date")
    count(s2.get("body"), 85, 110, "slot2.body")
    kind = s3.get("kind") if isinstance(s3.get("kind"), str) else ""
    if kind not in {"SCIENCE", "HISTORY", "ACADEMIA"}:
        errors.append("slot3.kind must be SCIENCE, HISTORY, or ACADEMIA")
    if issue_date and ((issue_date.weekday() == 4) != (kind == "HISTORY")):
        errors.append("slot3 must be HISTORY on Friday and only on Friday")
    low, high = {"HISTORY": (100, 130), "ACADEMIA": (70, 90)}.get(kind, (85, 110))
    count(s3.get("body"), low, high, "slot3.body")
    if kind == "ACADEMIA":
        count(text(s3, "why", "slot3"), 30, 45, "slot3.why")
        if any(isinstance(r.get("slot3"), dict) and r["slot3"].get("kind") == "ACADEMIA"
               for r in recent[-6:]):
            errors.append("ACADEMIA already appeared in the previous six issues")
    elif "why" in s3:
        errors.append("slot3.why is only permitted for ACADEMIA")
    if kind == "HISTORY":
        subject = normalized_text(text(s3, "history_subject", "slot3"))
        if subject and any(isinstance(r.get("slot3"), dict)
                           and normalized_text(r["slot3"].get("history_subject")) == subject
                           for r in existing):
            errors.append("slot3.history_subject already appears in the archive")
    elif "history_subject" in s3:
        errors.append("slot3.history_subject is only permitted for HISTORY")

    archived_ids = set()
    for old in existing:
        for key in ("lead", "slot2", "slot3"):
            archived_ids.update(story_ids(old.get(key)))
    current_ids = set()
    for key, story in stories.items():
        ids = story_ids(story)
        if ids & archived_ids:
            errors.append(key + " repeats a paper or story URL/DOI in the archive")
        if ids & current_ids:
            errors.append(key + " repeats a paper or story from another slot in this issue")
        current_ids.update(ids)

    audit = record.get("source_audit")
    if not isinstance(audit, list) or not audit:
        errors.append("record.source_audit must record the sources actually checked")
        audit = []
    covered = set()
    for index, source in enumerate(audit):
        where = f"source_audit[{index}]"
        if not isinstance(source, dict):
            errors.append(where + " must be an object")
            continue
        url(source, "url", where)
        text(source, "title", where)
        text(source, "evidence", where)
        use = source.get("used_for")
        if not isinstance(use, str) or use not in AUDIT_USES:
            errors.append(where + ".used_for must be lead, person_1, person_2, slot2, or slot3")
        else:
            covered.add(use)
    missing = AUDIT_USES - covered
    if missing:
        errors.append("source_audit is missing evidence for: " + ", ".join(sorted(missing)))
    return errors


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("file", type=Path)
    parser.add_argument("--data-dir", type=Path, default=DEFAULT_DATA)
    parser.add_argument("--expected-date")
    args = parser.parse_args(argv)
    try:
        if args.file.stat().st_size > 512000:
            raise ValueError("candidate exceeds 512 KB")
        record = json.loads(args.file.read_text(encoding="utf-8"))
        if not args.data_dir.is_dir():
            raise ValueError("archive directory does not exist: " + str(args.data_dir))
        existing = [json.loads(path.read_text(encoding="utf-8"))
                    for path in sorted(args.data_dir.glob("*.json"))]
        errors = validate_record(record, existing, args.expected_date)
    except (OSError, ValueError, RecursionError) as exc:
        errors = [str(exc)]
    print(json.dumps({"valid": not errors, "errors": errors}, ensure_ascii=False))
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
