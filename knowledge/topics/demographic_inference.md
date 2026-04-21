---
layout: default
title: "Demographic Inference"
topic_slug: demographic_inference
last_updated: 2026-04-21T15:54:51.025773+00:00
papers_supporting: [10.1002/ece3.73483]
permalink: /knowledge/topics/demographic_inference/
category: "Population genetics"
---
# Demographic Inference

## Current understanding

Demographic inference from genomic data allows researchers to reconstruct the population history of species — including shifts in effective population size (Ne), bottlenecks, and patterns of inbreeding — even when sampling is limited to a handful of individuals or a single genome. Two complementary approaches are increasingly applied in conservation genomics of non-model organisms: pairwise sequentially Markovian coalescent (PSMC) analysis of whole-genome heterozygosity, and runs-of-homozygosity (ROH) analysis to decompose ancient versus recent reductions in Ne.

A key methodological question is whether PSMC trajectories are robust across sequencing platforms and between sexes. Work on the endangered *Cheirotonus formosanus* (long-armed scarab) provides direct evidence that they are: [Chromosome-Level Reference Genome of an Endemic, Endangered Long-Armed Scarab (*Cheirotonus formosanus*): Discovery of a Putative Y-Linked Scaffold and Demographic History., Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1) showed that PSMC trajectories reconstructed from independently sequenced male (PacBio HiFi) and female (Illumina) genomes are nearly identical, with overlapping bootstrap intervals. This platform-agnosticism is practically important for conservation programs where only opportunistically collected samples may be available.

ROH analysis offers a complementary temporal lens. In *C. formosanus*, the ROH landscape is dominated by short segments (<1 Mbp), with medium-length segments (1–5 Mbp) present in some individuals but a complete absence of very long segments (>5 Mbp). As documented in [Chromosome-Level Reference Genome of an Endemic, Endangered Long-Armed Scarab (*Cheirotonus formosanus*): Discovery of a Putative Y-Linked Scaffold and Demographic History., Finding 2](/knowledge/papers/10_1002_ece3_73483/#finding-2), this pattern is characteristic of historical bottlenecks or long-term persistence at low ancestral Ne, rather than recent consanguineous mating. The medium-length segments hint at localized recent inbreeding within demes, adding resolution that PSMC alone — which cannot reliably address the last ~10 kya — cannot provide.

Together, these two approaches illustrate a general principle: short ROH diagnose ancient demographic restriction, long ROH diagnose recent inbreeding, and PSMC captures broad multi-generational trends. Their concordance in a single endangered beetle provides a useful proof-of-concept for applying multi-method demographic inference to non-model invertebrates with limited genomic resources.

## Supporting evidence

- **PSMC platform concordance:** [Chromosome-Level Reference Genome of an Endemic, Endangered Long-Armed Scarab (*Cheirotonus formosanus*): Discovery of a Putative Y-Linked Scaffold and Demographic History., Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1) — PSMC trajectories from one PacBio HiFi male and one Illumina female *C. formosanus* genome are nearly identical with overlapping bootstrap intervals.

- **ROH length distribution as a demographic signature:** [Chromosome-Level Reference Genome of an Endemic, Endangered Long-Armed Scarab (*Cheirotonus formosanus*): Discovery of a Putative Y-Linked Scaffold and Demographic History., Finding 2](/knowledge/papers/10_1002_ece3_73483/#finding-2) — A genome dominated by short ROH and lacking segments >5 Mbp points to long-term historical low Ne rather than recent consanguineous mating in this endangered species.

## Contradictions / open disagreements

**Platform concordance sample size:** The PSMC comparison rests on n=2 genomes (one individual per sex, one per platform) from a single endemic population. This is a weak test; broader sampling across populations or species is needed before platform-agnosticism can be treated as a general rule.

**ROH inference data quality:** The ROH analysis used reduced-representation ddRAD data (n=46 individuals) rather than whole-genome resequencing. The paper acknowledges that ddRAD likely lacks sufficient coverage to fully exploit linkage information, meaning the absence of segments >5 Mbp could partly reflect data sparsity rather than true demographic history. Whole-genome resequencing of the same individuals would be needed to confirm this signal.

## Tealc's citation-neighborhood suggestions

- Li & Durbin (2011) *Inference of human population history from individual whole-genome sequences* — the original PSMC paper; useful to cite explicitly when validating the method in non-model organisms.
- Kardos et al. (2018) work on ROH and inbreeding depression — provides the theoretical framework for interpreting ROH length categories in conservation contexts.

## Related on the Blackmon Lab site

- [Chromosome-Level Reference Genome of *Cheirotonus formosanus* (source paper)](/knowledge/papers/10_1002_ece3_73483/)