---
layout: default
title: "Bioinformatics Tools"
topic_slug: bioinformatics_tools
last_updated: 2026-04-22T13:09:22.831193+00:00
papers_supporting: [10.1093/bioinformatics/bty191, 74e7bc680605ee2207a1f5cf31811de0fef84fed56357b0bbe6d6ba1443f9925]
permalink: /knowledge/topics/bioinformatics_tools/
category: "Bioinformatics & tools"
---
<!-- tealc:auto-start -->
# Bioinformatics Tools

## Current understanding

Bioinformatics tools in this literature fall into two broad categories: interactive web applications that aggregate multi-study data for a specific model organism, and high-performance alignment algorithms designed to handle the error profiles of long-read sequencing platforms. Both categories share a common design pressure — they must extract reliable signal from noisy, heterogeneous data faster than the alternatives.

**CaveCrawler** exemplifies the web-application category. It is a Shiny-based suite purpose-built for *Astyanax mexicanus* (the Mexican tetra) that pulls together transcriptomic data, population genetics statistics, Gene Ontology annotations, and genome architecture from multiple independent studies into a single interface. The integration of GO terms directly alongside population-level signals is what distinguishes it from a static data repository: users can generate functional hypotheses without running their own annotation pipelines. ([Perry et al. 2022, Finding 1](/knowledge/papers/10_1093_g3journal_jkac132/#finding-1))

**Minimap2** represents the algorithm-first category. For spliced alignment of long, noisy Oxford Nanopore (ONT) reads, it achieves 94.0% exact intron accuracy on a real mouse cDNA dataset, against 83.8% for GMAP and 87.9% for SpAln — and does so more than 40 times faster than either competitor. ([10.1093/bioinformatics/bty191, Finding 1](/knowledge/papers/10_1093_bioinformatics_bty191/#finding-1)) That accuracy advantage is not primarily driven by the downstream base-level dynamic programming step. The chaining algorithm alone outperforms all other long-read mappers tested before any base-level alignment is applied, which matters for anyone evaluating the tool's design or extending it to new sequencing contexts. ([10.1093/bioinformatics/bty191, Finding 2](/knowledge/papers/10_1093_bioinformatics_bty191/#finding-2))

## Supporting evidence

- **CaveCrawler as a multi-omics integration platform:** Combines population genetics and transcriptomic data from multiple Mexican tetra populations with GO term information to enable biological inferences from cross-study patterns that no single dataset could support alone. ([Perry et al. 2022, Finding 1](/knowledge/papers/10_1093_g3journal_jkac132/#finding-1))

- **Minimap2 spliced-alignment accuracy and speed:** 94.0% exact intron accuracy on real ONT mouse cDNA reads vs. 83.8% (GMAP) and 87.9% (SpAln), with a >40× runtime advantage. ([10.1093/bioinformatics/bty191, Finding 1](/knowledge/papers/10_1093_bioinformatics_bty191/#finding-1))

- **Minimap2 chaining as the primary accuracy driver:** The chaining step alone is more accurate than all other long-read mappers tested, reducing the number of candidate chains that must proceed to the slower base-level alignment stage. ([10.1093/bioinformatics/bty191, Finding 2](/knowledge/papers/10_1093_bioinformatics_bty191/#finding-2))

## Contradictions / open disagreements

The minimap2 spliced-alignment benchmark has two structural limitations worth flagging. First, the comparison used a single mouse cDNA dataset sequenced with R9.4 ONT chemistry; GMAP and SpAln were not tuned for noisy reads, so their performance under optimized parameters could be meaningfully higher. Second, the chaining-accuracy claim is supported by unpublished supplementary data ("data not shown"), and the genomic benchmarks rely on simulated human reads — neither condition transfers cleanly to repeat-rich, non-human, or highly divergent genomes. The >40× speed advantage and the absolute accuracy numbers should therefore be treated as chemistry- and organism-specific baselines rather than universal rankings.

No contradictions are currently known between CaveCrawler and the minimap2 findings; they address different problems and different data types.

## Tealc's citation-neighborhood suggestions

- Benchmarking studies covering newer ONT chemistry (R10.4+) or PacBio HiFi reads would update the minimap2 accuracy comparisons with tools that *were* optimized for long noisy reads (e.g., STAR with long-read mode, LR-Kallisto).
- General reviews of Shiny-based biological databases could contextualize CaveCrawler within the broader landscape of interactive genomics portals.
- Papers describing analogous model-organism portals (WormBase, FlyBase, Xenbase) would provide useful comparative framing for evaluating CaveCrawler's design choices.

## Related on the Blackmon Lab site

- [Perry et al. 2022](/knowledge/papers/10_1093_g3journal_jkac132/)
- [Li 2018 — minimap2](/knowledge/papers/10_1093_bioinformatics_bty191/)
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
<!-- tealc:related-end -->
