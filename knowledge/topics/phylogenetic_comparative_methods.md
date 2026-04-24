---
layout: default
title: "Phylogenetic Comparative Methods"
topic_slug: phylogenetic_comparative_methods
last_updated: 2026-04-22T13:14:13.911745+00:00
papers_supporting: [10.1093/sysbio/syu131]
permalink: /knowledge/topics/phylogenetic_comparative_methods/
category: "Bioinformatics & tools"
---<!-- tealc:auto-start -->
# Phylogenetic Comparative Methods

<!-- tealc:freshness-start -->
<aside class="wiki-freshness" aria-label="Page provenance">
<span class="wf-label">Composed by Tealc</span>
<span class="wf-date">2026-04-22</span>
<span class="wf-dot">·</span>
<span class="wf-sources">1 source</span>
<span class="wf-dot">·</span>
<span class="wf-review">Last reviewed by Heath: never</span>
</aside>
<!-- tealc:freshness-end -->


## Current understanding

Phylogenetic comparative methods are used throughout macroevolution to test whether a trait influences diversification rates, but at least one class of these methods — binary state speciation and extinction (BiSSE) — produces false positives at rates that should give pause to anyone interpreting a significant result. The core problem is diversification-rate heterogeneity across the tree: when background speciation rates vary among lineages for reasons unrelated to the focal trait, BiSSE detects that variation and attributes it to the trait anyway.

Two concrete benchmarks illustrate the scale of the problem. On the empirical cetacean phylogeny, which contains well-documented rate heterogeneity driven by the dolphin radiation, more than 77% of neutral character datasets simulated with *no* state-dependent diversification returned a statistically significant association between character state and speciation rate at p < 0.05 — and 58% cleared the p < 0.001 threshold [10.1093/sysbio/syu131, Finding 1](/knowledge/papers/10_1093_sysbio_syu131/#finding-1). The second benchmark is harder to explain away: taxon name length, which cannot conceivably drive speciation, showed a significant correlation with speciation rate in more than 69% of vertebrate subtrees, with the false-positive rate approaching 100% (60 of 61 subtrees) in ray-finned fishes [10.1093/sysbio/syu131, Finding 2](/knowledge/papers/10_1093_sysbio_syu131/#finding-2). Whether model adequacy testing and hidden-state corrections (e.g., HiSSE) reliably fix these problems — or merely redistribute them — remains an active area of debate in the field.

## Supporting evidence

- [10.1093/sysbio/syu131, Finding 1](/knowledge/papers/10_1093_sysbio_syu131/#finding-1): On the cetacean phylogeny, 77% of simulated neutral characters returned a significant BiSSE result (p < 0.05), with 58% reaching p < 0.001 — a direct, empirical quantification of Type I error under realistic conditions.

- [10.1093/sysbio/syu131, Finding 2](/knowledge/papers/10_1093_sysbio_syu131/#finding-2): Taxon name length correlated significantly with speciation rate in >69% of vertebrate subtrees and in nearly all ray-finned fish subtrees, providing an unambiguous demonstration that the inflated error rates cannot be blamed on any biological confound.

## Contradictions / open disagreements

The cetacean result is specific to a phylogeny with unusually pronounced diversification heterogeneity. Phylogenies with more homogeneous background diversification dynamics would likely show lower false-positive rates, so the 77% figure is probably an upper bound rather than a universal baseline. Additionally, taxon name length carries weak phylogenetic signal because congeners share name prefixes; the false-positive rates for that character may partly reflect residual phylogenetic structure in the names themselves, not purely tree-wide diversification heterogeneity. Whether state-dependent diversification methods can be trusted without hidden-state correction is still contested, and the degree to which newer approaches (HiSSE, BAMM-trait combinations) solve versus reframe the model adequacy problem is only starting to be tested systematically.

## Tealc's citation-neighborhood suggestions

- Maddison & FitzJohn (2015, *Systematic Biology*) — the hidden-state correction (HiSSE precursor) proposal, directly relevant to the remedies discussion.
- Rabosky (2014, *PLoS ONE*) on BAMM and diversification-rate heterogeneity, which is the biological mechanism producing the inflated BiSSE errors documented here.
- Davis et al. (2013, *Evolution*) on the statistical performance of trait-dependent diversification models under incomplete sampling.

## Related on the Blackmon Lab site

- [Rabosky & Goldberg (2015) paper page](/knowledge/papers/10_1093_sysbio_syu131/)
<!-- tealc:auto-end -->
