"""
Unit tests for wiki_tools.accuracy.

Run with:
    python -m unittest wiki_tools.tests.test_accuracy
"""

import unittest

from wiki_tools.accuracy import digit_substring_ok, region_grammar_ok, synthesis_rouge_ok, _strip_claim_metadata


class TestDigitSubstringOk(unittest.TestCase):

    # --- exact pass ---

    def test_exact_pass_simple(self):
        passes, reason = digit_substring_ok("67%", "across 10,754 species... 67%...")
        self.assertTrue(passes)
        self.assertEqual(reason, 'exact')

    def test_exact_pass_in_long_quote(self):
        passes, reason = digit_substring_ok(
            "41% vs 5%",
            "41% of XY lineages show turnover, 5% of ZW show the same"
        )
        self.assertTrue(passes)
        self.assertEqual(reason, 'exact')

    # --- exact fail ---

    def test_exact_fail_no_tilde(self):
        passes, reason = digit_substring_ok("28%", "27%...", allow_tilde=False)
        self.assertFalse(passes)
        self.assertEqual(reason, '28')

    # --- tilde pass ---

    def test_tilde_pass_within_10_percent(self):
        # 28% is within 10% of 27.8%  (27.8 * 1.10 = 30.58, 27.8 * 0.90 = 25.02)
        passes, reason = digit_substring_ok("~28%", "27.8%...")
        self.assertTrue(passes)
        self.assertEqual(reason, 'tilde_match')

    def test_tilde_pass_word_approximately(self):
        passes, reason = digit_substring_ok("approximately 28%", "27.8%...")
        self.assertTrue(passes)
        self.assertEqual(reason, 'tilde_match')

    def test_tilde_pass_word_about(self):
        passes, reason = digit_substring_ok("about 28%", "27.8%...")
        self.assertTrue(passes)
        self.assertEqual(reason, 'tilde_match')

    def test_tilde_pass_exact_still_preferred(self):
        # Even when tilde is present, exact match returns 'exact'
        passes, reason = digit_substring_ok("~67%", "...67% of species...")
        self.assertTrue(passes)
        self.assertEqual(reason, 'exact')

    # --- tilde fail ---

    def test_tilde_fail_outside_10_percent(self):
        # 50% is far from 27.8%
        passes, reason = digit_substring_ok("~50%", "27.8%...")
        self.assertFalse(passes)
        self.assertEqual(reason, '50')

    # --- multi-numeric pass ---

    def test_multi_numeric_pass(self):
        passes, reason = digit_substring_ok(
            "41% vs 5%",
            "41% of XY, 5% of ZW"
        )
        self.assertTrue(passes)
        self.assertEqual(reason, 'exact')

    # --- multi-numeric fail ---

    def test_multi_numeric_fail_second_token(self):
        passes, reason = digit_substring_ok(
            "41% vs 5%",
            "41% of XY, 3% of ZW"
        )
        self.assertFalse(passes)
        self.assertEqual(reason, '5')

    # --- normalization ---

    def test_non_breaking_space_normalization(self):
        # NBSP in quote should still match
        claim = "67%"
        quote = "across\u00a067%\u00a0of species"
        passes, reason = digit_substring_ok(claim, quote)
        self.assertTrue(passes)
        self.assertEqual(reason, 'exact')

    def test_thousand_comma_normalization_claim_matches_quote(self):
        # Claim says "10754", quote says "10,754" — after normalization both are "10754"
        passes, reason = digit_substring_ok("10754 species", "10,754 species examined")
        self.assertTrue(passes)
        self.assertEqual(reason, 'exact')

    def test_thousand_comma_in_quote(self):
        # Claim "10,754", quote "10,754" — both normalize to "10754"
        passes, reason = digit_substring_ok("10,754", "...10,754 records...")
        self.assertTrue(passes)
        self.assertEqual(reason, 'exact')

    # --- no-numeric claim ---

    def test_no_numeric_tokens(self):
        # Claim with no numbers always passes
        passes, reason = digit_substring_ok("sex chromosomes", "Y chromosome degeneration")
        self.assertTrue(passes)
        self.assertEqual(reason, 'exact')

    # --- author-year citation stripping (Phase 3 normalizer) ---

    def test_author_year_paren_stripped(self):
        # "Charlesworth & Charlesworth (1980)" — 1980 is a bibliographic label,
        # not a measured value.  The quote mentions the same year in no form.
        claim = (
            "The analytic foundations were worked out by "
            "Charlesworth & Charlesworth (1980): a necessary condition is..."
        )
        quote = (
            "a necessary condition for selection to favour a fusion between "
            "an autosome and a sex chromosome is that the alleles at the locus "
            "are maintained at different frequencies in the two sexes"
        )
        passes, reason = digit_substring_ok(claim, quote)
        self.assertTrue(passes, f"Expected pass but got FAIL reason={reason!r}")
        self.assertEqual(reason, 'exact')

    def test_et_al_year_paren_stripped(self):
        # "Pennell et al. (2015)" — year is a citation label.
        claim = "Pennell et al. (2015) modeled the frequency of Y-autosome fusions."
        quote = "Y-autosome fusions are predicted to increase at three times the rate of X-autosome fusions."
        passes, reason = digit_substring_ok(claim, quote)
        self.assertTrue(passes, f"Expected pass but got FAIL reason={reason!r}")

    def test_et_al_year_no_paren_stripped(self):
        # "Herman et al. 2018" — no parens around year.
        claim = "FST outlier data (Herman et al. 2018) was integrated with circadian data."
        quote = "we generated a Shiny database, CaveCrawler, which combines population genetics"
        passes, reason = digit_substring_ok(claim, quote)
        self.assertTrue(passes, f"Expected pass but got FAIL reason={reason!r}")

    def test_prose_year_the_stripped(self):
        # "the 2020 study" — prose reference to a year.
        claim = "The authors of the 2020 microsats study note that rates differ."
        quote = "we found no significant relationship between chromosome number and microsatellite rates."
        passes, reason = digit_substring_ok(claim, quote)
        self.assertTrue(passes, f"Expected pass but got FAIL reason={reason!r}")

    def test_prose_year_a_stripped(self):
        # "a 2024 study" — prose reference to a year.
        claim = "A 2024 study of Galliform birds found that domestication status is significant."
        quote = "we found a significant relationship between domestication and reproductive compatibility."
        passes, reason = digit_substring_ok(claim, quote)
        self.assertTrue(passes, f"Expected pass but got FAIL reason={reason!r}")

    def test_author_year_does_not_strip_real_measurement(self):
        # The year-like number 1980 appears as a genuine count, not a citation year.
        # Claim: "a gene count of 1980 was observed" — 1980 is a real value.
        claim = "a gene count of 1980 was observed in the analysis"
        quote = "gene count of 1980 across the sampled taxa"
        passes, reason = digit_substring_ok(claim, quote)
        self.assertTrue(passes, f"Measurement 1980 should still match: {reason!r}")

    # --- CI percentage label stripping (Phase 3 normalizer) ---

    def test_ci_percent_label_stripped(self):
        # "95% credible interval" — 95 is a CI width label, not a measured value.
        # The quote contains the actual bounds (0.062–0.141) but not "95".
        claim = (
            "In Carnivora, lineages with small ranges show elevated fusion rates "
            "(ΔR = 0.101, 95% credible interval 0.062–0.141)."
        )
        quote = (
            "We found a ΔR fusion of 0.101 (CI 0.062 to 0.141) and a "
            "ΔR fission of 0.163 (CI 0.116 to 0.207)"
        )
        passes, reason = digit_substring_ok(claim, quote)
        self.assertTrue(passes, f"Expected pass but got FAIL reason={reason!r}")

    def test_ci_percent_abbreviated_stripped(self):
        # "95% CI" abbreviation.
        claim = "The difference has 95% CI 0.062 to 0.141."
        quote = "We found a ΔR fusion of 0.101 (CI 0.062 to 0.141)"
        passes, reason = digit_substring_ok(claim, quote)
        self.assertTrue(passes, f"Expected pass but got FAIL reason={reason!r}")

    def test_ci_percent_does_not_strip_real_percentage(self):
        # "67%" is a real percentage measurement, not a CI label — must still be checked.
        # Quote deliberately does not contain "67" so the check fails as expected.
        claim = "67% of species showed the pattern."
        quote = "a significant relationship between traits was observed"
        passes, reason = digit_substring_ok(claim, quote)
        self.assertFalse(passes)
        self.assertEqual(reason, '67')


class TestRegionGrammarOk(unittest.TestCase):

    def test_matched_tealc_region(self):
        md = "<!-- tealc:auto-start -->\ntext\n<!-- tealc:auto-end -->"
        ok, problems = region_grammar_ok(md)
        self.assertTrue(ok)
        self.assertEqual(problems, [])

    def test_matched_user_region(self):
        md = "<!-- user-start -->\ntext\n<!-- user-end -->"
        ok, problems = region_grammar_ok(md)
        self.assertTrue(ok)
        self.assertEqual(problems, [])

    def test_orphan_start_tealc(self):
        md = "<!-- tealc:auto-start -->\ntext"
        ok, problems = region_grammar_ok(md)
        self.assertFalse(ok)
        self.assertTrue(any('orphan start' in p and 'tealc:auto' in p for p in problems))

    def test_orphan_end_tealc(self):
        md = "<!-- tealc:auto-end -->\ntext"
        ok, problems = region_grammar_ok(md)
        self.assertFalse(ok)
        self.assertTrue(any('orphan end' in p and 'tealc:auto' in p for p in problems))

    def test_orphan_start_user(self):
        md = "<!-- user-start -->\ntext"
        ok, problems = region_grammar_ok(md)
        self.assertFalse(ok)
        self.assertTrue(any('orphan start' in p and 'user' in p for p in problems))

    def test_orphan_end_user(self):
        md = "<!-- user-end -->\ntext"
        ok, problems = region_grammar_ok(md)
        self.assertFalse(ok)
        self.assertTrue(any('orphan end' in p and 'user' in p for p in problems))

    def test_nested_same_name_fails(self):
        md = (
            "<!-- tealc:auto-start -->\n"
            "<!-- tealc:auto-start -->\n"
            "text\n"
            "<!-- tealc:auto-end -->\n"
            "<!-- tealc:auto-end -->"
        )
        ok, problems = region_grammar_ok(md)
        self.assertFalse(ok)
        self.assertTrue(any('nested' in p for p in problems))

    def test_sequential_different_regions_pass(self):
        md = (
            "<!-- tealc:auto-start -->\nblock1\n<!-- tealc:auto-end -->\n"
            "<!-- tealc:related-start -->\nblock2\n<!-- tealc:related-end -->"
        )
        ok, problems = region_grammar_ok(md)
        self.assertTrue(ok)
        self.assertEqual(problems, [])

    def test_multiple_tealc_regions_and_user_region(self):
        md = (
            "<!-- tealc:auto-start -->\nauto text\n<!-- tealc:auto-end -->\n"
            "<!-- user-start -->\nuser text\n<!-- user-end -->"
        )
        ok, problems = region_grammar_ok(md)
        self.assertTrue(ok)
        self.assertEqual(problems, [])

    def test_empty_document(self):
        ok, problems = region_grammar_ok("")
        self.assertTrue(ok)
        self.assertEqual(problems, [])


class TestSynthesisRougeOk(unittest.TestCase):

    def test_identical_strings_pass(self):
        text = "sex chromosomes evolve rapidly in beetles"
        self.assertTrue(synthesis_rouge_ok(text, [text]))

    def test_totally_different_fail(self):
        self.assertFalse(
            synthesis_rouge_ok(
                "completely different unrelated words here",
                ["sex chromosomes evolve rapidly in beetles"]
            )
        )

    def test_paraphrase_passes(self):
        quote = "sex chromosomes evolve rapidly and show high turnover rates in insects"
        claim = "sex chromosomes show rapid turnover in insects"
        # There is substantial overlap — should exceed 0.35
        self.assertTrue(synthesis_rouge_ok(claim, [quote]))

    def test_empty_claim_fails(self):
        self.assertFalse(synthesis_rouge_ok("", ["some text here"]))

    def test_empty_quotes_fails(self):
        self.assertFalse(synthesis_rouge_ok("some claim here", []))

    def test_both_empty_fails(self):
        self.assertFalse(synthesis_rouge_ok("", []))

    def test_multiple_quotes_concatenated(self):
        # Claim draws from two different findings
        claim = "Y chromosomes degenerate and loss occurs frequently"
        quotes = [
            "Y chromosomes undergo extensive degeneration over evolutionary time",
            "loss of the Y chromosome occurs frequently across diverse taxa",
        ]
        self.assertTrue(synthesis_rouge_ok(claim, quotes))

    def test_threshold_boundary(self):
        # A very short claim that matches exactly should be well above 0.35
        claim = "rapid evolution"
        quotes = ["rapid evolution of sex chromosomes"]
        self.assertTrue(synthesis_rouge_ok(claim, quotes, threshold=0.35))

    def test_below_threshold_fails(self):
        # Single word match against long quote — F-score will be low
        claim = "mammals"
        quotes = ["sex chromosomes evolve rapidly and show extensive degeneration in insects"]
        self.assertFalse(synthesis_rouge_ok(claim, quotes, threshold=0.35))


class TestClaimSegmentation(unittest.TestCase):
    """Tests for validate_surface._claim_segments_for_line — the per-citation
    partitioning that prevents multi-cite contamination (numerics from one
    citation's prose leaking into another citation's claim check)."""

    def setUp(self):
        # Deferred imports so a broken validate_surface never breaks the rest
        # of the accuracy test suite.
        from wiki_tools.validate_surface import (
            _claim_segments_for_line,
            INLINE_CITE_RE,
        )
        self._segment = _claim_segments_for_line
        self._cite_re = INLINE_CITE_RE

    def test_single_citation_no_bullet(self):
        line = (
            "About 67% of surveyed species exhibit XX/XY systems "
            "([Jonika et al. 2022, Finding 1]"
            "(/knowledge/papers/jonika_2022/#finding-1))."
        )
        matches = list(self._cite_re.finditer(line))
        segs = self._segment(line, matches)
        self.assertEqual(len(segs), 1)
        self.assertIn('67', segs[0])
        # Markdown link should be stripped: DOI fragments and slug digits gone
        self.assertNotIn('jonika_2022', segs[0])
        self.assertNotIn('finding-1', segs[0])

    def test_multi_citation_partitions_numerics(self):
        # The canonical multi-cite contamination failure: Finding A's 77%
        # appears in a segment that then gets checked against Finding B's
        # quote (which doesn't have 77%) and falsely fails. This test asserts
        # each segment contains only its own prose's numerics.
        line = (
            "Male heterogamety covers 77% of insect orders "
            "([Blackmon & Demuth 2015, Finding 1]"
            "(/knowledge/papers/bd_2015/#finding-1)), "
            "while female heterogamety accounts for 42% of the rest "
            "([Blackmon et al. 2017, Finding 2]"
            "(/knowledge/papers/b_2017/#finding-2))."
        )
        matches = list(self._cite_re.finditer(line))
        segs = self._segment(line, matches)
        self.assertEqual(len(segs), 2)
        # First segment sees only 77%; must NOT see 42%
        self.assertIn('77', segs[0])
        self.assertNotIn('42', segs[0])
        # Second segment sees only 42%; must NOT see 77%
        self.assertIn('42', segs[1])
        self.assertNotIn('77', segs[1])

    def test_bullet_prefix_stripped_only_on_first_segment(self):
        line = (
            "- Finding with 50% rate "
            "([Paper X, Finding 1]"
            "(/knowledge/papers/px/#finding-1))."
        )
        matches = list(self._cite_re.finditer(line))
        segs = self._segment(line, matches)
        self.assertEqual(len(segs), 1)
        # Leading "- " must be gone, but the content remains
        self.assertFalse(segs[0].startswith('-'))
        self.assertIn('50', segs[0])

    def test_three_citations_each_own_segment(self):
        line = (
            "Finding A reports 10 "
            "([P1 2020, Finding 1](/knowledge/papers/p1/#finding-1)), "
            "Finding B reports 20 "
            "([P2 2021, Finding 1](/knowledge/papers/p2/#finding-1)), "
            "and Finding C reports 30 "
            "([P3 2022, Finding 1](/knowledge/papers/p3/#finding-1))."
        )
        matches = list(self._cite_re.finditer(line))
        segs = self._segment(line, matches)
        self.assertEqual(len(segs), 3)
        # Each segment contains only its own numeric
        self.assertIn('10', segs[0])
        self.assertNotIn('20', segs[0])
        self.assertNotIn('30', segs[0])
        self.assertIn('20', segs[1])
        self.assertNotIn('10', segs[1])
        self.assertNotIn('30', segs[1])
        self.assertIn('30', segs[2])
        self.assertNotIn('10', segs[2])
        self.assertNotIn('20', segs[2])

    def test_no_citations_returns_empty(self):
        line = "A line of prose with no citations at all."
        matches = list(self._cite_re.finditer(line))
        segs = self._segment(line, matches)
        self.assertEqual(segs, [])

    def test_digit_substring_ok_against_partitioned_segment(self):
        # End-to-end: partition, then run the real accuracy check on each
        # segment — demonstrates that the multi-cite contamination is fixed.
        line = (
            "Y-autosome fusions reach 41% in fishes "
            "([Pennell et al. 2015, Finding 1]"
            "(/knowledge/papers/pennell_2015/#finding-1)) "
            "versus only 5% in ZW systems "
            "([Pennell et al. 2015, Finding 2]"
            "(/knowledge/papers/pennell_2015/#finding-2))."
        )
        matches = list(self._cite_re.finditer(line))
        segs = self._segment(line, matches)
        # Finding 1's quote has 41% only; Finding 2's quote has 5% only
        quote_f1 = "In fishes 41% of XY species have fused sex chromosomes"
        quote_f2 = "In fishes only 5% of ZW species have fused sex chromosomes"
        passes1, _ = digit_substring_ok(segs[0], quote_f1)
        passes2, _ = digit_substring_ok(segs[1], quote_f2)
        self.assertTrue(passes1,
                        f"segment 0 should match F1 quote; seg={segs[0]!r}")
        self.assertTrue(passes2,
                        f"segment 1 should match F2 quote; seg={segs[1]!r}")


if __name__ == '__main__':
    unittest.main()
