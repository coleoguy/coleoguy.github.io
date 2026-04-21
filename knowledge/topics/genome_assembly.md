---
layout: default
title: "Genome Assembly"
topic_slug: genome_assembly
last_updated: 2026-04-21T15:55:43.901460+00:00
papers_supporting: [10.1002/ece3.73483]
permalink: /knowledge/topics/genome_assembly/
category: "Genome structure"
---
# Genome Assembly

## Current understanding

Chromosome-level genome assemblies — those in which sequencing contigs are scaffolded into chromosome-scale sequences — have become an essential tool for connecting raw sequence data to cytogenetic and evolutionary inference. A high-quality assembly allows researchers to count chromosomes, identify sex-linked scaffolds, and compare genome architecture across taxa without relying solely on traditional karyotyping. The quality of such assemblies is validated by cross-referencing the number and size of major scaffolds against established cytogenetic data for the focal species or its close relatives.

## Supporting evidence

A recent chromosome-level assembly of the endemic and endangered long-armed scarab beetle *Cheirotonus formosanus* illustrates these principles in practice. Using Hi-C contact mapping, the assembly was scaffolded into 10 primary large scaffolds — 9 autosomes plus an X chromosome — a configuration directly consistent with the modal beetle karyotype of 2n = 20 (9AA + XY) documented across the majority of Coleoptera and with cytogenetic knowledge of the subfamily Euchirinae. As the authors note, "The final corrected contact map displayed 10 primary large scaffolds, including 9 autosomes and X chromosomes. This genetic architecture is highly consistent with known cytogenetic data for the group. The majority of Coleoptera possess a diploid number of 2n = 20 (9AA + XY)." This result demonstrates that modern long-read sequencing combined with Hi-C scaffolding can recover biologically interpretable chromosome-level structure in non-model organisms, and that assembly scaffold counts can serve as an independent line of evidence for karyotype inference (see [Chromosome-Level Reference Genome of an Endemic, Endangered Long-Armed Scarab (*Cheirotonus formosanus*): Discovery of a Putative Y-Linked Scaffold and Demographic History., Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1)).

## Contradictions / open disagreements

One important caveat in using assembly-based scaffold counts as a proxy for karyotype is that the chromosome number assignment in the *C. formosanus* assembly is inferred indirectly from Hi-C contact patterns and consistency with relatives rather than from direct cytogenetic counts on the focal species itself. No new cytogenetic data for *C. formosanus* were presented in the source paper. If direct chromosome counts were to differ from the inferred 2n = 20, the scaffold-to-chromosome correspondence would need to be revisited. This highlights a broader methodological tension in the field: assembly-based karyotyping is powerful but requires validation against direct cytogenetic evidence where possible.

## Tealc's citation-neighborhood suggestions

Future pages on this topic might benefit from citing comparative studies that formally benchmark Hi-C-based chromosome assignment against flow cytometry or squash preparations, as well as broader surveys of chromosome-level Coleoptera assemblies that would contextualize the *C. formosanus* result within a larger phylogenetic framework.

## Related on the Blackmon Lab site

- [Paper detail page: Chromosome-Level Reference Genome of *Cheirotonus formosanus*](/knowledge/papers/10_1002_ece3_73483/)