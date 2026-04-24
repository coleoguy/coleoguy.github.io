---
layout: default
title: "Type I Error"
topic_slug: type_I_error
last_updated: 2026-04-22T13:13:24.679735+00:00
papers_supporting: [10.1093/sysbio/syu131]
permalink: /knowledge/topics/type_I_error/
category: "Bioinformatics & tools"
---<!-- tealc:auto-start -->
# Type I Error

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

In hypothesis testing, a Type I error is a false positive — rejecting a true null hypothesis. In macroevolution, the stakes of inflated Type I error are high: a method that routinely detects trait–diversification associations that do not exist will produce a literature full of spurious evolutionary stories.

State-dependent diversification methods, and BiSSE in particular, are now known to have severe Type I error inflation on real phylogenies. The core problem is not that the models are wrong in principle, but that heterogeneous background diversification rates — rate variation driven by something other than the focal trait — mimic the signal the model is designed to detect. When a phylogeny already contains clades with dramatically different net diversification rates, almost any binary character mapped onto that tree will appear to predict those rate differences, even if the character is causally irrelevant.

The empirical evidence for this is stark. On the cetacean phylogeny, over 77% of 400 neutral character datasets — characters simulated with no relationship to diversification whatsoever — produced a statistically significant BiSSE result (p < 0.05), and 58% rejected the character-independent model with p < 0.001. That is not a modest inflation around the nominal 5% threshold; it is a near-complete inversion of what the test is supposed to guarantee.

The taxon name length test sharpens the point. Taxon name length has no conceivable biological meaning, yet across vertebrate subtrees it showed a significant association with speciation rate in more than 69% of cases. In ray-finned fishes, 60 of 61 subtrees returned a significant result — essentially 100%. A method that flags the number of letters in a species' name as a driver of speciation is not a tool that can be trusted without correction.

## Supporting evidence

- [10.1093/sysbio/syu131, Finding 1](/knowledge/papers/10_1093_sysbio_syu131/#finding-1): On the empirical cetacean phylogeny, >77% of neutral character datasets simulated without state-dependent diversification showed a statistically significant BiSSE association with speciation rate (p < 0.05); 58% rejected the character-independent model at p < 0.001.

- [10.1093/sysbio/syu131, Finding 2](/knowledge/papers/10_1093_sysbio_syu131/#finding-2): Taxon name length — a purely arbitrary character — showed a significant association with speciation rate in >69% of vertebrate subtrees, approaching 100% for ray-finned fishes (60 of 61 subtrees).

## Contradictions / open disagreements

The cetacean result may not generalize uniformly. The cetacean phylogeny contains one of the most dramatic radiations in vertebrate history (delphinids), so the diversification heterogeneity driving false positives is unusually pronounced. Phylogenies with more homogeneous background rates might show lower Type I error inflation, though the taxon name length analysis across many vertebrate subtrees suggests the problem is broadly distributed, not confined to especially heterogeneous trees.

Taxon name length is not a perfectly clean null: congeners share name prefixes, so the character carries residual phylogenetic signal. Some fraction of the inflated error rate could reflect that structure rather than diversification heterogeneity alone. The finding is still damning — no one would argue name length *causes* speciation — but the precise magnitude of inflation attributable purely to background rate heterogeneity remains somewhat entangled with this artifact.

Whether hidden-state extensions (e.g., HiSSE) adequately resolve the Type I error problem is contested and not directly addressed by these findings.

## Tealc's citation-neighborhood suggestions

- Rabosky & Goldberg (2015, *Systematic Biology*) — the source paper for both findings above; any analysis using BiSSE or related SSE methods should engage directly with this work.
- Beaulieu & O'Meara (2016) on HiSSE — directly motivated by the Type I error problem documented here.
- Maddison & FitzJohn (2015) on the model adequacy problem in SSE methods.

## Related on the Blackmon Lab site

- [Paper page: 10.1093/sysbio/syu131](/knowledge/papers/10_1093_sysbio_syu131/)
<!-- tealc:auto-end -->
