---
layout: default
title: "Demographic Inference"
topic_slug: demographic_inference
last_updated: 2026-04-21T15:35:43.636168+00:00
papers_supporting: [10.1002/ece3.73483]
permalink: /knowledge/topics/demographic_inference/
---
# Demographic Inference

## Current understanding

Demographic inference from genomic data offers two complementary windows into a species' past: PSMC (Pairwise Sequentially Markovian Coalescent) analysis of a single diploid genome to reconstruct long-term effective population size (*N*e) trajectories, and runs-of-homozygosity (ROH) analysis across multiple individuals to distinguish ancient demographic contraction from recent consanguineous mating. Together, these methods are increasingly applied in conservation genomics of non-model and endangered species, where sample sizes are often limited and sequencing platforms may vary.

A key practical question is whether PSMC-derived *N*e trajectories are sensitive to sequencing platform, an important concern when reference genomes and population samples are generated under different protocols. Work on the endangered scarab *Cheirotonus formosanus* provides direct evidence that broad long-term signals are platform-agnostic: [Chromosome-Level Reference Genome of an Endemic, Endangered Long-Armed Scarab (*Cheirotonus formosanus*): Discovery of a Putative Y-Linked Scaffold and Demographic History., Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1) shows that PSMC trajectories from an independently sequenced male (PacBio HiFi) and female (Illumina) genome are nearly identical and their bootstrap intervals overlap, supporting methodological confidence in single-genome inference even when platform differs.

ROH length distributions carry a distinct and complementary signal. Short ROH (<1 Mbp) accumulate over many generations of small population size, whereas very long ROH (>5 Mbp) reflect recent relatedness within a pedigree. In *C. formosanus*, [Finding 2](/knowledge/papers/10_1002_ece3_73483/#finding-2) documents a ROH landscape dominated by short segments and a complete absence of segments >5 Mbp, with only medium-length segments (1–5 Mbp) present in a subset of individuals. This pattern is interpreted as evidence of long-term historical low *N*e rather than recent inbreeding, though medium segments suggest localized deme-level relatedness persists.

## Supporting evidence

- **PSMC platform concordance:** [Chromosome-Level Reference Genome of an Endemic, Endangered Long-Armed Scarab (*Cheirotonus formosanus*): Discovery of a Putative Y-Linked Scaffold and Demographic History., Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1) — two genomes from the same population but different sequencing platforms yield overlapping *N*e reconstructions, validating single-genome PSMC as robust in invertebrate conservation genomics contexts.

- **ROH as a diagnostic of demographic history:** [Chromosome-Level Reference Genome of an Endemic, Endangered Long-Armed Scarab (*Cheirotonus formosanus*): Discovery of a Putative Y-Linked Scaffold and Demographic History., Finding 2](/knowledge/papers/10_1002_ece3_73483/#finding-2) — short-dominated ROH profiles in endangered beetles distinguish chronic small-population history from acute inbreeding, informing conservation management decisions.

## Contradictions / open disagreements

Both findings rest on a single endemic species with limited genomic sampling. The PSMC concordance result uses only two individuals (n=1 per sex), which is a minimal test of platform effects; broader multi-individual or multi-species comparisons are needed before generalizing. For the ROH analysis, the data derive from reduced-representation ddRAD sequencing (n=46) rather than whole-genome resequencing. The authors acknowledge that ddRAD coverage may be insufficient to detect long ROH reliably, meaning the reported absence of >5 Mbp segments could partly reflect data sparsity rather than true demography. Additionally, PSMC cannot resolve demographic events in the last ~10 kya, leaving recent population dynamics uncharacterized by either method.

## Tealc's citation-neighborhood suggestions

Future work might cite Li & Durbin (2011, *Nature*) for the PSMC framework itself, McQuillan et al. (2008) for ROH methodology, and Beichman et al. (2018, *Annual Review of Ecology, Evolution, and Systematics*) for a comparative review of single-genome demographic inference methods in conservation contexts.

## Related on the Blackmon Lab site

- [Source paper: Chromosome-Level Reference Genome of *Cheirotonus formosanus*](/knowledge/papers/10_1002_ece3_73483/)