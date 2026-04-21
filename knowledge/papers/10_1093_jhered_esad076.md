---
layout: default
title: "Reference genome for the Mojave poppy bee (Perdita meconis), a specialist pollinator of conservation concern."
doi: 10.1093/jhered/esad076
fingerprint_sha256: 91daa4cf9551778bc0561c38208ea57529131687ca5cb7a013f6e1eaa13490bd
authors: "Schweizer RM, Meidt CG, Benavides LR, Wilson JS, Griswold TL, Sim SB, Geib SM, Branstetter MG"
journal: ""
year: 2024
topics: [bee_genomics, bee_phylogenomics, conservation_genomics, genome_structure_evolution, sequencing_methods, transposable_elements, uce_phylogenetics]
tier: canon
ingested_at: 2026-04-21T15:32:57.285271+00:00
permalink: /knowledge/papers/10_1093_jhered_esad076/
---

# Reference genome for the Mojave poppy bee (Perdita meconis), a specialist pollinator of conservation concern.

## Summary

_Ingested 2026-04-21. 4 findings extracted and verified._

## Findings worth citing

<a id="finding-1"></a>
### Finding 1 — The Perdita meconis draft genome assembly is 327 Mb with a contig N50 of 17.5 Mb and 95.5% complete Hymenoptera BUSCOs, produced from a single small male specimen using PacBio HiFi.

> The initial genome assembly is 327,936,261 bp, with an average depth of coverage of 49.2× as estimated by GenomeScope2 k-mer analysis ( Table 1 ; Fig. 2A ). The initial assembly consists of 107 gapless contigs, with a contig N50 length of 17.5 Mb, and an N90 length of 3.03 Mb

*Why this is citable:* Provides the core genome resource statistics that downstream comparative genomics, population genetics, and conservation studies of Andrenidae/Perdita will cite as the reference assembly.

*Counter / limitation:* The assembly is contig-level without HiC scaffolding, so it is not a true chromosome-level reference and may contain misassemblies as indicated by the dot plots against Andrena and Apis.

*Topics:* [bee_genomics](/knowledge/topics/bee_genomics/), [conservation_genomics](/knowledge/topics/conservation_genomics/)

<a id="finding-2"></a>
### Finding 2 — Repetitive elements comprise 37.3% of the Perdita meconis genome, with 24.87% being unclassified repeats and smaller contributions from retroelements (6.07%) and DNA transposons (4.38%).

> RepeatModeler identified repeats and subsequently masked 37.3% of the iyPerMec1 genome ( Table 2 ). Categories of interspersed repeats included retroelements (6.07%), DNA transposons (4.38%), rolling circles (0.24%), and a large proportion (24.87%) of unclassified repeats.

*Why this is citable:* Quantifies repeat content in a non-model bee, contributing a data point for comparative analyses of TE dynamics across Hymenoptera and highlighting the annotation gap for non-Drosophila insects.

*Counter / limitation:* The high fraction of unclassified repeats (nearly two-thirds of repeat content) indicates the annotation is limited by available repeat libraries, so specific TE family abundances are unreliable.

*Topics:* [genome_structure_evolution](/knowledge/topics/genome_structure_evolution/), [transposable_elements](/knowledge/topics/transposable_elements/)

<a id="finding-3"></a>
### Finding 3 — A high-quality HiFi reference genome can be generated from a single sub-7 mm insect specimen that was freeze-killed at −20 °C rather than snap-frozen, demonstrating feasibility of genome assembly from suboptimally preserved field samples.

> The high quality of this genome is especially impressive given both the very small size of the organism and the fact that the specimen was not preserved under ideal circumstances (i.e. not snap frozen, stored at −20 °C rather than −80 °C).

*Why this is citable:* Supports methodological claims in conservation and biodiversity genomics that PacBio HiFi enables reference assemblies from tiny, non-ideally preserved specimens, relevant for rare or museum-archived taxa.

*Counter / limitation:* A single anecdotal success does not establish general reliability; the study still failed to obtain HiC-compatible samples, and outcomes likely depend on species, body size, and exact storage duration.

*Topics:* [conservation_genomics](/knowledge/topics/conservation_genomics/), [sequencing_methods](/knowledge/topics/sequencing_methods/)

<a id="finding-4"></a>
### Finding 4 — UCE-based phylogenomic analysis of 119 Apoidea genomes resolves Perdita meconis as sister to Andrena within Andrenidae, with most nodes receiving 100% ultrafast bootstrap support.

> Perdita meconis is resolved as the sister group to Andrena (family Andrenidae, subfamily Andreninae).

*Why this is citable:* Provides a phylogenomic placement useful for comparative genomics of bees and contributes the first Panurginae genome to Apoidea phylogenetic datasets.

*Counter / limitation:* Taxon sampling is heavily biased toward social bees in Apidae and Halictidae, Stenotritidae is entirely absent, and only one Andrenidae genus (Andrena) is represented alongside Perdita, so the sister-group relationship and Andrenidae internal topology remain incompletely tested with available genome data.

*Topics:* [bee_phylogenomics](/knowledge/topics/bee_phylogenomics/), [uce_phylogenetics](/knowledge/topics/uce_phylogenetics/)

<!-- tealc:related-start -->
## Read the paper

[doi.org/10.1093/jhered/esad076](https://doi.org/10.1093/jhered/esad076)
<!-- tealc:related-end -->
