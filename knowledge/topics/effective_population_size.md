---
layout: default
title: "Effective Population Size"
topic_slug: effective_population_size
last_updated: 2026-04-21T18:32:03.651467+00:00
papers_supporting: [f27c2afdfa103056f78a31587504db0cd2ede6ba343c3c727ddac8c4f114bb78]
permalink: /knowledge/topics/effective_population_size/
category: "Population genetics"
---
<!-- tealc:auto-start -->
# Effective Population Size

## Current understanding

Effective population size (Ne) is a central parameter in population genetics, summarizing the rate at which genetic drift operates within a population. It is routinely estimated from genomic data via coalescent-based approaches, often using pairwise nucleotide divergence (π) between lineages under the assumption of panmixia. A critical caveat, however, is that Ne estimated this way reflects the *entire ancestry* of a sample — including shared lineage histories that pre-date the current population boundaries. When populations have been spatially structured in the past, this ancestral identity-by-descent (IBD) can cause Ne estimates to dramatically exceed the actual census size (Nc).

Simulations of stepping-stone models make this inflation concrete. At low migration rates (m = 0.001), end species in a linear array of demes accumulate high pairwise divergence from historical barriers to gene flow; when that divergence is fed into a standard panmictic Ne estimator, the resulting Ne (~7,370) is roughly 7-fold larger than the known census size of Nc = 1,000. Populations near the geographic center of the same array are much less affected, reaching only Ne ≈ 1,255 under the same conditions. This "ghost of structure past" means that range-edge or recently isolated lineages are particularly susceptible to Ne overestimation, with direct consequences for conservation assessments that rely on Ne as a proxy for population viability.

The magnitude of the bias depends on the ratio of divergence time to population size (TD/ND) and on migration rate: the 7-fold inflation specifically applies under TD/ND = 50 and m = 0.001. Other parameter regimes produce different degrees of inflation, but the directional effect — ancestral structure pushing estimated Ne above Nc — is robust across the scenarios examined.

## Supporting evidence

- [Hancock & Blackmon 2020, Finding 1](/knowledge/papers/2020_ghost_of_a_structured/#finding-1): Quantifies Ne inflation due to ancestral IBD in a stepping-stone model. At m = 0.001 and TD/ND = 50, end-species pairwise divergence yields Ne ≈ 7,370 versus a true Nc of 1,000, while center-species Ne rises only modestly to ~1,255. The inflation arises because the panmictic estimator (Ne = (π₁₂ − 2TD·μ) / 4μ) cannot distinguish within-deme coalescence from among-deme coalescence accumulated over structured history.

## Contradictions / open disagreements

The primary tension is methodological rather than empirical: the Ne inflation documented above is an artifact of applying a *panmictic* estimator to data generated under a *structured* model. Coalescent frameworks that explicitly incorporate population structure (e.g., the structured coalescent or isolation-with-migration models) would in principle recover unbiased local Ne values. Whether practitioners routinely apply such corrections — and whether the necessary demographic information is available to do so — remains an open question in applied conservation genetics. The magnitude of overestimation also varies with parameter choices (TD/ND ratio, m), so generalizing the exact 7-fold figure to real systems requires caution.

## Tealc's citation-neighborhood suggestions

- Papers developing or benchmarking structured-coalescent Ne estimators (e.g., MIGRATE-N, ∂a∂i, fastsimcoal2) would contextualize when panmictic approximations break down.
- Empirical conservation-genetics studies comparing Ne estimated from π vs. direct demographic censuses in fragmented populations would test whether the simulated bias manifests in real data.

## Related on the Blackmon Lab site

- [Hancock & Blackmon 2020](/knowledge/papers/2020_ghost_of_a_structured/)
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
<!-- tealc:related-end -->
