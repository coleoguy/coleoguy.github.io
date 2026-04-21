---
layout: default
title: "Epistasis"
topic_slug: epistasis
last_updated: 2026-04-21T19:34:01.150764+00:00
papers_supporting: [02a1144372eea7637a416bdecad69c824db50c3d41a6f0df6417a02d719dbee2, 50ffa26858c4ac0cc040432925613a01d371c052da7ba3e3b12f8becd9ade8b0, acf19af8d6f8703b16fd377afd2ea26b12e00f435318e00d8d13bbbc5fe02b19]
permalink: /knowledge/topics/epistasis/
---
# Epistasis

## Current understanding

Epistasis — the phenomenon in which the effect of one locus depends on the genotypic state at one or more other loci — is a central but methodologically contested feature of quantitative genetics. Detecting epistatic composite genetic effects (CGEs) in line-cross analyses (LCA) has historically relied on the joint-scaling (J-S) test, a hypothesis-testing framework that evaluates whether additive and dominance parameters alone are sufficient to explain observed means across crosses. Growing evidence suggests this approach systematically underdetects epistasis relative to information-theoretic alternatives.

Using the SAGA (Statistically Appropriate Genetic Architecture) framework, which applies information-theoretic model selection rather than null-hypothesis significance testing, re-analysis of 22 empirical LCA datasets revealed that 11 epistatic CGEs across 9 datasets carried high variable importance (vi > 0.5) yet were never flagged by the J-S test. This finding implies that the traditional approach may produce a systematically impoverished picture of genetic architecture, particularly for the epistatic components that contribute to isolation, heterosis, or complex trait variation. [2016 saga, Finding 1](/knowledge/papers/2016_saga/#finding-1)

A separate concern is whether LCA inferences of epistasis are real or merely artifacts of incomplete allele fixation in the parental lines — a problem called allelic dispersion. Forward-time simulations specifically designed to test this artifact in *Tribolium castaneum* dispersal lines show that dispersion can indeed produce spurious epistatic signals, but only at magnitudes far smaller than what is observed empirically. Simulated datasets produced an epistatic-to-additive ratio of only 0–0.33, whereas the empirical dataset yielded a ratio of 5.27 — a roughly 16-fold difference — strongly suggesting that the inferred epistasis in that system reflects genuine genetic architecture rather than incomplete fixation. [2020-march of beetles, Finding 1](/knowledge/papers/2020_march_of_beetles/#finding-1)

The prevalence of epistasis extends beyond beetles. In crosses between the wild tomato *Solanum pennellii* and domesticated *S. lycopersicum*, four of eight morphological traits had genetic architectures dominated by epistatic effects, with epistatic contributions exceeding 50%. Leaf shape traits — perimeter-area ratio, perimeter, width, and area — all fell into this category, suggesting that epistasis plays an outsized role in morphological divergence between wild and domesticated plant lineages. [2024 solanum, Finding 1](/knowledge/papers/2024_solanum/#finding-1)

Together, these results suggest that epistasis in quantitative traits is (1) more prevalent than J-S-based studies imply, (2) not easily explained away as a methodological artifact of how selection lines are constructed, and (3) detectable across phylogenetically disparate systems including insects and plants.

## Supporting evidence

- Across 22 re-analyzed empirical LCA datasets, SAGA identified 11 epistatic CGEs (in 9 datasets) with variable importance > 0.5 that the joint-scaling test had not identified, directly quantifying the detection gap between the two frameworks. [2016 saga, Finding 1](/knowledge/papers/2016_saga/#finding-1)

- Forward-time simulations of allelic dispersion in short-term artificial selection lines yielded an epistatic:additive ratio of 0–0.33, far below the empirically observed ratio of 5.27 in *T. castaneum* dispersal, indicating that dispersion artifacts alone are insufficient to explain empirically inferred epistasis. [2020-march of beetles, Finding 1](/knowledge/papers/2020_march_of_beetles/#finding-1)

- In *S. pennellii* × *S. lycopersicum* crosses, four of eight morphological traits had epistatic contributions greater than 0.5, indicating epistasis-dominated genetic architectures for leaf shape and size traits and implying limited accessibility of these traits to selection. [2024 solanum, Finding 1](/knowledge/papers/2024_solanum/#finding-1)

## Contradictions / open disagreements

**Detection philosophy.** The primary unresolved tension concerns whether SAGA's advantage over the J-S test reflects a genuine gain in sensitivity or a difference in error-rate philosophy. The 11 "missed" epistatic effects were identified using a vi > 0.5 threshold chosen by the authors rather than a threshold tied to a controlled false-discovery rate. A researcher committed to significance-based inference could argue that J-S is not missing real epistasis but is correctly withholding support for effects that do not clear an appropriate evidence bar.

**Simulation scope.** The simulation-based dismissal of allelic dispersion as an explanation for large epistatic signals uses 20 unlinked biallelic loci with all dispersal alleles dominant, matched to specific empirical lines. Different numbers of loci, linkage structures, dominance relationships, or starting allele frequencies could produce higher false-positive epistatic magnitudes. The simulations do not fully bracket all possible artifact scenarios.

**Hybridization artifacts in plant LCA.** The Solanum finding that four of eight traits are epistasis-dominated rests on only five cohorts from two parental strains. More critically, LCA can infer epistasis arising from novel multi-locus genotypes created by crossing that would never co-occur during natural divergence, meaning the observed signals may reflect properties of hybrid genotype space rather than epistasis experienced during the wild-to-domesticated transition.

**Taxonomic breadth.** The combined evidence base — 22 datasets with heavy representation of *Tribolium* and *Silene*, plus a single two-species tomato cross — is still a limited convenience sample. Neither the detection gap between SAGA and J-S nor the robustness-to-dispersion result can yet be taken as global properties across taxa or cross designs.

## Tealc's citation-neighborhood suggestions

- Lynch & Walsh (1998) *Genetics and Analysis of Quantitative Traits* — the canonical treatment of composite genetic effects in line-cross analysis, against which SAGA results should be benchmarked.
- Burnham & Anderson (2002) *Model Selection and Multimodel Inference* — foundational text for the AIC-based variable importance framework used by SAGA.
- Demuth & Wade (2007a/b) — primary source for the majority of the 22 re-analyzed datasets; directly relevant for assessing the representativeness of the convenience sample.

## Related on the Blackmon Lab site

- [2016 saga paper page](/knowledge/papers/2016_saga/)
- [2020-march of beetles paper page](/knowledge/papers/2020_march_of_beetles/)
- [2024 solanum paper page](/knowledge/papers/2024_solanum/)