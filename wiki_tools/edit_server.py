"""
wiki_tools.edit_server — click-to-edit local dev server for the Blackmon Lab wiki.

Binds 127.0.0.1:4711 (localhost only, never exposed beyond loopback).
Run as:
    python3 -m wiki_tools.edit_server

Endpoints:
    OPTIONS /*           — CORS preflight
    GET  /health         — liveness check
    GET  /raw?path=...   — return raw markdown for a knowledge page
    PATCH /file          — replace a user-region in a knowledge page
    POST /propose-edit   — queue a Tealc-region change proposal

Security:
    - Binds loopback only.
    - Host header check: rejects anything not from localhost / 127.0.0.1.
    - Path allowlist enforced before any file I/O.
    - In-process threading.Lock serializes all file writes.
    - No shell execution, no eval.
"""

from __future__ import annotations

import json
import os
import re
import threading
import uuid
from datetime import datetime, timezone
from http.server import BaseHTTPRequestHandler, HTTPServer
from pathlib import Path
from socketserver import ThreadingMixIn
from urllib.parse import parse_qs, urlparse

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

HOST = "127.0.0.1"
PORT = 4711

REPO_ROOT = Path(__file__).resolve().parent.parent

# Editable content pattern: any .html or .md file in the repo EXCEPT files
# under these deny-listed directories. This is a deny-list rather than an
# explicit allowlist so every content page (homepage, team, ai.html,
# subpages/*, phylo-methods/*, knowledge/*) is editable once it carries
# the region markers, without requiring per-file allowlist entries.
DENIED_PATH_PREFIXES: tuple[str, ...] = (
    "_site/",             # Jekyll build output — ephemeral
    "_includes/",         # Layout templates — breaks all pages if edited
    "_layouts/",          # Layout templates
    "_data/",             # Jekyll data files
    "_drafts/",           # Jekyll drafts
    "assets/",            # CSS, JS, images, fonts
    "wiki_tools/",        # Python source for this server
    "data/",              # runtime DB + JSON + logs
    "scripts/",           # shell launchers and .app bundles
    "app/",
    ".git/",
    ".claude/",
    "node_modules/",
    "deprecated/",
    "subpages/karyotype-data/",  # auto-generated, large, should be pipeline-written only
)
ALLOWED_EXTENSIONS: tuple[str, ...] = (".html", ".md")

# Developer-facing metadata files at the repo root that users shouldn't
# edit via the overlay — they're for humans reading on GitHub / CI.
# Note: AGENT_CONTRACT.md is intentionally editable (external collaborator
# contract; kept in the repo root so agents can amend it through the
# normal review flow).
DENIED_EXACT_PATHS: tuple[str, ...] = (
    "README.md",
    "TODO.md",
    "CONTRIBUTING.md",
    "CHANGELOG.md",
    "WIKI_V1_PLAN.md",
)

# Kept for backward-compat with tests that imported these names.
ALLOWED_PATH_PREFIXES: tuple[str, ...] = ()
ALLOWED_EXACT_PATHS: tuple[str, ...] = ()

PROPOSALS_DIR = REPO_ROOT / "data" / "wiki_proposals"
AUDIT_LOG = PROPOSALS_DIR / "audit.log"

ALLOWED_ORIGINS = {"http://localhost:4000", "http://127.0.0.1:4000"}

# Serialize all file writes across threads.
_FILE_LOCK = threading.Lock()


# ---------------------------------------------------------------------------
# Path allowlist
# ---------------------------------------------------------------------------

def _path_is_allowed(rel_path: str) -> bool:
    """Return True if rel_path is writable by the overlay.

    Policy (deny-list): any .html / .md file in the repo EXCEPT files under
    DENIED_PATH_PREFIXES (templates, assets, build output, code, runtime
    data). Path traversal is caught in _resolve_safe; this function only
    covers the allowlist semantics.
    """
    # Reject path traversal attempts (also caught by _resolve_safe; cheap
    # upfront guard that keeps the code readable).
    if rel_path.startswith("/") or ".." in rel_path.split("/"):
        return False
    # Deny-list: templates, assets, code, build output.
    if any(rel_path.startswith(p) for p in DENIED_PATH_PREFIXES):
        return False
    # Deny specific developer-facing files at repo root.
    if rel_path in DENIED_EXACT_PATHS:
        return False
    # Only content file extensions.
    if not rel_path.endswith(ALLOWED_EXTENSIONS):
        return False
    return True


def _resolve_safe(rel_path: str) -> Path | None:
    """Resolve rel_path relative to REPO_ROOT, reject traversals."""
    try:
        full = (REPO_ROOT / rel_path).resolve()
        full.relative_to(REPO_ROOT.resolve())  # raises ValueError on traversal
        return full
    except ValueError:
        return None


# ---------------------------------------------------------------------------
# Region extraction helpers
# ---------------------------------------------------------------------------

_USER_START = re.compile(r"^\s*<!--\s*user-start\s*-->", re.MULTILINE)
_USER_END   = re.compile(r"^\s*<!--\s*user-end\s*-->",   re.MULTILINE)


def _extract_user_region(text: str, region_index: int) -> tuple[int, int] | None:
    """Return (content_start, content_end) for the region_index-th user region.

    content_start is the offset just after the user-start marker line's newline.
    content_end is the offset of the start of the user-end marker line.
    Returns None if the region is not found.
    """
    starts = list(_USER_START.finditer(text))
    ends   = list(_USER_END.finditer(text))

    if region_index >= len(starts):
        return None

    start_match = starts[region_index]
    # Find the end that follows this start
    start_pos = start_match.end()
    matching_end = None
    for em in ends:
        if em.start() > start_match.start():
            matching_end = em
            break
    if matching_end is None:
        return None

    # content lives between end-of-start-marker-line and start-of-end-marker
    # Include the newline after the start marker
    content_start = start_pos
    if content_start < len(text) and text[content_start] == "\n":
        content_start += 1
    content_end = matching_end.start()
    return content_start, content_end


# ---------------------------------------------------------------------------
# Proposals directory
# ---------------------------------------------------------------------------

def _ensure_proposals_dir() -> None:
    PROPOSALS_DIR.mkdir(parents=True, exist_ok=True)


def _proposal_count() -> int:
    try:
        return sum(
            1 for f in PROPOSALS_DIR.iterdir()
            if f.is_file() and f.name != ".gitkeep" and f.name != "audit.log"
        )
    except Exception:
        return 0


# ---------------------------------------------------------------------------
# Audit log
# ---------------------------------------------------------------------------

def _audit(row: dict) -> str:
    """Append a JSON-line to audit.log, return the row id."""
    row_id = str(uuid.uuid4())[:8]
    row["audit_row_id"] = row_id
    _ensure_proposals_dir()
    with open(AUDIT_LOG, "a", encoding="utf-8") as fh:
        fh.write(json.dumps(row) + "\n")
    return row_id


# ---------------------------------------------------------------------------
# CORS headers helper
# ---------------------------------------------------------------------------

def _cors_headers(origin: str | None) -> dict[str, str]:
    allowed_origin = origin if origin in ALLOWED_ORIGINS else "http://localhost:4000"
    return {
        "Access-Control-Allow-Origin": allowed_origin,
        "Access-Control-Allow-Methods": "PATCH, POST, OPTIONS, GET",
        "Access-Control-Allow-Headers": "Content-Type",
    }


# ---------------------------------------------------------------------------
# Request handler
# ---------------------------------------------------------------------------

class EditHandler(BaseHTTPRequestHandler):

    def log_message(self, fmt, *args):  # silence default httpd log noise
        pass  # Keep server output clean

    def _check_host(self) -> bool:
        """Return True if the Host header is localhost or 127.0.0.1."""
        host = self.headers.get("Host", "")
        return host.startswith("localhost") or host.startswith("127.0.0.1")

    def _send_json(self, code: int, data: dict, origin: str | None = None) -> None:
        body = json.dumps(data).encode()
        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        for k, v in _cors_headers(origin).items():
            self.send_header(k, v)
        self.end_headers()
        self.wfile.write(body)

    def _read_body(self) -> bytes:
        length = int(self.headers.get("Content-Length", 0))
        return self.rfile.read(length) if length else b""

    def _origin(self) -> str | None:
        return self.headers.get("Origin")

    # ------------------------------------------------------------------
    # OPTIONS — CORS preflight
    # ------------------------------------------------------------------

    def do_OPTIONS(self):
        origin = self._origin()
        allowed_origin = origin if origin in ALLOWED_ORIGINS else "http://localhost:4000"
        self.send_response(204)
        self.send_header("Access-Control-Allow-Origin", allowed_origin)
        self.send_header("Access-Control-Allow-Methods", "PATCH, POST, OPTIONS, GET")
        self.send_header("Access-Control-Allow-Headers", "Content-Type")
        self.send_header("Content-Length", "0")
        self.end_headers()

    # ------------------------------------------------------------------
    # GET /health  and  GET /raw
    # ------------------------------------------------------------------

    def do_GET(self):
        if not self._check_host():
            self._send_json(403, {"error": "forbidden host"})
            return

        parsed = urlparse(self.path)
        origin = self._origin()

        if parsed.path == "/health":
            self._send_json(200, {"status": "ok", "proposals": _proposal_count()}, origin)
            return

        if parsed.path == "/raw":
            qs = parse_qs(parsed.query)
            rel = (qs.get("path") or [""])[0]
            if not rel or not _path_is_allowed(rel):
                self._send_json(403, {"error": "path not in allowlist"}, origin)
                return
            full = _resolve_safe(rel)
            if full is None or not full.exists():
                self._send_json(404, {"error": "file not found"}, origin)
                return
            try:
                content = full.read_text(encoding="utf-8")
            except Exception as exc:
                self._send_json(500, {"error": str(exc)}, origin)
                return
            body = content.encode("utf-8")
            self.send_response(200)
            self.send_header("Content-Type", "text/plain; charset=utf-8")
            self.send_header("Content-Length", str(len(body)))
            for k, v in _cors_headers(origin).items():
                self.send_header(k, v)
            self.end_headers()
            self.wfile.write(body)
            return

        self._send_json(404, {"error": "not found"}, origin)

    # ------------------------------------------------------------------
    # PATCH /file
    # ------------------------------------------------------------------

    def do_PATCH(self):
        if not self._check_host():
            self._send_json(403, {"error": "forbidden host"})
            return

        parsed = urlparse(self.path)
        origin = self._origin()

        if parsed.path != "/file":
            self._send_json(404, {"error": "not found"}, origin)
            return

        try:
            payload = json.loads(self._read_body())
        except json.JSONDecodeError:
            self._send_json(400, {"error": "invalid JSON body"}, origin)
            return

        rel_path     = str(payload.get("path", ""))
        region       = str(payload.get("region", "user"))
        region_index = int(payload.get("region_index", 0))
        new_content  = str(payload.get("new_content", ""))

        # Allowlist check
        if not _path_is_allowed(rel_path):
            self._send_json(403, {"error": "path not in allowlist"}, origin)
            return
        full_path = _resolve_safe(rel_path)
        if full_path is None:
            self._send_json(403, {"error": "path traversal rejected"}, origin)
            return
        if not full_path.exists():
            self._send_json(404, {"error": "file not found"}, origin)
            return

        with _FILE_LOCK:
            try:
                original = full_path.read_text(encoding="utf-8")
            except Exception as exc:
                self._send_json(500, {"error": f"read error: {exc}"}, origin)
                return

            span = _extract_user_region(original, region_index)
            if span is None:
                self._send_json(
                    404,
                    {"error": f"user region index {region_index} not found"},
                    origin,
                )
                return

            content_start, content_end = span
            # Ensure new_content ends with a newline so the end marker is on its own line
            replacement = new_content
            if replacement and not replacement.endswith("\n"):
                replacement += "\n"

            updated = original[:content_start] + replacement + original[content_end:]

            # Grammar check
            from wiki_tools.accuracy import region_grammar_ok
            ok, problems = region_grammar_ok(updated)
            if not ok:
                self._send_json(
                    400,
                    {"error": "region grammar violation", "problems": problems},
                    origin,
                )
                return

            # Atomic write
            tmp_path = Path(str(full_path) + ".tmp")
            try:
                tmp_path.write_text(updated, encoding="utf-8")
                os.replace(str(tmp_path), str(full_path))
            except Exception as exc:
                try:
                    tmp_path.unlink(missing_ok=True)
                except Exception:
                    pass
                self._send_json(500, {"error": f"write error: {exc}"}, origin)
                return

            bytes_written = len(updated.encode("utf-8"))
            row_id = _audit({
                "ts": datetime.now(timezone.utc).isoformat(),
                "path": rel_path,
                "region": region,
                "region_index": region_index,
                "bytes_before": len(original.encode("utf-8")),
                "bytes_after": bytes_written,
            })

        self._send_json(
            200,
            {"ok": True, "bytes_written": bytes_written, "audit_row_id": row_id},
            origin,
        )

    # ------------------------------------------------------------------
    # POST /propose-edit
    # ------------------------------------------------------------------

    def do_POST(self):
        if not self._check_host():
            self._send_json(403, {"error": "forbidden host"})
            return

        parsed = urlparse(self.path)
        origin = self._origin()

        if parsed.path != "/propose-edit":
            self._send_json(404, {"error": "not found"}, origin)
            return

        try:
            payload = json.loads(self._read_body())
        except json.JSONDecodeError:
            self._send_json(400, {"error": "invalid JSON body"}, origin)
            return

        rel_path         = str(payload.get("path", ""))
        region           = str(payload.get("region", ""))
        proposed_content = str(payload.get("proposed_content", ""))
        rationale        = str(payload.get("rationale", ""))

        # Allowlist check
        if not _path_is_allowed(rel_path):
            self._send_json(403, {"error": "path not in allowlist"}, origin)
            return
        if _resolve_safe(rel_path) is None:
            self._send_json(403, {"error": "path traversal rejected"}, origin)
            return

        now = datetime.now(timezone.utc)
        ts_str = now.strftime("%Y%m%dT%H%M%SZ")

        # Build a URL-safe slug from path + region
        raw_slug = f"{rel_path}_{region}".replace("/", "_").replace(":", "_")
        slug = re.sub(r"[^A-Za-z0-9_-]", "", raw_slug)[:60]
        proposal_id = f"{ts_str}_{slug}"
        proposal_filename = f"{proposal_id}.md"

        # Read original region content (best-effort; not a hard failure)
        full_path = _resolve_safe(rel_path)
        original_snippet = ""
        if full_path and full_path.exists():
            try:
                src = full_path.read_text(encoding="utf-8")
                # Extract the named tealc region if possible
                tealc_name = region.replace("tealc:", "")
                pat = re.compile(
                    rf"<!--\s*tealc:{re.escape(tealc_name)}-start\s*-->(.*?)<!--\s*tealc:{re.escape(tealc_name)}-end\s*-->",
                    re.DOTALL,
                )
                m = pat.search(src)
                if m:
                    original_snippet = m.group(1).strip()
            except Exception:
                pass

        proposal_content = (
            f"---\n"
            f"path: {rel_path}\n"
            f"region: {region}\n"
            f"proposed_at: {now.isoformat()}\n"
            f"rationale: |\n"
            f"  {rationale}\n"
            f"---\n\n"
            f"## Original\n\n"
            f"```\n{original_snippet}\n```\n\n"
            f"## Proposed\n\n"
            f"```\n{proposed_content}\n```\n"
        )

        with _FILE_LOCK:
            _ensure_proposals_dir()
            proposal_path = PROPOSALS_DIR / proposal_filename
            try:
                proposal_path.write_text(proposal_content, encoding="utf-8")
            except Exception as exc:
                self._send_json(500, {"error": f"write error: {exc}"}, origin)
                return

        self._send_json(
            200,
            {"ok": True, "proposal_id": proposal_id, "file": f"data/wiki_proposals/{proposal_filename}"},
            origin,
        )


# ---------------------------------------------------------------------------
# Threading server
# ---------------------------------------------------------------------------

class ThreadingHTTPServer(ThreadingMixIn, HTTPServer):
    daemon_threads = True


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

def run():
    server = ThreadingHTTPServer((HOST, PORT), EditHandler)
    print(f"click-to-edit server listening on http://{HOST}:{PORT}")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.server_close()


if __name__ == "__main__":
    run()
