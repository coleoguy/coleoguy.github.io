---
layout: default
title: "Sequence Alignment"
topic_slug: sequence_alignment
last_updated: 2026-04-22T13:08:23.180260+00:00
papers_supporting: [10.1093/bioinformatics/bty191]
permalink: /knowledge/topics/sequence_alignment/
category: "Bioinformatics & tools"
---
<!-- tealc:auto-start -->
# Sequence Alignment

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

Long-read sequencing has shifted alignment from a solved problem to an active design space. For genomic alignment of noisy long reads (ONT, PacBio), minimap2's chaining algorithm is the primary accuracy driver — chaining alone outperforms the full alignment pipelines of competing tools before any base-level dynamic programming is applied. This means the seed-chain step, not the final DP polish, is where most mapping errors are won or lost. [10.1093/bioinformatics/bty191, Finding 2](/knowledge/papers/10_1093_bioinformatics_bty191/#finding-2)

For spliced alignment of long noisy reads against a genome — the task that matters for long-read RNA-seq and gene-structure annotation — minimap2 reaches 94.0% exact intron accuracy on real ONT mouse cDNA data, compared to 83.8% for GMAP and 87.9% for SpAln, while running more than 40× faster than either. [10.1093/bioinformatics/bty191, Finding 1](/knowledge/papers/10_1093_bioinformatics_bty191/#finding-1) Neither GMAP nor SpAln was designed for the error profiles of noisy long reads, which likely depresses their numbers, but the speed gap is large enough that even a tuned re-run of those tools would leave minimap2 as the practical default for this read type.

## Supporting evidence

- [10.1093/bioinformatics/bty191, Finding 1](/knowledge/papers/10_1093_bioinformatics_bty191/#finding-1): On real ONT mouse cDNA reads, minimap2 achieves 94.0% exact intron accuracy vs. 83.8% (GMAP) and 87.9% (SpAln), with a >40× speed advantage.
- [10.1093/bioinformatics/bty191, Finding 2](/knowledge/papers/10_1093_bioinformatics_bty191/#finding-2): Minimap2's chaining step alone is more accurate than full-pipeline competing long-read mappers on simulated human reads, establishing chaining as the key accuracy determinant in the tool's design.

## Contradictions / open disagreements

The chaining-accuracy superiority claim in Finding 2 is reported as "data not shown," so independent verification from the published figures is not possible. The spliced-alignment benchmarks (Finding 1) come from a single mouse cDNA dataset under R9.4 ONT chemistry; whether the accuracy ordering holds for SMRT reads, newer ONT chemistries, or genomes with higher repeat content is not yet documented in this paper. These two gaps leave open the possibility that performance rankings shift on non-mammalian or highly repetitive genomes — a relevant concern for insect genomics work.

## Tealc's citation-neighborhood suggestions

- Benchmarking papers that systematically compare minimap2 against BWA-MEM2 or STAR on both short and long reads would clarify where the tool boundaries lie.
- Work on repeat-rich insect genomes (e.g., Coleoptera) using long-read assemblies would test whether the chaining accuracy advantage persists outside standard human/mouse benchmarks.

## Related on the Blackmon Lab site

- [Minimap2 paper page](/knowledge/papers/10_1093_bioinformatics_bty191/)
<!-- tealc:auto-end -->
