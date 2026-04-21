---
layout: default
title: "Sex-linkage mutation"
topic_slug: sex_linkage_mutation
last_updated: 2026-04-21T15:35:15.744185+00:00
papers_supporting: [10.1002/ece3.73483]
permalink: /knowledge/topics/sex_linkage_mutation/
---
---
layout: default
title: "Sex-linkage mutation"
topic_slug: sex_linkage_mutation
last_updated: 2026-04-21T14:54:24.027439+00:00
papers_supporting: [10.1534/genetics.117.300382, 10.1002/ece3.73483]
permalink: /knowledge/topics/sex_linkage_mutation/
---
# Sex-linkage mutation

## Current understanding

A central puzzle in sex chromosome evolution is why sexually antagonistic alleles — variants that benefit one sex at a cost to the other — so often become physically linked to sex-determining regions (SDRs). Theoretical work by Blackmon & Brandvain (2017) shows that this linkage can arise through chromosomal inversions and that the parameter regimes permitting fixation depend critically on the dominance of the male-beneficial allele and the aneuploidy cost the inversion imposes.

On the Y chromosome, inversions that capture a male-beneficial allele and suppress recombination with the SDR are favored when selection is sufficiently strong. Crucially, even inversions that elevate aneuploidy rates by 4–6% can spread to fixation under realistic conditions: [Long-Term Fragility of Y Chromosomes Is Dominated by Short-Term Resolution of Sexual Antagonism., Finding 1](/knowledge/papers/10_1534_genetics_117_300382/#finding-1) demonstrates that dominance of the male-beneficial allele and a selection coefficient as low as s ≈ 0.2 are sufficient to overcome this cost. This result underpins the paper's broader "long-term fragility from short-term resolution" thesis: each episode of sexual antagonism that is resolved by Y-linkage incrementally degrades Y-chromosome integrity over evolutionary time.

The dynamics on the X chromosome are qualitatively different and depend on the dominance architecture of the male-beneficial allele. When that allele is recessive (dominance coefficient h < ~0.3), an X-chromosome inversion capturing the female-beneficial allele cannot fix; instead it is maintained as a stable polymorphism ([Long-Term Fragility of Y Chromosomes Is Dominated by Short-Term Resolution of Sexual Antagonism., Finding 2](/knowledge/papers/10_1534_genetics_117_300382/#finding-2)). This has implications for the X as a reservoir of sexually antagonistic variation: balanced polymorphisms, not selective sweeps, may be the predominant outcome when male-beneficial alleles are recessive.

Empirical evidence from beetles is beginning to populate the theoretical landscape. A chromosome-level genome assembly of the long-armed scarab *Cheirotonus formosanus* has identified a putative Y-linked scaffold bearing a gene model with KDM5/JARID1 demethylase architecture that is covered by male reads but absent from female data. This pattern is strikingly parallel to KDM5D on the mammalian Y chromosome, suggesting convergent sex-linkage of this gene family across distantly related lineages: [Chromosome-Level Reference Genome of an Endemic, Endangered Long-Armed Scarab (<i>Cheirotonus formosanus</i>): Discovery of a Putative Y-Linked Scaffold and Demographic History., Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1). Because beetle Y chromosomes are notoriously gene-poor and poorly characterized, this candidate represents a rare anchor point for understanding which gene classes are repeatedly drawn into sex-linkage.

## Supporting evidence

The fixation and polymorphism thresholds (s ≈ 0.2 for Y-inversion spread; h < 0.3 for stable X polymorphism) derive from a deterministic three-locus population-genetic model with multiplicative fitness effects and an explicit aneuploidy cost tied to inversion size. These provide a concrete, testable parameter space. The beetle KDM5-like finding rests on InterProScan domain annotations combined with sex-differential read coverage, establishing a candidate Y-linked gene in an insect order where such genes have rarely been characterized.

## Contradictions / open disagreements

The primary limitation of the theoretical model is its determinism: genetic drift is not incorporated, and the aneuploidy–PAR cost relationship is treated as fixed and multiplicative. In small populations, drift could either destabilize the balanced X polymorphisms predicted when h < 0.3 or prevent fixation of Y inversions even when selection exceeds the modeled threshold.

For the beetle genomic finding, the KDM5-like annotation rests on domain architecture from InterProScan rather than orthology-based gene naming, and the candidate lacks experimental validation. The gene may be a paralog rather than a true ortholog of KDM5D, meaning the convergence with the mammalian Y may be superficial. No contradicting empirical study is yet available to test the population-genetic predictions head-on.

## Tealc's citation-neighborhood suggestions

- Empirical studies measuring aneuploidy rates associated with pseudoautosomal boundary inversions in systems with known Y-chromosome age could test the predicted cost thresholds.
- Population-genetic models incorporating drift alongside sexually antagonistic inversions would help determine how robust the fixation and polymorphism predictions are across a range of effective population sizes.
- Orthology-based phylogenomic analyses of KDM5 family members across beetles could clarify whether Y-linkage of this demethylase is truly convergent with mammals or instead reflects ancestral retention.

## Related on the Blackmon Lab site

- [Paper page: Long-Term Fragility of Y Chromosomes Is Dominated by Short-Term Resolution of Sexual Antagonism.](/knowledge/papers/10_1534_genetics_117_300382/)
- [Paper page: Chromosome-Level Reference Genome of an Endemic, Endangered Long-Armed Scarab (Cheirotonus formosanus): Discovery of a Putative Y-Linked Scaffold and Demographic History.](/knowledge/papers/10_1002_ece3_73483/)