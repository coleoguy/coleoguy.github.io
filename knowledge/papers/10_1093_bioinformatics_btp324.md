---
layout: default
title: "Fast and accurate short read alignment with Burrows-Wheeler transform."
doi: "10.1093/bioinformatics/btp324"
fingerprint_sha256: a3d9f7f03e60ae6f356d5e84312d052ae5ff207ef17afcdeaf86215cf3f41413
authors: "Li H, Durbin R"
journal: ""
year: 2009
topics: [bioinformatics_methods, genome_resequencing, genome_structure_evolution, karyotype_database, short_read_alignment]
tier: canon
ingested_at: 2026-04-22T12:36:29.408666+00:00
permalink: /knowledge/papers/10_1093_bioinformatics_btp324/
---
# Fast and accurate short read alignment with Burrows-Wheeler transform.

<!-- tealc:freshness-start -->
<aside class="wiki-freshness" aria-label="Source paper provenance">
<span class="wf-label">Source paper</span>
<span class="wf-date">ingested 2026-04-22</span>
<span class="wf-dot">·</span>
<span class="wf-sources">4 findings extracted</span>
<span class="wf-dot">·</span>
<span class="wf-review">fingerprint a3d9f7f0</span>
</aside>
<!-- tealc:freshness-end -->


## Summary

_Ingested 2026-04-22. 4 findings extracted and verified._

## Findings worth citing

<a id="finding-1"></a>
### Finding 1 — BWA achieves a confident mapping rate of 88.9% on real 51 bp Illumina paired-end reads with 98.8% of confident mappings in consistent pairs, outperforming MAQ (86.1% confident, 98.7% paired) in fewer CPU hours (4.0 vs. 94.9).

> BWA 4.0 88.9 98.8 MAQ 94.9 86.1 98.7

*Why this is citable:* Provides a concrete, real-data benchmark comparing BWA to the prior standard (MAQ) on both accuracy and speed simultaneously, directly informing choices for large-scale resequencing projects.

*Counter / limitation:* The real-data evaluation uses a single individual (NA12750) and a single read length (51 bp); performance on different organisms, read lengths, or higher-diversity populations may differ substantially.

*Topics:* [Genome structure evolution](/knowledge/topics/genome_structure_evolution/)

<a id="finding-2"></a>
### Finding 2 — BWA requires approximately 2.3 GB of memory for single-end mapping, independent of the number of reads, whereas MAQ's memory footprint scales linearly with read count.

> Both Bowtie and BWA uses 2.3 GB for single-end mapping and about 3 GB for paired-end, larger than MAQ's memory footprint 1 GB. However, the memory usage of all the three BWT-based aligners is independent of the number of reads to be aligned, while MAQ's is linear in it.

*Why this is citable:* Establishes the scalability advantage of BWT-based indexing over hash-table approaches for population-scale resequencing, a critical practical consideration for large genomic studies.

*Counter / limitation:* Memory requirements depend on genome size; the 2.3 GB figure applies specifically to the ~3 Gb human genome, and may not generalize to larger or polyploid genomes where BWT index construction itself becomes a bottleneck.

*Topics:* [Genome structure evolution](/knowledge/topics/genome_structure_evolution/), [Karyotype database](/knowledge/topics/karyotype_database/)

<a id="finding-3"></a>
### Finding 3 — Using seeding (restricting allowed differences in the first 32 bp) makes BWA 2.5× faster for 70 bp reads while increasing alignment error rate only modestly from 0.08% to 0.11%.

> Given 70 bp simulated reads, alignment with maximum two differences in the 32 bp seed is 2.5× faster than without seeding. The alignment error rate, which is the fraction of wrong alignments out of confident mappings in simulation (see also Section 3.2 ), only increases from 0.08% to 0.11%.

*Why this is citable:* Quantifies the accuracy–speed trade-off of the seeding heuristic, which is a design decision directly relevant to any study using BWA and interpreting mapping quality or variant calls from the output.

*Counter / limitation:* The error rate increase from seeding is characterized only on simulated 70 bp reads with a specific error model (2% uniform base error, 0.09% SNP rate); performance under higher indel rates or with longer reads may show greater accuracy loss.

*Topics:* [Genome structure evolution](/knowledge/topics/genome_structure_evolution/)

<a id="finding-4"></a>
### Finding 4 — BWA is 6–18× faster than MAQ while achieving similar alignment accuracy for short reads mapped to the human genome.

> Between BWA and MAQ, BWA is 6–18× faster, depending on the read length. MAQ's speed is not affected by read length because internally it treats all reads as 128 bp.

*Why this is citable:* Quantifies the primary speed improvement of BWA over MAQ — the then-dominant short-read aligner — making it the most directly citable result for studies selecting or benchmarking short-read aligners against the human genome.

*Counter / limitation:* Benchmarks were run on a single core of one specific processor (2.5 GHz Xeon E5420) with simulated data; real-world speedups may differ with different hardware, read lengths, or genome complexity. Additionally, the abstract states 10–20× while the results section reports 6–18×, suggesting the range depends on the read-length range considered.

*Topics:* [Short Read Alignment](/knowledge/topics/short_read_alignment/), [Bioinformatics Methods](/knowledge/topics/bioinformatics_methods/), [Genome Resequencing](/knowledge/topics/genome_resequencing/)
