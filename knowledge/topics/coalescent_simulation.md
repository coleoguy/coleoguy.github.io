---
layout: default
title: "Coalescent Simulation"
topic_slug: coalescent_simulation
last_updated: 2026-04-21T18:31:40.674698+00:00
papers_supporting: [f27c2afdfa103056f78a31587504db0cd2ede6ba343c3c727ddac8c4f114bb78]
permalink: /knowledge/topics/coalescent_simulation/
category: "Population genetics"
---
<!-- tealc:auto-start -->
# Coalescent Simulation

## Current understanding

Coalescent simulation is widely used to evaluate the performance of phylogenetic and population-genetic inference methods under controlled demographic scenarios. A key insight emerging from simulation work is that violations of the standard coalescent assumption — that ancestral populations are well-mixed and panmictic — can introduce severe bias into divergence time estimates, even when modern populations appear distinct.

One striking example comes from simulations of SNAPP (a Bayesian species-tree method implemented in BEAST2) under a linear stepping-stone model. When ancestral populations are structured with low migration between adjacent demes, SNAPP can dramatically overestimate divergence times between taxa derived from opposite ends of the stepping-stone chain. The core mechanism is that lineages from geographically distant demes take much longer to coalesce within the ancestral metapopulation than a panmictic model would predict — a phenomenon sometimes called the "ghost" of ancestral structure. The method misattributes this extended coalescence time to deep species divergence rather than to within-population geographic isolation.

This bias is not a generic consequence of shallow divergences (low TD/ND ratios). Simulation results show that SNAPP performs well under other migration geometries at the same TD/ND ratio, meaning the problem is specifically tied to the isolation-by-distance architecture of the stepping-stone model rather than to any general limitation of the approach. The implication for empirical studies is that phylogeographic systems with range-wide geographic structure in ancestral lineages — which is common in continuously distributed taxa — may yield inflated node ages in coalescent species-tree analyses without any obvious diagnostic signal.

## Supporting evidence

Quantitative simulation under a 10-deme linear stepping-stone model demonstrates that SNAPP overestimates divergence times between end-deme-derived species by approximately 700% when TD/ND = 1 and migration is low (m = 0.001). See [Hancock & Blackmon 2020, Finding 1](/knowledge/papers/2020_ghost_of_a_structured/#finding-1) for full details.

## Contradictions / open disagreements

The 700% overestimation result is specific to SNAPP and a particular simulation architecture (linear stepping stone, 10 demes, m = 0.001, TD/ND = 1). It is not yet clear whether other coalescent frameworks — such as *BEAST, SVDquartets, or MSC-based approaches in IQ-TREE — exhibit the same magnitude of bias under analogous conditions. Broader benchmarking across methods and migration geometries is needed before this finding can be treated as a general property of coalescent simulation.

## Tealc's citation-neighborhood suggestions

- Papers benchmarking *BEAST or SVDquartets under structured ancestral populations would directly extend this work.
- Studies on isolation-by-distance and its effects on coalescent genealogies (e.g., Wilkins & Wakeley 2002) provide theoretical grounding.
- Empirical phylogeographic studies of continuously distributed species that use SNAPP for divergence dating should be evaluated in light of this bias.

## Related on the Blackmon Lab site

- [Hancock & Blackmon 2020](/knowledge/papers/2020_ghost_of_a_structured/)
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
<!-- tealc:related-end -->
