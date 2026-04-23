"""
Unit tests for wiki_tools.edit_server.

Run with:
    python3 -m unittest wiki_tools.tests.test_edit_server
"""

from __future__ import annotations

import json
import os
import re
import tempfile
import threading
import time
import unittest
from pathlib import Path
from unittest.mock import MagicMock, patch

# ---------------------------------------------------------------------------
# We patch REPO_ROOT before importing the module so file-system helpers
# point to a temp directory during tests.
# ---------------------------------------------------------------------------
import wiki_tools.edit_server as edit_server


# ---------------------------------------------------------------------------
# Fixtures
# ---------------------------------------------------------------------------

FIXTURE_MD = """\
---
layout: default
title: Test Page
---

# Test page

<!-- tealc:lead-start -->
Tealc writes this lead paragraph. Do not edit directly.
<!-- tealc:lead-end -->

<!-- user-start -->
This is the first user-written note.
It spans two lines.
<!-- user-end -->

<!-- tealc:auto-start -->
Tealc auto content here.
<!-- tealc:auto-end -->

<!-- user-start -->
Second user region content.
<!-- user-end -->
"""

FIXTURE_NO_USER = """\
---
layout: default
title: No User Regions
---

<!-- tealc:lead-start -->
Only Tealc content.
<!-- tealc:lead-end -->
"""

FIXTURE_BROKEN_GRAMMAR = """\
---
layout: default
title: Broken
---

<!-- user-start -->
Orphan start — no end marker.
"""


# ---------------------------------------------------------------------------
# Helper: build a temporary repo-root with the fixture file
# ---------------------------------------------------------------------------

def _make_temp_repo(fixture_content: str, rel_path: str = "knowledge/topics/test.md") -> tempfile.TemporaryDirectory:
    tmp = tempfile.TemporaryDirectory()
    root = Path(tmp.name)
    full = root / rel_path
    full.parent.mkdir(parents=True, exist_ok=True)
    full.write_text(fixture_content, encoding="utf-8")
    (root / "data" / "wiki_proposals").mkdir(parents=True, exist_ok=True)
    return tmp


# ---------------------------------------------------------------------------
# 1. Region extraction
# ---------------------------------------------------------------------------

class TestExtractUserRegion(unittest.TestCase):

    def test_extract_first_user_region(self):
        spans = edit_server._extract_user_region(FIXTURE_MD, 0)
        self.assertIsNotNone(spans)
        start, end = spans
        content = FIXTURE_MD[start:end]
        self.assertIn("first user-written note", content)
        self.assertNotIn("tealc", content.lower())

    def test_extract_second_user_region(self):
        spans = edit_server._extract_user_region(FIXTURE_MD, 1)
        self.assertIsNotNone(spans)
        start, end = spans
        content = FIXTURE_MD[start:end]
        self.assertIn("Second user region", content)

    def test_extract_out_of_bounds_returns_none(self):
        result = edit_server._extract_user_region(FIXTURE_MD, 99)
        self.assertIsNone(result)

    def test_extract_no_user_regions_returns_none(self):
        result = edit_server._extract_user_region(FIXTURE_NO_USER, 0)
        self.assertIsNone(result)

    def test_extracted_content_does_not_include_markers(self):
        spans = edit_server._extract_user_region(FIXTURE_MD, 0)
        self.assertIsNotNone(spans)
        start, end = spans
        content = FIXTURE_MD[start:end]
        self.assertNotIn("user-start", content)
        self.assertNotIn("user-end", content)


# ---------------------------------------------------------------------------
# 2. Path allowlist
# ---------------------------------------------------------------------------

class TestPathAllowlist(unittest.TestCase):

    def test_knowledge_topics_allowed(self):
        self.assertTrue(edit_server._path_is_allowed("knowledge/topics/sex_chromosome.md"))

    def test_knowledge_papers_allowed(self):
        self.assertTrue(edit_server._path_is_allowed("knowledge/papers/10_1234_foo.md"))

    def test_knowledge_concepts_allowed(self):
        self.assertTrue(edit_server._path_is_allowed("knowledge/concepts/autosome.md"))

    def test_knowledge_methods_allowed(self):
        self.assertTrue(edit_server._path_is_allowed("knowledge/methods/parsimony.md"))

    def test_knowledge_courses_allowed(self):
        self.assertTrue(edit_server._path_is_allowed("knowledge/courses/biol3301.md"))

    def test_knowledge_projects_allowed(self):
        self.assertTrue(edit_server._path_is_allowed("knowledge/projects/fragile_y.md"))

    def test_knowledge_questions_allowed(self):
        self.assertTrue(edit_server._path_is_allowed("knowledge/questions/why_y.md"))

    def test_knowledge_paths_allowed(self):
        self.assertTrue(edit_server._path_is_allowed("knowledge/paths/intro.md"))

    def test_knowledge_contradictions_allowed(self):
        self.assertTrue(edit_server._path_is_allowed("knowledge/contradictions/y_fusion.md"))

    def test_agent_contract_allowed(self):
        self.assertTrue(edit_server._path_is_allowed("AGENT_CONTRACT.md"))

    def test_assets_rejected(self):
        self.assertFalse(edit_server._path_is_allowed("assets/js/v3.js"))

    def test_config_rejected(self):
        self.assertFalse(edit_server._path_is_allowed("_config.yml"))

    def test_data_file_rejected(self):
        self.assertFalse(edit_server._path_is_allowed("data/publications.json"))

    def test_layout_rejected(self):
        self.assertFalse(edit_server._path_is_allowed("_layouts/default.html"))

    def test_root_readme_rejected(self):
        self.assertFalse(edit_server._path_is_allowed("README.md"))

    def test_path_traversal_rejected(self):
        self.assertFalse(edit_server._path_is_allowed("../../../etc/passwd"))


# ---------------------------------------------------------------------------
# 3. region_grammar_ok integration — PATCH that would corrupt grammar is rejected
# ---------------------------------------------------------------------------

class TestPatchGrammarRejection(unittest.TestCase):

    def test_patch_that_breaks_grammar_rejected(self):
        """Inserting an orphan user-start into a file should be rejected."""
        tmp = _make_temp_repo(FIXTURE_MD)
        try:
            root = Path(tmp.name)
            # Patch REPO_ROOT so the server resolves files against our tmp dir
            with patch.object(edit_server, "REPO_ROOT", root):
                with patch.object(edit_server, "PROPOSALS_DIR", root / "data" / "wiki_proposals"):
                    with patch.object(edit_server, "AUDIT_LOG", root / "data" / "wiki_proposals" / "audit.log"):
                        from wiki_tools.accuracy import region_grammar_ok

                        # Read the file, find the first user region span
                        src = (root / "knowledge/topics/test.md").read_text(encoding="utf-8")
                        span = edit_server._extract_user_region(src, 0)
                        self.assertIsNotNone(span)
                        content_start, content_end = span

                        # Corrupt replacement: inject an unclosed user-start
                        bad_replacement = "<!-- user-start -->\norphan\n"
                        updated = src[:content_start] + bad_replacement + src[content_end:]

                        ok, problems = region_grammar_ok(updated)
                        self.assertFalse(ok, "Grammar should fail with orphan user-start")
                        self.assertTrue(len(problems) > 0)
        finally:
            tmp.cleanup()

    def test_valid_patch_passes_grammar(self):
        """A clean replacement should pass grammar check."""
        src = FIXTURE_MD
        span = edit_server._extract_user_region(src, 0)
        self.assertIsNotNone(span)
        content_start, content_end = span
        new_content = "Replacement prose that is safe.\n"
        updated = src[:content_start] + new_content + src[content_end:]

        from wiki_tools.accuracy import region_grammar_ok
        ok, problems = region_grammar_ok(updated)
        self.assertTrue(ok, f"Grammar should pass; problems: {problems}")


# ---------------------------------------------------------------------------
# 4. Propose-edit writes a timestamped file and returns a JSON-serializable id
# ---------------------------------------------------------------------------

class TestProposeEdit(unittest.TestCase):

    def _run_propose_via_handler(self, tmp_root: Path, payload: dict) -> dict:
        """Invoke the POST /propose-edit handler directly via a mock request."""
        import io

        body = json.dumps(payload).encode()

        # Build a minimal mock handler
        handler = edit_server.EditHandler.__new__(edit_server.EditHandler)
        handler.headers = {
            "Host": "127.0.0.1:4711",
            "Content-Length": str(len(body)),
            "Origin": "http://localhost:4000",
            "Content-Type": "application/json",
        }
        handler.rfile = io.BytesIO(body)
        handler.path = "/propose-edit"

        response_data = {}

        def fake_send_json(code, data, origin=None):
            response_data["code"] = code
            response_data["data"] = data

        handler._send_json = fake_send_json
        handler._check_host = lambda: True
        handler._origin = lambda: "http://localhost:4000"
        handler._read_body = lambda: body

        proposals_dir = tmp_root / "data" / "wiki_proposals"
        proposals_dir.mkdir(parents=True, exist_ok=True)

        with patch.object(edit_server, "REPO_ROOT", tmp_root), \
             patch.object(edit_server, "PROPOSALS_DIR", proposals_dir), \
             patch.object(edit_server, "AUDIT_LOG", proposals_dir / "audit.log"):
            # Ensure the topic file exists for slug resolution
            topic = tmp_root / "knowledge/topics/test.md"
            topic.parent.mkdir(parents=True, exist_ok=True)
            topic.write_text(FIXTURE_MD, encoding="utf-8")

            handler.do_POST()

        return response_data

    def test_propose_edit_creates_file(self):
        tmp = tempfile.TemporaryDirectory()
        try:
            root = Path(tmp.name)
            resp = self._run_propose_via_handler(root, {
                "path": "knowledge/topics/test.md",
                "region": "tealc:lead",
                "proposed_content": "I propose a better lead paragraph.",
                "rationale": "The current lead is unclear.",
            })
            self.assertEqual(resp["code"], 200)
            data = resp["data"]
            self.assertTrue(data.get("ok"))
            proposal_id = data.get("proposal_id")
            self.assertIsInstance(proposal_id, str)
            self.assertTrue(len(proposal_id) > 0)

            # File should exist
            proposals_dir = root / "data" / "wiki_proposals"
            files = [f for f in proposals_dir.iterdir() if f.suffix == ".md"]
            self.assertEqual(len(files), 1)
            content = files[0].read_text(encoding="utf-8")
            self.assertIn("tealc:lead", content)
            self.assertIn("I propose a better lead paragraph.", content)
        finally:
            tmp.cleanup()

    def test_propose_edit_id_is_json_serializable(self):
        tmp = tempfile.TemporaryDirectory()
        try:
            root = Path(tmp.name)
            resp = self._run_propose_via_handler(root, {
                "path": "knowledge/topics/test.md",
                "region": "tealc:auto",
                "proposed_content": "Better auto section.",
                "rationale": "Improvement.",
            })
            data = resp["data"]
            # Should serialize without error
            serialized = json.dumps(data)
            self.assertIsInstance(serialized, str)
        finally:
            tmp.cleanup()

    def test_propose_edit_rejected_outside_allowlist(self):
        tmp = tempfile.TemporaryDirectory()
        try:
            root = Path(tmp.name)
            resp = self._run_propose_via_handler(root, {
                "path": "assets/js/v3.js",
                "region": "tealc:lead",
                "proposed_content": "Attempt to modify JS.",
                "rationale": "Naughty.",
            })
            self.assertEqual(resp["code"], 403)
        finally:
            tmp.cleanup()


# ---------------------------------------------------------------------------
# 5. Concurrency: two simultaneous patches to the same file serialize correctly
# ---------------------------------------------------------------------------

class TestConcurrentPatches(unittest.TestCase):

    def test_two_concurrent_patches_do_not_race(self):
        """Two threads patching different user regions in the same file should
        both succeed and the final file should contain both edits."""
        tmp = _make_temp_repo(FIXTURE_MD)
        try:
            root = Path(tmp.name)
            target = root / "knowledge/topics/test.md"

            results: list[dict] = []
            errors: list[str] = []

            def patch_region(region_index: int, new_text: str):
                try:
                    with edit_server._FILE_LOCK:
                        src = target.read_text(encoding="utf-8")
                        span = edit_server._extract_user_region(src, region_index)
                        if span is None:
                            errors.append(f"region {region_index} not found")
                            return
                        cs, ce = span
                        replacement = new_text if new_text.endswith("\n") else new_text + "\n"
                        updated = src[:cs] + replacement + src[ce:]

                        from wiki_tools.accuracy import region_grammar_ok
                        ok, problems = region_grammar_ok(updated)
                        if not ok:
                            errors.append(f"grammar error: {problems}")
                            return

                        tmp_path = Path(str(target) + ".tmp")
                        tmp_path.write_text(updated, encoding="utf-8")
                        os.replace(str(tmp_path), str(target))
                        results.append({"region_index": region_index, "text": new_text})
                except Exception as exc:
                    errors.append(str(exc))

            # Run two patches "concurrently" — the lock ensures serialization
            t1 = threading.Thread(target=patch_region, args=(0, "Thread-1 edit for region 0."))
            t2 = threading.Thread(target=patch_region, args=(1, "Thread-2 edit for region 1."))
            t1.start()
            t2.start()
            t1.join(timeout=5)
            t2.join(timeout=5)

            self.assertEqual(errors, [], f"Unexpected errors: {errors}")
            self.assertEqual(len(results), 2, "Both patches should have succeeded")

            final = target.read_text(encoding="utf-8")
            self.assertIn("Thread-1 edit for region 0.", final)
            self.assertIn("Thread-2 edit for region 1.", final)
        finally:
            tmp.cleanup()


# ---------------------------------------------------------------------------
# 6. Resolve-safe: path traversal is rejected
# ---------------------------------------------------------------------------

class TestResolveSafe(unittest.TestCase):

    def test_traversal_rejected(self):
        result = edit_server._resolve_safe("../../etc/passwd")
        self.assertIsNone(result)

    def test_valid_path_resolved(self):
        result = edit_server._resolve_safe("knowledge/topics/foo.md")
        self.assertIsNotNone(result)
        self.assertTrue(str(result).endswith("knowledge/topics/foo.md"))


if __name__ == "__main__":
    unittest.main()
