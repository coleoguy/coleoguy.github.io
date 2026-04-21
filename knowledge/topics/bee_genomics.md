---
layout: default
title: "Bee Genomics"
topic_slug: bee_genomics
last_updated: 2026-04-21T15:50:19.463662+00:00
papers_supporting: [10.1093/jhered/esad076]
permalink: /knowledge/topics/bee_genomics/
category: "Insects & comparative genomics"
---
# Bee Genomics

## Current understanding

High-quality reference genomes are increasingly available for bees, enabling comparative genomics, population genetics, and conservation-focused research across the order Hymenoptera. A recent addition to this growing genomic toolkit is a draft assembly for *Perdita meconis* (the Mojave poppy bee), a specialist oligolectic pollinator of conservation concern in the Andrenidae family. The assembly was generated from a single small male specimen using PacBio HiFi long-read sequencing — a notable technical achievement given the challenges of working with minute insects — yielding 327 Mb of sequence across 107 gapless contigs with a contig N50 of 17.5 Mb and 95.5% complete Hymenoptera BUSCOs. This represents a highly contiguous, near-complete gene space for a non-model bee lineage. See [Reference genome for the Mojave poppy bee (Perdita meconis), a specialist pollinator of conservation concern., Finding 1](/knowledge/papers/10_1093_jhered_esad076/#finding-1) for full assembly statistics.

## Supporting evidence

The *P. meconis* genome provides the first genomic reference for the largest bee genus in North America, opening avenues for studying host-plant specialization, population structure, and the evolutionary genomics of Andrenidae more broadly. The assembly's depth of coverage (~49×) and BUSCO completeness situate it among high-quality insect genomes, despite being contig-level rather than chromosome-scale. [Reference genome for the Mojave poppy bee (Perdita meconis), a specialist pollinator of conservation concern., Finding 1](/knowledge/papers/10_1093_jhered_esad076/#finding-1)

## Contradictions / open disagreements

The assembly lacks HiC scaffolding, meaning it does not reach chromosome-level contiguity. Dot-plot comparisons against *Andrena* and *Apis* genomes have revealed potential misassemblies, so downstream analyses relying on synteny or large-scale structural features should be treated with caution until a chromosome-anchored version is available. There is no direct contradiction with other published findings at this time, but the gap between contig-level and chromosome-level assemblies remains an important limitation to surface.

## Tealc's citation-neighborhood suggestions

- Chromosome-level genome assemblies for other Andrenidae or solitary bee genera would provide the scaffolding context needed to resolve synteny questions flagged by the *P. meconis* dot plots.
- Population genomics studies of oligolectic bees using reduced-representation or whole-genome resequencing would be natural consumers of this reference.
- BUSCO benchmarking papers and Hymenoptera-specific ortholog databases underpin the completeness assessment and should be cited alongside this assembly.

## Related on the Blackmon Lab site

- [Reference genome for the Mojave poppy bee (*Perdita meconis*)](/knowledge/papers/10_1093_jhered_esad076/)