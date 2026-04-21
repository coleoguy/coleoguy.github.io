---
layout: default
title: "Software Tools"
topic_slug: software_tools
last_updated: 2026-04-21T20:48:02.379515+00:00
papers_supporting: [3780c17c37d408cf1151745b75b70eea040ad4a9fa24b5d3ba4a327fa493df88]
permalink: /knowledge/topics/software_tools/
---
# Software Tools

## Current understanding

The Blackmon Lab develops and applies computational tools to address questions in genome biology and evolutionary genetics. One recent contribution is **DirectRepeateR**, a pipeline for detecting and statistically evaluating direct repeats flanking protein-coding exons across whole-genome assemblies. The tool employs a Monte Carlo simulation framework to generate a null expectation for how many exons should be flanked by direct repeats under random placement, then compares that expectation to observed counts — providing a quantitative test of whether purifying selection depletes direct repeats near coding sequence (consistent with the hypothesis that single-strand annealing, or SSA, poses a mutational hazard to exon integrity).

Applied to *Aedes aegypti*, DirectRepeateR revealed a striking genome-wide depletion: far fewer exons are flanked by direct repeats than chance would predict, with observed counts roughly seven-fold below the null expectation. This result frames direct-repeat proximity to exons as a selectively disfavored configuration and positions DirectRepeateR as a tool capable of detecting such signals at genomic scale.

## Supporting evidence

[2025 DirectRepeateR, Finding 1](/knowledge/papers/2025_directrepeater/#finding-1) reports that in the *A. aegypti* genome, 5,782 out of 80,498 exons were flanked by direct repeats, whereas the Monte Carlo null model predicted just under 40,000 — a ~7-fold deficit that supports the inference of purifying selection against SSA-prone genomic configurations near protein-coding sequence.

## Contradictions / open disagreements

The analysis underlying Finding 1 is currently confined to a single species (*A. aegypti*), limiting the generality of the biological conclusion. Additionally, the null model randomizes repeat positions while preserving repeat sizes and inter-copy distances but does not fully control for GC content, chromatin accessibility, or recombination landscape. The observed depletion could therefore partly reflect compositional or structural differences between genic and intergenic regions rather than natural selection alone. The paper was also awaiting peer review at the time this finding was recorded, so conclusions should be treated as provisional until independent review is complete.

## Tealc's citation-neighborhood suggestions

- Benchmarking studies comparing repeat-detection pipelines (e.g., RepeatMasker, TRF, MISA) would help contextualize DirectRepeateR's sensitivity and specificity relative to existing tools.
- Comparative genomic analyses across insects or other arthropods could test whether the *A. aegypti* depletion pattern is phylogenetically widespread or lineage-specific.

## Related on the Blackmon Lab site

- [2025 DirectRepeateR paper page](/knowledge/papers/2025_directrepeater/)