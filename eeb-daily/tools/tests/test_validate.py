import copy
import importlib.util
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest


VALIDATOR = Path(__file__).resolve().parents[1] / "validate.py"
spec = importlib.util.spec_from_file_location("validate", VALIDATOR)
validate = importlib.util.module_from_spec(spec)
spec.loader.exec_module(validate)


def words(n):
    return " ".join(["evidence"] * n)


def candidate():
    return {
        "no": 10, "date": "2026-10-26", "weekday": "Monday",
        "lead": {
            "topic": "Phylogenetic comparative methods", "headline": "A testable headline",
            "deck": "A sourced description.", "authors": "Author A, Author B",
            "journal": "Evolution", "pubdate": "24 Oct 2026",
            "doi": "10.1234/new-paper", "url": "https://doi.org/10.1234/new-paper",
            "paragraphs": [words(90), words(90)], "push": words(50),
        },
        "people": [
            {"role": role, "name": name, "bio": words(40),
             "links": [{"label": "Faculty page", "url": "https://university.edu/" + name}]}
            for role, name in (("First author", "Alpha"), ("Last author", "Beta"))
        ],
        "slot2": {"kind": "BEYOND", "headline": "Another paper",
                  "cite": '<a href="https://doi.org/10.1234/second">Primary paper</a>',
                  "url": "https://doi.org/10.1234/second", "body": words(90)},
        "slot3": {"kind": "SCIENCE", "headline": "Another science story",
                  "cite": '<a href="https://science.org/new-story">Primary source</a>',
                  "url": "https://science.org/new-story", "body": words(90)},
        "tomorrow": "Classic and Beyond biology",
        "source_audit": [
            {"url": "https://example.org/source/" + use, "title": "Primary source",
             "used_for": use, "evidence": "A concise note on the evidence actually inspected."}
            for use in sorted(validate.AUDIT_USES)
        ],
    }


def archive():
    # Deliberately does not conform to the new schema. Legacy issues are context.
    return [{"no": 9, "date": "2026-10-24", "lead": {"topic": "Chromosome numbers",
            "doi": "10.1234/old-paper", "url": "https://doi.org/10.1234/old-paper"},
            "slot2": {"url": "https://science.org/old-story"}, "slot3": {"kind": "SCIENCE"}}]


class ValidationTests(unittest.TestCase):
    def assertInvalid(self, record, fragment, previous=None):
        errors = validate.validate_record(record, archive() if previous is None else previous)
        self.assertTrue(any(fragment in error for error in errors), errors)

    def test_valid_candidate_and_legacy_context_are_not_mutated(self):
        record, previous = candidate(), archive()
        before = copy.deepcopy((record, previous))
        self.assertEqual(validate.validate_record(record, previous, "2026-10-26"), [])
        self.assertEqual((record, previous), before)

    def test_doi_case_resolver_alias_and_encoded_path_are_deduplicated(self):
        record = candidate()
        record["slot2"]["url"] = "http://dx.doi.org/10.1234/OLD%2DPAPER#abstract"
        self.assertInvalid(record, "slot2 repeats a paper or story URL/DOI in the archive")

    def test_citation_doi_prevents_cross_slot_repeat(self):
        record = candidate()
        record["slot3"]["cite"] = '<a href="https://doi.org/10.1234/SECOND">Same paper</a>'
        self.assertInvalid(record, "slot3 repeats a paper or story from another slot")

    def test_tracking_parameters_do_not_hide_archived_story(self):
        record = candidate()
        record["slot3"]["url"] = "http://www.science.org/old-story/?utm_source=newsletter#section"
        self.assertInvalid(record, "slot3 repeats a paper or story URL/DOI in the archive")

    def test_doi_field_matches_doi_url(self):
        record = candidate()
        record["lead"]["url"] = "https://doi.org/10.1234/something-else"
        self.assertInvalid(record, "lead.doi does not match")

    def test_optional_side_story_doi_has_safe_type_and_matches_resolver(self):
        for slot in ("slot2", "slot3"):
            for value in (123, None, [], {}, "", "https://doi.org/10.1234/second", "not-a-doi"):
                with self.subTest(slot=slot, value=value):
                    record = candidate()
                    record[slot]["doi"] = value
                    self.assertInvalid(record, slot + ".doi must be")
            record = candidate()
            record[slot].update(doi="10.1234/mismatch", url="https://doi.org/10.1234/expected")
            self.assertInvalid(record, slot + ".doi does not match its DOI URL")
        record = candidate()
        record["slot2"]["doi"] = "10.1234/second"
        record["slot3"]["doi"] = "10.1234/third"
        self.assertEqual(validate.validate_record(record, archive()), [])

    def test_html_executable_attributes_scripts_and_unbalanced_tags_rejected(self):
        for value in ("<script>alert(1)</script>", '<em onclick="alert(1)">Hi</em>',
                      '<a href="javascript:alert(1)">Hi</a>',
                      '<a href="https://valid.org" style="color:red">Hi</a>',
                      "<em>Unclosed", "<!-- comment -->", "<em/>Hi"):
            with self.subTest(value=value):
                record = candidate()
                record["lead"]["headline"] = value
                self.assertTrue(validate.validate_record(record, archive()))

    def test_safe_inline_html_and_entities_are_allowed(self):
        record = candidate()
        record["lead"]["headline"] = 'A <em>new</em> H<sub>2</sub> result &amp; x<sup>2</sup>'
        self.assertEqual(validate.validate_record(record, archive()), [])

    def test_unfinished_markup_cannot_be_completed_by_the_renderer(self):
        # HTMLParser otherwise reports an unfinished opening tag as plain data.
        # The renderer appends </h2>, which supplies '>' and activates the tag.
        for value in ('<img src=x onerror=console.log(1)//', '<a href="https://example.org"',
                      '<em', 'A comparison: 2 < 3', '<'):
            with self.subTest(value=value):
                record = candidate()
                record["lead"]["headline"] = value
                self.assertInvalid(record, "raw '<' outside a complete allowed HTML tag")

    def test_escaped_angle_brackets_remain_harmless_text(self):
        record = candidate()
        record["lead"]["headline"] = 'A comparison: 2 &lt; 3 and &#60;img&#62; is text'
        self.assertEqual(validate.validate_record(record, archive()), [])
        self.assertEqual(validate.word_count("2 &lt; 3"), 3)

    def test_optional_renderer_fields_require_nonempty_strings(self):
        for location, key in (("root", "producer"), ("root", "motto"),
                              ("slot2", "topic"), ("slot2", "kicker"),
                              ("slot3", "topic"), ("slot3", "kicker")):
            for value in (123, None, [], {}, " "):
                with self.subTest(location=location, key=key, value=value):
                    record = candidate()
                    target = record if location == "root" else record[location]
                    target[key] = value
                    self.assertInvalid(record, key + " must be a nonempty string")
        record = candidate()
        record.update(producer="ChatGPT", motto="One paper worth the coffee.")
        record["slot2"].update(topic="Biophysics", kicker="Beyond EEB")
        self.assertEqual(validate.validate_record(record, archive()), [])

    def test_entity_encoded_dangerous_link_rejected(self):
        record = candidate()
        record["slot2"]["cite"] = '<a href="java&#x73;cript:alert(1)">Danger</a>'
        self.assertInvalid(record, "exactly one safe HTTP(S) href")

    def test_raw_and_entity_em_dashes_rejected(self):
        for value in ("word\u2014word", "word&mdash;word", "word&#8212;word"):
            record = candidate()
            record["lead"]["headline"] = value
            self.assertInvalid(record, "em dash")

    def test_unsafe_urls_rejected(self):
        for value in ("javascript:alert(1)", "//example.org", "https://a:b@example.org",
                      "https://example.org\n/path", "https://example.org:bad", "https://example.org\\@evil.org"):
            self.assertFalse(validate.valid_url(value), value)

    def test_date_number_and_weekday_guards(self):
        for key, value, fragment in (("no", True, "positive integer"),
                                     ("no", 11, "next issue number"),
                                     ("date", "../../escape", "real calendar date"),
                                     ("date", "2026-02-30", "real calendar date"),
                                     ("date", "2026-10-24", "already exists"),
                                     ("date", "2026-10-23", "later than"),
                                     ("weekday", "Sunday", "does not match")):
            with self.subTest(key=key, value=value):
                record = candidate()
                record[key] = value
                self.assertInvalid(record, fragment)
        self.assertIn("record.date must match the expected date (2026-10-27)",
                      validate.validate_record(candidate(), archive(), "2026-10-27"))

    def test_tuesday_requires_classic(self):
        record = candidate()
        record.update(date="2026-10-27", weekday="Tuesday")
        self.assertInvalid(record, "slot2.kind must be CLASSIC")
        record["slot2"]["kind"] = "CLASSIC"
        self.assertEqual(validate.validate_record(record, archive()), [])

    def test_history_only_on_friday_and_no_subject_repeats(self):
        record = candidate()
        record.update(date="2026-10-30", weekday="Friday")
        self.assertInvalid(record, "must be HISTORY on Friday")
        record["slot3"].update(kind="HISTORY", body=words(110), history_subject="Nettie Stevens")
        self.assertEqual(validate.validate_record(record, archive()), [])
        previous = archive()
        previous[0]["slot3"].update(kind="HISTORY", history_subject=" NETTIE, Stevens ")
        self.assertInvalid(record, "history_subject already appears", previous)

    def test_academia_frequency_and_required_why(self):
        record = candidate()
        record["slot3"].update(kind="ACADEMIA", body=words(80), why=words(35))
        self.assertEqual(validate.validate_record(record, archive()), [])
        previous = archive()
        previous[0]["slot3"]["kind"] = "ACADEMIA"
        self.assertInvalid(record, "ACADEMIA already appeared", previous)
        record["slot3"].pop("why")
        self.assertInvalid(record, "slot3.why must be a nonempty string")

    def test_word_count_borders_and_html(self):
        record = candidate()
        record["slot3"]["body"] = "<em>" + words(110) + "</em>"
        self.assertEqual(validate.validate_record(record, archive()), [])
        record["slot3"]["body"] = words(111)
        self.assertInvalid(record, "slot3.body has 111 words")

    def test_source_audit_requires_all_roles(self):
        record = candidate()
        record["source_audit"] = [entry for entry in record["source_audit"] if entry["used_for"] != "person_2"]
        self.assertInvalid(record, "missing evidence for: person_2")
        record = candidate()
        record["source_audit"][0]["used_for"] = ["lead"]
        self.assertInvalid(record, ".used_for must be")

    def test_people_need_professional_sources(self):
        record = candidate()
        record["people"][0]["links"] = []
        self.assertInvalid(record, "at least one public professional source")

    def test_malformed_types_return_errors_instead_of_crashing(self):
        self.assertEqual(validate.validate_record([], archive()), ["record must be a JSON object"])
        for key, value in (("lead", None), ("slot2", []), ("slot3", True), ("people", [None, {}]),
                           ("source_audit", [None, {"used_for": []}])):
            record = candidate()
            record[key] = value
            self.assertTrue(validate.validate_record(record, archive()))
        record = candidate()
        record["slot2"]["kind"] = []
        record["slot3"]["kind"] = {}
        self.assertTrue(validate.validate_record(record, archive()))

    def test_exact_topic_rotation(self):
        record = candidate()
        record["lead"]["topic"] = "Chromosome numbers"
        self.assertInvalid(record, "topic repeats one of the previous two")

    def test_cli_exit_status_and_json_diagnostics(self):
        with tempfile.TemporaryDirectory() as temp:
            directory = Path(temp)
            data = directory / "data"
            data.mkdir()
            (data / "0009-2026-10-24.json").write_text(json.dumps(archive()[0]))
            path = directory / "2026-10-26.json"
            path.write_text(json.dumps(candidate()))
            command = [sys.executable, str(VALIDATOR), str(path), "--data-dir", str(data)]
            result = subprocess.run(command, capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertTrue(json.loads(result.stdout)["valid"])
            path.write_text("not JSON")
            result = subprocess.run(command, capture_output=True, text=True)
            self.assertEqual(result.returncode, 1)
            self.assertFalse(json.loads(result.stdout)["valid"])


if __name__ == "__main__":
    unittest.main()
