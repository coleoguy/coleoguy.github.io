---
layout: default
title: "Population Genetics"
topic_slug: population_genetics
last_updated: 2026-04-21T18:54:01.797045+00:00
papers_supporting: [74e7bc680605ee2207a1f5cf31811de0fef84fed56357b0bbe6d6ba1443f9925]
permalink: /knowledge/topics/population_genetics/
category: "Population genetics"
---
<!-- tealc:auto-start -->
# Population Genetics

## Current understanding

Population genetics is concerned with how allele frequencies vary within and between populations, and with identifying the evolutionary forces — selection, drift, gene flow, and mutation — that drive those changes. A central tool in this work is FST, a measure of genetic differentiation between populations. High or low FST outliers are used to flag loci potentially under divergent or balancing selection. Complementary approaches, such as differential gene expression analyses (summarized by log-fold change, logFC), provide functional context for candidate loci. Integrating these two data streams — population-level divergence and transcriptomic response — is a powerful but logistically demanding task, particularly in emerging model systems where data are scattered across independent studies.

A concrete illustration of this challenge comes from work on the Mexican cavefish *Astyanax mexicanus*, a system used to study the genetic basis of cave-adapted traits. Despite a substantial body of published genomic work, the overlap between independently computed datasets is strikingly small: of 1,140 genes with published FST values, only 83 had both FST and logFC measurements available from prior studies [Perry et al. 2022, Finding 1](/knowledge/papers/2022_cave_crawler/#finding-1). This fragmentation underscores a recurring problem in population genetics — that analytical results exist in silos, making cross-study synthesis difficult without dedicated aggregation infrastructure.

This data-integration bottleneck motivates the development of tools like CaveCrawler, which aim to bring disparate population genomic and transcriptomic datasets into a common queryable framework, enabling researchers to ask compound questions (e.g., "Is this FST outlier also differentially expressed?") that no single dataset could answer alone.

## Supporting evidence

- [Perry et al. 2022, Finding 1](/knowledge/papers/2022_cave_crawler/#finding-1) — Of 1,140 genes with published FST values in *A. mexicanus*, only 83 had both FST outlier status and logFC measurements available from prior studies, quantifying the fragmented nature of population genomic data in this system.

## Contradictions / open disagreements

None known from current findings. The count of 83 overlapping genes is a snapshot tied to the studies included at the time of publication; as more data are deposited and integrated, this figure will change, but no contradicting claim about the degree of overlap has been identified in the supplied findings.

## Tealc's citation-neighborhood suggestions

- Studies benchmarking FST-based outlier detection methods (e.g., BayeScan, OutFLANK) would strengthen the methodological context for interpreting FST outlier thresholds.
- Transcriptome-wide eQTL mapping papers in *A. mexicanus* could reveal how much of the FST–logFC disconnect reflects genuine biological independence versus sampling artifacts.
- Reviews on the integration of population genomics and transcriptomics in non-model organisms would provide broader context for the data-fragmentation problem illustrated here.

## Related on the Blackmon Lab site

- [Perry et al. 2022](/knowledge/papers/2022_cave_crawler/) — source of the primary finding on this page.
<!-- tealc:auto-end -->
