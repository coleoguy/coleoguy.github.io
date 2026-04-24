---
layout: default
title: "Short Read Alignment"
topic_slug: short_read_alignment
last_updated: 2026-04-22T12:38:49.433857+00:00
papers_supporting: [10.1093/bioinformatics/btp324]
permalink: /knowledge/topics/short_read_alignment/
category: "Bioinformatics & tools"
---<!-- tealc:auto-start -->
# Short Read Alignment

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

Short read alignment — mapping millions of sequencing reads back to a reference genome — has been shaped heavily by algorithmic advances that trade index construction cost for dramatic query-time speedups. The Burrows-Wheeler Aligner (BWA), introduced by Li & Durbin in 2009, anchored the field's shift toward suffix-array–based methods. By indexing the reference with a Burrows-Wheeler Transform, BWA achieves alignment speeds 6–18× faster than the then-standard MAQ aligner while maintaining comparable accuracy on human genome data. The magnitude of the speedup varies with read length; MAQ internally pads all reads to 128 bp, so it shows no length-dependent change in throughput, whereas BWA scales more naturally with actual read length. That architectural difference has downstream consequences for how each tool handles the growing read lengths produced by successive sequencing platforms.

Accuracy was evaluated in parallel with speed: BWA's error and missing-alignment rates on simulated data were comparable to MAQ's, meaning the speed gain did not require sacrificing alignment quality for typical short-read genomic work.

## Supporting evidence

BWA's core performance advantage is documented quantitatively in [Fast and accurate short read alignment with Burrows-Wheeler transform., Finding 1](/knowledge/papers/10_1093_bioinformatics_btp324/#finding-1): on a 2.5 GHz Xeon E5420, BWA aligned reads to the human genome 6–18× faster than MAQ across a range of read lengths, with the upper bound of the range reflecting longer reads where MAQ's fixed 128 bp internal representation becomes a bottleneck.

## Contradictions / open disagreements

The original benchmark figures carry a noted internal inconsistency: the abstract of Li & Durbin 2009 reports a 10–20× speedup while the results section gives 6–18×, with the difference attributable to which range of read lengths is considered. Neither figure is wrong, but citing the paper requires specifying which range is meant. More broadly, these benchmarks reflect single-core performance on 2009 hardware with simulated data; real-world speedups against modern multi-threaded aligners on current hardware and with empirical reads from complex genomes could differ substantially. No contradicting paper has been incorporated into this page yet, but the benchmarking landscape for short-read alignment has evolved considerably since 2009.

## Tealc's citation-neighborhood suggestions

- Langmead et al. 2009 (Bowtie) — the contemporaneous BWT-based aligner that shares BWA's indexing strategy but prioritizes different speed/sensitivity tradeoffs.
- Li et al. 2009 (SAMtools/SAM format) — directly paired with BWA in most pipelines; the alignment output format is inseparable from the aligner choice.
- Langmead & Salzberg 2012 (Bowtie 2) — extended the approach to gapped alignment and longer reads, making it directly comparable to BWA-MEM.

## Related on the Blackmon Lab site

- [BWA paper detail page](/knowledge/papers/10_1093_bioinformatics_btp324/)
<!-- tealc:auto-end -->
