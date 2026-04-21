---
layout: default
title: "Line Cross Analysis"
topic_slug: line_cross_analysis
last_updated: 2026-04-21T19:35:29.718888+00:00
papers_supporting: [02a1144372eea7637a416bdecad69c824db50c3d41a6f0df6417a02d719dbee2, 50ffa26858c4ac0cc040432925613a01d371c052da7ba3e3b12f8becd9ade8b0, acf19af8d6f8703b16fd377afd2ea26b12e00f435318e00d8d13bbbc5fe02b19]
permalink: /knowledge/topics/line_cross_analysis/
---
# Line Cross Analysis

## Current understanding

Line cross analysis (LCA) is a classical quantitative-genetic framework for decomposing the genetic basis of trait differences between diverged populations or species. By examining the mean phenotypes of parental lines, F1, F2, and backcross generations, LCA allows researchers to estimate composite genetic effects (CGEs) — including additive, dominance, and epistatic components — that contribute to phenotypic divergence.

The number and types of CGEs that can be estimated depend directly on which generational cohorts are included in a cross design. A minimal five-cohort design — two parentals, an F2, and two backcrosses — can support inference on up to ten distinct CGEs, including three additive types (autosomal, cytotype, and maternal effect), two dominance types, and five epistatic interactions ([2024 solanum, Finding 1](/knowledge/papers/2024_solanum/#finding-1)). This illustrates both the power of even small cohort sets and their inherent ceiling: two-partner epistatic interactions are accessible, but higher-order interactions and some recombinant-inbred classes require richer designs.

The traditional workhorse of LCA is the joint-scaling test (J-S test), a hypothesis-testing approach that fits successive models to generational means and uses chi-square or F-statistics to evaluate whether higher-order terms (e.g., additive × additive epistasis) are needed. Although widely used, the J-S test has known limitations in model comparison, particularly when multiple epistatic terms are plausible candidates and sample sizes are moderate.

A newer information-theoretic alternative, SAGA (Selection Among Genetic Architecture models), replaces null-hypothesis significance testing with AIC-based model selection and variable importance (vi) scores. When applied retrospectively to 22 published LCA datasets, SAGA identified 11 epistatic CGEs (across 9 datasets) with high variable importance (vi > 0.5) that had gone undetected by the traditional J-S test ([2016 saga, Finding 1](/knowledge/papers/2016_saga/#finding-1)). This suggests that epistasis in line cross data may be more prevalent than the classical framework reveals.

A persistent methodological concern for LCA is whether artificial selection lines used as parents are sufficiently inbred to satisfy the assumption of near-complete allele fixation. Incomplete fixation — allelic dispersion — could in principle inflate inferred epistatic effects. Forward-time simulations directly addressing this concern show that dispersion can indeed produce spurious epistatic inferences, but only at modest magnitudes: the epistatic-to-additive ratio produced by simulated dispersion ranged from 0 to 0.33, far below the empirically observed ratio of 5.27 in *Tribolium castaneum* dispersal behavior ([2020-march of beetles, Finding 1](/knowledge/papers/2020_march_of_beetles/#finding-1)). This quantitative gap provides meaningful, if not absolute, reassurance that the large epistatic signal detected empirically cannot be fully attributed to incomplete allele fixation.

## Supporting evidence

The most direct quantitative evidence for the limitations of the J-S test comes from the re-analysis of 22 empirical datasets using the SAGA framework. In nine of these datasets, at least one epistatic CGE had vi > 0.5 under information-theoretic model selection despite being non-significant — and therefore excluded — under the joint-scaling test ([2016 saga, Finding 1](/knowledge/papers/2016_saga/#finding-1)). Variable importance aggregates support across all models in the candidate set, providing a continuous measure of evidence rather than a binary retain/reject decision.

Simulation-based validation from work on *T. castaneum* dispersal complements this empirical finding. By modeling artificial selection lines as starting from a defined allele-frequency architecture across 20 unlinked biallelic loci and tracking inbreeding over generations, the simulations confirm that allelic dispersion produces at most a modest spurious epistatic signature — an epistatic:additive ratio no greater than 0.33, compared to 5.27 observed in the real data ([2020-march of beetles, Finding 1](/knowledge/papers/2020_march_of_beetles/#finding-1)).

Empirical application in *Solanum* interspecific crosses demonstrates the practical scope of minimal cohort designs. With five cohorts (P1, P2, F2, BC1, rBC2), ten CGEs spanning additive, dominance, and epistatic categories — including cytotype and maternal effect additive terms — were simultaneously estimable using the information-theoretic approach ([2024 solanum, Finding 1](/knowledge/papers/2024_solanum/#finding-1)), illustrating that LCA remains tractable even without F1 or recombinant-inbred generations.

## Contradictions / open disagreements

The claim that the J-S test systematically underestimates epistasis rests on a convenience sample of 22 datasets drawn heavily from prior work on *Tribolium castaneum* and *Silene*, so the apparent detection gap may reflect the cross designs and organisms studied rather than a general bias. The vi > 0.5 cutoff is also an author-chosen heuristic without formal type-I error control, making it difficult to compare the 11 "newly detected" epistatic effects directly against significance-based methods.

The simulation controlling for allelic dispersion, while reassuring, has its own architectural constraints: it uses only 20 unlinked biallelic loci with all dispersal alleles dominant. Different numbers of loci, linkage structures, dominance relationships, or starting allele frequencies could in principle yield higher false-positive epistatic ratios, meaning the simulation may not fully bracket the space of possible dispersion artifacts.

The five-cohort design demonstrated in the 2024 *Solanum* work ([2024 solanum, Finding 1](/knowledge/papers/2024_solanum/#finding-1)) cannot estimate higher-order epistatic interactions beyond two-partner effects, and small within-cohort sample sizes may reduce power to detect some CGEs. Its ten-effect parameterization also incorporates cytotype and maternal-effect terms that are specific to interspecific crosses with cytonuclear complexity, limiting direct generalization to simpler intraspecific designs.

## Tealc's citation-neighborhood suggestions

- Mather & Jinks (1982) *Biometrical Genetics* — the foundational text for the joint-scaling test and composite genetic effect parameterization.
- Burnham & Anderson (2002) *Model Selection and Multimodel Inference* — the information-theoretic framework underpinning the SAGA approach.
- Demuth & Wade (2007) studies on *Tribolium castaneum* — the source of the majority of re-analyzed datasets, whose results anchor the empirical comparison.

## Related on the Blackmon Lab site

- [2016 SAGA paper](/knowledge/papers/2016_saga/)
- [2020 March of Beetles](/knowledge/papers/2020_march_of_beetles/)
- [2024 Solanum](/knowledge/papers/2024_solanum/)