---
layout: default
title: "Divergence Time Estimation"
topic_slug: divergence_time_estimation
last_updated: 2026-04-21T18:30:55.312637+00:00
papers_supporting: [f27c2afdfa103056f78a31587504db0cd2ede6ba343c3c727ddac8c4f114bb78]
permalink: /knowledge/topics/divergence_time_estimation/
category: "Population genetics"
---
# Divergence Time Estimation

## Current understanding

Estimating when lineages diverged is a core goal in evolutionary biology, but coalescent-based methods can produce severely misleading results when ancestral populations were spatially structured. A key insight from simulation work is that the "ghost" of a structured ancestor — one where gene flow connected populations along a linear stepping-stone model — inflates inferred divergence times because deep coalescent events within the ancestral metapopulation are mistaken for pre-speciation divergence.

The severity of this bias depends on two interacting factors: the geometry of ancestral gene flow and the ratio of divergence time to ancestral deme size (T_D/N_D). When migration among ancestral demes is low and T_D/N_D is small, SNAPP dramatically overestimates node ages. The risk becomes acute specifically when T_D/N_D falls below 10 and migration is low — a concrete threshold practitioners can use to assess vulnerability in their own systems ([Hancock & Blackmon 2020, Finding 2](/knowledge/papers/2020_ghost_of_a_structured/#finding-2)).

The worst-case scenario involves taxa whose ancestors occupied the ends of a linear stepping-stone chain. Under these conditions, the most geographically isolated lineages share the oldest common ancestors within the metapopulation, and SNAPP interprets this deep within-ancestor coalescence as evidence of an ancient speciation event. At T_D/N_D = 1 with low migration (m = 0.001), estimated divergence times between end-deme-derived species reached approximately 700% of the true age — an error of nearly an order of magnitude ([Hancock & Blackmon 2020, Finding 1](/knowledge/papers/2020_ghost_of_a_structured/#finding-1)). Crucially, this extreme bias was not simply a consequence of low T_D/N_D ratios in general; other migration regimes tested at the same ratio performed well, implicating the specific combination of spatial isolation and restricted gene flow as the causal driver.

These findings extend the earlier Rosenberg and Feldman (2002) rule — that T_D/N_e ≈ 5 marks a zone of concern for ILS-based bias — to the spatially explicit case, showing that structured ancestral demography adds a further layer of risk beyond panmictic assumptions.

## Supporting evidence

- [Hancock & Blackmon 2020, Finding 1](/knowledge/papers/2020_ghost_of_a_structured/#finding-1): SNAPP overestimates divergence times between end-deme species by ~700% when T_D/N_D = 1 under low migration in a 10-deme linear stepping-stone model.
- [Hancock & Blackmon 2020, Finding 2](/knowledge/papers/2020_ghost_of_a_structured/#finding-2): Overestimation becomes severe when the divergence-to-population-size ratio falls below 10 combined with low migration — a practical threshold for assessing bias risk.

## Contradictions / open disagreements

The 700% overestimation figure and the T_D/N_D < 10 threshold both arise from a single simulation design (10 demes, linear stepping stone, three discrete migration rates, SNAPP as the inference engine). Whether these quantitative benchmarks hold for systems with continuous geography, different deme numbers, non-linear spatial arrangements, or other coalescent methods (e.g., *BEAST, BPP) remains untested. It is therefore possible that the critical ratio differs substantially in empirical systems, and that the bias is partially method-specific rather than a universal property of ancestral-structure scenarios.

## Tealc's citation-neighborhood suggestions

- Rosenberg & Feldman (2002) — foundational T_D/N_e threshold paper cited as the panmictic baseline this work extends.
- Bryant et al. (2012) — original SNAPP publication; important context for understanding the model assumptions that make it susceptible to ancestral-structure bias.
- Wakeley (1999) on the "structured coalescent" — theoretical grounding for how spatial subdivision inflates apparent coalescence times.

## Related on the Blackmon Lab site

- [Ghost of a Structured Ancestor (2020)](/knowledge/papers/2020_ghost_of_a_structured/)