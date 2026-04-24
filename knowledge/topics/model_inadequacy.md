---
layout: default
title: "Model Inadequacy"
topic_slug: model_inadequacy
last_updated: 2026-04-22T13:14:37.850235+00:00
papers_supporting: [10.1093/sysbio/syu131]
permalink: /knowledge/topics/model_inadequacy/
category: "Bioinformatics & tools"
---
<!-- tealc:auto-start -->
# Model Inadequacy

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

Model inadequacy, in the context of trait-dependent diversification, is the failure of a statistical model to capture the data-generating process well enough to produce reliable inferences — even when the data are perfectly clean and the analysis is executed correctly. The problem is distinct from model misspecification in a narrow technical sense: a model can pass likelihood-ratio tests and still generate false positives at rates that make the results scientifically uninterpretable.

The clearest demonstration of this failure comes from BiSSE (Binary State Speciation and Extinction). The model assumes that diversification rates are constant within each character state, but real phylogenies routinely contain rate heterogeneity that has nothing to do with the focal trait. When that background heterogeneity is present, BiSSE exploits it and assigns it to whatever binary character happens to be loaded. On the empirical cetacean phylogeny — a tree with well-documented diversification rate variation driven by the dolphin radiation — [10.1093/sysbio/syu131, Finding 1](/knowledge/papers/10_1093_sysbio_syu131/#finding-1) showed that more than 77% of 400 neutral character datasets simulated with no state-dependent diversification returned a statistically significant BiSSE result (p < 0.05), and 58% rejected the character-independent model at p < 0.001. A false positive rate of that magnitude means individual BiSSE p-values carry almost no evidential weight on trees with heterogeneous diversification.

The taxon name length result makes this point even harder to dismiss. Taxon name length cannot cause speciation. It has no evolutionary meaning. Yet [10.1093/sysbio/syu131, Finding 2](/knowledge/papers/10_1093_sysbio_syu131/#finding-2) found that across vertebrate subtrees, more than 69% showed a significant association between name length and speciation rate under BiSSE, and among ray-finned fishes the figure approached 100% — 60 of 61 subtrees. Any biological confound is excluded by design, leaving rate heterogeneity in the tree as the only explanation. The model is picking up signal; that signal just has nothing to do with the question being asked.

These results set a hard baseline: before interpreting any BiSSE finding as evidence of a trait's effect on diversification, the false positive rate on that specific tree — under that tree's actual diversification dynamics — needs to be characterized directly.

## Supporting evidence

- [10.1093/sysbio/syu131, Finding 1](/knowledge/papers/10_1093_sysbio_syu131/#finding-1): On the cetacean phylogeny, >77% of neutral character simulations returned p < 0.05 under BiSSE; 58% returned p < 0.001.
- [10.1093/sysbio/syu131, Finding 2](/knowledge/papers/10_1093_sysbio_syu131/#finding-2): Taxon name length — biologically meaningless — yielded significant BiSSE associations in >69% of vertebrate subtrees and ~100% of ray-finned fish subtrees.

## Contradictions / open disagreements

The cetacean phylogeny result may overstate the general problem. That tree has unusually strong diversification heterogeneity (the dolphin radiation), and false positive rates on more rate-homogeneous trees are likely lower. Whether the problem is severe enough to disqualify BiSSE results across vertebrates broadly, or only on clades with known rate shifts, remains an open empirical question. The taxon name length test is nearly a clean null, but taxon names do carry phylogenetic signal through shared prefixes among congeners, so the false positive rate it measures is not purely attributable to tree-level rate heterogeneity.

## Tealc's citation-neighborhood suggestions

Hidden-state extensions of BiSSE (HiSSE) were developed specifically to address the rate-heterogeneity confound flagged here; papers introducing and evaluating those methods would round out this topic. Simulation studies that characterize the false positive rate of BiSSE as a function of tree shape and rate heterogeneity magnitude would also help contextualize how broadly these findings generalize.

## Related on the Blackmon Lab site

- [Paper: 10.1093/sysbio/syu131](/knowledge/papers/10_1093_sysbio_syu131/)
<!-- tealc:auto-end -->
