---
layout: default
title: "Rna Seq"
topic_slug: RNA_seq
last_updated: 2026-04-22T13:08:59.678373+00:00
papers_supporting: [10.1093/bioinformatics/bty191]
permalink: /knowledge/topics/RNA_seq/
category: "Bioinformatics & tools"
---
<!-- tealc:lead-start -->
<div class="wiki-lead" data-active="researcher">
<div data-register="researcher" markdown="1">

RNA-seq spans a wide methodological range, from short Illumina reads that count transcripts with high throughput to long noisy reads from Oxford Nanopore Technology (ONT) or PacBio SMRT platforms that can resolve full-length isoforms and splice junctions in a single pass. The choice of aligner matters substantially, especially for long-read data where base-level error rates are high and read lengths cross multiple exon boundaries.

For spliced alignment of long, noisy reads, minimap2 stands out on real data. On a mouse cDNA dataset sequenced with R9.4 ONT chemistry, minimap2 achieves 94.0% exact intron accuracy, compared with 83.8% for GMAP and 87.9% for SpAln — while running more than 40× faster than either alternative. That combination of accuracy and speed makes it the practical default for long-read RNA-seq workflows aimed at characterizing gene structure or cataloguing alternative splicing. See [10.1093/bioinformatics/bty191, Finding 1](/knowledge/papers/10_1093_bioinformatics_bty191/#finding-1).

Whether these advantages extend cleanly to SMRT reads or to future ONT chemistries with lower raw error rates is not yet settled. GMAP and SpAln were designed for low-error inputs, so their performance gap against minimap2 may narrow as read quality improves — or widen as read lengths increase.

</div>
<div data-register="student" markdown="1">

<!-- tealc:lead-student-only -->

When scientists sequence RNA, they can use fast but short reads from Illumina machines, or slower but longer reads from Oxford Nanopore Technology (ONT) or PacBio that can capture entire genes in one piece. Picking the right [aligner](/knowledge/concepts/sequence-aligner/) — the software that matches reads to a reference genome — makes a big difference, especially with long reads that have many errors and span multiple [exons](/knowledge/concepts/exon/).

For lining up long, noisy reads to find [splice junctions](/knowledge/concepts/splice-junction/), minimap2 performs best in real experiments. On a mouse dataset sequenced with R9.4 ONT chemistry, minimap2 correctly identified 94.0% of introns exactly, versus 83.8% for GMAP and 87.9% for SpAln — and ran more than 40× faster than either tool. This combination of accuracy and speed makes minimap2 the practical choice for long-read RNA-seq work when you want to understand gene structure or find [alternative splicing](/knowledge/concepts/alternative-splicing/) events. See [10.1093/bioinformatics/bty191, Finding 1](/knowledge/papers/10_1093_bioinformatics_bty191/#finding-1).

However, it is unclear whether minimap2's advantage holds up with SMRT reads or with improved ONT chemistries that have fewer errors. GMAP and SpAln were built for accurate reads, so they might close the gap against minimap2 as read quality improves — or the gap might widen as reads get longer.

<!-- tealc:lead-student-only-end -->

</div>
</div>
<!-- tealc:lead-end -->

<!-- tealc:auto-start -->
# RNA-seq

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

RNA-seq spans a wide methodological range, from short Illumina reads that count transcripts with high throughput to long noisy reads from Oxford Nanopore Technology (ONT) or PacBio SMRT platforms that can resolve full-length isoforms and splice junctions in a single pass. The choice of aligner matters substantially, especially for long-read data where base-level error rates are high and read lengths cross multiple exon boundaries.

For spliced alignment of long, noisy reads, minimap2 stands out on real data. On a mouse cDNA dataset sequenced with R9.4 ONT chemistry, minimap2 achieves 94.0% exact intron accuracy, compared with 83.8% for GMAP and 87.9% for SpAln — while running more than 40× faster than either alternative. That combination of accuracy and speed makes it the practical default for long-read RNA-seq workflows aimed at characterizing gene structure or cataloguing alternative splicing. See [10.1093/bioinformatics/bty191, Finding 1](/knowledge/papers/10_1093_bioinformatics_bty191/#finding-1).

Whether these advantages extend cleanly to SMRT reads or to future ONT chemistries with lower raw error rates is not yet settled. GMAP and SpAln were designed for low-error inputs, so their performance gap against minimap2 may narrow as read quality improves — or widen as read lengths increase.

## Supporting evidence

- [10.1093/bioinformatics/bty191, Finding 1](/knowledge/papers/10_1093_bioinformatics_bty191/#finding-1): On real ONT mouse cDNA reads, minimap2 finds more splice junctions with a higher fraction exactly correct (94.0%) than GMAP (83.8%) or SpAln (87.9%), and does so more than 40× faster.

## Contradictions / open disagreements

The minimap2 benchmark is limited to a single species and a single ONT chemistry. GMAP and SpAln were not run with parameters tuned for high-error reads, so the reported accuracy gap may overstate minimap2's advantage in a fair comparison. Performance on SMRT data or on newer, higher-accuracy ONT chemistries remains an open question.

## Tealc's citation-neighborhood suggestions

- A direct comparison of minimap2 against STAR or HISAT2 on matched short-read and long-read data from the same samples would clarify where the long-read spliced-alignment advantage is largest.
- Benchmarks on non-mammalian transcriptomes (e.g., insects with compact introns) would be relevant to the lab's Coleoptera work.

## Related on the Blackmon Lab site

- [Minimap2 paper page](/knowledge/papers/10_1093_bioinformatics_bty191/)
<!-- tealc:auto-end -->
