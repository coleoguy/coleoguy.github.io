---
layout: default
title: "Model Organism Databases"
topic_slug: model_organism_databases
last_updated: 2026-04-21T18:53:41.411936+00:00
papers_supporting: [74e7bc680605ee2207a1f5cf31811de0fef84fed56357b0bbe6d6ba1443f9925]
permalink: /knowledge/topics/model_organism_databases/
category: "Bioinformatics & tools"
---
<!-- tealc:auto-start -->
# Model Organism Databases

## Current understanding

Model organism databases serve as community resources that aggregate multi-study datasets — transcriptomics, population genetics, functional annotation, and genome architecture — into a unified, queryable interface. By centralizing data across experiments, these databases enable cross-study comparisons that individual analyses cannot support, and they lower the barrier for researchers who lack specialized bioinformatics expertise.

A recent example of this approach is CaveCrawler, a Shiny-based web analysis suite built around *Astyanax mexicanus* (the Mexican tetra), a leading model for studying the evolution of cave-associated traits. CaveCrawler integrates transcriptomic and population genetic data from multiple cavefish and surface-fish populations, enriches them with Gene Ontology (GO) term information, and includes genome architecture data — all accessible through an interactive browser interface. The tool was explicitly designed to support "unique biological inferences from cross-study patterns," recognizing that individual datasets are most powerful when interpreted in a shared analytical context. [Perry et al. 2022, Finding 1](/knowledge/papers/2022_cave_crawler/#finding-1)

This architecture — a lightweight, interactive front-end (Shiny) wrapping curated multi-source data — reflects a broader trend in model organism informatics: prioritizing accessibility and biological interpretability over raw data volume.

## Supporting evidence

- **CaveCrawler (*A. mexicanus*)** — Integrates population genetics, transcriptomics, GO annotations, and genome architecture data across multiple Mexican tetra populations in a Shiny web application. [Perry et al. 2022, Finding 1](/knowledge/papers/2022_cave_crawler/#finding-1)

## Contradictions / open disagreements

None known from current findings. However, a significant open question is **sustainability**: model organism databases depend on active curation and community data deposition. If a database is not continuously updated, its value as a citable and reliable resource erodes. CaveCrawler's long-term utility will hinge on whether the *A. mexicanus* community continues to contribute new datasets to the platform.

Additionally, CaveCrawler is species-specific; whether its design principles generalize to other non-traditional model organisms with smaller research communities remains untested.

## Tealc's citation-neighborhood suggestions

- FlyBase, WormBase, and ZFIN represent mature model organism databases with established data standards; comparing their curation models to emerging tools like CaveCrawler could yield design insights.
- Literature on FAIR data principles (Findable, Accessible, Interoperable, Reusable) in biodiversity informatics would be relevant for evaluating the long-term sustainability of species-specific databases.

## Related on the Blackmon Lab site

- [Perry et al. 2022](/knowledge/papers/2022_cave_crawler/)
<!-- tealc:auto-end -->
