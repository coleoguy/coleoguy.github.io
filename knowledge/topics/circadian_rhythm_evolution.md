---
layout: default
title: "Circadian rhythm evolution"
topic_slug: circadian_rhythm_evolution
last_updated: 2026-04-21T18:54:23.116161+00:00
papers_supporting: [74e7bc680605ee2207a1f5cf31811de0fef84fed56357b0bbe6d6ba1443f9925]
permalink: /knowledge/topics/circadian_rhythm_evolution/
category: "Bioinformatics & tools"
---
<!-- tealc:auto-start -->
# Circadian rhythm evolution

## Current understanding

Circadian rhythms — the endogenous ~24-hour molecular clocks that coordinate behavior, physiology, and gene expression — are evolutionarily ancient, yet their genetic architecture can be reshaped rapidly under novel selection pressures. Cave environments, which lack light–dark cycles, offer a natural experiment: populations that colonize caves are released from the selective constraint that normally stabilizes circadian timekeeping, and the molecular components of the clock can diverge or degrade over time. Identifying which specific genes drive this divergence requires integrating population-genetic signals of selection with transcriptomic evidence of altered circadian regulation.

One promising computational approach to this problem is to cross-reference FST outlier scans — which flag genomic regions unusually differentiated between cave and surface populations — with circadian transcription datasets. Applied to the Mexican cavefish *Astyanax mexicanus*, this strategy has identified candidate genes showing convergent molecular evolution across independently derived cave populations.

## Supporting evidence

A key proof-of-principle comes from the CaveCrawler tool, which integrated FST outlier data (Herman et al. 2018) with a circadian transcription dataset (Mack et al. 2021) across three independent cave populations (Pachón, Molino, and Tinaja) compared to surface fish from Río Choy. The gene *arpin* — a negative regulator of actin dynamics — emerged as a "double outlier" in all three cave-versus-surface comparisons, meaning it showed both elevated population-genetic differentiation and differential expression in a circadian context. A second gene, *cyp26a1*, achieved double-outlier status in two of the three pairings (Pachón and Tinaja versus Río Choy). The convergence of *arpin*'s signal across three independently colonized cave systems strengthens the inference that its divergence is not merely stochastic drift but may reflect shared adaptive or degenerative pressures on circadian regulation in cave environments. See [Perry et al. 2022, Finding 1](/knowledge/papers/2022_cave_crawler/#finding-1) for full details.

## Contradictions / open disagreements

The biological inference that *arpin* plays a functional role in cavefish circadian evolution remains correlative. The double-outlier status depends on both the choice of FST threshold (lowest 5% divergence in Herman et al. 2018) and the specific circadian transcription dataset used; altering either input could change the candidate gene list. No functional validation — e.g., knockouts, rescue experiments, or behavioral circadian assays — has been reported for *arpin* in this context. Additionally, *arpin*'s canonical function is in actin regulation, so its appearance in a circadian screen may reflect pleiotropic effects or limitations of the transcription dataset rather than a primary role in clock evolution. These uncertainties should be resolved before *arpin* is treated as a confirmed circadian evolution gene in cavefish.

## Tealc's citation-neighborhood suggestions

- Functional studies of *Astyanax mexicanus* circadian behavior (e.g., free-running period assays in cave versus surface fish) would complement the bioinformatic candidate list.
- Work on *arpin* and Arp2/3 complex regulation in other systems could help evaluate whether actin dynamics plausibly intersect with circadian clock machinery.
- QTL mapping studies of circadian phenotypes in *A. mexicanus* cave × surface hybrids could test whether the *arpin* locus co-localizes with behavioral or molecular clock divergence.

## Related on the Blackmon Lab site

- Paper page: [Perry et al. 2022](/knowledge/papers/2022_cave_crawler/)
<!-- tealc:auto-end -->
