---
layout: default
title: "Coleoptera genomics"
topic_slug: coleoptera_genomics
last_updated: 2026-04-21T18:14:07.402830+00:00
papers_supporting: [0235cb8484d2982c4d4f1d13c021c95aedc035bc7214dcfec49ec3ea96ccfa84, 10.1002/ece3.73483]
permalink: /knowledge/topics/coleoptera_genomics/
category: "Coleoptera"
---
# Coleoptera genomics

## Current understanding

Beetles (Coleoptera) are the most species-rich animal order, yet chromosome-level reference genomes remain scarce and Y chromosomes are almost entirely uncharacterized at the sequence level. New work on the endangered long-armed scarab *Cheirotonus formosanus* (Scarabaeidae: Euchirinae) provides one of the few assembled beetle genomes with direct molecular evidence for Y-linked sequence, advancing understanding of both karyotype conservation and sex-chromosome biology in the order. Complementing genomic assembly work, comparative cytogenetic surveys across Adephaga reveal that meiotic mechanism — specifically, whether males undergo achiasmatic meiosis — is a key predictor of sex-chromosome stability, with achiasmatic clades retaining Y chromosomes far more often than expected by chance.

## Supporting evidence

**Y-chromosome identification.** A chromosome-quotient analysis flagged a 1.1 Mbp scaffold with female:male read-depth ratios near 0 and male coverage averaging ~0.5× of autosomal depth, the hallmark of hemizygous single-copy Y sequence ([Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1)). One gene model on this scaffold carries a JARID1/KDM5 family domain architecture, is covered by male reads, and is entirely absent from female data, suggesting a KDM5-like histone demethylase is Y-linked in this species — paralleling *KDM5D* on the mammalian Y and hinting at convergent sex-linkage of this gene family across metazoans ([Finding 2](/knowledge/papers/10_1002_ece3_73483/#finding-2)).

**Karyotype conservation.** Hi-C scaffolding of the *C. formosanus* assembly recovered 10 primary large scaffolds — 9 autosomes plus an X chromosome — consistent with the ancestral coleopteran karyotype of 2n=20 (9AA+XY) and with cytogenetic data for the broader Euchirinae ([Finding 4](/knowledge/papers/10_1002_ece3_73483/#finding-4)). This conserved genomic architecture makes the scarab a useful comparative anchor for studies of karyotype evolution across Scarabaeidae.

**Sex-chromosome stability and meiotic mechanism.** A broader comparative analysis of Adephaga demonstrates that achiasmatic clades — in which male meiosis lacks chiasmata, allowing the sex chromosomes to segregate via an alternative mechanism — retain Y chromosomes at strikingly elevated rates. Among 45 taxa within Trechitae, only 3 XO species are observed where 16 are expected under the overall Adephaga Y-loss rate; similarly, in Cicindelinae + Colyrinae only 1 XO taxon is observed versus 6 expected. Simulation tests confirm these deficits are highly improbable under neutral Y-loss assumptions (p ≈ 0.08 and p ≈ 0.05, respectively), implicating achiasmy as a stabilizing force that suppresses Y-chromosome loss ([2015a, Finding 1](/knowledge/papers/2015a/#finding-1)).

**Demographic inference.** PSMC trajectories from an independently sequenced male (PacBio HiFi) and female (Illumina) genome were nearly identical, demonstrating that broad long-term effective population size (Ne) signals are robust across sequencing platforms ([Finding 3](/knowledge/papers/10_1002_ece3_73483/#finding-3)). Runs-of-homozygosity (ROH) from ddRAD data (n=46) show a landscape dominated by short segments (<1 Mbp) with no segments >5 Mbp, consistent with long-term persistence at low ancestral Ne rather than recent inbreeding, though medium-length segments in some individuals indicate localized recent consanguinity within demes ([Finding 5](/knowledge/papers/10_1002_ece3_73483/#finding-5)).

## Contradictions / open disagreements

**Y-scaffold validation.** Y-linkage of the 1.1 Mbp scaffold was inferred from read-depth ratios in a single male–female pair without PCR confirmation or population-level validation; some of the scaffold could reflect repeat artifacts or male-biased heterochromatic sequence ([Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1)).

**KDM5-family gene identity.** The putative Y-linked gene was assigned to the KDM5 family by InterProScan domain architecture rather than orthology-based naming and lacks experimental validation; it may be a paralog rather than the sex-determining lineage copy found on mammalian Ys ([Finding 2](/knowledge/papers/10_1002_ece3_73483/#finding-2)).

**Karyotype assignment by proxy.** The 2n=20 karyotype is inferred from scaffold number and Hi-C contact patterns; no new cytogenetic counts were performed for *C. formosanus* directly, so the assignment rests on consistency with related taxa ([Finding 4](/knowledge/papers/10_1002_ece3_73483/#finding-4)).

**ROH data limitations.** ROH inference relied on reduced-representation ddRAD sequencing, which may lack sufficient marker density to detect very long homozygous tracts; the observed absence of >5 Mbp segments could partly reflect data sparsity rather than true demography ([Finding 5](/knowledge/papers/10_1002_ece3_73483/#finding-5)).

**Achiasmy rate assumption.** The simulation test for suppressed Y loss in achiasmatic Adephaga clades assumes a single background Y-loss rate across the entire suborder. If loss rates vary for reasons independent of meiotic mechanism — such as lineage-specific effective population sizes or karyotypic constraints — the expected counts are biased and the inferential strength of the achiasmy hypothesis weakens ([2015a, Finding 1](/knowledge/papers/2015a/#finding-1)).

## Tealc's citation-neighborhood suggestions

- Broad surveys of beetle Y-chromosome gene content (e.g., work on *Tribolium castaneum*) would contextualize the KDM5-like finding.
- Comparative chromosome-quotient studies across Scarabaeidae could test whether the 2n=20 karyotype is truly conserved or whether hidden fissions/fusions exist.
- Studies examining the molecular mechanism by which achiasmy stabilizes Y chromosomes during meiosis would directly test the causal claim implied by the Adephaga comparative data.

## Related on the Blackmon Lab site

- [Sex Chromosome Evolution](/sex-chromosome-evolution.html)
- [Source paper: *Cheirotonus formosanus* genome and demographic history](/knowledge/papers/10_1002_ece3_73483/)
- [Source paper: 2015a — Adephaga sex-chromosome evolution](/knowledge/papers/2015a/)