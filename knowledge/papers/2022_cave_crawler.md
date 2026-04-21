---
layout: default
title: "CaveCrawler: an interactive analysis suite for cavefish bioinformatics"
doi: "10.1093/g3journal/jkac132"
fingerprint_sha256: 74e7bc680605ee2207a1f5cf31811de0fef84fed56357b0bbe6d6ba1443f9925
authors: "Annabel Perry, Suzanne E McGaugh, Alex C Keene, Heath Blackmon"
journal: "G3 Genes|Genomes|Genetics"
year: 2022
topics: [bioinformatics_tools, cavefish_genomics, circadian_rhythm_evolution, convergent_evolution, model_organism_databases, population_genetics]
tier: canon
ingested_at: 2026-04-21T18:52:38.991252+00:00
permalink: /knowledge/papers/2022_cave_crawler/
---

# CaveCrawler: an interactive analysis suite for cavefish bioinformatics

## Summary

_Ingested 2026-04-21. 3 findings extracted and verified._

## Findings worth citing

<a id="finding-1"></a>
### Finding 1 — CaveCrawler is a Shiny-based web analysis suite that integrates transcriptomic, population genetics, GO, and genome architecture data for Astyanax mexicanus across multiple studies.

> Here, we generated a Shiny database, CaveCrawler, which combines population genet- ics and transcriptomic data from multiple Mexican tetra popula- tions and leverages Gene Ontology (GO) term information to enable unique biological inferences from cross-study patterns.
— p. 1

*Why this is citable:* This is the paper's central contribution — establishing a community resource tool for cavefish genomics. Downstream papers would cite this to reference the database itself or as an example of Shiny-based model organism databases.

*Counter / limitation:* The tool's utility depends on ongoing curation and data submission; if the repository is not maintained or updated, its value as a citable resource diminishes. Also, it is specific to A. mexicanus and not a general-purpose tool.

*Topics:* [cavefish_genomics](/knowledge/topics/cavefish_genomics/), [bioinformatics_tools](/knowledge/topics/bioinformatics_tools/), [model_organism_databases](/knowledge/topics/model_organism_databases/)

<a id="finding-2"></a>
### Finding 2 — Of 1,140 genes with published FST values, only 83 had both FST and logFC measurements available from prior studies on A. mexicanus.

> Of the genes for which both F ST and logFC had been calculated by previous studies, there were 83 for which FST outlier status had been determined by a previous study which defined FST outliers as genes whose FST values were in the lowest 5% of di- vergence
— p. 4

*Why this is citable:* This quantifies the degree of overlap across existing cavefish datasets and illustrates the fragmented nature of genomic data for emerging model systems, motivating integrative tools like CaveCrawler.

*Counter / limitation:* The count reflects the specific studies included at the time of publication and will change as more data are added; it is a snapshot, not a stable property of A. mexicanus genomics.

*Topics:* [cavefish_genomics](/knowledge/topics/cavefish_genomics/), [population_genetics](/knowledge/topics/population_genetics/)

<a id="finding-3"></a>
### Finding 3 — The gene arpin, a negative regulator of actin, was identified as both an FST outlier and differentially expressed in circadian regulation across all three Pachón, Molino, and Tinaja versus Río Choy surface fish comparisons.

> We found one gene, arpin, which was a double outlier in all 3 cave-R /C19ıo Choy pairings ( Table 2 and Fig. 2), one, cyp26a1, which was a double outlier for both Pacho ´ n-R/C19ıo Choy and for Tinaja-R/C19ıo Choy
— p. 4

*Why this is citable:* This finding demonstrates CaveCrawler's proof-of-principle empirical utility: by cross-referencing FST outlier status and circadian transcription data across three independent cave population comparisons, the tool identified arpin as a convergent candidate gene. Papers studying actin regulation, circadian evolution in cavefish, or convergent molecular evolution could cite this as a bioinformatically-derived candidate requiring functional follow-up.

*Counter / limitation:* The finding relies on a circadian transcription dataset (Mack et al. 2021) and FST outliers defined at the lowest 5% divergence threshold (Herman et al. 2018); changing either dataset or threshold could alter which genes qualify as double outliers. No functional validation of arpin's role in cavefish circadian or actin phenotypes is provided, so the biological inference remains correlative.

*Topics:* [cavefish_genomics](/knowledge/topics/cavefish_genomics/), [circadian_rhythm_evolution](/knowledge/topics/circadian_rhythm_evolution/), [convergent_evolution](/knowledge/topics/convergent_evolution/)

<!-- tealc:related-start -->
## Read the paper

[doi.org/10.1093/g3journal/jkac132](https://doi.org/10.1093/g3journal/jkac132)

## Other papers by these authors

- [Blackmon H](/knowledge/authors/blackmon_h/)
<!-- tealc:related-end -->
