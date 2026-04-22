---
layout: default
title: "Genome Resequencing"
topic_slug: genome_resequencing
last_updated: 2026-04-22T12:39:23.362868+00:00
papers_supporting: [10.1093/bioinformatics/btp324]
permalink: /knowledge/topics/genome_resequencing/
category: "Bioinformatics & tools"
---
<!-- tealc:auto-start -->
# Genome Resequencing

## Current understanding

Genome resequencing — aligning short reads from one or more individuals back to a reference assembly — sits at the core of population genomics, variant calling, and comparative work. The throughput of this step is set almost entirely by the choice of aligner. The Burrows-Wheeler Aligner (BWA), introduced by Li & Durbin in 2009, replaced MAQ as the dominant short-read aligner by achieving comparable alignment accuracy at 6–18× greater speed, with the exact gain depending on read length. MAQ's architecture internally pads every read to 128 bp regardless of actual length, which caps its speed; BWA avoids this by using the Burrows-Wheeler Transform to index the reference rather than the reads. At the time of publication, this made genome-scale resequencing on a single workstation practical in a way it had not been before.

The accuracy parity with MAQ matters as much as the speed gain: faster alignment is only useful if the resulting mappings are trustworthy enough for downstream variant calling. Benchmarks on simulated human genome reads showed BWA matching MAQ's sensitivity and specificity across a range of error models.

What remains less characterized is how these numbers translate to non-model organisms with complex repeat landscapes, highly heterozygous populations, or non-diploid karyotypes — precisely the cases that arise frequently in comparative and evolutionary genomic work.

## Supporting evidence

- [Fast and accurate short read alignment with Burrows-Wheeler transform., Finding 1](/knowledge/papers/10_1093_bioinformatics_btp324/#finding-1) — Li & Durbin (2009) report that BWA is 6–18× faster than MAQ on a 2.5 GHz Xeon E5420 with simulated human genome reads, while achieving similar alignment accuracy. The speed range reflects variation across read lengths tested.

## Contradictions / open disagreements

The Li & Durbin (2009) benchmarks were run on a single processor core using simulated reads against the human reference genome. The abstract reports 10–20× speed gains while the Results section reports 6–18×; the discrepancy reflects which read-length range is considered. Real-world performance on non-human genomes, repeat-rich assemblies, or modern multi-core hardware is not directly addressed by this study, and no comparisons to post-2009 aligners (BWA-MEM, BWA-MEM2, Bowtie2) are available from this paper.

## Tealc's citation-neighborhood suggestions

- Benchmarking studies comparing BWA-MEM and BWA-MEM2 on large genomes would contextualize how much the 2009 speed figures have been superseded.
- Papers on alignment accuracy in organisms with high heterozygosity or unusual repeat content (e.g., insects with holocentric chromosomes) would extend these findings beyond the human-genome context.

## Related on the Blackmon Lab site

- [Li & Durbin 2009 paper page](/knowledge/papers/10_1093_bioinformatics_btp324/)
<!-- tealc:auto-end -->
