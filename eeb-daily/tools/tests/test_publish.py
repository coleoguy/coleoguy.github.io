import copy
import json
import sys
import tempfile
import unittest
from datetime import date
from pathlib import Path
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import publish


def candidate(no=1, issue_date="2026-10-26"):
    """Test content; publisher integration uses the actual separate validator."""
    import datetime
    weekday = datetime.date.fromisoformat(issue_date).strftime("%A")
    classic = weekday in ("Tuesday", "Saturday")
    history = weekday == "Friday"
    stem = f"https://example.org/issue-{no}"
    result = {
        "no": no, "date": issue_date, "weekday": weekday,
        "lead": {"topic": f"Test topic {no}", "headline": "A test headline", "deck": "A test deck.",
                 "authors": "First A, Last B", "journal": "Test Journal", "pubdate": issue_date,
                 "doi": f"10.1234/test{no}", "url": f"https://doi.org/10.1234/test{no}",
                 "paragraphs": ["Research " * 95, "Evidence " * 95], "push": "Question " * 50},
        "people": [{"role": "First author", "name": "First Author", "bio": "Researcher " * 45,
                    "links": [{"label": "Profile", "url": stem + "/first"}]},
                   {"role": "Last author", "name": "Last Author", "bio": "Researcher " * 45,
                    "links": [{"label": "Profile", "url": stem + "/last"}]}],
        "slot2": {"kind": "CLASSIC" if classic else "BEYOND", "headline": f"Second test {no}",
                  "cite": f'<a href="{stem}/second">A citation</a>', "body": "Finding " * 95, "url": stem + "/second"},
        "slot3": {"kind": "HISTORY" if history else "SCIENCE", "headline": f"Third test {no}",
                  "cite": f'<a href="{stem}/third">A citation</a>', "body": "Finding " * (110 if history else 95),
                  "url": stem + "/third"},
        "tomorrow": "Classic and Beyond biology",
        "source_audit": [{"url": url, "title": "Test source", "used_for": part, "evidence": "Test fixture source evidence."}
                         for part, url in [("lead", f"https://doi.org/10.1234/test{no}"),
                                           ("person_1", stem + "/first"), ("person_2", stem + "/last"),
                                           ("slot2", stem + "/second"), ("slot3", stem + "/third")]],
    }
    if history:
        result["slot3"]["history_subject"] = f"Historical subject {no}"
    return result


class PublishTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.data = self.root / "eeb-daily/data"
        self.inbox = self.root / "eeb-daily/inbox"
        self.data.mkdir(parents=True)
        self.inbox.mkdir()

    def write_inbox(self, record, name=None):
        path = self.inbox / (name or record["date"] + ".json")
        path.write_text(json.dumps(record), encoding="utf-8")
        return path

    def archive(self, record):
        path = self.data / f'{record["no"]:04d}-{record["date"]}.json'
        path.write_text(json.dumps(record), encoding="utf-8")
        return path

    def accept(self, **kwargs):
        return publish.accept_pending(self.root, today=date(2026, 10, 26), **kwargs)

    def test_accept_and_replay_do_not_change_canonical_record(self):
        record = candidate()
        source = self.write_inbox(record)
        report = self.accept()
        target = self.data / "0001-2026-10-26.json"
        original = target.read_bytes()
        self.assertEqual(report["imported"], [target.name])
        self.assertFalse(source.exists())
        self.write_inbox(record)
        report = self.accept()
        self.assertEqual(report["replayed"], [source.name])
        self.assertEqual(original, target.read_bytes())
        self.assertFalse(source.exists())

    def test_dry_run_does_not_move_anything(self):
        source = self.write_inbox(candidate())
        report = self.accept(check=True)
        self.assertEqual(report["consumed"], 1)
        self.assertTrue(source.exists())
        self.assertEqual(list(self.data.iterdir()), [])

    def test_invalid_later_candidate_leaves_entire_batch_untouched(self):
        first = self.write_inbox(candidate())
        bad = candidate(2, "2026-10-27")
        bad["lead"]["paragraphs"] = ["too short", "too short"]
        second = self.write_inbox(bad)
        with self.assertRaises(publish.PublishError):
            self.accept()
        self.assertTrue(first.exists())
        self.assertTrue(second.exists())
        self.assertEqual(list(self.data.iterdir()), [])

    def test_conflicting_replay_rejects_and_preserves_archive(self):
        record = candidate()
        target = self.archive(record)
        original = target.read_bytes()
        altered = copy.deepcopy(record)
        altered["lead"]["headline"] = "Changed without approval"
        source = self.write_inbox(altered)
        with self.assertRaisesRegex(publish.PublishError, "conflicts"):
            self.accept()
        self.assertTrue(source.exists())
        self.assertEqual(original, target.read_bytes())

    def test_filename_mismatch_rejects(self):
        self.write_inbox(candidate(), "2026-10-27.json")
        with self.assertRaisesRegex(publish.PublishError, "filename does not match"):
            self.accept()

    def test_sequential_batch_uses_prior_candidates_as_dedup_context(self):
        self.write_inbox(candidate())
        duplicate = candidate(2, "2026-10-27")
        duplicate["slot2"]["url"] = candidate()["slot3"]["url"]
        self.write_inbox(duplicate)
        with self.assertRaises(publish.PublishError):
            self.accept()
        self.assertEqual(list(self.data.iterdir()), [])

    def test_old_archive_does_not_need_new_audit_fields(self):
        old = {"no": 1, "date": "2026-10-24", "lead": {}, "slot2": {}, "slot3": {}}
        self.archive(old)
        self.write_inbox(candidate(2))
        report = self.accept()
        self.assertEqual(report["latest_no"], 2)

    def test_symlink_is_rejected_without_reading_target(self):
        target = self.root / "external.json"
        target.write_text(json.dumps(candidate()))
        (self.inbox / "2026-10-26.json").symlink_to(target)
        with self.assertRaisesRegex(publish.PublishError, "not a link"):
            self.accept()

    def test_malformed_json_cannot_publish(self):
        (self.inbox / "2026-10-26.json").write_text('{"no": 1')
        with self.assertRaisesRegex(publish.PublishError, "invalid UTF-8 JSON"):
            self.accept()
        self.assertEqual(list(self.data.iterdir()), [])

    def test_no_inbox_is_a_noop(self):
        self.inbox.rmdir()
        self.assertEqual(self.accept()["consumed"], 0)

    def test_tomorrows_issue_is_allowed(self):
        self.write_inbox(candidate(1, "2026-10-27"))
        self.assertEqual(self.accept()["latest_date"], "2026-10-27")

    def test_day_after_tomorrow_cannot_replace_latest_issue(self):
        existing = candidate(1)
        original = self.archive(existing).read_bytes()
        future = self.write_inbox(candidate(2, "2026-10-28"))
        with self.assertRaisesRegex(publish.PublishError, "later than tomorrow"):
            self.accept()
        self.assertTrue(future.exists())
        self.assertEqual((self.data / "0001-2026-10-26.json").read_bytes(), original)
        self.assertEqual(len(list(self.data.iterdir())), 1)

    def test_distant_future_rejects_whole_batch(self):
        current = self.write_inbox(candidate(1))
        future = self.write_inbox(candidate(2, "2099-01-01"))
        with self.assertRaisesRegex(publish.PublishError, "later than tomorrow"):
            self.accept()
        self.assertTrue(current.exists())
        self.assertTrue(future.exists())
        self.assertEqual(list(self.data.iterdir()), [])


if __name__ == "__main__":
    unittest.main()
