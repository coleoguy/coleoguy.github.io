---
layout: default
title: "Cavefish Genomics"
topic_slug: cavefish_genomics
last_updated: 2026-04-21T18:53:08.695101+00:00
papers_supporting: [74e7bc680605ee2207a1f5cf31811de0fef84fed56357b0bbe6d6ba1443f9925]
permalink: /knowledge/topics/cavefish_genomics/
category: "Bioinformatics & tools"
---
<!-- tealc:auto-start -->
# Cavefish Genomics

## Current understanding

*Astyanax mexicanus* — the Mexican tetra — has become a leading model for studying convergent evolution, regressive trait loss, and the genomic basis of cave adaptation. Multiple independent cave populations (Pachón, Molino, Tinaja) evolved from surface-dwelling ancestors, allowing researchers to ask whether similar phenotypes arose through similar molecular mechanisms. However, data from different studies — population-genetics scans, transcriptomic time courses, genome-wide association analyses — have historically been generated in isolation, making cross-study synthesis difficult.

A critical bottleneck is data fragmentation. Of 1,140 genes with published F_ST values, only 83 had both F_ST and log-fold-change (logFC) measurements available from prior studies, highlighting how sparsely the existing datasets overlap and how much signal may be hidden in their intersections ([Perry et al. 2022, Finding 2](/knowledge/papers/2022_cave_crawler/#finding-2)). This motivates purpose-built integrative infrastructure.

CaveCrawler, a Shiny-based web analysis suite, was developed to address this gap. It combines population genetics and transcriptomic data from multiple *A. mexicanus* populations and integrates Gene Ontology (GO) term information, enabling cross-study biological inference from a unified interface ([Perry et al. 2022, Finding 1](/knowledge/papers/2022_cave_crawler/#finding-1)). The tool represents the current state of practice for community-level genomic synthesis in cavefish research.

As a proof of principle, CaveCrawler identified *arpin* — a negative regulator of actin polymerization — as a "double outlier": both an F_ST outlier and differentially expressed in circadian rhythm datasets across all three cave-population-versus-surface comparisons (Pachón, Molino, and Tinaja vs. Río Choy). This convergent signal across independent populations makes *arpin* a high-priority candidate for functional follow-up in studies of actin dynamics and/or circadian evolution in cavefish ([Perry et al. 2022, Finding 3](/knowledge/papers/2022_cave_crawler/#finding-3)).

## Supporting evidence

- **Integrative database:** CaveCrawler unifies transcriptomic, population genetics, GO, and genome architecture data for *A. mexicanus* in a single interactive platform. [Perry et al. 2022, Finding 1](/knowledge/papers/2022_cave_crawler/#finding-1)

- **Data sparsity quantified:** Across prior published studies, only 83 genes had simultaneous F_ST outlier status and logFC measurements, underscoring the need for cross-study integration. [Perry et al. 2022, Finding 2](/knowledge/papers/2022_cave_crawler/#finding-2)

- **Convergent candidate gene:** *arpin* emerged as a double outlier (F_ST + circadian logFC) in all three independent cave-vs.-surface population pairs, suggesting a shared molecular substrate for at least some convergent cave traits. [Perry et al. 2022, Finding 3](/knowledge/papers/2022_cave_crawler/#finding-3)

## Contradictions / open disagreements

The *arpin* result is correlative and threshold-dependent: classifying F_ST outliers at the lowest 5% of divergence (Herman et al. 2018) and drawing on one circadian transcription dataset (Mack et al. 2021) means the double-outlier list could shift with different datasets or thresholds. No functional validation of *arpin*'s role in cavefish biology has been reported, so its candidacy remains bioinformatic rather than mechanistic. Additionally, CaveCrawler's long-term utility as a citable resource depends on continued curation; if data deposition stalls, the snapshot captured at publication may become unrepresentative of the field.

## Tealc's citation-neighborhood suggestions

- Functional CRISPR or morpholino studies targeting *arpin* in *A. mexicanus* would test whether the convergent signal reflects genuine shared causation.
- Broader comparative cavefish genomics (e.g., other cave-adapted teleosts such as *Sinocyclocheilus* or *Typhlichthys*) could contextualize whether the patterns observed in *A. mexicanus* are general or clade-specific.
- Papers on circadian rhythm loss in cave animals would be natural companions to the *arpin* finding.

## Related on the Blackmon Lab site

- Paper permalink: [CaveCrawler (2022)](/knowledge/papers/2022_cave_crawler/)
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
<!-- tealc:related-end -->
