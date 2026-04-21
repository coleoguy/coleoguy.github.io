---
layout: default
title: "Isolation By Distance"
topic_slug: isolation_by_distance
last_updated: 2026-04-21T18:31:21.933720+00:00
papers_supporting: [f27c2afdfa103056f78a31587504db0cd2ede6ba343c3c727ddac8c4f114bb78]
permalink: /knowledge/topics/isolation_by_distance/
---
# Isolation By Distance

## Current understanding

Isolation by distance (IBD) describes the pattern in which genetic differentiation between populations increases as a function of geographic distance, arising when gene flow is spatially limited. A critical but underappreciated consequence of IBD is that *ancestral* spatial structure — not just contemporary structure — can severely distort the output of modern coalescent-based inference tools, biasing estimates of both divergence times and effective population sizes.

Under a linear stepping-stone model with low migration, standard species-tree methods such as SNAPP dramatically overestimate divergence times between taxa derived from the ends of the ancestral range. Simulations show that this overestimation can reach roughly 700% of the true divergence age when the ratio of divergence time to ancestral population size (TD/ND) equals 1 and migration is low (m = 0.001). Crucially, this bias is not a general artifact of low TD/ND ratios: other migration regimes tested under the same demographic parameters performed well, implicating the stepping-stone geometry specifically rather than shallow divergence alone ([2020 ghost of a structured, Finding 1](/knowledge/papers/2020_ghost_of_a_structured/#finding-1)).

A practical decision rule emerges from these simulations: divergence-time overestimation in SNAPP becomes severe when TD/ND falls below 10 and migration is low ([2020 ghost of a structured, Finding 2](/knowledge/papers/2020_ghost_of_a_structured/#finding-2)). This extends the classical Rosenberg & Feldman (2002) heuristic (TD/Ne ≈ 5) to spatially structured ancestors and gives empiricists a concrete threshold for assessing whether their systems are at risk. Studies whose inferred divergence-to-population-size ratios fall near or below this boundary should be treated with heightened skepticism.

Ancestral IBD also inflates estimates of effective population size. When end-deme taxa are sampled under low migration, applying the standard panmictic Ne estimator to pairwise divergence (π₁₂) yields mean ancestral Ne values on the order of ~7,370 — more than seven times the true census size of 1,000 ([2020 ghost of a structured, Finding 3](/knowledge/papers/2020_ghost_of_a_structured/#finding-3)). Populations sampled from the range center are far less affected (Ne ≈ 1,255), underscoring that sampling design relative to ancestral range geometry is a major, often overlooked, source of bias in demographic inference.

Together, these results suggest that the "ghost" of ancestral population structure can masquerade as deep divergence and large ancestral populations — two signals that are central to biogeographic and conservation-genetic interpretation.

## Supporting evidence

- [2020 ghost of a structured, Finding 1](/knowledge/papers/2020_ghost_of_a_structured/#finding-1) — SNAPP overestimates end-deme divergence times by ~700% under low migration when TD/ND = 1 in a 10-deme linear stepping-stone model.
- [2020 ghost of a structured, Finding 2](/knowledge/papers/2020_ghost_of_a_structured/#finding-2) — Severe bias threshold identified at TD/ND < 10 combined with low migration; provides an actionable screening criterion.
- [2020 ghost of a structured, Finding 3](/knowledge/papers/2020_ghost_of_a_structured/#finding-3) — Ancestral Ne inflated ~7-fold (Ne ≈ 7,370 vs. Nc = 1,000) for end-deme species pairs under m = 0.001, while center-deme pairs show modest inflation (Ne ≈ 1,255).

## Contradictions / open disagreements

The quantitative findings above all come from a single simulation framework: a 10-deme linear stepping-stone model with three discrete migration rates. It is not yet established whether the same thresholds and magnitudes apply to (a) non-linear or two-dimensional habitat geometries, (b) continuous rather than discrete population models, or (c) coalescent methods other than SNAPP. Methods that explicitly incorporate population structure (e.g., structured coalescent models) are expected to avoid the Ne inflation identified in Finding 3, but direct comparisons under IBD conditions have not been reported in this literature. These gaps represent open empirical questions rather than direct contradictions between published studies.

## Tealc's citation-neighborhood suggestions

- Rosenberg & Feldman (2002) — original TD/Ne ≈ 5 heuristic that the threshold in Finding 2 extends.
- Wright (1943) — foundational IBD theory; useful for contextualizing stepping-stone results.
- Bryant et al. (2012) — original SNAPP paper, needed to understand model assumptions underlying the bias.
- Bradburd et al. (2016, *Genetics*) — methods for detecting and correcting for IBD in population genomic data.

## Related on the Blackmon Lab site

- [Ghost of a Structured Ancestor (paper page)](/knowledge/papers/2020_ghost_of_a_structured/)