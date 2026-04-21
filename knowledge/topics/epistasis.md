---
layout: default
title: "Epistasis"
topic_slug: epistasis
last_updated: 2026-04-21T18:20:10.513564+00:00
papers_supporting: [02a1144372eea7637a416bdecad69c824db50c3d41a6f0df6417a02d719dbee2]
permalink: /knowledge/topics/epistasis/
---
# Epistasis

## Current understanding

Epistasis — the phenomenon in which the effect of one locus depends on the genotypic state at one or more other loci — is a central but methodologically contested feature of quantitative genetics. Detecting epistatic composite genetic effects (CGEs) in line-cross analyses (LCA) has historically relied on the joint-scaling (J-S) test, a hypothesis-testing framework that evaluates whether additive and dominance parameters alone are sufficient to explain observed means across crosses. However, growing evidence suggests this approach systematically underdetects epistasis relative to information-theoretic alternatives.

Using the SAGA (Statistically Appropriate Genetic Architecture) framework, which applies information-theoretic model selection rather than null-hypothesis significance testing, re-analysis of 22 empirical LCA datasets revealed that 11 epistatic CGEs across 9 datasets carried high variable importance (vi > 0.5) yet were never flagged by the J-S test. This finding implies that the traditional approach may produce a systematically impoverished picture of genetic architecture, particularly for the epistatic components that contribute to isolation, heterosis, or complex trait variation. [2016 saga, Finding 1](/knowledge/papers/2016_saga/#finding-1)

The practical implication is that estimates of how frequently epistasis shapes phenotypic divergence between populations or species may be underestimates when based solely on J-S test outcomes. Information-theoretic approaches weight candidate models by their relative fit to data — including models with epistatic parameters — without requiring that a null model be formally rejected, which gives them greater sensitivity to moderate-effect epistatic terms.

## Supporting evidence

- Across 22 re-analyzed empirical LCA datasets, SAGA identified 11 epistatic CGEs (in 9 datasets) with variable importance > 0.5 that the joint-scaling test had not identified, directly quantifying the detection gap between the two frameworks. [2016 saga, Finding 1](/knowledge/papers/2016_saga/#finding-1)

## Contradictions / open disagreements

The primary unresolved tension concerns whether the detection advantage of SAGA over the J-S test reflects a genuine gain in sensitivity or a difference in error-rate philosophy. The 11 "missed" epistatic effects were identified using a vi > 0.5 threshold chosen by the authors rather than a threshold tied to a controlled false-discovery rate. A researcher committed to significance-based inference could argue that J-S is not missing real epistasis but is correctly withholding support for effects that do not clear an appropriate evidence bar. Additionally, the 22 datasets analyzed are a convenience sample with heavy representation of *Tribolium castaneum* and *Silene* crosses, so the apparent frequency with which J-S misses epistasis may not generalize to other taxa or cross designs. Broader taxonomic and design replication is needed before the detection gap can be taken as a global property of the two methods.

## Tealc's citation-neighborhood suggestions

- Lynch & Walsh (1998) *Genetics and Analysis of Quantitative Traits* — the canonical treatment of composite genetic effects in line-cross analysis, against which SAGA results should be benchmarked.
- Burnham & Anderson (2002) *Model Selection and Multimodel Inference* — foundational text for the AIC-based variable importance framework used by SAGA.
- Demuth & Wade (2007a/b) — primary source for the majority of the 22 re-analyzed datasets; directly relevant for assessing the representativeness of the convenience sample.

## Related on the Blackmon Lab site

- [2016 saga paper page](/knowledge/papers/2016_saga/)