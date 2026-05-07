---
layout: default
title: "Chaining Algorithm"
topic_slug: chaining_algorithm
last_updated: 2026-04-22T13:09:41.861401+00:00
papers_supporting: [10.1093/bioinformatics/bty191]
permalink: /knowledge/topics/chaining_algorithm/
category: "Bioinformatics & tools"
---
<!-- tealc:auto-start -->
# Chaining Algorithm

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

In sequence alignment, chaining refers to the step that links sparse anchor hits — typically minimizer matches between a query and reference — into candidate alignment paths before any expensive base-level dynamic programming is applied. The intuition is that a good chain of anchors is already a reliable signal of where a true alignment lies, so base-level work can be focused rather than exhaustive.

Minimap2's implementation of this idea goes further than most tools. According to [10.1093/bioinformatics/bty191, Finding 1](/knowledge/papers/10_1093_bioinformatics_bty191/#finding-1), the chaining step alone is more accurate than all other long-read mappers tested — before a single base-level alignment is computed. That is a strong claim: the accuracy advantage of the tool is not coming from a superior Smith-Waterman or Suzuki-Kasahara DP pass, but from the chain scoring itself. The practical consequence is that downstream DP, which is still several times slower than chaining even with the Suzuki-Kasahara improvement, only needs to run on a pruned set of high-confidence candidates.

This design choice reflects a broader principle in long-read alignment: the bottleneck shifts. For short reads, the anchor-to-chain step was almost trivial because reads were short enough that a handful of seeds sufficed. For reads measured in kilobases or megabases, the chaining problem becomes combinatorially harder, and getting it right pays dividends everywhere downstream.

## Supporting evidence

- [10.1093/bioinformatics/bty191, Finding 1](/knowledge/papers/10_1093_bioinformatics_bty191/#finding-1): Minimap2's chaining alone outperforms all other long-read mappers tested on accuracy, with the downstream base-level alignment step described as still several times slower than chaining even after the Suzuki-Kasahara improvement is applied.

## Contradictions / open disagreements

The chaining-accuracy claim from minimap2's paper rests on unpublished supplementary data ("data not shown"), which makes independent verification impossible. The benchmarks were conducted on simulated human reads; it is not clear whether the same accuracy advantage holds on more repeat-dense genomes, highly divergent sequences, or non-human organisms where anchor density and false-hit rates differ substantially. Until those comparisons appear in reproducible form, the generality of the claim should be treated cautiously.

## Tealc's citation-neighborhood suggestions

Papers describing the original sparse dynamic programming formulation of the chaining problem, as well as the Suzuki-Kasahara banded alignment improvement referenced in the minimap2 text, would round out this page. Benchmark studies comparing long-read mappers on non-human or highly repetitive genomes would directly test the limits of the accuracy claim above.

## Related on the Blackmon Lab site

- [Minimap2 paper page](/knowledge/papers/10_1093_bioinformatics_bty191/)
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
<!-- tealc:related-end -->
