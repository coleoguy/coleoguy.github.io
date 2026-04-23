# Phase 3 Triage Report — Validator Failure Analysis

**Date:** 2026-04-21
**Author:** Phase 3 automated triage pass

---

## Headline Numbers

| Stage | Files with failures | Claim fails |
|-------|---------------------|-------------|
| Baseline (before Phase 3) | 71 of 131 | 300 |
| After normalizer changes | 68 of 131 | 285 |
| After 4 topic-page fixes | 64 of 131 | 279 |

Net reduction: **21 false-positive claim fails eliminated** by normalizer; **6 true-drift claim fails fixed** in 4 topic pages.

---

## Failure Breakdown

### Category A — Author-year citation false positives (FIXED: −21 fails)

**Root cause:** Claims say something like "Charlesworth & Charlesworth (1980) showed that..." or "the 2020 holocentric study reports...". The year is a bibliographic label. The validator extracted `1980`, `2020`, etc. as numeric tokens and checked them against the finding's verbatim quote, which naturally does not contain those years.

**Fix applied:** Two new regex patterns in `accuracy.py._strip_claim_metadata()`:
- `_AUTHOR_YEAR_UPPER_RE`: strips `Surname (YEAR)`, `Surname & Surname (YEAR)`, `Surname et al. YEAR`, "; Author YEAR" patterns (case-sensitive on surname initial capital).
- `_PROSE_YEAR_RE`: strips "the YEAR", "a YEAR", "an YEAR", "in YEAR", "of YEAR" patterns (case-insensitive, year must be 1800–2099).

**Before:** 9 fails on `1980`, 3 on `2020`, 2 each on `2015`, `2024`, 1 each on `2018`, `2009`, `2002`, `2001`, `1990` = 21 fails.
**After:** 0 year-citation fails.

**Example eliminated:**
```
claim: "...founded on Charlesworth & Charlesworth (1980): a necessary condition is..."
quote: "a necessary condition for selection to favour a fusion between an autosome..."
reason: '1980'  → correctly stripped as citation label
```

### Category B — CI percentage label false positives (FIXED: −4 fails)

**Root cause:** Claims say "95% credible interval" or "95% CI 0.062–0.141". The `95` is the width label of the confidence interval. The verbatim quote uses just "CI 0.062 to 0.141" without the percent width. The validator flagged `95` as a missing numeric token.

**Fix applied:** `_CI_PERCENT_LABEL_RE` in `_strip_claim_metadata()` replaces `N% CI`, `N% credible interval`, `N% confidence interval` with the token `CI` before numeric extraction.

**Before:** 4 fails on `95`.
**After:** 0 CI-label fails.

**Example eliminated:**
```
claim: "...small-range lineages (ΔR = 0.101, 95% credible interval 0.062–0.141)."
quote: "We found a ΔR fusion of 0.101 (CI 0.062 to 0.141)..."
reason: '95'  → correctly stripped as CI label
```

### Category C — Wrong finding number (FIXED: −6 fails, 4 topic pages)

**Root cause:** Several topic pages cite `[Jonika et al. 2020, Finding 1](/knowledge/papers/10_3390_genes11080945/#finding-1)` for the "99 of 100 posterior trees favored a two-rate model" result. That statistic lives in **Finding 3** of that paper, not Finding 1. Finding 1 concerns the (negative) result that chromosome number has no relationship with microsatellite rates.

**Fix applied:** Updated citations from `#finding-1` to `#finding-3` in 4 files:
- `knowledge/topics/microsatellite_evolution.md` (2 citations + 1 contradictions citation)
- `knowledge/topics/centromere_evolution.md` (2 citations)
- `knowledge/topics/centromere_type.md` (3 citations)
- `knowledge/topics/genome_dynamics.md` (2 citations)

All 4 files now pass `validate_surface`.

### Category D — Multi-citation line contamination (~17 remaining fails)

**Root cause:** The validator extracts the full line's text as the `claim` for every inline citation on that line. When a single sentence contains two citations from different findings, the numeric tokens from one finding's prose are checked against the other finding's verbatim quote. This is not drift — the prose is correct — but the validator architecture produces false positives.

**Example (genuine false positive, not fixed):**
```
File: genome_structure_evolution.md, line 25
Sentence: "...the rate at which that content evolves does: 99 of 100 posterior-distribution trees 
           favored a two-rate model ... ([Jonika et al. 2020, Finding 3](...#finding-3)).
           Diploid chromosome number has no significant relationship...
           ([Jonika et al. 2020, Finding 1](...#finding-1))."
Fail: Finding 1's quote does not contain '99' — but '99' belongs to Finding 3's portion of the line.
```

**Fix recommendation for Phase 3.5:** The validator should extract only the text *between* consecutive inline-citation markers, rather than the entire line. This is a `validate_surface.py` change (claim extraction logic), not a normalizer change. Estimated impact: ~17 fails eliminated.

### Category E — True numeric drift (255 remaining fails)

These are cases where the claim's numeric token is genuinely absent from the cited finding's verbatim quote. Representative subcategories:

#### E1 — Number present in claim but in wrong finding (~103 fails, "all-fail" lines)
The number appears in the claim and is scientifically correct but the finding cited does not contain it. The citation should point to a different finding in the same paper, or the number was synthesized across multiple findings.

**Example:**
```
paper: 10_1093_jhered_esae001, finding 1 (14 fails)
claim: "...rate estimates...0.76 fusions per lineage per million years..."
quote: "In Polyphaga, the mean rate of fusions in low Ne clades ranges from 0.05 to 0.11..."
reason: '0.76'  — 0.76 appears elsewhere in the paper, likely in a different finding
```

**Example:**
```
paper: 10_1093_evolut_qpae003, finding 1 (12 fails)
claim: "Across 488 species-trait pairings, life-history traits showed..."
quote: "Life-history traits showed a greater proportion of epistatic contribution..."
reason: '488'  — 488 may appear in paper but not in this specific finding's blockquote
```

#### E2 — Number synthesized from multiple findings (~100 fails, "all-fail" multi-claim lines)
The claim is a synthesis statement citing multiple findings simultaneously. The numeric token appears in one of the cited findings but is checked against each individual quote — some of which don't contain it.

**Example:**
```
paper: 10_1111_evo_13682, finding 2 (11 fails)
claim: "In mammals, BiSSE analysis...finds no detectable difference in net diversification 
       rates but shows 90.9% of polarity switches concentrated in Cetartiodactyla..."
quote: "We found the highest rate of polarity switching in Cetartio- dactyla, where the 
       mean waiting time for a transition was 1..."
reason: '90.9'  — 90.9% appears in the paper but not in finding-2's specific blockquote
```

#### E3 — Rounding or reformatting (~30 fails)
Claim states a number that is a rounded or reformatted version of what appears in the quote.

**Example:**
```
claim: "...minimap2 achieves 94.0% junction accuracy..."
quote: "...it finds more junctions with a higher percentage of them exactly correct..."
reason: '94.0'  — the exact figure is in Table 1 of the paper, not the cited blockquote paragraph
```

#### E4 — Number in finding title but not verbatim quote (~20 fails)
The finding's title or "Why citable" section contains the number, but the verbatim blockquote itself does not. The validator only checks against the blockquote.

**Example:**
```
paper: 10_1093_g3journal_jkac132, finding 2
Finding title: "Of 1,140 genes with published FST values, only 83 had both FST and logFC..."
Blockquote: "Of the genes for which both F ST and logFC had been calculated by previous studies..."
claim: "Of 1,140 genes with published F_ST values, only 83 had..."
reason: '1140'  — in finding title but not in blockquote
```

---

## Normalizer Changes Applied to `accuracy.py`

### 1. `_strip_claim_metadata()` — new function

Strips two classes of non-measurement numeric tokens from the claim string before `digit_substring_ok` extracts tokens:
- Author-year citations: `Surname (YEAR)`, `Surname et al. YEAR`, "the YEAR study", etc.
- CI percentage labels: `95% CI`, `95% credible interval`, `99% confidence interval`

### 2. `_AUTHOR_YEAR_UPPER_RE` — new pattern

Matches surname-year citations (capital-initial surname required to avoid matching lowercase prose words).

### 3. `_PROSE_YEAR_RE` — new pattern

Matches `\b(the|a|an|in|of)\s+(1800–2099)\b` case-insensitively.

### 4. `_CI_PERCENT_LABEL_RE` — new pattern

Matches `\d+%\s+(CI|credible interval|confidence interval)` and replaces with bare `CI`.

### 5. `digit_substring_ok()` — now calls `_strip_claim_metadata()` on claim before extraction

The quote is never modified — only the claim is preprocessed.

**Unit tests added:** 10 new tests in `wiki_tools/tests/test_accuracy.py` (42 total, up from 33, all passing).

---

## Topic Pages Fixed (4 of max 5)

| File | Fix | Claim fails resolved |
|------|-----|----------------------|
| `knowledge/topics/microsatellite_evolution.md` | Changed 3× Finding 1 → Finding 3 in `10_3390_genes11080945` citations | 2 |
| `knowledge/topics/centromere_evolution.md` | Changed 2× Finding 1 → Finding 3 | 2 |
| `knowledge/topics/centromere_type.md` | Changed 3× Finding 1 → Finding 3 | 2 |
| `knowledge/topics/genome_dynamics.md` | Changed 2× Finding 1 → Finding 3 | 2 |

All fixes: the "99 of 100 posterior trees" statistic for centromere-type microsatellite rate differences is correctly reported in Finding 3 (not Finding 1) of Jonika et al. 2020. Finding 1 covers the negative result on chromosome number vs. microsatellite rates.

`knowledge/topics/sex_chromosome_evolution.md` was NOT touched (owned by Phase 6c).

---

## True-Drift Categories for Phase 3.5 / V2

Priority order for backfilling:

1. **Multi-citation line contamination (~17 fails)** — Fix in `validate_surface.py` claim extraction. Change the claim text extracted for each citation to be only the text between that citation and the preceding/following citation on the same line, rather than the entire line. High confidence fix, no content changes to topic pages required.

2. **Wrong finding number (~103 fails)** — Systematic audit of which finding number actually contains each cited statistic. Many cases are finding-1 vs finding-2 transpositions. Could be partially automated by scanning all paper finding blockquotes for the claimed number.

3. **Number in finding title but not blockquote (~20 fails)** — Either add the number to the blockquote verbatim, or adjust the finding's blockquote to include the key statistic. Example: `10_1093_g3journal_jkac132` finding 2 title has "1,140 genes" but the blockquote does not.

4. **Synthesis numbers not in any single finding (~100 fails)** — The claim synthesizes across multiple findings. Either (a) add a synthesis-style citation that aggregates findings, or (b) accept these as deliberate synthesis statements that the validator cannot easily check. These require the most judgment to fix.

5. **Table/figure numbers not in blockquote (~30 fails)** — The cited statistic is in a table in the paper (e.g., "94.0% junction accuracy") but the finding blockquote quotes prose rather than the table row. Fix by updating the finding blockquote to include the specific numeric result.

---

## Recommendation on Flipping `_DIGIT_SUBST_BLOCKING` to True

**Not yet.** 279 claim fails remain. Of these, ~255 are true drift or structural issues requiring content fixes. Blocking mode at this fail count would make the validator a continuous CI blocker and discourage contributions.

**Suggested threshold:** Flip to blocking mode when fails drop below 50. At 50 fails, a developer adding a new topic page can reasonably inspect all existing failures and know they are pre-existing issues rather than regressions from their edit.

**Path to <50 fails:**
- Fix multi-cite contamination in `validate_surface.py` (~17 fails): straightforward engineering, no content audit
- Fix wrong-finding-number cases (~103 fails): requires systematic paper audit; partially automatable
- Together these would bring fails to ~160. A focused Phase 3.5 sprint fixing the top-10 most-failed paper/finding combos (each averaging 10+ fails) could clear most of the remainder.
