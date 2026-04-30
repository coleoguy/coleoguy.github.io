---
layout: default
title: "Divergence Time Estimation"
topic_slug: divergence_time_estimation
last_updated: 2026-04-21T18:30:55.312637+00:00
papers_supporting: [f27c2afdfa103056f78a31587504db0cd2ede6ba343c3c727ddac8c4f114bb78]
permalink: /knowledge/topics/divergence_time_estimation/
category: "Population genetics"
editor_frozen: true
---
<!-- tealc:auto-start -->
# Divergence Time Estimation

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

Estimating when lineages diverged is a core goal in evolutionary biology, but coalescent-based methods can produce severely misleading results when ancestral populations were spatially structured. A key insight from simulation work is that the "ghost" of a structured ancestor — one where gene flow connected populations along a linear stepping-stone model — inflates inferred divergence times because deep coalescent events within the ancestral metapopulation are mistaken for pre-speciation divergence.

The severity of this bias depends on two interacting factors: the geometry of ancestral gene flow and the ratio of divergence time to ancestral deme size (TD/ND). When migration among ancestral demes is low and TD/ND is small, SNAPP dramatically overestimates node ages. The risk becomes acute specifically when TD/ND falls below 10 and migration is low — a concrete threshold practitioners can use to assess vulnerability in their own systems ([Hancock & Blackmon 2020, Finding 2](/knowledge/papers/10_1093_jhered_esaa042/#finding-2)).

The worst-case scenario involves taxa whose ancestors occupied the ends of a linear stepping-stone chain. Under these conditions, the most geographically isolated lineages share the oldest common ancestors within the metapopulation, and SNAPP interprets this deep within-ancestor coalescence as evidence of an ancient speciation event. At TD/ND = 1 with low migration (m = 0.001), estimated divergence times between end-deme-derived species reached approximately 700% of the true age — an error of nearly an order of magnitude ([Hancock & Blackmon 2020, Finding 1](/knowledge/papers/10_1093_jhered_esaa042/#finding-1)). Crucially, this extreme bias was not simply a consequence of low TD/ND ratios in general; other migration regimes tested at the same ratio performed well, implicating the specific combination of spatial isolation and restricted gene flow as the causal driver.

These findings extend the earlier Rosenberg and Feldman (2002) rule — that TD/Ne ≈ 5 marks a zone of concern for ILS-based bias — to the spatially explicit case, showing that structured ancestral demography adds a further layer of risk beyond panmictic assumptions.

## Supporting evidence

- [Hancock & Blackmon 2020, Finding 1](/knowledge/papers/10_1093_jhered_esaa042/#finding-1): SNAPP overestimates divergence times between end-deme species by ~700% when TD/ND = 1 under low migration in a 10-deme linear stepping-stone model.
- [Hancock & Blackmon 2020, Finding 2](/knowledge/papers/10_1093_jhered_esaa042/#finding-2): Overestimation becomes severe when the divergence-to-population-size ratio falls below 10 combined with low migration — a practical threshold for assessing bias risk.

## Contradictions / open disagreements

The 700% overestimation figure and the TD/ND < 10 threshold both arise from a single simulation design (10 demes, linear stepping stone, three discrete migration rates, SNAPP as the inference engine). Whether these quantitative benchmarks hold for systems with continuous geography, different deme numbers, non-linear spatial arrangements, or other coalescent methods (e.g., *BEAST, BPP) remains untested. It is therefore possible that the critical ratio differs substantially in empirical systems, and that the bias is partially method-specific rather than a universal property of ancestral-structure scenarios.

## Tealc's citation-neighborhood suggestions

- Rosenberg & Feldman (2002) — foundational TD/Ne threshold paper cited as the panmictic baseline this work extends.
- Bryant et al. (2012) — original SNAPP publication; important context for understanding the model assumptions that make it susceptible to ancestral-structure bias.
- Wakeley (1999) on the "structured coalescent" — theoretical grounding for how spatial subdivision inflates apparent coalescence times.

## Related on the Blackmon Lab site

- [Hancock & Blackmon 2020](/knowledge/papers/10_1093_jhered_esaa042/)
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
<!-- tealc:related-end -->
