---
layout: default
title: "Line Cross Analysis"
topic_slug: line_cross_analysis
last_updated: 2026-04-21T20:36:21.044276+00:00
papers_supporting: [02a1144372eea7637a416bdecad69c824db50c3d41a6f0df6417a02d719dbee2, 50ffa26858c4ac0cc040432925613a01d371c052da7ba3e3b12f8becd9ade8b0, 9b26073c4ef21e4b81ec477d50cc357c4809ccb79b53507cb54707da1d48856b, acf19af8d6f8703b16fd377afd2ea26b12e00f435318e00d8d13bbbc5fe02b19]
permalink: /knowledge/topics/line_cross_analysis/
category: "Quantitative genetics & epistasis"
---
<!-- tealc:auto-start -->
# Line Cross Analysis

## Current understanding

Line cross analysis (LCA) is a classical quantitative-genetic framework for decomposing the genetic basis of trait differences between diverged populations or species. By examining the mean phenotypes of parental lines, F1, F2, and backcross generations, LCA allows researchers to estimate composite genetic effects (CGEs) — including additive, dominance, and epistatic components — that contribute to phenotypic divergence.

The number and types of CGEs that can be estimated depend directly on which generational cohorts are included in a cross design. A minimal five-cohort design — two parentals, an F2, and two backcrosses — can support inference on up to ten distinct CGEs, including three additive types (autosomal, cytotype, and maternal effect), two dominance types, and five epistatic interactions ([Assessing the opportunity for 2024, Finding 3](/knowledge/papers/10_7717_peerj_17985/#finding-3)). This illustrates both the power of even small cohort sets and their inherent ceiling: two-partner epistatic interactions are accessible, but higher-order interactions and some recombinant-inbred classes require richer designs.

The traditional workhorse of LCA is the joint-scaling test (J-S test), a hypothesis-testing approach that fits successive models to generational means and uses chi-square or F-statistics to evaluate whether higher-order terms (e.g., additive × additive epistasis) are needed. Although widely used, the J-S test has known limitations in model comparison, particularly when multiple epistatic terms are plausible candidates and sample sizes are moderate.

A newer information-theoretic alternative, SAGA (Selection Among Genetic Architecture models), replaces null-hypothesis significance testing with AIC-based model selection and variable importance (vi) scores. When applied retrospectively to 22 published LCA datasets, SAGA identified 11 epistatic CGEs (across 9 datasets) with high variable importance (vi > 0.5) that had gone undetected by the traditional J-S test ([Blackmon & Demuth 2016, Finding 1](/knowledge/papers/10_1111_evo_12844/#finding-1)), suggesting that epistasis in line cross data may be more prevalent than the classical framework reveals. The stakes of this methodological gap become clearer at larger scale: in a survey of 1,606 LCA datasets from the published literature, approximately 19% failed to yield any genetic effects meeting SAGA's information-theoretic thresholds (vi > 0.5 and 95% CI excluding zero), raising the possibility that a meaningful fraction of legacy inferences rest on model-selection uncertainty that the J-S test never quantified ([Wright was right: leveraging 2024, Finding 3](/knowledge/papers/10_1093_evolut_qpae003/#finding-3)).

A persistent methodological concern for LCA is whether artificial selection lines used as parents are sufficiently inbred to satisfy the assumption of near-complete allele fixation. Incomplete fixation — allelic dispersion — could in principle inflate inferred epistatic effects. Forward-time simulations directly addressing this concern show that dispersion can indeed produce spurious epistatic inferences, but only at modest magnitudes: the epistatic-to-additive ratio produced by simulated dispersion ranged from 0 to 0.33, far below the empirically observed ratio of 5.27 in *Tribolium castaneum* dispersal behavior ([Ruckman & Blackmon 2020, Finding 2](/knowledge/papers/10_1093_jhered_esaa030/#finding-2)). This quantitative gap provides meaningful, if not absolute, reassurance that large epistatic signals detected empirically cannot be fully attributed to incomplete allele fixation.

## Supporting evidence

The most direct quantitative evidence for the limitations of the J-S test comes from the re-analysis of 22 empirical datasets using the SAGA framework. In nine of these datasets, at least one epistatic CGE had vi > 0.5 under information-theoretic model selection despite being non-significant under the joint-scaling test ([Blackmon & Demuth 2016, Finding 1](/knowledge/papers/10_1111_evo_12844/#finding-1)).

At larger scale, a survey of 1,606 LCA datasets confirms that SAGA's model-averaging approach substantially changes the landscape of supported inferences: 81% of datasets met the framework's evidence thresholds, while the remaining 19% did not, and the number of models included in the confidence set ranged from 1 to 2,002 across datasets ([Wright was right: leveraging 2024, Finding 3](/knowledge/papers/10_1093_evolut_qpae003/#finding-3)). The breadth of this confidence-set range underscores how profoundly model-selection uncertainty varies across study designs.

Simulation-based validation from work on *T. castaneum* dispersal complements these empirical findings. By modeling artificial selection lines across 20 unlinked biallelic loci and tracking inbreeding over generations, the simulations confirm that allelic dispersion produces at most a modest spurious epistatic signature — an epistatic:additive ratio no greater than 0.33, compared to 5.27 observed in real data ([Ruckman & Blackmon 2020, Finding 2](/knowledge/papers/10_1093_jhered_esaa030/#finding-2)).

Empirical application in *Solanum* interspecific crosses demonstrates the practical scope of minimal cohort designs. With five cohorts (P1, P2, F2, BC1, rBC2), ten CGEs spanning additive, dominance, and epistatic categories — including cytotype and maternal effect additive terms — were simultaneously estimable using the information-theoretic approach ([Assessing the opportunity for 2024, Finding 3](/knowledge/papers/10_7717_peerj_17985/#finding-3)).

## Contradictions / open disagreements

The claim that the J-S test systematically underestimates epistasis rests on a convenience sample of 22 datasets drawn heavily from prior work on *Tribolium castaneum* and *Silene*, so the apparent detection gap may reflect the cross designs and organisms studied rather than a general bias. The vi > 0.5 cutoff is an author-chosen heuristic without formal type-I error control, making it difficult to directly compare the "newly detected" epistatic effects against significance-based methods.

Relatedly, the 19% of datasets in the large-scale 2024 survey that failed SAGA thresholds ([Wright was right: leveraging 2024, Finding 3](/knowledge/papers/10_1093_evolut_qpae003/#finding-3)) may reflect insufficient statistical power or cohort diversity in those studies rather than genuine false positives in prior analyses. The finding conflates "not supported under this framework" with "false positive," and different evidence thresholds would shift the failure rate in either direction.

The simulation controlling for allelic dispersion uses only 20 unlinked biallelic loci with all dispersal alleles dominant. Different numbers of loci, linkage structures, dominance relationships, or starting allele frequencies could yield higher false-positive epistatic ratios, so the simulation may not fully bracket the space of possible dispersion artifacts.

The five-cohort design demonstrated in the 2024 *Solanum* work ([Assessing the opportunity for 2024, Finding 3](/knowledge/papers/10_7717_peerj_17985/#finding-3)) cannot estimate higher-order epistatic interactions, and its cytotype and maternal-effect terms are specific to interspecific crosses with cytonuclear complexity, limiting generalization to simpler intraspecific designs.

## Tealc's citation-neighborhood suggestions

- Mather & Jinks (1982) *Biometrical Genetics* — the foundational text for the joint-scaling test and composite genetic effect parameterization.
- Burnham & Anderson (2002) *Model Selection and Multimodel Inference* — the information-theoretic framework underpinning the SAGA approach.
- Demuth & Wade (2007) studies on *Tribolium castaneum* — the source of the majority of re-analyzed datasets, whose results anchor the empirical comparison.

## Related on the Blackmon Lab site

- [Blackmon & Demuth 2016](/knowledge/papers/10_1111_evo_12844/)
- [Ruckman & Blackmon 2020](/knowledge/papers/10_1093_jhered_esaa030/)
- [Assessing the opportunity for 2024](/knowledge/papers/10_7717_peerj_17985/)
- [Wright was right: leveraging 2024](/knowledge/papers/10_1093_evolut_qpae003/)
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
## Related topics on this site

- [Epistasis](/knowledge/topics/epistasis/) — 4 shared papers
<!-- tealc:related-end -->
