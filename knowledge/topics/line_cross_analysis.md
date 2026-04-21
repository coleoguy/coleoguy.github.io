---
layout: default
title: "Line Cross Analysis"
topic_slug: line_cross_analysis
last_updated: 2026-04-21T18:20:30.682795+00:00
papers_supporting: [02a1144372eea7637a416bdecad69c824db50c3d41a6f0df6417a02d719dbee2]
permalink: /knowledge/topics/line_cross_analysis/
---
# Line Cross Analysis

## Current understanding

Line cross analysis (LCA) is a classical quantitative-genetic framework for decomposing the genetic basis of trait differences between diverged populations or species. By examining the mean phenotypes of parental lines, F1, F2, and backcross generations, LCA allows researchers to estimate composite genetic effects (CGEs) — including additive, dominance, and epistatic components — that contribute to phenotypic divergence.

The traditional workhorse of LCA is the joint-scaling test (J-S test), a hypothesis-testing approach that fits successive models to generational means and uses chi-square or F-statistics to evaluate whether higher-order terms (e.g., additive × additive epistasis) are needed. Although widely used, the J-S test has known limitations in model comparison, particularly when multiple epistatic terms are plausible candidates and sample sizes are moderate.

A newer information-theoretic alternative, SAGA (Selection Among Genetic Architecture models), replaces null-hypothesis significance testing with AIC-based model selection and variable importance (vi) scores. When applied retrospectively to 22 published LCA datasets, SAGA identified 11 epistatic CGEs (across 9 datasets) with high variable importance (vi > 0.5) that had gone undetected by the traditional J-S test ([2016 saga, Finding 1](/knowledge/papers/2016_saga/#finding-1)). This suggests that epistasis in line cross data may be more prevalent than the classical framework reveals, and that model-selection criteria focused on relative evidence — rather than p-value thresholds — can recover biologically meaningful signal that would otherwise be discarded.

## Supporting evidence

The most direct quantitative evidence for the limitations of the J-S test comes from the re-analysis of 22 empirical datasets using the SAGA framework. In nine of these datasets, at least one epistatic composite genetic effect had vi > 0.5 under information-theoretic model selection despite having been non-significant — and therefore excluded — under the joint-scaling test ([2016 saga, Finding 1](/knowledge/papers/2016_saga/#finding-1)). Variable importance in this context aggregates support across all models in the candidate set, providing a continuous measure of evidence rather than a binary retain/reject decision.

## Contradictions / open disagreements

The claim that the J-S test systematically underestimates epistasis rests on a convenience sample of 22 datasets drawn heavily from prior work on *Tribolium castaneum* and *Silene*, so the apparent detection gap may reflect the cross designs and organisms studied rather than a general bias. Additionally, the vi > 0.5 cutoff is an author-chosen heuristic without formal type-I error control, making it difficult to compare the 11 "newly detected" epistatic effects directly against results from significance-based methods. Whether these effects represent true epistasis or elevated false-discovery rates under the I-T framework remains an open question that broader taxonomic replication could help resolve.

## Tealc's citation-neighborhood suggestions

- Mather & Jinks (1982) *Biometrical Genetics* — the foundational text for the joint-scaling test and composite genetic effect parameterization.
- Burnham & Anderson (2002) *Model Selection and Multimodel Inference* — the information-theoretic framework underpinning the SAGA approach.
- Demuth & Wade (2007) studies on *Tribolium castaneum* — the source of the majority of re-analyzed datasets, whose results anchor the empirical comparison.

## Related on the Blackmon Lab site

- [2016 SAGA paper](/knowledge/papers/2016_saga/)