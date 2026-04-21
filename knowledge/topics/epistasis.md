---
layout: default
title: "Epistasis"
topic_slug: epistasis
last_updated: 2026-04-21T18:50:10.127435+00:00
papers_supporting: [02a1144372eea7637a416bdecad69c824db50c3d41a6f0df6417a02d719dbee2, acf19af8d6f8703b16fd377afd2ea26b12e00f435318e00d8d13bbbc5fe02b19]
permalink: /knowledge/topics/epistasis/
---
# Epistasis

## Current understanding

Epistasis — the phenomenon in which the effect of one locus depends on the genotypic state at one or more other loci — is a central but methodologically contested feature of quantitative genetics. Detecting epistatic composite genetic effects (CGEs) in line-cross analyses (LCA) has historically relied on the joint-scaling (J-S) test, a hypothesis-testing framework that evaluates whether additive and dominance parameters alone are sufficient to explain observed means across crosses. Growing evidence suggests this approach systematically underdetects epistasis relative to information-theoretic alternatives.

Using the SAGA (Statistically Appropriate Genetic Architecture) framework, which applies information-theoretic model selection rather than null-hypothesis significance testing, re-analysis of 22 empirical LCA datasets revealed that 11 epistatic CGEs across 9 datasets carried high variable importance (vi > 0.5) yet were never flagged by the J-S test. This finding implies that the traditional approach may produce a systematically impoverished picture of genetic architecture, particularly for the epistatic components that contribute to isolation, heterosis, or complex trait variation. [2016 saga, Finding 1](/knowledge/papers/2016_saga/#finding-1)

A separate concern is whether LCA inferences of epistasis are real or merely artifacts of incomplete allele fixation in the parental lines — a problem called allelic dispersion. Forward-time simulations specifically designed to test this artifact in *Tribolium castaneum* dispersal lines show that dispersion can indeed produce spurious epistatic signals, but only at magnitudes far smaller than what is observed empirically. Simulated datasets produced an epistatic-to-additive ratio of only 0–0.33, whereas the empirical dataset yielded a ratio of 5.27 — a roughly 16-fold difference — strongly suggesting that the inferred epistasis in that system reflects genuine genetic architecture rather than incomplete fixation. [2020-march of beetles, Finding 1](/knowledge/papers/2020_march_of_beetles/#finding-1)

Together, these results suggest that epistasis in quantitative traits is (1) more prevalent than J-S-based studies imply, and (2) not easily explained away as a methodological artifact of how selection lines are constructed.

## Supporting evidence

- Across 22 re-analyzed empirical LCA datasets, SAGA identified 11 epistatic CGEs (in 9 datasets) with variable importance > 0.5 that the joint-scaling test had not identified, directly quantifying the detection gap between the two frameworks. [2016 saga, Finding 1](/knowledge/papers/2016_saga/#finding-1)

- Forward-time simulations of allelic dispersion in short-term artificial selection lines yielded an epistatic:additive ratio of 0–0.33, far below the empirically observed ratio of 5.27 in *T. castaneum* dispersal, indicating that dispersion artifacts alone are insufficient to explain empirically inferred epistasis. [2020-march of beetles, Finding 1](/knowledge/papers/2020_march_of_beetles/#finding-1)

## Contradictions / open disagreements

**Detection philosophy.** The primary unresolved tension concerns whether SAGA's advantage over the J-S test reflects a genuine gain in sensitivity or a difference in error-rate philosophy. The 11 "missed" epistatic effects were identified using a vi > 0.5 threshold chosen by the authors rather than a threshold tied to a controlled false-discovery rate. A researcher committed to significance-based inference could argue that J-S is not missing real epistasis but is correctly withholding support for effects that do not clear an appropriate evidence bar.

**Simulation scope.** The simulation-based dismissal of allelic dispersion as an explanation for large epistatic signals uses 20 unlinked biallelic loci with all dispersal alleles dominant, matched to specific empirical lines. Different numbers of loci, linkage structures, dominance relationships, or starting allele frequencies could produce higher false-positive epistatic magnitudes. The simulations do not fully bracket all possible artifact scenarios.

**Taxonomic breadth.** The 22 datasets analyzed are a convenience sample with heavy representation of *Tribolium castaneum* and *Silene* crosses, so neither the detection gap between SAGA and J-S nor the robustness-to-dispersion result can yet be taken as global properties across taxa or cross designs.

## Tealc's citation-neighborhood suggestions

- Lynch & Walsh (1998) *Genetics and Analysis of Quantitative Traits* — the canonical treatment of composite genetic effects in line-cross analysis, against which SAGA results should be benchmarked.
- Burnham & Anderson (2002) *Model Selection and Multimodel Inference* — foundational text for the AIC-based variable importance framework used by SAGA.
- Demuth & Wade (2007a/b) — primary source for the majority of the 22 re-analyzed datasets; directly relevant for assessing the representativeness of the convenience sample.

## Related on the Blackmon Lab site

- [2016 saga paper page](/knowledge/papers/2016_saga/)
- [2020-march of beetles paper page](/knowledge/papers/2020_march_of_beetles/)