---
layout: default
title: "Population Genetics"
topic_slug: population_genetics
last_updated: 2026-04-21T18:54:01.797045+00:00
papers_supporting: [74e7bc680605ee2207a1f5cf31811de0fef84fed56357b0bbe6d6ba1443f9925]
permalink: /knowledge/topics/population_genetics/
category: "Population genetics"
editor_frozen: true
---
<!-- tealc:lead-start -->
<div class="wiki-lead" data-active="researcher">
<div data-register="researcher" markdown="1">

Population genetics is concerned with how allele frequencies vary within and between populations, and with identifying the evolutionary forces — selection, drift, gene flow, and mutation — that drive those changes. A central tool in this work is FST, a measure of genetic differentiation between populations. High or low FST outliers are used to flag loci potentially under divergent or balancing selection. Complementary approaches, such as differential gene expression analyses (summarized by log-fold change, logFC), provide functional context for candidate loci. Integrating these two data streams — population-level divergence and transcriptomic response — is a powerful but logistically demanding task, particularly in emerging model systems where data are scattered across independent studies.

A concrete illustration of this challenge comes from work on the Mexican cavefish *Astyanax mexicanus*, a system used to study the genetic basis of cave-adapted traits. Despite a substantial body of published genomic work, the overlap between independently computed datasets is strikingly small: of 1,140 genes with published FST values, only 83 had both FST and logFC measurements available from prior studies [Perry et al. 2022, Finding 1](/knowledge/papers/10_1093_g3journal_jkac132/#finding-1). This fragmentation underscores a recurring problem in population genetics — that analytical results exist in silos, making cross-study synthesis difficult without dedicated aggregation infrastructure.

This data-integration bottleneck motivates the development of tools like CaveCrawler, which aim to bring disparate population genomic and transcriptomic datasets into a common searchable framework, enabling researchers to ask compound questions (e.g., "Is this FST outlier also differentially expressed?") that no single dataset could answer alone.

</div>
<div data-register="student" markdown="1">

<!-- tealc:lead-start -->
<div class="wiki-lead" data-active="student">
<div data-register="student" markdown="1">

Population genetics studies how the frequency of genetic variants (alleles) changes within groups of organisms and between different populations. Scientists use several tools to understand what drives these changes—including natural selection, random genetic drift, gene flow between populations, and mutation. One widely used measurement is FST, which tells us how genetically different two populations are from each other. When FST values are unusually high or low at certain genes, it can signal that those genes are under selection.

Scientists also measure how genes are turned on or off in different conditions using gene expression analysis, which produces numbers called log-fold changes (logFC). Combining FST data (showing which genes differ between populations) with expression data (showing which genes are active) is powerful but difficult—especially when studying newly popular model organisms where data are scattered across many separate studies.

A striking example comes from research on the Mexican cavefish *Astyanax mexicanus*, used to study how fish adapt to caves. Even though scientists have published a lot of genomic work on this species, the overlap between different studies is surprisingly small: of 1,140 genes with published FST values, only 83 had both FST and logFC measurements available from prior studies [Perry et al. 2022, Finding 1](/knowledge/papers/10_1093_g3journal_jkac132/#finding-1). This fragmentation shows a real problem in population genetics—research results sit in separate places, making it hard to combine them without special tools.

This challenge has motivated the creation of tools like CaveCrawler, designed to bring together different population genomic and gene-expression datasets into one searchable system, letting researchers answer complex questions (such as "Is this FST outlier also turned on or off differently?") that single datasets alone cannot.

</div>
</div>
<!-- tealc:lead-end -->

</div>
</div>
<!-- tealc:lead-end -->

<!-- tealc:auto-start -->
# Population Genetics

<!-- tealc:freshness-start -->
<aside class="wiki-freshness" aria-label="Page provenance">
<span class="wf-label">Composed by Tealc</span>
<span class="wf-date">2026-04-21</span>
<span class="wf-dot">·</span>
<span class="wf-sources">1 source</span>
<span class="wf-dot">·</span>
<span class="wf-review">Last reviewed by Heath: never</span>
</aside>
<!-- tealc:freshness-end -->


## Current understanding

Population genetics is concerned with how allele frequencies vary within and between populations, and with identifying the evolutionary forces — selection, drift, gene flow, and mutation — that drive those changes. A central tool in this work is FST, a measure of genetic differentiation between populations. High or low FST outliers are used to flag loci potentially under divergent or balancing selection. Complementary approaches, such as differential gene expression analyses (summarized by log-fold change, logFC), provide functional context for candidate loci. Integrating these two data streams — population-level divergence and transcriptomic response — is a powerful but logistically demanding task, particularly in emerging model systems where data are scattered across independent studies.

A concrete illustration of this challenge comes from work on the Mexican cavefish *Astyanax mexicanus*, a system used to study the genetic basis of cave-adapted traits. Despite a substantial body of published genomic work, the overlap between independently computed datasets is strikingly small: of 1,140 genes with published FST values, only 83 had both FST and logFC measurements available from prior studies [Perry et al. 2022, Finding 1](/knowledge/papers/10_1093_g3journal_jkac132/#finding-1). This fragmentation underscores a recurring problem in population genetics — that analytical results exist in silos, making cross-study synthesis difficult without dedicated aggregation infrastructure.

This data-integration bottleneck motivates the development of tools like CaveCrawler, which aim to bring disparate population genomic and transcriptomic datasets into a common searchable framework, enabling researchers to ask compound questions (e.g., "Is this FST outlier also differentially expressed?") that no single dataset could answer alone.

## Supporting evidence

- [Perry et al. 2022, Finding 1](/knowledge/papers/10_1093_g3journal_jkac132/#finding-1) — Of 1,140 genes with published FST values in *A. mexicanus*, only 83 had both FST outlier status and logFC measurements available from prior studies, quantifying the fragmented nature of population genomic data in this system.

## Tealc's citation-neighborhood suggestions

- Studies benchmarking FST-based outlier detection methods (e.g., BayeScan, OutFLANK) would strengthen the methodological context for interpreting FST outlier thresholds.
- Transcriptome-wide eQTL mapping papers in *A. mexicanus* could reveal how much of the FST–logFC disconnect reflects genuine biological independence versus sampling artifacts.
- Reviews on the integration of population genomics and transcriptomics in non-model organisms would provide broader context for the data-fragmentation problem illustrated here.

## Related on the Blackmon Lab site

- [Perry et al. 2022](/knowledge/papers/10_1093_g3journal_jkac132/) — source of the primary finding on this page.
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
<!-- tealc:related-end -->
