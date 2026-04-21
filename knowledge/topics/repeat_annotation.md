---
layout: default
title: "Repeat Annotation"
topic_slug: repeat_annotation
last_updated: 2026-04-21T20:47:44.354505+00:00
papers_supporting: [3780c17c37d408cf1151745b75b70eea040ad4a9fa24b5d3ba4a327fa493df88]
category: "Bioinformatics & tools"
permalink: /knowledge/topics/repeat_annotation/
---
# Repeat Annotation

## Current understanding

Repeat annotation — the identification and cataloguing of repetitive DNA elements within a genome — is increasingly recognized as essential not only for genome assembly quality but also for understanding mutational hazards posed by repetitive sequences near functional elements. A key class of repeats relevant to genome stability are **direct repeats**: pairs of identical or near-identical sequences oriented in the same direction. When a direct repeat flanks a coding exon, it creates a substrate for single-strand annealing (SSA) and related repair pathways that can delete the intervening sequence, including the exon itself.

A central prediction of the SSA-mediated mutational hazard hypothesis is that purifying selection should have eroded direct repeats from the vicinity of protein-coding sequence over evolutionary time. Genome-wide repeat annotation provides the empirical framework needed to test this prediction quantitatively. Using Monte Carlo simulation as a null model, [DirectRepeateR: An R package 2025, Finding 1](/knowledge/papers/2025_directrepeater/#finding-1) showed that in *Aedes aegypti*, only 5,782 of 80,498 exons are flanked by direct repeats — roughly seven-fold fewer than the ~40,000 expected under a random placement model. This striking depletion supports the view that repeat context around exons is non-random and shaped by selection, with practical implications for how annotators should interpret repeat distributions in assembled genomes.

## Supporting evidence

- [DirectRepeateR: An R package 2025, Finding 1](/knowledge/papers/2025_directrepeater/#finding-1): In *A. aegypti*, 5,782 exons out of 80,498 are flanked by direct repeats, versus ~40,000 expected from simulation — a roughly 7-fold depletion consistent with purifying selection eliminating SSA-hazardous repeat configurations near coding sequence.

## Contradictions / open disagreements

The single-species scope of the current evidence is a notable limitation. The Monte Carlo null model randomizes repeat positions while preserving repeat sizes and inter-copy distances but does not account for GC content gradients, chromatin accessibility, or variation in local recombination rate. Consequently, part of the observed depletion could reflect compositional or structural differences between genic and intergenic regions rather than selection per se. Broader taxonomic sampling and null models that explicitly control for sequence composition will be needed to distinguish these explanations. Additionally, the source paper was awaiting peer review at the time this finding was recorded.

## Tealc's citation-neighborhood suggestions

- Studies benchmarking repeat-annotation pipelines (e.g., RepeatMasker, EDTA) across insect genomes would contextualize how annotation choices affect the observed repeat-flanking statistics.
- Population-genetic analyses estimating selection coefficients against repeat insertions near exons would complement the descriptive depletion result.
- Comparative analyses across Diptera or other highly repetitive insect genomes could test whether the depletion pattern generalizes beyond *A. aegypti*.

## Related on the Blackmon Lab site

- [Paper page: 2025 DirectRepeateR](/knowledge/papers/2025_directrepeater/)