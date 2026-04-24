---
layout: default
title: "Quantitative Genetics"
topic_slug: quantitative_genetics
last_updated: 2026-04-21T18:49:29.302109+00:00
papers_supporting: [acf19af8d6f8703b16fd377afd2ea26b12e00f435318e00d8d13bbbc5fe02b19]
permalink: /knowledge/topics/quantitative_genetics/
category: "Quantitative genetics & epistasis"
---
<!-- tealc:auto-start -->
# Quantitative Genetics

<!-- tealc:freshness-start -->
<aside class="wiki-freshness" aria-label="Page provenance">
<span class="wf-label">Composed by Tealc</span>
<span class="wf-date">2026-04-21</span>
<span class="wf-dot">·</span>
<span class="wf-sources">1 source</span>
<span class="wf-dot">·</span>
<span class="wf-review">Last reviewed by Heath: never</span>
</aside>
<!-- tealc:freshness-end -->


## Current understanding

Quantitative genetics asks how standing genetic variance — additive, dominance, and epistatic components — shapes the response of continuous traits to selection. Two closely related questions are: (1) how fast and how far can a trait shift under directional selection before genetic variance is exhausted, and (2) when line cross analysis (LCA) infers epistasis, is that inference robust or an artifact of incomplete allele fixation in the parental lines?

Work in *Tribolium castaneum* provides instructive empirical answers to both questions. Artificial selection on dispersal tendency produced a strikingly rapid early response — the high-dispersal line (P2) climbed from a base of 25% to 59% dispersal in just three generations while the low-dispersal line (P1) fell to 5% — but that momentum largely stalled; by generation five the lines had reached only 70% and 18%, respectively ([Ruckman & Blackmon 2020, Finding 1](/knowledge/papers/10_1093_jhered_esaa030/#finding-1)). This pattern of rapid early divergence followed by a plateau is consistent with rapid depletion of the additive genetic variance accessible to selection within a modest number of generations, a hallmark prediction of quantitative genetic theory.

Once divergent lines exist, LCA can be applied to estimate the genetic architecture of the trait difference. A standing concern with LCA applied to short-term artificial selection lines is that incomplete allele fixation ("allelic dispersion") could spuriously inflate inferred epistatic components. Forward-time simulations directly addressing this concern — modeling 20 unlinked biallelic loci with dispersal alleles assumed dominant and allele frequencies matched to the empirical lines — show that dispersion artifacts can produce epistatic-to-additive ratios of at most 0.33, far below the empirically observed ratio of 5.27 ([Ruckman & Blackmon 2020, Finding 2](/knowledge/papers/10_1093_jhered_esaa030/#finding-2)). This simulation-based control substantially strengthens the conclusion that the large epistatic component inferred for dispersal in *T. castaneum* reflects true gene-by-gene interactions rather than a methodological artifact.

Together, these findings illustrate two important themes in quantitative genetics: the speed and limits of selection on heritable behavioral traits, and the importance of validating genetic-architecture inferences with simulation controls that bracket the plausible range of confounds.

## Supporting evidence

- [Ruckman & Blackmon 2020, Finding 1](/knowledge/papers/10_1093_jhered_esaa030/#finding-1) — Artificial selection on dispersal in *T. castaneum* produced rapid divergence over three generations (P2: 25%→59%; P1: 25%→5%) but approached a plateau by generation five, indicating rapid early exhaustion of accessible additive variance.
- [Ruckman & Blackmon 2020, Finding 2](/knowledge/papers/10_1093_jhered_esaa030/#finding-2) — Forward-time simulations show allelic dispersion in short-term selection lines yields epistatic:additive ratios of only 0–0.33, far below the empirical value of 5.27, supporting the reality of strong epistasis in dispersal architecture.

## Contradictions / open disagreements

None known from the current evidence base. However, the simulation control for dispersion artifacts (Finding 2) rests on specific assumptions — 20 unlinked biallelic loci, all dispersal alleles dominant, allele frequencies matched to this particular experiment. Different locus numbers, linkage structures, or dominance architectures could in principle produce higher false-positive epistatic signals and have not been fully explored.

## Tealc's citation-neighborhood suggestions

- Classical quantitative genetic studies partitioning additive vs. non-additive variance for life-history and behavioral traits in *Tribolium* (e.g., Rawlings & Cockerham line cross frameworks) would contextualize the LCA approach used here.
- Literature on the "selection plateau" phenomenon (e.g., Weber & Diggins 1990 on *Drosophila* bristle number) would help frame how quickly additive variance is depleted under strong artificial selection.
- Recent work applying genomic approaches (e.g., GWAS or QST–FST comparisons) to dispersal in beetles could bridge the quantitative genetics and genomics perspectives.

## Related on the Blackmon Lab site

- [Ruckman & Blackmon 2020](/knowledge/papers/10_1093_jhered_esaa030/)
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
<!-- tealc:related-end -->
