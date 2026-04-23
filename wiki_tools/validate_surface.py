"""
wiki_tools.validate_surface — CLI accuracy validator for Blackmon Lab wiki pages.

Usage:
    python -m wiki_tools.validate_surface <path>         # validate one file
    python -m wiki_tools.validate_surface --all          # validate all knowledge/ pages
    python -m wiki_tools.validate_surface --all --json   # machine-readable output

Exit code 0 if all files pass, 1 if any fail.
"""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

from wiki_tools.accuracy import digit_substring_ok, region_grammar_ok

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------

REPO_ROOT = Path(__file__).resolve().parent.parent

KNOWLEDGE_SUBDIRS = [
    "knowledge/topics",
    "knowledge/papers",
    "knowledge/concepts",
    "knowledge/methods",
    "knowledge/courses",
    "knowledge/projects",
    "knowledge/questions",
    "knowledge/paths",
    "knowledge/contradictions",
]

ALLOWLISTED_PATHS = KNOWLEDGE_SUBDIRS + ["AGENT_CONTRACT.md"]

# Inline citation: ([anything, Finding N](anything#finding-N))
INLINE_CITE_RE = re.compile(
    r'\[([^\]]*?),\s*Finding\s+(\d+)\]\(([^)]+?#finding-(\d+))\)'
)

# Footnote citation: <sup>[[n]](#cite-n)</sup>  where the anchor #cite-n is
# expected to resolve to a finding URL.  We capture the number.
FOOTNOTE_CITE_RE = re.compile(
    r'<sup>\[\[(\d+)\]\]\(#cite-\d+\)</sup>'
)

# Finding anchor: <a id="finding-N"></a>  followed by a blockquote
FINDING_ANCHOR_RE = re.compile(
    r'<a\s+id="finding-(\d+)"></a>.*?>\s*(.*?)(?=\n<a\s+id="finding-|\Z)',
    re.DOTALL,
)

# Blockquote lines
BLOCKQUOTE_LINE_RE = re.compile(r'^\s*>\s?(.*)$', re.MULTILINE)


# ---------------------------------------------------------------------------
# YAML front-matter parser (stdlib only)
# ---------------------------------------------------------------------------

def _parse_frontmatter(text: str) -> tuple[dict, str]:
    """Split YAML front-matter from body.  Returns (meta_dict, body_str).

    We parse only the scalar/list values we actually need:
      - editor_frozen (bool)
      - title (str)

    Falls back to an empty dict on any parse error.
    """
    if not text.startswith('---'):
        return {}, text

    end = text.find('\n---', 3)
    if end == -1:
        return {}, text

    yaml_block = text[3:end].strip()
    body = text[end + 4:].lstrip('\n')

    meta: dict = {}
    for line in yaml_block.splitlines():
        m = re.match(r'^(\w[\w_-]*):\s*(.*)', line)
        if not m:
            continue
        key, val = m.group(1), m.group(2).strip()
        # bool
        if val.lower() == 'true':
            meta[key] = True
        elif val.lower() == 'false':
            meta[key] = False
        else:
            # strip surrounding quotes
            val = val.strip('"\'')
            meta[key] = val

    return meta, body


# ---------------------------------------------------------------------------
# Finding extraction from paper pages
# ---------------------------------------------------------------------------

def _load_finding_quote(paper_slug: str, finding_num: str) -> str | None:
    """Load the verbatim blockquote for finding N from a paper page.

    The "quote" used for validation is the union of four sources within the
    finding block:
      1. The ``### Finding N — ...`` heading text (the summary line).
      2. The verbatim blockquote lines (``> ...``).
      3. The ``*Why this is citable:*`` paragraph that follows the blockquote.
      4. The ``*Counter / limitation:*`` paragraph, which often contains the
         precise numeric values that are cited as caveats in topic pages.

    All four are part of the finding's provenance and semantically describe
    what the finding says.  Including them reduces false failures when the
    blockquote is truncated but the number appears in the heading, the
    "Why citable" annotation, or the counter/limitation note.

    Returns the combined text string or None if the finding block is not found.
    """
    slug = paper_slug.replace('/', '_').replace('.', '_')
    candidate = REPO_ROOT / 'knowledge' / 'papers' / f'{slug}.md'
    if not candidate.exists():
        return None

    text = candidate.read_text(encoding='utf-8')
    # Find <a id="finding-N"></a> block
    anchor_re = re.compile(
        rf'<a\s+id="finding-{re.escape(finding_num)}"></a>(.*?)(?=\n<a\s+id="finding-\d+"|$)',
        re.DOTALL,
    )
    m = anchor_re.search(text)
    if not m:
        return None

    block = m.group(1)

    parts: list[str] = []

    # 1. Heading text: ### Finding N — <summary>
    heading_re = re.compile(r'###\s+Finding\s+\d+\s+[—–-]+\s+(.*?)(?:\n|$)')
    hm = heading_re.search(block)
    if hm:
        parts.append(hm.group(1).strip())

    # 2. Blockquote lines
    bq_lines = BLOCKQUOTE_LINE_RE.findall(block)
    if bq_lines:
        parts.append(' '.join(line.strip() for line in bq_lines if line.strip()))

    # 3. "Why this is citable" paragraph
    why_re = re.compile(
        r'\*Why(?:\s+this\s+is)?\s+citable[:\*]*\*?\s*(.*?)(?=\n\s*\n|\n\s*\*Counter|\n\s*\*Topics|\n<a\s+id=|$)',
        re.DOTALL | re.IGNORECASE,
    )
    wm = why_re.search(block)
    if wm:
        parts.append(re.sub(r'\s+', ' ', wm.group(1)).strip())

    # 4. "Counter / limitation" paragraph
    counter_re = re.compile(
        r'\*Counter\s*/\s*limitation[:\*]*\*?\s*(.*?)(?=\n\s*\n|\n\s*\*Topics|\n<a\s+id=|$)',
        re.DOTALL | re.IGNORECASE,
    )
    cm = counter_re.search(block)
    if cm:
        parts.append(re.sub(r'\s+', ' ', cm.group(1)).strip())

    if not parts:
        return None
    return ' '.join(parts)


def _extract_paper_slug_from_url(url: str) -> tuple[str, str] | None:
    """Given a citation URL like /knowledge/papers/10_1093_sysbio_syu131/#finding-1,
    return (slug, finding_num) or None.
    """
    m = re.search(r'/knowledge/papers/([^/]+)/#finding-(\d+)', url)
    if m:
        return m.group(1), m.group(2)
    return None


def _claim_segments_for_line(line: str, matches: list) -> list[str]:
    """Partition `line` so each citation in `matches` gets only its own claim
    segment (the prose from the previous match's end — or the line start — up
    through this match's end). Strips inline markdown links so DOIs / anchor
    ids in the citation itself don't leak into the numeric claim. Strips a
    leading "- " or "* " bullet prefix from the first segment only.

    Fixes multi-cite contamination: if two citations on the same line belong
    to different findings, each check now sees only its own supporting prose
    instead of the whole line.
    """
    segments: list[str] = []
    prev_end = 0
    for i, m in enumerate(matches):
        seg = line[prev_end:m.end()]
        # Remove the markdown link(s) in the segment — leaves only the prose
        # that led up to the citation.
        seg = re.sub(r'\[[^\]]*\]\([^)]*\)', '', seg)
        # Only the first segment can carry a leading bullet prefix.
        if i == 0:
            seg = re.sub(r'^\s*[-*]\s+', '', seg)
        segments.append(seg.strip())
        prev_end = m.end()
    return segments


# ---------------------------------------------------------------------------
# Per-file validation
# ---------------------------------------------------------------------------

def validate_file(path: Path, repo_root: Path = REPO_ROOT) -> dict:
    """Validate a single knowledge page.

    Returns a result dict with keys:
        file, frozen, region_ok, region_problems, claims, has_failure
    """
    rel = str(path.relative_to(repo_root))
    result: dict = {
        'file': rel,
        'frozen': False,
        'region_ok': True,
        'region_problems': [],
        'claims': [],
        'has_failure': False,
    }

    # Allowlist check
    in_allowlist = any(rel.startswith(p) for p in ALLOWLISTED_PATHS)
    if not in_allowlist:
        result['has_failure'] = True
        result['region_problems'] = [f'path not in allowlist: {rel}']
        return result

    try:
        raw = path.read_text(encoding='utf-8')
    except Exception as e:
        result['has_failure'] = True
        result['region_problems'] = [f'cannot read file: {e}']
        return result

    meta, body = _parse_frontmatter(raw)

    if meta.get('editor_frozen'):
        result['frozen'] = True
        return result

    # Region grammar
    ok, problems = region_grammar_ok(body)
    result['region_ok'] = ok
    result['region_problems'] = problems
    if not ok:
        result['has_failure'] = True

    # Claim extraction — inline citations
    lines = body.splitlines()
    claim_results = []

    for lineno, line in enumerate(lines, start=1):
        matches = list(INLINE_CITE_RE.finditer(line))
        if not matches:
            continue
        # Partition the line so each citation gets only the prose that
        # logically belongs to it (prev-match-end .. current-match-end).
        # Avoids multi-cite contamination where numerics from one finding's
        # prose get checked against another finding's quote.
        segments = _claim_segments_for_line(line, matches)
        for m, claim_text in zip(matches, segments):
            finding_url = m.group(3)
            finding_num = m.group(4)

            slug_info = _extract_paper_slug_from_url(finding_url)
            claim_entry = {
                'lineno': lineno,
                'claim': claim_text,
                'finding_num': finding_num,
                'paper_slug': slug_info[0] if slug_info else None,
                'quote': None,
                'result': None,
                'reason': None,
            }

            if slug_info:
                paper_slug, fn = slug_info
                quote = _load_finding_quote(paper_slug, fn)
                claim_entry['quote'] = quote
                if quote:
                    passes, reason = digit_substring_ok(claim_text, quote)
                    claim_entry['result'] = 'PASS' if passes else 'FAIL'
                    claim_entry['reason'] = reason
                    if not passes:
                        result['has_failure'] = True
                else:
                    claim_entry['result'] = 'SKIP'
                    claim_entry['reason'] = 'quote not found'
            else:
                claim_entry['result'] = 'SKIP'
                claim_entry['reason'] = 'could not resolve paper slug'

            claim_results.append(claim_entry)

    result['claims'] = claim_results
    return result


# ---------------------------------------------------------------------------
# Corpus discovery
# ---------------------------------------------------------------------------

def discover_files(repo_root: Path = REPO_ROOT) -> list[Path]:
    """Return all .md files in the knowledge subdirectories that exist."""
    files: list[Path] = []
    for subdir in KNOWLEDGE_SUBDIRS:
        d = repo_root / subdir
        if d.exists():
            files.extend(sorted(d.glob('*.md')))
    return files


# ---------------------------------------------------------------------------
# Output formatting
# ---------------------------------------------------------------------------

def format_human(results: list[dict]) -> str:
    lines: list[str] = []
    total_files = len(results)
    fail_count = 0
    frozen_count = 0
    fail_claim_count = 0

    for r in results:
        lines.append(r['file'])
        if r['frozen']:
            lines.append('  [editor_frozen: skipped]')
            frozen_count += 1
            continue

        if r['region_ok']:
            lines.append('  REGION GRAMMAR: OK')
        else:
            for prob in r['region_problems']:
                lines.append(f'  REGION GRAMMAR FAIL: {prob}')

        claims = r.get('claims', [])
        for i, c in enumerate(claims, 1):
            quote_snippet = (c['quote'] or '')[:60].replace('\n', ' ')
            if c['result'] == 'PASS':
                lines.append(
                    f"  CLAIM {i} at line {c['lineno']}: "
                    f"digit_substring_ok('{_abbrev(c['claim'], 40)}', "
                    f"'{quote_snippet}...'): PASS ({c['reason']})"
                )
            elif c['result'] == 'FAIL':
                lines.append(
                    f"  CLAIM {i} at line {c['lineno']}: "
                    f"digit_substring_ok('{_abbrev(c['claim'], 40)}', "
                    f"'{quote_snippet}...'): FAIL (claim has '{c['reason']}')"
                )
                fail_claim_count += 1
            else:
                lines.append(
                    f"  CLAIM {i} at line {c['lineno']}: SKIP ({c['reason']})"
                )

        if r['has_failure']:
            fail_count += 1

    active = total_files - frozen_count
    if fail_count == 0:
        summary = f"Summary: {active} files validated ({frozen_count} frozen/skipped), all pass."
    else:
        summary = (
            f"Summary: {active} files validated ({frozen_count} frozen/skipped), "
            f"{fail_count} file(s) had failures ({fail_claim_count} claim fail(s))."
        )
    lines.append('')
    lines.append(summary)
    return '\n'.join(lines)


def _abbrev(s: str, n: int) -> str:
    return s if len(s) <= n else s[:n - 1] + '…'


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

def main() -> int:
    parser = argparse.ArgumentParser(
        description='Validate Blackmon Lab wiki knowledge pages.'
    )
    parser.add_argument('path', nargs='?', help='Path to a single file to validate')
    parser.add_argument('--all', action='store_true', help='Validate entire knowledge/ corpus')
    parser.add_argument('--json', action='store_true', help='Output machine-readable JSON')
    args = parser.parse_args()

    if args.path and args.all:
        print('Error: specify either a path or --all, not both.', file=sys.stderr)
        return 1

    if not args.path and not args.all:
        parser.print_help()
        return 1

    if args.all:
        files = discover_files(REPO_ROOT)
    else:
        files = [Path(args.path).resolve()]

    results = [validate_file(f) for f in files]

    if args.json:
        print(json.dumps(results, indent=2))
    else:
        print(format_human(results))

    any_fail = any(r['has_failure'] for r in results)
    return 1 if any_fail else 0


if __name__ == '__main__':
    sys.exit(main())
