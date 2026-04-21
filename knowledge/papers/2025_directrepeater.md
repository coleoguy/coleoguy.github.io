---
layout: default
title: "DirectRepeateR: An R package for annotating direct repeats in genome assemblies"
doi: 
fingerprint_sha256: 3780c17c37d408cf1151745b75b70eea040ad4a9fa24b5d3ba4a327fa493df88
authors: ""
journal: ""
year: 
topics: [genome_structure_evolution, repeat_annotation, selection_and_drift, software_tools]
tier: canon
ingested_at: 2026-04-21T20:45:55.807686+00:00
permalink: /knowledge/papers/2025_directrepeater/
---

# DirectRepeateR: An R package for annotating direct repeats in genome assemblies

## Summary

_Ingested 2026-04-21. 1 findings extracted and verified._

## Findings worth citing

<a id="finding-1"></a>
### Finding 1 — In Aedes aegypti, far fewer exons are flanked by direct repeats than expected under a random null model (5,782 observed vs. ~40,000 expected).

> In the A. aegypti genome, we observed that 5,782 out of 80,498 exons were flanked by direct repeats. The expected number, based on simulations, was calculated as just under 40,000, highlighting a significant deviation from what our null model predicted
— p. 5

*Why this is citable:* This is the paper's central empirical result supporting the hypothesis that purifying selection acts against direct repeats near protein-coding sequence in A. aegypti. It provides a quantitative, citable test of the SSA-mediated mutational hazard hypothesis using Monte Carlo simulation, showing observed flanked exons are roughly 7-fold below random expectation.

*Counter / limitation:* The analysis is limited to a single species (A. aegypti) and uses a Monte Carlo null that randomizes repeat positions while preserving repeat sizes and inter-copy distances but does not control for GC content, chromatin accessibility, or recombination landscape, so the depletion could partly reflect compositional or structural differences between genic and intergenic regions rather than selection alone. Additionally, the paper is awaiting peer review at the time of this finding.

*Topics:* [genome_structure_evolution](/knowledge/topics/genome_structure_evolution/), [selection_and_drift](/knowledge/topics/selection_and_drift/), [repeat_annotation](/knowledge/topics/repeat_annotation/), [software_tools](/knowledge/topics/software_tools/)
