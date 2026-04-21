---
layout: default
title: "Genome Assembly"
topic_slug: genome_assembly
last_updated: 2026-04-21T15:36:14.431277+00:00
papers_supporting: [10.1002/ece3.73483]
permalink: /knowledge/topics/genome_assembly/
---
# Genome Assembly

## Current understanding

Chromosome-level genome assemblies increasingly serve as tools not only for gene annotation but also for inferring karyotype structure and sex chromosome composition directly from sequencing data. When Hi-C proximity-ligation scaffolding is applied, the resulting contact maps can recover major chromosomal units whose number and relative sizes can be compared against cytogenetic expectations. This approach is particularly powerful in beetle (Coleoptera) genomics, where a well-characterized modal karyotype — 2n=20 (9AA+XY) — provides an independent benchmark against which assembly quality can be evaluated.

## Supporting evidence

A chromosome-level assembly of the endangered long-armed scarab *Cheirotonus formosanus* illustrates this principle clearly. After Hi-C scaffolding and contact-map correction, the assembly resolved 10 primary large scaffolds corresponding to 9 autosomes and an X chromosome — a configuration precisely consistent with the modal beetle karyotype. As the authors note, "The final corrected contact map displayed 10 primary large scaffolds, including 9 autosomes and X chromosomes. This genetic architecture is highly consistent with known cytogenetic data for the group. The majority of Coleoptera possess a diploid number of 2n = 20 (9AA + XY)." This outcome supports the broader principle that Hi-C-based assemblies can faithfully reflect underlying karyotype structure, and provides a genomic anchor for comparative studies of karyotype conservatism within Scarabaeidae and its subfamily Euchirinae. See [Chromosome-Level Reference Genome of an Endemic, Endangered Long-Armed Scarab (<i>Cheirotonus formosanus</i>): Discovery of a Putative Y-Linked Scaffold and Demographic History., Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1) for details.

## Contradictions / open disagreements

The karyotype inference for *C. formosanus* rests on scaffold number and Hi-C contact patterns rather than direct cytogenetic counts from this species. No new cytogenetic data were generated; the 2n=20 assignment is supported by consistency with related taxa rather than direct evidence from the focal species. Future cytogenetic work on *C. formosanus* itself would fully resolve this ambiguity.

## Tealc's citation-neighborhood suggestions

Studies benchmarking Hi-C scaffolding accuracy against independently verified karyotypes across multiple Coleoptera families would help establish how reliably contact-map scaffold counts reflect true chromosome number in beetles with variable karyotypes.

## Related on the Blackmon Lab site

- [Chromosome-Level Reference Genome of *Cheirotonus formosanus*](/knowledge/papers/10_1002_ece3_73483/)