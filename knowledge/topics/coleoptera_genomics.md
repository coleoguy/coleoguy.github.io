---
layout: default
title: "Coleoptera genomics"
topic_slug: coleoptera_genomics
last_updated: 2026-04-21T15:34:53.428817+00:00
papers_supporting: [10.1002/ece3.73483]
permalink: /knowledge/topics/coleoptera_genomics/
---
# Coleoptera genomics

## Current understanding

Beetles (Order Coleoptera) are the most species-rich animal order, yet chromosome-level genome assemblies remain rare, leaving fundamental questions about karyotype evolution, sex-chromosome biology, and demographic history underexplored in most lineages. A 2026 study of the endangered long-armed scarab *Cheirotonus formosanus* (Scarabaeidae: Euchirinae) provides one of the most complete genomic resources yet assembled for a non-model beetle, and illustrates both the power and the current limits of reference-genome approaches in this order.

The *C. formosanus* assembly recovered 10 major scaffolds — 9 autosomes plus the X chromosome — consistent with the modal coleopteran karyotype of 2n = 20 (9AA + XY) and with available cytogenetic data for related Euchirinae ([Finding 4](/knowledge/papers/10_1002_ece3_73483/#finding-4)). This congruence reinforces the view that karyotype structure has been broadly conserved across much of beetle diversity, even as many lineages show derived fusions or fissions.

Perhaps the most noteworthy result is the identification of a putative Y-linked scaffold. Beetle Y chromosomes are typically punctiform, heterochromatic, and difficult to assemble, making gene-level characterization rare. Chromosome-quotient analysis flagged a 1.1 Mbp scaffold with female:male read-depth ratios near zero and male coverage averaging ~0.5× of autosomal depth, the hallmark signature of hemizygous, single-copy Y sequence ([Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1)). Within this scaffold, a gene model carrying JARID1/KDM5 family domain architecture was covered exclusively by male reads, suggesting a KDM5-like histone demethylase is Y-linked in this beetle — an intriguing parallel to *KDM5D* on the mammalian Y chromosome and a candidate case of convergent sex-linkage of this gene family ([Finding 2](/knowledge/papers/10_1002_ece3_73483/#finding-2)).

On the demographic side, PSMC trajectories reconstructed independently from a PacBio HiFi male genome and an Illumina female genome were nearly identical, with overlapping bootstrap envelopes, supporting robust long-term Ne inference from single high-quality genomes regardless of sequencing platform ([Finding 3](/knowledge/papers/10_1002_ece3_73483/#finding-3)). Population-level runs-of-homozygosity (ROH) analysis on 46 individuals via ddRAD revealed a landscape dominated by short segments (<1 Mbp), an absence of very long segments (>5 Mbp), and a modest number of medium-length segments (1–5 Mbp) in a subset of individuals ([Finding 5](/knowledge/papers/10_1002_ece3_73483/#finding-5)). Together these patterns point to long-term persistence at low ancestral Ne rather than acute consanguineous mating, though localized demes show signs of recent inbreeding.

## Supporting evidence

- [Chromosome-Level Reference Genome of an Endemic, Endangered Long-Armed Scarab (*Cheirotonus formosanus*): Discovery of a Putative Y-Linked Scaffold and Demographic History., Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1) — chromosome-quotient identification of the 1.1 Mbp Y-linked scaffold.
- [Finding 2](/knowledge/papers/10_1002_ece3_73483/#finding-2) — KDM5-like gene model exclusively covered by male reads on the Y scaffold.
- [Finding 3](/knowledge/papers/10_1002_ece3_73483/#finding-3) — platform-concordant PSMC Ne trajectories from one male and one female genome.
- [Finding 4](/knowledge/papers/10_1002_ece3_73483/#finding-4) — 10-scaffold assembly consistent with the ancestral 2n = 20 coleopteran karyotype.
- [Finding 5](/knowledge/papers/10_1002_ece3_73483/#finding-5) — ROH length distribution diagnosing historical low Ne and limited recent inbreeding.

## Contradictions / open disagreements

**Y-scaffold validation.** Y-linkage was inferred from coverage in a single male–female pair without PCR or population-level confirmation. Some of the 1.1 Mbp scaffold may reflect repeat artifacts or male-biased heterochromatin rather than bona fide Y sequence. Similarly, the KDM5 gene assignment rests on InterProScan domain architecture rather than orthology, leaving open whether the model is a true KDM5 ortholog or a paralog.

**Karyotype by inference.** The 2n = 20 assignment for *C. formosanus* is inferred from scaffold count and Hi-C contact patterns rather than direct cytogenetic counts on this species; no new chromosome spreads are presented.

**ROH data sparsity.** ROH inference relied on reduced-representation ddRAD data rather than whole-genome resequencing; the authors acknowledge that ddRAD may lack sufficient linkage information to detect long ROH reliably, so the absence of >5 Mbp segments could partly reflect data sparsity.

## Tealc's citation-neighborhood suggestions

Comparative studies of beetle Y-chromosome gene content in other Scarabaeidae or Polyphaga more broadly would strengthen the claim of convergent KDM5 sex-linkage. PSMC benchmarking papers that test platform concordance across a wider range of insect taxa would also complement the demographic findings here.

## Related on the Blackmon Lab site

- [Sex chromosome evolution](/sex-chromosome-evolution.html)