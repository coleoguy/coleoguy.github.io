---
layout: default
title: "Ghosts of a Structured Past: Impacts of Ancestral Patterns of Isolation-by-Distance on Divergence-Time Estimation"
doi: "10.1093/jhered/esaa042"
fingerprint_sha256: f27c2afdfa103056f78a31587504db0cd2ede6ba343c3c727ddac8c4f114bb78
authors: "Zachary B Hancock, Heath Blackmon"
journal: "Journal of Heredity"
year: 2020
topics: [coalescent_simulation, conservation_genetics, divergence_time_estimation, effective_population_size, isolation_by_distance]
tier: canon
ingested_at: 2026-04-21T18:30:32.948914+00:00
permalink: /knowledge/papers/10_1093_jhered_esaa042/
---
# Ghosts of a Structured Past: Impacts of Ancestral Patterns of Isolation-by-Distance on Divergence-Time Estimation

<!-- tealc:freshness-start -->
<aside class="wiki-freshness" aria-label="Source paper provenance">
<span class="wf-label">Source paper</span>
<span class="wf-date">ingested 2026-04-21</span>
<span class="wf-dot">·</span>
<span class="wf-sources">3 findings extracted</span>
<span class="wf-dot">·</span>
<span class="wf-review">fingerprint f27c2afd</span>
</aside>
<!-- tealc:freshness-end -->


## Summary

_Ingested 2026-04-21. 3 findings extracted and verified._

## Findings worth citing

<a id="finding-1"></a>
### Finding 1 — When ancestral populations follow a linear stepping-stone model with low migration, SNAPP overestimates divergence times between end-deme-derived species by roughly 700% when TD/ND = 1.

> The most dramatic overestimation occurred between end species when T D / ND = 1 at ~700% the true age. Importantly, this was not merely the result of a low T D / ND ratio, as the other migration regimes performed well.
— p. 577

*Why this is citable:* This is the headline quantitative result of the paper, grounding claims that ancestral IBD can severely bias coalescent-based divergence dating. Useful for citing when critiquing or contextualizing SNAPP/BEAST divergence estimates in phylogeographic studies.

*Counter / limitation:* The 700% figure comes from a specific simulation scenario (m=0.001, TD/ND=1) with a fixed 10-deme linear stepping stone; empirical systems may not match these parameters, and the result is SNAPP-specific rather than a general property of all coalescent methods.

*Topics:* [divergence_time_estimation](/knowledge/topics/divergence_time_estimation/), [isolation_by_distance](/knowledge/topics/isolation_by_distance/), [coalescent_simulation](/knowledge/topics/coalescent_simulation/)

<a id="finding-2"></a>
### Finding 2 — Divergence-time overestimation due to ancestral IBD becomes severe specifically when the ratio of divergence time to ancestral population size falls below 10 and migration is low.

> Divergence-time overestimation in SNAPP becomes severe when the divergence-to-population size ratio < 10 and migration is low.
— p. 573

*Why this is citable:* Provides a concrete, citable threshold (TD/ND < 10) that downstream studies can use to decide whether their systems are at risk of ancestral-structure bias. Directly extends Rosenberg and Feldman's (2002) TD/Ne ≈ 5 rule to spatially structured ancestors.

*Counter / limitation:* The threshold was derived from simulations with 10 demes and specific migration rates (0.1, 0.01, 0.001); empirical systems with different deme numbers, geometries, or continuous habitats may have different critical ratios.

*Topics:* [divergence_time_estimation](/knowledge/topics/divergence_time_estimation/), [isolation_by_distance](/knowledge/topics/isolation_by_distance/)

<a id="finding-3"></a>
### Finding 3 — Ancestral IBD inflates estimated effective population size relative to census size, with mean ancestral Ne reaching ~7370 versus Nc = 1000 at m = 0.001 when sampling end species.

> However, when m = 0.001, π 12 for end species was 0.012948, an ancestral Ne = 7370. Center species, on the other hand, only increased to Ne = 1255.
— p. 580

*Why this is citable:* Quantifies how ancestral spatial structure inflates Ne estimates derived from pairwise divergence (π12) relative to the known census size, showing mean Ne (~7370) can exceed Nc (1000) by roughly 7-fold when m=0.001 and end species are sampled. Relevant to any study interpreting coalescent-based Ne as a proxy for census population size, particularly in conservation contexts involving fragmented or range-edge populations.

*Counter / limitation:* The Ne value of ~7370 is derived by applying the panmictic expectation (equation 5: Ne = (π12 − 2TDμ) / 4μ) to data generated under a structured model; this is the very source of the inflation, not a failure of a general Ne estimator. Methods that explicitly account for population structure (e.g., structured coalescent models) would not produce this bias. Additionally, the specific TD/ND ratio used matters: the paper reports this figure for TD/ND = 50 with m = 0.001, so the magnitude may differ for other parameter combinations.

*Topics:* [effective_population_size](/knowledge/topics/effective_population_size/), [isolation_by_distance](/knowledge/topics/isolation_by_distance/), [conservation_genetics](/knowledge/topics/conservation_genetics/)

<!-- tealc:related-start -->
## Read the paper

[doi.org/10.1093/jhered/esaa042](https://doi.org/10.1093/jhered/esaa042)

## Other papers by these authors

- [Blackmon H](/knowledge/authors/blackmon_h/)
<!-- tealc:related-end -->
