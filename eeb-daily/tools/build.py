#!/usr/bin/env python3
"""Build the EEB Daily web edition from the JSON issue records in eeb-daily/data/.

Why a build script: the nightly task writes one structured JSON record per issue
and runs this script. Layout, archive index, feed and the latest-issue page are
all derived here, so the unattended run never hand-edits HTML.

Outputs (all under eeb-daily/):
  index.html                 latest issue (stable URL, QR target)
  issues/YYYY-MM-DD.html     one page per issue (a repeated date gets a -b, -c suffix)
  archive/index.html         every issue, newest first
  feed.xml                   RSS 2.0, newest 30 issues
  manifest.json              compact archive context for the cloud editor
Usage: python3 eeb-daily/tools/build.py   (run from the repo root or anywhere)
"""
import glob
import html
import json
import os
import re
from datetime import datetime, timezone
from email.utils import format_datetime
from zoneinfo import ZoneInfo

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))   # .../eeb-daily
SITE = "https://coleoguy.github.io/eeb-daily"
DATA = os.path.join(ROOT, "data")
ISSUES_DIR = os.path.join(ROOT, "issues")
ARCHIVE_DIR = os.path.join(ROOT, "archive")

KIND_KICKER = {
    # slot 2
    "BEYOND": "Beyond EEB", "CLASSIC": "Classic", "FIELDNOTES": "Field notes", "FARAFIELD": "Far afield",
    # slot 3
    "SCIENCE": "Beyond biology", "HISTORY": "History", "ACADEMIA": "The wider campus", "PAPER": "Far afield",
}


def load_issues():
    issues = []
    for path in sorted(glob.glob(os.path.join(DATA, "*.json"))):
        with open(path, encoding="utf-8") as fh:
            rec = json.load(fh)
        rec["_file"] = os.path.basename(path)
        issues.append(rec)
    issues.sort(key=lambda r: (r["no"], r["date"]))
    # Page file names: date, with -b/-c for a repeated date (two issues carried 2026-10-21).
    seen = {}
    for rec in issues:
        n = seen.get(rec["date"], 0)
        rec["slug"] = rec["date"] + ("" if n == 0 else "-" + "bcdefg"[n - 1])
        seen[rec["date"]] = n + 1
    return issues


def esc(s):
    return html.escape(s or "", quote=True)


def strip_tags(s):
    return re.sub(r"<[^>]+>", "", s or "")


def long_date(date_str):
    d = datetime.strptime(date_str, "%Y-%m-%d")
    return d.strftime("%A, %B ") + str(d.day) + d.strftime(", %Y")


def kicker_for(slot, fallback_kind):
    return slot.get("kicker") or KIND_KICKER.get(slot.get("kind", fallback_kind), fallback_kind.title())


CSS = r"""
:root {
  --paper: #FBFAF7; --raised: #FFFFFF; --ink: #141414; --ink-2: #4E4E4E; --ink-3: #7A7A76;
  --rule: #141414; --hair: #CFCDC6; --accent: #7A1F1F; --tint: #F1EDE6; --link: #7A1F1F;
  --display: "Newsreader", "Iowan Old Style", "Times New Roman", serif;
  --body: "Newsreader", Georgia, serif;
  --label: "Archivo Narrow", "Arial Narrow", "Helvetica Neue", Arial, sans-serif;
  color-scheme: light;
}
@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) {
    --paper: #15161A; --raised: #1C1D22; --ink: #ECE9E2; --ink-2: #B9B5AC; --ink-3: #8B877F;
    --rule: #ECE9E2; --hair: #3A3B41; --accent: #E0837E; --tint: #23242A; --link: #E0837E; color-scheme: dark;
  }
}
:root[data-theme="dark"] {
  --paper: #15161A; --raised: #1C1D22; --ink: #ECE9E2; --ink-2: #B9B5AC; --ink-3: #8B877F;
  --rule: #ECE9E2; --hair: #3A3B41; --accent: #E0837E; --tint: #23242A; --link: #E0837E; color-scheme: dark;
}
* { box-sizing: border-box; }
html { -webkit-text-size-adjust: 100%; }
body { margin: 0; background: var(--paper); color: var(--ink); font-family: var(--body); font-size: 17.5px; line-height: 1.5;
       padding: 0 max(18px, env(safe-area-inset-left)) max(28px, env(safe-area-inset-bottom)) max(18px, env(safe-area-inset-right)); }
a { color: var(--link); text-decoration: none; }
a:hover, a:focus-visible { text-decoration: underline; text-underline-offset: 2px; }
a:focus-visible { outline: 2px solid var(--accent); outline-offset: 2px; }
p { margin: 0 0 0.85em; }
em { font-style: italic; }
sub { font-size: 0.7em; }
.wrap { max-width: 560px; margin: 0 auto; }

/* Nameplate */
.nameplate { text-align: center; border-top: 4px solid var(--rule); border-bottom: 1px solid var(--rule); padding: 14px 0 10px; margin-top: 14px; }
.nameplate h1 { font-family: var(--display); font-weight: 800; font-size: clamp(2.6rem, 12vw, 3.6rem); line-height: 0.95; letter-spacing: -0.015em; margin: 0; font-variation-settings: "opsz" 72; }
.nameplate h1 a { color: inherit; text-decoration: none; }
.ears { display: flex; justify-content: center; flex-wrap: wrap; gap: 4px 14px; margin-top: 8px;
        font-family: var(--label); font-size: 0.74rem; text-transform: uppercase; letter-spacing: 0.1em; color: var(--ink-2); }
.dateline { border-bottom: 3px solid var(--rule); padding: 6px 0 7px; margin-bottom: 22px; text-align: center;
            font-family: var(--display); font-style: italic; font-size: 0.95rem; color: var(--ink-2); text-wrap: balance; }

/* Stories */
.kicker { font-family: var(--label); font-weight: 700; font-size: 0.74rem; text-transform: uppercase; letter-spacing: 0.14em; color: var(--accent); margin: 0 0 6px; }
.kicker .topic { color: var(--ink-2); font-weight: 500; }
h2 { font-family: var(--display); font-weight: 600; font-size: clamp(1.7rem, 7vw, 2.1rem); line-height: 1.1; margin: 0 0 10px; letter-spacing: -0.01em; text-wrap: balance; font-variation-settings: "opsz" 48; }
.deck { font-family: var(--display); font-style: italic; font-size: 1.15rem; line-height: 1.35; color: var(--ink-2); margin: 0 0 12px; text-wrap: pretty; }
.byline { font-family: var(--label); font-size: 0.82rem; letter-spacing: 0.02em; color: var(--ink-2); border-top: 1px solid var(--hair); border-bottom: 1px solid var(--hair); padding: 7px 0; margin: 0 0 16px; line-height: 1.45; }
.byline b { color: var(--ink); font-weight: 600; }
.byline .sep { color: var(--ink-3); padding: 0 6px; }
.text p:first-of-type::first-letter { font-family: var(--display); font-weight: 700; font-size: 3.1em; float: left; line-height: 0.8; padding: 0.08em 0.1em 0 0; }
.pushbox { background: var(--tint); padding: 12px 14px; margin: 6px 0 18px; border-radius: 3px; font-size: 1rem; line-height: 1.45; }
.pushbox .lab, .why .lab { font-family: var(--label); font-weight: 700; text-transform: uppercase; letter-spacing: 0.12em; font-size: 0.7rem; color: var(--accent); display: block; margin-bottom: 3px; }

.side { border-top: 1px solid var(--rule); padding-top: 10px; }
.side .kicker { color: var(--ink); }
.author { padding: 6px 0 10px; }
.author + .author { border-top: 1px solid var(--hair); padding-top: 12px; }
.author .role { font-family: var(--label); font-size: 0.7rem; letter-spacing: 0.1em; text-transform: uppercase; color: var(--ink-2); }
.author .name { font-family: var(--display); font-weight: 700; font-size: 1.2rem; line-height: 1.2; margin: 2px 0 5px; }
.author p { font-size: 1rem; line-height: 1.45; margin: 0; }
.links { font-family: var(--label); font-size: 0.82rem; letter-spacing: 0.02em; }
.links a { color: var(--link); }

.fold { border-top: 3px double var(--rule); margin: 26px 0 22px; }
.story { margin-bottom: 26px; }
.story + .story { border-top: 1px solid var(--hair); padding-top: 22px; }
.story h3 { font-family: var(--display); font-weight: 600; font-size: 1.45rem; line-height: 1.15; margin: 0 0 8px; letter-spacing: -0.005em; text-wrap: balance; font-variation-settings: "opsz" 36; }
.story .cite { font-family: var(--label); font-size: 0.82rem; color: var(--ink-2); margin: 0 0 10px; letter-spacing: 0.02em; line-height: 1.45; overflow-wrap: anywhere; }
.story .body { font-size: 1.05rem; }
.why { border-top: 1px solid var(--hair); padding-top: 8px; margin-top: 10px; font-size: 1rem; line-height: 1.45; }

/* Footer */
.colophon { border-top: 1px solid var(--rule); margin-top: 24px; padding-top: 12px; font-family: var(--label); font-size: 0.76rem; letter-spacing: 0.04em; color: var(--ink-2); text-transform: uppercase; line-height: 1.7; }
.colophon .nav { display: flex; justify-content: space-between; flex-wrap: wrap; gap: 6px 16px; margin-bottom: 8px; font-size: 0.82rem; }
.colophon .nav a { color: var(--link); }
.colophon .tiny { text-transform: none; letter-spacing: 0; font-size: 0.74rem; color: var(--ink-3); margin-top: 10px; }
.colophon .tiny a { color: var(--ink-3); text-decoration: underline; text-underline-offset: 2px; }

/* Archive */
.archive h2 { font-size: 1.6rem; margin: 0 0 18px; }
.archive ol { list-style: none; padding: 0; margin: 0; }
.archive li { border-top: 1px solid var(--hair); padding: 14px 0; }
.archive li:last-child { border-bottom: 1px solid var(--hair); }
.archive .meta { font-family: var(--label); font-size: 0.74rem; text-transform: uppercase; letter-spacing: 0.1em; color: var(--ink-2); margin-bottom: 3px; }
.archive .meta .num { color: var(--accent); font-weight: 700; }
.archive .hl { font-family: var(--display); font-weight: 600; font-size: 1.2rem; line-height: 1.2; display: block; color: var(--ink); }
.archive .hl:hover { color: var(--accent); }
.archive .also { font-size: 0.92rem; color: var(--ink-2); margin: 5px 0 0; line-height: 1.4; }
.archive .also b { font-family: var(--label); font-weight: 700; font-size: 0.72rem; text-transform: uppercase; letter-spacing: 0.1em; color: var(--ink-3); margin-right: 4px; }

/* Guide page */
.guide h2 { font-size: 1.45rem; margin: 28px 0 10px; }
.guide p, .guide li { font-size: 1.02rem; line-height: 1.5; }
.guide ol, .guide ul { padding-left: 1.3em; margin: 0 0 1em; }
.guide li { margin-bottom: 0.5em; }
.guide code { font-family: ui-monospace, "JetBrains Mono", Menlo, monospace; font-size: 0.86em; background: var(--tint); padding: 1px 5px; border-radius: 3px; }
.guide pre { font-family: ui-monospace, "JetBrains Mono", Menlo, monospace; font-size: 0.78rem; line-height: 1.5; background: var(--tint); padding: 14px; border-radius: 4px; overflow-x: auto; white-space: pre; margin: 0 0 1em; }
.guide .files { font-family: var(--label); font-size: 0.92rem; }

@media print {
  @page { size: letter; margin: 0.6in; }
  body { background: #fff; color: #000; font-size: 11pt; padding: 0; }
  .wrap { max-width: none; }
  .nameplate { margin-top: 0; }
  .colophon .nav, .colophon .tiny { display: none; }
  a { color: inherit; }
  .story, .author, .pushbox { break-inside: avoid; }
}
"""

HEAD = """<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>{title}</title>
<meta name="description" content="{description}">
<meta property="og:title" content="{title}">
<meta property="og:description" content="{description}">
<meta property="og:type" content="article">
<meta property="og:site_name" content="EEB Daily">
<link rel="canonical" href="{canonical}">
<link rel="alternate" type="application/rss+xml" title="EEB Daily" href="{site}/feed.xml">
<link rel="icon" href="/assets/img/favicon.ico">
<meta name="theme-color" content="#FBFAF7" media="(prefers-color-scheme: light)">
<meta name="theme-color" content="#15161A" media="(prefers-color-scheme: dark)">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Newsreader:ital,opsz,wght@0,6..72,400;0,6..72,500;0,6..72,600;0,6..72,700;0,6..72,800;1,6..72,400;1,6..72,500&family=Archivo+Narrow:wght@400;500;600;700&display=swap">
<style>{css}</style>
</head>
<body>
<div class="wrap">
"""

FOOT = """</div>
</body>
</html>
"""


def nameplate(rec, base, is_latest):
    ears = f'<span>Vol. 1, No. {rec["no"]}</span><span>{esc(rec.get("weekday") or long_date(rec["date"]).split(",")[0])}, {esc(long_date(rec["date"]).split(", ", 1)[1])}</span><span>Bryan, Texas</span>'
    if is_latest:
        ears = ears.replace("<span>Bryan, Texas</span>", "<span>Latest issue</span>")
    return (f'<header class="nameplate"><h1><a href="{base}">EEB Daily</a></h1><div class="ears">{ears}</div></header>\n'
            f'<div class="dateline">{esc(rec.get("motto") or "One paper worth the coffee. One paper from beyond the fence. One story from the wider world.")}</div>\n')


def render_lead(rec):
    L = rec["lead"]
    parts = [f'<section class="lead">',
             f'<p class="kicker">The lead <span class="topic">&middot; {esc(L.get("topic", ""))}</span></p>',
             f'<h2>{L["headline"]}</h2>']
    if L.get("deck"):
        parts.append(f'<p class="deck">{L["deck"]}</p>')
    by = [f'<b>{esc(L.get("authors", ""))}</b>']
    jr = " ".join(x for x in [f'<em>{esc(L["journal"])}</em>,' if L.get("journal") else "", esc(L.get("pubdate", ""))] if x).rstrip(",")
    if jr:
        by.append(jr)
    if L.get("url"):
        label = ("doi:" + L["doi"]) if L.get("doi") else re.sub(r"^https?://", "", L["url"])
        by.append(f'<a href="{esc(L["url"])}">{esc(label)}</a>')
    parts.append('<div class="byline">' + '<span class="sep">&middot;</span>'.join(by) + '</div>')
    parts.append('<div class="text">' + "".join(f"<p>{p}</p>" for p in L["paragraphs"]) + '</div>')
    if L.get("push"):
        parts.append(f'<div class="pushbox"><span class="lab">Where to push</span>{L["push"]}</div>')
    if rec.get("people"):
        parts.append('<aside class="side"><p class="kicker">Who wrote it</p>')
        for a in rec["people"]:
            links = " &middot; ".join(f'<a href="{esc(l["url"])}">{esc(l["label"])}</a>' for l in a.get("links", []) if l.get("url"))
            links_html = f' <span class="links">{links}</span>' if links else ""
            parts.append(f'<div class="author"><div class="role">{esc(a.get("role", ""))}</div><div class="name">{esc(a["name"])}</div><p>{a.get("bio", "")}{links_html}</p></div>')
        parts.append('</aside>')
    parts.append('</section>')
    return "\n".join(parts)


def render_story(slot, fallback_kind, topic_label):
    kick = kicker_for(slot, fallback_kind)
    sub = slot.get("topic") or topic_label.get(slot.get("kind", ""), "")
    out = [f'<article class="story"><p class="kicker">{esc(kick)}' + (f' <span class="topic">&middot; {esc(sub)}</span>' if sub else "") + '</p>',
           f'<h3>{slot["headline"]}</h3>']
    if slot.get("cite"):
        out.append(f'<p class="cite">{slot["cite"]}</p>')
    out.append(f'<p class="body">{slot["body"]}</p>')
    if slot.get("why"):
        out.append(f'<div class="why"><span class="lab">Why it matters</span>{slot["why"]}</div>')
    out.append('</article>')
    return "\n".join(out)


SLOT2_TOPIC = {"BEYOND": "A paper from outside evolution and ecology", "CLASSIC": "A landmark paper, revisited",
               "FIELDNOTES": "In the news", "FARAFIELD": "A paper from outside the fence"}
SLOT3_TOPIC = {"SCIENCE": "A result from outside biology", "HISTORY": "From the history of science",
               "ACADEMIA": "News from the academy", "PAPER": "A paper from outside the fence"}


def render_issue(rec, issues, base, is_latest):
    idx = issues.index(rec)
    prev_rec = issues[idx - 1] if idx > 0 else None
    next_rec = issues[idx + 1] if idx + 1 < len(issues) else None
    title = f'EEB Daily No. {rec["no"]}: {strip_tags(rec["lead"]["headline"])}'
    desc = strip_tags(rec["lead"].get("deck") or rec["lead"]["paragraphs"][0])[:200]
    canonical = f'{SITE}/issues/{rec["slug"]}.html'
    body = [HEAD.format(title=esc(title), description=esc(desc), canonical=canonical, site=SITE, css=CSS),
            nameplate(rec, base, is_latest),
            render_lead(rec),
            '<div class="fold"></div>',
            render_story(rec["slot2"], "BEYOND", SLOT2_TOPIC),
            render_story(rec["slot3"], "SCIENCE", SLOT3_TOPIC)]
    nav = []
    if prev_rec:
        nav.append(f'<a href="{base}issues/{prev_rec["slug"]}.html">&larr; No. {prev_rec["no"]}</a>')
    nav.append(f'<a href="{base}archive/">All issues</a>')
    if next_rec:
        nav.append(f'<a href="{base}issues/{next_rec["slug"]}.html">No. {next_rec["no"]} &rarr;</a>')
    elif not is_latest:
        nav.append(f'<a href="{base}">Latest &rarr;</a>')
    tomorrow = f' &middot; Tomorrow: {esc(rec["tomorrow"])}' if rec.get("tomorrow") else ""
    body.append('<footer class="colophon">'
                f'<div class="nav">{"".join(nav)}</div>'
                f'<div>Produced nightly for the Blackmon lab, Texas A&amp;M Biology &middot; Research from linked sources{tomorrow}</div>'
                f'<div class="tiny">Written by {esc(rec.get("producer", "Claude"))} from the day\'s literature; read the linked sources before citing anything. '
                f'<a href="{base}build-your-own.html">Build one for your own lab</a> &middot; <a href="{base}feed.xml">RSS</a></div>'
                '</footer>')
    body.append(FOOT)
    return "\n".join(body)


def render_archive(issues):
    items = []
    for rec in reversed(issues):
        L = rec["lead"]
        s2, s3 = rec["slot2"], rec["slot3"]
        items.append('<li>'
                     f'<div class="meta"><span class="num">No. {rec["no"]}</span> &middot; {esc(long_date(rec["date"]))}</div>'
                     f'<a class="hl" href="../issues/{rec["slug"]}.html">{L["headline"]}</a>'
                     f'<p class="also"><b>{esc(kicker_for(s2, "BEYOND"))}</b>{strip_tags(s2["headline"])}<br>'
                     f'<b>{esc(kicker_for(s3, "SCIENCE"))}</b>{strip_tags(s3["headline"])}</p>'
                     '</li>')
    title = "EEB Daily: all issues"
    out = [HEAD.format(title=esc(title), description="Every issue of EEB Daily, the Blackmon lab's nightly evolutionary biology newsletter.",
                       canonical=f"{SITE}/archive/", site=SITE, css=CSS),
           '<header class="nameplate"><h1><a href="../">EEB Daily</a></h1><div class="ears"><span>Archive</span><span>'
           f'{len(issues)} issues</span></div></header>',
           '<div class="dateline">Every issue, newest first.</div>',
           '<section class="archive"><ol>' + "".join(items) + '</ol></section>',
           '<footer class="colophon"><div class="nav"><a href="../">Latest issue &rarr;</a></div>'
           '<div>Produced nightly for the Blackmon lab, Texas A&amp;M Biology</div>'
           '<div class="tiny"><a href="../build-your-own.html">Build one for your own lab</a> &middot; <a href="../feed.xml">RSS</a></div></footer>',
           FOOT]
    return "\n".join(out)


def render_feed(issues):
    items = []
    for rec in list(reversed(issues))[:30]:
        L = rec["lead"]
        link = f'{SITE}/issues/{rec["slug"]}.html'
        pub = format_datetime(datetime.strptime(rec["date"], "%Y-%m-%d").replace(hour=6, tzinfo=ZoneInfo("America/Chicago")))
        summary = strip_tags(L.get("deck") or L["paragraphs"][0])
        items.append(f"<item><title>{esc('No. ' + str(rec['no']) + ': ' + strip_tags(L['headline']))}</title><link>{link}</link>"
                     f"<guid>{link}</guid><pubDate>{pub}</pubDate><description>{esc(summary)}</description></item>")
    now = format_datetime(datetime.strptime(issues[-1]["date"], "%Y-%m-%d").replace(hour=6, tzinfo=ZoneInfo("America/Chicago")))
    return ('<?xml version="1.0" encoding="UTF-8"?>\n<rss version="2.0"><channel><title>EEB Daily</title>'
            f'<link>{SITE}/</link><description>Nightly one-page evolutionary biology newsletter from the Blackmon lab, Texas A&amp;M.</description>'
            f'<language>en-us</language><lastBuildDate>{now}</lastBuildDate>' + "".join(items) + '</channel></rss>\n')


def render_manifest(issues):
    """Expose only public archive facts, never the private editorial configuration."""
    entries = []
    urls, dois = set(), set()
    for rec in issues:
        lead, second, third = rec["lead"], rec["slot2"], rec["slot3"]
        entries.append({
            "path": "eeb-daily/data/" + rec["_file"],
            "no": rec["no"], "date": rec["date"], "slug": rec["slug"],
            "topic": lead.get("topic", ""), "lead_headline": strip_tags(lead["headline"]),
            "lead_doi": lead.get("doi", ""), "lead_url": lead.get("url", ""),
            "slot2_kind": second.get("kind", ""), "slot2_headline": strip_tags(second["headline"]),
            "slot2_url": second.get("url", ""),
            "slot3_kind": third.get("kind", ""), "slot3_headline": strip_tags(third["headline"]),
            "slot3_url": third.get("url", ""), "history_subject": third.get("history_subject", ""),
        })
        for slot in (lead, second, third):
            if slot.get("url"):
                urls.add(slot["url"])
            if isinstance(slot.get("doi"), str) and slot["doi"]:
                dois.add(slot["doi"].lower())
            match = re.search(r"(?:dx\.)?doi\.org/(10\.[^?#\s]+)", slot.get("url", ""), re.I)
            if match:
                dois.add(match.group(1).lower())
    return {"schema_version": 1, "latest": {"no": issues[-1]["no"], "date": issues[-1]["date"]},
            "issues": entries, "used_urls": sorted(urls), "used_dois": sorted(dois)}


def main():
    issues = load_issues()
    if not issues:
        raise SystemExit("no issue records in " + DATA)
    os.makedirs(ISSUES_DIR, exist_ok=True)
    os.makedirs(ARCHIVE_DIR, exist_ok=True)
    for rec in issues:
        with open(os.path.join(ISSUES_DIR, rec["slug"] + ".html"), "w", encoding="utf-8") as fh:
            fh.write(render_issue(rec, issues, "../", is_latest=False))
    latest = issues[-1]
    with open(os.path.join(ROOT, "index.html"), "w", encoding="utf-8") as fh:
        fh.write(render_issue(latest, issues, "", is_latest=True))
    with open(os.path.join(ARCHIVE_DIR, "index.html"), "w", encoding="utf-8") as fh:
        fh.write(render_archive(issues))
    with open(os.path.join(ROOT, "feed.xml"), "w", encoding="utf-8") as fh:
        fh.write(render_feed(issues))
    with open(os.path.join(ROOT, "manifest.json"), "w", encoding="utf-8") as fh:
        json.dump(render_manifest(issues), fh, ensure_ascii=False, indent=2)
        fh.write("\n")
    # The build-your-own guide shares the stylesheet, so it is rendered here from its body file.
    body_path = os.path.join(ROOT, "tools", "build-your-own.body.html")
    if os.path.exists(body_path):
        with open(body_path, encoding="utf-8") as fh:
            guide_body = fh.read()
        with open(os.path.join(ROOT, "build-your-own.html"), "w", encoding="utf-8") as fh:
            fh.write(HEAD.format(title="Build your own lab daily newsletter",
                                 description="How to set up a nightly AI-written one-page newsletter for your own lab, with the config template, build script and task prompt.",
                                 canonical=f"{SITE}/build-your-own.html", site=SITE, css=CSS) + guide_body + FOOT)
    print(json.dumps({"issues": len(issues), "latest": latest["no"], "latest_date": latest["date"],
                      "latest_slug": latest["slug"], "latest_headline": strip_tags(latest["lead"]["headline"])}))


if __name__ == "__main__":
    main()
