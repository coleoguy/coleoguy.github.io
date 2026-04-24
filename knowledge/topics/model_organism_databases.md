---
layout: default
title: "Model Organism Databases"
topic_slug: model_organism_databases
last_updated: 2026-04-21T18:53:41.411936+00:00
papers_supporting: [74e7bc680605ee2207a1f5cf31811de0fef84fed56357b0bbe6d6ba1443f9925]
permalink: /knowledge/topics/model_organism_databases/
category: "Bioinformatics & tools"
---
<!-- tealc:lead-start -->
<div class="wiki-lead" data-active="researcher">
<div data-register="researcher" markdown="1">

Model organism databases serve as community resources that aggregate multi-study datasets — transcriptomics, population genetics, functional annotation, and genome architecture — into a unified, searchable interface. By centralizing data across experiments, these databases enable cross-study comparisons that individual analyses cannot support, and they lower the barrier for researchers who lack specialized bioinformatics expertise.

A recent example of this approach is CaveCrawler, a Shiny-based web analysis suite built around *Astyanax mexicanus* (the Mexican tetra), a leading model for studying the evolution of cave-associated traits. CaveCrawler integrates transcriptomic and population genetic data from multiple cavefish and surface-fish populations, enriches them with Gene Ontology (GO) term information, and includes genome architecture data — all accessible through an interactive browser interface. The tool was explicitly designed to support "unique biological inferences from cross-study patterns," recognizing that individual datasets are most powerful when interpreted in a shared analytical context. [Perry et al. 2022, Finding 1](/knowledge/papers/10_1093_g3journal_jkac132/#finding-1)

This architecture — a lightweight, interactive front-end (Shiny) wrapping curated multi-source data — reflects a broader trend in model organism informatics: prioritizing accessibility and biological interpretability over raw data volume.

</div>
<div data-register="student" markdown="1">

<!-- tealc:lead-start -->
<div class="wiki-lead" data-active="student">
<div data-register="student" markdown="1">

Model organism databases are shared online tools that collect data from many different studies — things like gene expression patterns, genetic variation, and chromosome structure — and put them all in one place where scientists can search and compare them. By bringing together information from different experiments, these databases let researchers spot patterns that no single study could find on its own, and they make it easier for scientists who don't have advanced computer skills to do complex analyses.

A real example is CaveCrawler, a web-based analysis tool built around *Astyanax mexicanus* (the Mexican tetra fish), which scientists use to study how cave fish have evolved differently from their relatives that live in surface streams. CaveCrawler combines gene expression data and genetic variation data from multiple cave populations and surface populations, adds information about what genes do (using Gene Ontology, or GO, a standard labeling system), and includes data about how genes are arranged on chromosomes — all viewable through an interactive website. The creators of CaveCrawler designed it specifically to help scientists "make unique biological discoveries by finding patterns across different studies," understanding that separate datasets become much more powerful when researchers can look at them side by side. [Perry et al. 2022, Finding 1](/knowledge/papers/10_1093_g3journal_jkac132/#finding-1)

This design — a simple, interactive website (built using Shiny software) connected to carefully organized data from multiple sources — shows a bigger shift in how scientists organize information about model organisms: making tools easy to use and scientifically clear rather than trying to include as much raw data as possible.

</div>
</div>
<!-- tealc:lead-end -->

</div>
</div>
<!-- tealc:lead-end -->

<!-- tealc:auto-start -->
# Model Organism Databases

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

Model organism databases serve as community resources that aggregate multi-study datasets — transcriptomics, population genetics, functional annotation, and genome architecture — into a unified, searchable interface. By centralizing data across experiments, these databases enable cross-study comparisons that individual analyses cannot support, and they lower the barrier for researchers who lack specialized bioinformatics expertise.

A recent example of this approach is CaveCrawler, a Shiny-based web analysis suite built around *Astyanax mexicanus* (the Mexican tetra), a leading model for studying the evolution of cave-associated traits. CaveCrawler integrates transcriptomic and population genetic data from multiple cavefish and surface-fish populations, enriches them with Gene Ontology (GO) term information, and includes genome architecture data — all accessible through an interactive browser interface. The tool was explicitly designed to support "unique biological inferences from cross-study patterns," recognizing that individual datasets are most powerful when interpreted in a shared analytical context. [Perry et al. 2022, Finding 1](/knowledge/papers/10_1093_g3journal_jkac132/#finding-1)

This architecture — a lightweight, interactive front-end (Shiny) wrapping curated multi-source data — reflects a broader trend in model organism informatics: prioritizing accessibility and biological interpretability over raw data volume.

## Supporting evidence

- **CaveCrawler (*A. mexicanus*)** — Integrates population genetics, transcriptomics, GO annotations, and genome architecture data across multiple Mexican tetra populations in a Shiny web application. [Perry et al. 2022, Finding 1](/knowledge/papers/10_1093_g3journal_jkac132/#finding-1)

## Contradictions / open disagreements

None known from current findings. However, a significant open question is **sustainability**: model organism databases depend on active curation and community data deposition. If a database is not continuously updated, its value as a citable and reliable resource erodes. CaveCrawler's long-term utility will hinge on whether the *A. mexicanus* community continues to contribute new datasets to the platform.

Additionally, CaveCrawler is species-specific; whether its design principles generalize to other non-traditional model organisms with smaller research communities remains untested.

## Tealc's citation-neighborhood suggestions

- FlyBase, WormBase, and ZFIN represent mature model organism databases with established data standards; comparing their curation models to emerging tools like CaveCrawler could yield design insights.
- Literature on FAIR data principles (Findable, Accessible, Interoperable, Reusable) in biodiversity informatics would be relevant for evaluating the long-term sustainability of species-specific databases.

## Related on the Blackmon Lab site

- [Perry et al. 2022](/knowledge/papers/10_1093_g3journal_jkac132/)
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
<!-- tealc:related-end -->
