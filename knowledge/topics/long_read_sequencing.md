---
layout: default
title: "Long Read Sequencing"
topic_slug: long_read_sequencing
last_updated: 2026-04-22T13:08:43.714460+00:00
papers_supporting: [10.1093/bioinformatics/bty191]
permalink: /knowledge/topics/long_read_sequencing/
category: "Bioinformatics & tools"
---<!-- tealc:auto-start -->
# Long Read Sequencing

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

Long-read sequencing platforms — PacBio HiFi and Oxford Nanopore (ONT) — have become central to chromosome-level genome assembly and transcriptome characterization. Unlike short reads, long reads can span repetitive regions and large introns, but they introduce new computational demands: aligners must handle higher per-read error rates, and spliced alignment of cDNA reads requires accurate intron boundary detection across reads that can be kilobases long.

Minimap2 addresses both problems. For spliced alignment of long noisy RNA reads, it achieves 94.0% exact intron accuracy on real ONT mouse cDNA data, compared to 83.8% for GMAP and 87.9% for SpAln — and it does this more than 40 times faster than either alternative ([10.1093/bioinformatics/bty191, Finding 1](/knowledge/papers/10_1093_bioinformatics_bty191/#finding-1)). That speed margin matters in practice: large transcriptome datasets that would require days with GMAP can be processed in hours.

For genomic alignment, the accuracy advantage is traceable to minimap2's chaining step rather than downstream base-level dynamic programming. The chaining algorithm alone outperforms all other long-read mappers tested, meaning that downstream DP alignment is primarily a refinement rather than the primary source of correctness ([10.1093/bioinformatics/bty191, Finding 2](/knowledge/papers/10_1093_bioinformatics_bty191/#finding-2)). This matters for researchers extending or benchmarking the tool: the algorithmic bottleneck is chaining, not alignment.

Together, these results position minimap2 as the default choice for long-read mapping in both genomic and transcriptomic contexts. The bottleneck in long-read projects is increasingly not the aligner's speed or accuracy — it is deciding which comparisons and which species to prioritize.

## Supporting evidence

- [10.1093/bioinformatics/bty191, Finding 1](/knowledge/papers/10_1093_bioinformatics_bty191/#finding-1): Minimap2 achieves 94.0% exact intron accuracy on real ONT mouse cDNA reads vs. 83.8% (GMAP) and 87.9% (SpAln), while running >40× faster.
- [10.1093/bioinformatics/bty191, Finding 2](/knowledge/papers/10_1093_bioinformatics_bty191/#finding-2): For genomic long-read alignment, minimap2's chaining step alone exceeds the accuracy of all other mappers tested, with downstream base-level DP serving as a refinement.

## Contradictions / open disagreements

The spliced-alignment benchmark (Finding 1) uses a single mouse cDNA dataset sequenced with R9.4 ONT chemistry. GMAP and SpAln were not parameter-tuned for noisy long reads, so their reported accuracy may understate what those tools can achieve with careful configuration. Performance on more repeat-dense or divergent genomes — beetle chromosomes, for instance — is not directly characterized. The chaining-accuracy claim (Finding 2) is described as "data not shown," making independent verification from the paper alone impossible, and the comparison relies on simulated human reads that may not represent the structural complexity of non-model organisms.

## Tealc's citation-neighborhood suggestions

- Benchmarking studies comparing minimap2 to PBMM2 and STARlong on non-mammalian genomes would be useful context, particularly for organisms with highly repetitive or holocentric chromosomes.
- Papers characterizing ONT accuracy improvements from R10.4 chemistry onward could update the error-rate assumptions underlying these benchmarks.

## Related on the Blackmon Lab site

- [Paper page: minimap2 (Li 2018)](/knowledge/papers/10_1093_bioinformatics_bty191/)
<!-- tealc:auto-end -->
