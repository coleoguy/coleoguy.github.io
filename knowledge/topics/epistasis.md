---
layout: default
title: "Epistasis"
topic_slug: epistasis
last_updated: 2026-04-21T20:34:36.416433+00:00
papers_supporting: [02a1144372eea7637a416bdecad69c824db50c3d41a6f0df6417a02d719dbee2, 50ffa26858c4ac0cc040432925613a01d371c052da7ba3e3b12f8becd9ade8b0, 9b26073c4ef21e4b81ec477d50cc357c4809ccb79b53507cb54707da1d48856b, acf19af8d6f8703b16fd377afd2ea26b12e00f435318e00d8d13bbbc5fe02b19]
permalink: /knowledge/topics/epistasis/
category: "Quantitative genetics & epistasis"
---
<!-- tealc:auto-start -->
# Epistasis

## Current understanding

Epistasis — the phenomenon in which the effect of one locus depends on the genotypic state at one or more other loci — is a central but methodologically contested feature of quantitative genetics. Detecting epistatic composite genetic effects (CGEs) in line-cross analyses (LCA) has historically relied on the joint-scaling (J-S) test, a hypothesis-testing framework that evaluates whether additive and dominance parameters alone are sufficient to explain observed means across crosses. Growing evidence suggests this approach systematically underdetects epistasis relative to information-theoretic alternatives.

Using the SAGA (Statistically Appropriate Genetic Architecture) framework, which applies information-theoretic model selection rather than null-hypothesis significance testing, re-analysis of 22 empirical LCA datasets revealed that 11 epistatic CGEs across 9 datasets carried high variable importance (vi > 0.5) yet were never flagged by the J-S test. [Blackmon & Demuth 2016, Finding 1](/knowledge/papers/2016_saga/#finding-1) This detection gap is now contextualized by a much larger synthesis: across 1,606 LCA datasets analyzed under SAGA, roughly 19% failed to meet information-theoretic thresholds, meaning they yielded no genetic effects with sufficient support under model averaging — a result that raises concerns about the reliability of legacy forward-selection inferences. [Wright was right: leveraging 2024, Finding 3](/knowledge/papers/2024_wright/#finding-3)

A separate concern is whether LCA inferences of epistasis are real or merely artifacts of incomplete allele fixation in the parental lines — a problem called allelic dispersion. Forward-time simulations specifically designed to test this artifact in *Tribolium castaneum* dispersal lines show that dispersion can produce spurious epistatic signals, but only at magnitudes far smaller than what is observed empirically. Simulated datasets produced an epistatic-to-additive ratio of only 0–0.33, whereas the empirical dataset yielded a ratio of 5.27 — a roughly 16-fold difference — strongly suggesting that inferred epistasis in that system reflects genuine genetic architecture. [Ruckman & Blackmon 2020, Finding 1](/knowledge/papers/2020_march_of_beetles/#finding-1)

The prevalence of epistasis extends beyond specific systems and into broad cross-taxonomic patterns. Across 488 species-trait pairings, life-history traits show a significantly greater epistatic contribution to trait divergence than morphological traits (mean difference of 0.06, empirical p-value = .024), broadly consistent with the classical prediction that fitness-associated traits harbor more nonadditive variance. [Wright was right: leveraging 2024, Finding 1](/knowledge/papers/2024_wright/#finding-1) At the same time, animals exhibit greater epistatic contributions to trait divergence than plants (mean difference of −0.08, empirical p-value = .01), pointing to a taxonomic dimension in how genetic architecture is organized. [Wright was right: leveraging 2024, Finding 2](/knowledge/papers/2024_wright/#finding-2) Within plants specifically, *Solanum pennellii* × *S. lycopersicum* crosses found that four of eight morphological traits had epistatic contributions exceeding 50%, underscoring that even in the plant clade, epistasis can dominate trait divergence in particular lineages. [Assessing the opportunity for 2024, Finding 1](/knowledge/papers/2024_solanum/#finding-1)

Together, these results suggest that epistasis in quantitative traits is (1) more prevalent than J-S-based studies imply, (2) not easily explained away as a methodological artifact of how selection lines are constructed, (3) detectable across phylogenetically disparate systems, and (4) structured by both trait category and broad taxonomic membership.

## Supporting evidence

- Across 22 re-analyzed empirical LCA datasets, SAGA identified 11 epistatic CGEs (in 9 datasets) with variable importance > 0.5 that the joint-scaling test had not identified, directly quantifying the detection gap. [Blackmon & Demuth 2016, Finding 1](/knowledge/papers/2016_saga/#finding-1)

- Of 1,606 LCA datasets analyzed under SAGA, 81% met information-theoretic thresholds; the remaining ~19% did not, indicating that a non-trivial fraction of legacy LCA inferences may lack robust support under rigorous model selection. [Wright was right: leveraging 2024, Finding 3](/knowledge/papers/2024_wright/#finding-3)

- Life-history traits showed a greater proportion of epistatic contribution to trait divergence than morphological traits (mean difference 0.06, p = .024) across 488 species-trait pairings, supporting classical expectations about fitness-trait architecture. [Wright was right: leveraging 2024, Finding 1](/knowledge/papers/2024_wright/#finding-1)

- Animals exhibited significantly higher epistatic contributions to trait divergence than plants (mean difference −0.08, p = .01) in the same large-scale survey. [Wright was right: leveraging 2024, Finding 2](/knowledge/papers/2024_wright/#finding-2)

- Forward-time simulations of allelic dispersion in short-term artificial selection lines yielded an epistatic:additive ratio of 0–0.33, far below the empirically observed ratio of 5.27 in *T. castaneum* dispersal, indicating that dispersion artifacts alone cannot explain large empirical epistatic signals. [Ruckman & Blackmon 2020, Finding 1](/knowledge/papers/2020_march_of_beetles/#finding-1)

- In *S. pennellii* × *S. lycopersicum* crosses, four of eight morphological traits had epistatic contributions greater than 0.5, indicating epistasis-dominated genetic architectures for leaf shape and size traits. [Assessing the opportunity for 2024, Finding 1](/knowledge/papers/2024_solanum/#finding-1)

## Contradictions / open disagreements

**Detection philosophy.** The J-S test and SAGA operate under fundamentally different inferential philosophies. The 11 "missed" epistatic effects from the 2016 SAGA re-analysis were identified using a vi > 0.5 threshold chosen by the authors, not tied to a controlled false-discovery rate. A researcher committed to significance-based inference could argue that J-S is not missing real epistasis but is correctly withholding support for marginal effects. The 19% dataset failure rate under SAGA likewise conflates "not supported under this framework" with "false positive," which may overstate the implication for legacy work.

**Simulation scope.** The simulation-based dismissal of allelic dispersion uses 20 unlinked biallelic loci with all dispersal alleles dominant, matched to specific empirical lines. Different numbers of loci, linkage structures, dominance relationships, or starting allele frequencies could produce higher false-positive epistatic magnitudes.

**Taxonomic confounds in the plant–animal comparison.** The finding that animals show greater epistatic contributions than plants is plausible but potentially confounded: the plant sample is dominated by domesticated crop crosses and selfing species, which may have reduced standing genetic variation and thus lower detectable epistasis, confounding the clade comparison with mating system and domestication history. [Wright was right: leveraging 2024, Finding 2](/knowledge/papers/2024_wright/#finding-2)

**Trait-category subjectivity.** The life-history vs. morphological contrast (mean difference 0.06) is small in absolute terms, and the assignment of traits to categories involves subjective judgment. LCA is known to be conservative in detecting epistasis under sparse data, so the true contrast could be under- or overestimated. [Wright was right: leveraging 2024, Finding 1](/knowledge/papers/2024_wright/#finding-1)

**Hybridization artifacts in plant LCA.** The Solanum finding rests on only five cohorts from two parental strains. LCA can infer epistasis arising from novel multi-locus genotypes created by crossing that would never co-occur during natural divergence, meaning signals may partly reflect properties of hybrid genotype space.

## Tealc's citation-neighborhood suggestions

- Lynch & Walsh (1998) *Genetics and Analysis of Quantitative Traits* — canonical treatment of composite genetic effects in LCA, against which SAGA results should be benchmarked.
- Burnham & Anderson (2002) *Model Selection and Multimodel Inference* — foundational text for the AIC-based variable importance framework used by SAGA.
- Crnokrak & Roff (1995) — original empirical paper predicting that fitness-associated traits harbor more nonadditive variance; the 2024 wright findings directly test this prediction at scale.
- Demuth & Wade (2007a/b) — primary source for the majority of the originally re-analyzed 22 datasets; relevant for assessing the representativeness of the convenience sample.

## Related on the Blackmon Lab site

- [Blackmon & Demuth 2016](/knowledge/papers/2016_saga/)
- [Ruckman & Blackmon 2020](/knowledge/papers/2020_march_of_beetles/)
- [Assessing the opportunity for 2024](/knowledge/papers/2024_solanum/)
- [Wright was right: leveraging 2024](/knowledge/papers/2024_wright/)
<!-- tealc:auto-end -->
