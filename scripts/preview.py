#!/usr/bin/env python3
"""
Ruby-free live preview server for the Blackmon Lab site.

Why this exists: the real build is Jekyll, which needs Ruby 3.x. When the Ruby
toolchain is broken this renders the same pages using only the Python standard
library, so previewing never blocks on `brew install`.

Scope, stated honestly: this implements the specific Liquid subset the site's
templates actually use (front matter, page/site variables, includes, the
`default` and `relative_url` filters, simple if-blocks, and the wiki
breadcrumb's split/assign). It is a preview aid, NOT a replacement for the
Jekyll build. GitHub Pages still builds the published site with Jekyll, so
verify anything layout-critical against a real build before pushing.

Pages are re-rendered on every request, so edits appear on plain reload.

    python3 scripts/preview.py            # serve on 4010
    python3 scripts/preview.py --port N
"""

import argparse
import html
import http.server
import os
import posixpath
import re
import socketserver
import sys
import urllib.parse

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


# ── Minimal YAML front matter -------------------------------------------------
# Only what the site uses: `key: value`, quoted values, and `key: |` block
# scalars. Deliberately not a general YAML parser.
def parse_front_matter(text):
    if not text.startswith("---"):
        return {}, text
    end = text.find("\n---", 3)
    if end == -1:
        return {}, text
    raw = text[3:end]
    body = text[end + 4:]
    if body.startswith("\n"):
        body = body[1:]

    data, lines, i = {}, raw.split("\n"), 0
    while i < len(lines):
        line = lines[i]
        if not line.strip() or line.lstrip().startswith("#"):
            i += 1
            continue
        m = re.match(r"^([A-Za-z_][\w.-]*):\s*(.*)$", line)
        if not m:
            i += 1
            continue
        key, val = m.group(1), m.group(2).strip()
        if val in ("|", "|-", ">", ">-"):
            # Block scalar: consume the indented run that follows.
            block, i = [], i + 1
            indent = None
            while i < len(lines):
                nxt = lines[i]
                if nxt.strip() == "":
                    block.append("")
                    i += 1
                    continue
                cur = len(nxt) - len(nxt.lstrip())
                if indent is None:
                    indent = cur
                if cur < indent:
                    break
                block.append(nxt[indent:])
                i += 1
            data[key] = "\n".join(block)
            continue
        if len(val) >= 2 and val[0] == val[-1] and val[0] in "\"'":
            val = val[1:-1]
        data[key] = val
        i += 1
    return data, body


# ── Liquid subset -------------------------------------------------------------
SITE = {}


def load_site_config():
    cfg_path = os.path.join(ROOT, "_config.yml")
    if not os.path.exists(cfg_path):
        return {}
    with open(cfg_path, encoding="utf-8") as fh:
        raw = fh.read()
    cfg = {}
    for line in raw.split("\n"):
        m = re.match(r"^([A-Za-z_][\w.-]*):\s*(.+?)\s*$", line)
        if not m:
            continue
        key, val = m.group(1), m.group(2)
        if val.startswith(("|", ">", "[", "{", "#")):
            continue
        if len(val) >= 2 and val[0] == val[-1] and val[0] in "\"'":
            val = val[1:-1]
        cfg[key] = val
    return cfg


def lookup(expr, page):
    """Resolve `page.x` / `site.x` / `content`, else empty string."""
    expr = expr.strip()
    if expr.startswith("page."):
        return page.get(expr[5:], "")
    if expr.startswith("site."):
        return SITE.get(expr[5:], "")
    if expr == "content":
        return page.get("__content__", "")
    if len(expr) >= 2 and expr[0] == expr[-1] and expr[0] in "\"'":
        return expr[1:-1]
    return page.get(expr, "")


def resolve_operand(expr, page):
    """Like lookup() but also understands `name[i]` indexing used in conditions."""
    expr = expr.strip()
    m = re.match(r"^(\w+)\[(\d+)\]$", expr)
    if m:
        seq = page.get(m.group(1), [])
        i = int(m.group(2))
        return seq[i] if isinstance(seq, list) and i < len(seq) else ""
    return lookup(expr, page)


def apply_filters(value, filters, page):
    for f in filters:
        f = f.strip()
        if f.startswith("default:"):
            if not value:
                value = lookup(f[len("default:"):], page)
        elif f == "relative_url":
            value = str(value)
            if value.startswith("/"):
                value = value  # served from site root, already correct
        elif f.startswith("append:"):
            value = str(value) + str(lookup(f[len("append:"):], page))
        elif f == "upcase":
            value = str(value).upper()
        elif f.startswith("replace:"):
            parts = [p.strip() for p in f[len("replace:"):].split(",")]
            if len(parts) == 2:
                a = parts[0].strip("'\"")
                b = parts[1].strip("'\"")
                value = str(value).replace(a, b)
    return value


def render(template, page, depth=0):
    if depth > 6:
        return template
    out = template

    # {% comment %} ... {% endcomment %}
    out = re.sub(r"\{%-?\s*comment\s*-?%\}.*?\{%-?\s*endcomment\s*-?%\}",
                 "", out, flags=re.S)

    # {% include file.html %}
    def do_include(m):
        name = m.group(1).strip()
        path = os.path.join(ROOT, "_includes", name)
        if not os.path.exists(path):
            return f"<!-- missing include: {html.escape(name)} -->"
        with open(path, encoding="utf-8") as fh:
            return render(fh.read(), page, depth + 1)

    out = re.sub(r"\{%-?\s*include\s+([\w./-]+)\s*-?%\}", do_include, out)

    # {% assign x = expr | filters %}   (only url_parts split is used)
    def do_assign(m):
        name, expr = m.group(1), m.group(2)
        parts = expr.split("|")
        val = lookup(parts[0], page)
        for f in parts[1:]:
            f = f.strip()
            if f.startswith("split:"):
                sep = f[len("split:"):].strip().strip("'\"")
                val = str(val).split(sep)
            else:
                val = apply_filters(val, [f], page)
        page[name] = val
        return ""

    out = re.sub(r"\{%-?\s*assign\s+(\w+)\s*=\s*(.+?)\s*-?%\}", do_assign, out)

    # {% if %} / {% elsif %} / {% else %} / {% endif %}
    # Handled with a token scanner rather than a regex: the wiki breadcrumb
    # nests ifs two deep, and a non-greedy regex silently mismatches the
    # closing tag there, leaking a stray {% endif %} into the output.
    def truthy(cond):
        cond = cond.strip()
        # `and` / `or` chains, evaluated left to right (Liquid has no precedence)
        parts = re.split(r"\s+(and|or)\s+", cond)
        if len(parts) > 1:
            result = truthy(parts[0])
            i = 1
            while i + 1 < len(parts):
                op, nxt = parts[i], parts[i + 1]
                result = (result and truthy(nxt)) if op == "and" else (result or truthy(nxt))
                i += 2
            return result
        m = re.match(r"^(.+?)\s+contains\s+(.+)$", cond)
        if m:
            return m.group(2).strip().strip("'\"") in str(lookup(m.group(1), page))
        m = re.match(r"^(.+?)\s*!=\s*(.+)$", cond)
        if m:
            rhs = m.group(2).strip().strip("'\"")
            return str(resolve_operand(m.group(1), page)) != rhs
        m = re.match(r"^(.+?)\s*==\s*(.+)$", cond)
        if m:
            rhs = m.group(2).strip().strip("'\"")
            return str(resolve_operand(m.group(1), page)) == rhs
        return bool(resolve_operand(cond, page))

    tag_re = re.compile(r"\{%-?\s*(if|elsif|else|endif)\b\s*(.*?)\s*-?%\}", re.S)

    def process_ifs(text):
        pos, out_parts = 0, []
        while True:
            m = tag_re.search(text, pos)
            if not m:
                out_parts.append(text[pos:])
                break
            if m.group(1) != "if":
                # Stray closing tag with no opener; drop it rather than emit it.
                out_parts.append(text[pos:m.start()])
                pos = m.end()
                continue
            out_parts.append(text[pos:m.start()])
            # Walk forward tracking depth to find this if's own else/endif.
            depth, i = 1, m.end()
            branches, cond, seg_start = [], m.group(2), m.end()
            while depth > 0:
                nm = tag_re.search(text, i)
                if not nm:
                    depth = 0
                    branches.append((cond, text[seg_start:]))
                    i = len(text)
                    break
                kind = nm.group(1)
                if kind == "if":
                    depth += 1
                    i = nm.end()
                elif kind == "endif":
                    depth -= 1
                    if depth == 0:
                        branches.append((cond, text[seg_start:nm.start()]))
                        i = nm.end()
                    else:
                        i = nm.end()
                elif depth == 1 and kind in ("elsif", "else"):
                    branches.append((cond, text[seg_start:nm.start()]))
                    cond = nm.group(2) if kind == "elsif" else None
                    seg_start = nm.end()
                    i = nm.end()
                else:
                    i = nm.end()
            chosen = ""
            for c, seg in branches:
                if c is None or truthy(c):
                    chosen = seg
                    break
            out_parts.append(process_ifs(chosen))
            pos = i
        return "".join(out_parts)

    out = process_ifs(out)

    # {{ expr | filters }}
    def do_var(m):
        parts = m.group(1).split("|")
        base = parts[0].strip()
        idx = re.match(r"^(\w+)\[(\d+)\]$", base)
        if idx:
            seq = page.get(idx.group(1), [])
            i = int(idx.group(2))
            val = seq[i] if isinstance(seq, list) and i < len(seq) else ""
        else:
            val = lookup(base, page)
        return str(apply_filters(val, parts[1:], page))

    out = re.sub(r"\{\{\s*(.+?)\s*\}\}", do_var, out)
    return out


def render_page(src_path, url_path):
    with open(src_path, encoding="utf-8") as fh:
        text = fh.read()
    page, body = parse_front_matter(text)
    if not page:
        return text  # no front matter: Jekyll passes it through unchanged
    page["url"] = url_path
    page["__content__"] = body
    if src_path.endswith(".md"):
        body = markdown_to_html(body)
        page["__content__"] = body
    layout = page.get("layout")
    if not layout:
        return render(body, page)
    lpath = os.path.join(ROOT, "_layouts", f"{layout}.html")
    if not os.path.exists(lpath):
        return render(body, page)
    with open(lpath, encoding="utf-8") as fh:
        tpl = fh.read()
    page["__content__"] = render(body, page)
    return render(tpl, page)



# ── Markdown (the wiki is 235 .md files) --------------------------------------
# A compact CommonMark subset covering what the wiki actually uses: ATX
# headings, fenced code, unordered/ordered lists, blockquotes, pipe tables,
# bold/italic/inline-code/links, and paragraphs. kramdown (what Jekyll uses)
# has many more features; this is close, not identical. Treat wiki rendering
# here as an approximation.
def md_inline(t):
    t = re.sub(r"`([^`]+)`", lambda m: "<code>" + html.escape(m.group(1)) + "</code>", t)
    t = re.sub(r"!\[([^\]]*)\]\(([^)]+)\)", r'<img src="\2" alt="\1">', t)
    t = re.sub(r"\[([^\]]+)\]\(([^)]+)\)", r'<a href="\2">\1</a>', t)
    t = re.sub(r"\*\*([^*]+)\*\*", r"<strong>\1</strong>", t)
    t = re.sub(r"(?<![*\w])\*([^*\n]+)\*(?![*\w])", r"<em>\1</em>", t)
    return t


def markdown_to_html(text):
    lines = text.split("\n")
    out, i = [], 0
    list_stack = []

    def close_lists(to=0):
        while len(list_stack) > to:
            out.append(f"</{list_stack.pop()[1]}>")

    while i < len(lines):
        line = lines[i]

        m = re.match(r"^```+\s*(\w*)\s*$", line)
        if m:
            close_lists()
            lang, body, i = m.group(1), [], i + 1
            while i < len(lines) and not re.match(r"^```+\s*$", lines[i]):
                body.append(lines[i]); i += 1
            i += 1
            cls = f' class="language-{lang}"' if lang else ""
            out.append(f"<pre><code{cls}>" + html.escape("\n".join(body)) + "</code></pre>")
            continue

        if not line.strip():
            j = i + 1
            while j < len(lines) and not lines[j].strip():
                j += 1
            if not (j < len(lines) and re.match(r"^\s*([-*+]|\d+[.)])\s+", lines[j])):
                close_lists()
            i += 1; continue

        m = re.match(r"^(#{1,6})\s+(.*)$", line)
        if m:
            close_lists()
            lvl = len(m.group(1))
            out.append(f"<h{lvl}>{md_inline(m.group(2).strip())}</h{lvl}>")
            i += 1; continue

        if re.match(r"^\s*([-*_])\s*\1\s*\1[\s\1]*$", line):
            close_lists(); out.append("<hr>"); i += 1; continue

        # Pipe table
        if line.lstrip().startswith("|") and i + 1 < len(lines) and \
           re.match(r"^\s*\|[\s:|-]+\|?\s*$", lines[i + 1]):
            close_lists()
            def cells(r):
                return [c.strip() for c in r.strip().strip("|").split("|")]
            head = cells(line); i += 2
            out.append("<table><thead><tr>" +
                       "".join(f"<th>{md_inline(c)}</th>" for c in head) +
                       "</tr></thead><tbody>")
            while i < len(lines) and lines[i].lstrip().startswith("|"):
                out.append("<tr>" + "".join(f"<td>{md_inline(c)}</td>"
                                            for c in cells(lines[i])) + "</tr>")
                i += 1
            out.append("</tbody></table>")
            continue

        if line.lstrip().startswith(">"):
            close_lists()
            buf = []
            while i < len(lines) and lines[i].lstrip().startswith(">"):
                buf.append(re.sub(r"^\s*>\s?", "", lines[i])); i += 1
            out.append("<blockquote>" + markdown_to_html("\n".join(buf)) + "</blockquote>")
            continue

        m = re.match(r"^(\s*)([-*+]|\d+[.)])\s+(.*)$", line)
        if m:
            # Nest by comparing actual indent columns rather than assuming a
            # fixed 2-space step: the wiki mixes 2- and 4-space indentation,
            # and arithmetic depth invented list levels that were not there.
            indent = len(m.group(1).expandtabs(4))
            tag = "ul" if m.group(2) in ("-", "*", "+") else "ol"
            while list_stack and indent < list_stack[-1][0]:
                out.append(f"</{list_stack.pop()[1]}>")
            if not list_stack or indent > list_stack[-1][0]:
                out.append(f"<{tag}>"); list_stack.append((indent, tag))
            elif list_stack[-1][1] != tag:
                out.append(f"</{list_stack.pop()[1]}>")
                out.append(f"<{tag}>"); list_stack.append((indent, tag))
            out.append(f"<li>{md_inline(m.group(3).strip())}</li>")
            i += 1; continue

        close_lists()
        buf = []
        while i < len(lines) and lines[i].strip() and \
              not re.match(r"^(#{1,6}\s|\s*[-*+]\s|\s*\d+[.)]\s|>|```)", lines[i]) and \
              not lines[i].lstrip().startswith("|"):
            buf.append(lines[i]); i += 1
        if buf:
            joined = " ".join(x.strip() for x in buf)
            # Raw HTML blocks in markdown pass through untouched, as kramdown does.
            if joined.lstrip().startswith("<"):
                out.append(joined)
            else:
                out.append(f"<p>{md_inline(joined)}</p>")
    close_lists()
    return "\n".join(out)


# ── Permalink routing ---------------------------------------------------------
# Every wiki page declares `permalink: /knowledge/topics/<slug>/`, so the URL
# does not match the file path. Build the map once at startup.
PERMALINKS = {}


def build_permalink_map():
    PERMALINKS.clear()
    for dirpath, dirnames, filenames in os.walk(ROOT):
        dirnames[:] = [d for d in dirnames
                       if d not in (".git", "_site", "node_modules", "assets", ".wrangler")]
        for fn in filenames:
            if not fn.endswith((".md", ".html")):
                continue
            fp = os.path.join(dirpath, fn)
            try:
                with open(fp, encoding="utf-8", errors="ignore") as fh:
                    head = fh.read(2048)
            except OSError:
                continue
            m = re.search(r"^permalink:\s*[\"']?([^\"'\n]+)", head, re.M)
            if m:
                PERMALINKS[m.group(1).strip().rstrip("/")] = fp
    return len(PERMALINKS)


BANNER = """<div style="position:fixed;bottom:0;left:0;right:0;z-index:99999;
background:#7a1c1c;color:#fff;font:12px/1.5 -apple-system,sans-serif;
padding:5px 10px;text-align:center;">
Python preview (no Ruby). Renders the Liquid subset this site uses.
Verify layout-critical changes against a real Jekyll build before pushing.
</div>"""


class Handler(http.server.SimpleHTTPRequestHandler):
    def translate_path(self, path):
        path = urllib.parse.urlparse(path).path
        path = posixpath.normpath(urllib.parse.unquote(path))
        parts = [p for p in path.split("/") if p and p not in (".", "..")]
        return os.path.join(ROOT, *parts)

    def do_GET(self):
        raw = urllib.parse.urlparse(self.path).path
        fs = self.translate_path(self.path)

        # Permalink lookup first: /knowledge/topics/x/ maps to a file elsewhere.
        perm = PERMALINKS.get(raw.rstrip("/"))
        if perm:
            fs = perm

        if os.path.isdir(fs):
            for cand in ("index.html", "index.md"):
                if os.path.exists(os.path.join(fs, cand)):
                    fs = os.path.join(fs, cand)
                    raw = raw.rstrip("/") + "/" + cand
                    break

        if fs.endswith((".html", ".md")) and os.path.exists(fs):
            try:
                out = render_page(fs, raw)
            except Exception as exc:  # surface the error, do not serve a blank
                out = (f"<pre style='color:#a00;font:13px monospace;padding:20px'>"
                       f"preview render error in {html.escape(fs)}\n\n"
                       f"{html.escape(repr(exc))}</pre>")
            out += BANNER
            data = out.encode("utf-8")
            self.send_response(200)
            self.send_header("Content-Type", "text/html; charset=utf-8")
            self.send_header("Content-Length", str(len(data)))
            self.send_header("Cache-Control", "no-store")
            self.end_headers()
            self.wfile.write(data)
            return
        return super().do_GET()

    def log_message(self, fmt, *args):
        pass


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--port", type=int, default=4010)
    args = ap.parse_args()
    SITE.update(load_site_config())
    n = build_permalink_map()
    socketserver.TCPServer.allow_reuse_address = True
    with socketserver.TCPServer(("127.0.0.1", args.port), Handler) as srv:
        print(f"Preview serving {ROOT}  ({n} permalinks mapped)")
        print(f"  http://127.0.0.1:{args.port}/index.html")
        print("  Edits appear on reload. Control-C to stop.")
        try:
            srv.serve_forever()
        except KeyboardInterrupt:
            print("\nstopped")


if __name__ == "__main__":
    main()
