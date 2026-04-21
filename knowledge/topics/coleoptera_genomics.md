---
layout: default
title: "Coleoptera genomics"
topic_slug: coleoptera_genomics
last_updated: 2026-04-21T19:09:48.830202+00:00
papers_supporting: [0235cb8484d2982c4d4f1d13c021c95aedc035bc7214dcfec49ec3ea96ccfa84, 10.1002/ece3.73483, 31776037050f6b89b93887fa1b80196fd30073325900b9b38adb091f0516948d]
permalink: /knowledge/topics/coleoptera_genomics/
---
# Coleoptera genomics

## Current understanding

Beetles (Coleoptera) are the most species-rich animal order, yet chromosome-level reference genomes remain scarce and Y chromosomes are almost entirely uncharacterized at the sequence level. New work on the endangered long-armed scarab *Cheirotonus formosanus* (Scarabaeidae: Euchirinae) and the jewel scarab *Chrysina gloriosa* (Scarabaeidae: Rutelinae) each provide chromosome-level reference assemblies, advancing understanding of karyotype conservation and sex-chromosome biology in the order. Complementing genomic assembly work, comparative cytogenetic surveys across Adephaga reveal that meiotic mechanism — specifically, whether males undergo achiasmatic meiosis — is a key predictor of sex-chromosome stability, with achiasmatic clades retaining Y chromosomes far more often than expected by chance.

## Supporting evidence

**Genome assemblies across Scarabaeidae.** High-quality reference genomes are now available for two scarab genera. The *C. formosanus* assembly recovered 10 primary large scaffolds (9 autosomes plus an X), consistent with the ancestral coleopteran karyotype of 2n=20 ([Finding 4](/knowledge/papers/10_1002_ece3_73483/#finding-4)). Similarly, the *Chrysina gloriosa* genome assembly spans 642 MB across 454 scaffolds with a scaffold N50 of 72 MB, with the 10 largest scaffolds capturing 98% of the genome and a BUSCO score of 95.5% ([2024 chrysina, Finding 1](/knowledge/papers/2024_chrysina/#finding-1)). The shared pattern of ~10 large scaffolds dominating both assemblies resonates with the conserved karyotypic architecture observed cytogenetically across Scarabaeidae.

**Y-chromosome identification.** A chromosome-quotient analysis in *C. formosanus* flagged a 1.1 Mbp scaffold with female:male read-depth ratios near 0 and male coverage averaging ~0.5× of autosomal depth, the hallmark of hemizygous single-copy Y sequence ([Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1)). One gene model on this scaffold carries a JARID1/KDM5 family domain architecture, is covered by male reads, and is entirely absent from female data, suggesting a KDM5-like histone demethylase is Y-linked in this species — paralleling *KDM5D* on the mammalian Y and hinting at convergent sex-linkage of this gene family across metazoans ([Finding 2](/knowledge/papers/10_1002_ece3_73483/#finding-2)).

**Sex-chromosome stability and meiotic mechanism.** A broader comparative analysis of Adephaga demonstrates that achiasmatic clades retain Y chromosomes at strikingly elevated rates. Among 45 taxa within Trechitae, only 3 XO species are observed where 16 are expected under the overall Adephaga Y-loss rate; in Cicindelinae + Colyrinae only 1 XO taxon is observed versus 6 expected. Simulation tests confirm these deficits are highly improbable under neutral Y-loss assumptions (p ≈ 0.08 and p ≈ 0.05), implicating achiasmy as a stabilizing force that suppresses Y-chromosome loss ([2015a, Finding 1](/knowledge/papers/2015a/#finding-1)).

**Demographic inference.** PSMC trajectories from a male (PacBio HiFi) and female (Illumina) *C. formosanus* genome were nearly identical, demonstrating that broad long-term Ne signals are robust across sequencing platforms ([Finding 3](/knowledge/papers/10_1002_ece3_73483/#finding-3)). Runs-of-homozygosity from ddRAD data (n=46) show a landscape dominated by short segments (<1 Mbp) with no segments >5 Mbp, consistent with long-term low ancestral Ne rather than recent inbreeding ([Finding 5](/knowledge/papers/10_1002_ece3_73483/#finding-5)).

## Contradictions / open disagreements

**Assembly completeness in *Chrysina*.** The *C. gloriosa* assembly (642 MB) is notably smaller than the flow-cytometry genome size estimate (~850 MB), likely reflecting unassembled repetitive content; additionally, the assembly derives from a single female, leaving structural variation across individuals and sex-specific sequences uncharacterized ([2024 chrysina, Finding 1](/knowledge/papers/2024_chrysina/#finding-1)).

**Y-scaffold validation.** Y-linkage of the 1.1 Mbp scaffold in *C. formosanus* was inferred from read-depth ratios in a single male–female pair without PCR confirmation or population-level validation ([Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1)).

**KDM5-family gene identity.** The putative Y-linked gene was assigned to the KDM5 family by InterProScan domain architecture rather than orthology-based naming and lacks experimental validation; it may be a paralog rather than the sex-determining lineage copy found on mammalian Ys ([Finding 2](/knowledge/papers/10_1002_ece3_73483/#finding-2)).

**Karyotype assignment by proxy.** The 2n=20 karyotype for *C. formosanus* is inferred from scaffold number and Hi-C contact patterns; no new cytogenetic counts were performed directly ([Finding 4](/knowledge/papers/10_1002_ece3_73483/#finding-4)).

**ROH data limitations.** ROH inference relied on reduced-representation ddRAD sequencing, which may lack sufficient marker density to detect very long homozygous tracts ([Finding 5](/knowledge/papers/10_1002_ece3_73483/#finding-5)).

**Achiasmy rate assumption.** The simulation test for suppressed Y loss assumes a single background Y-loss rate across all Adephaga. If loss rates vary for reasons independent of meiotic mechanism, the expected counts are biased and the inferential strength of the achiasmy hypothesis weakens ([2015a, Finding 1](/knowledge/papers/2015a/#finding-1)).

## Tealc's citation-neighborhood suggestions

- Broad surveys of beetle Y-chromosome gene content (e.g., work on *Tribolium castaneum*) would contextualize the KDM5-like finding.
- Comparative chromosome-quotient studies across Scarabaeidae could test whether the 2n=20 karyotype is truly conserved or whether hidden fissions/fusions exist.
- Male *Chrysina gloriosa* genome sequencing would enable sex-chromosome identification analogous to the *C. formosanus* analysis.
- Studies examining the molecular mechanism by which achiasmy stabilizes Y chromosomes during meiosis would directly test the causal claim implied by the Adephaga comparative data.

## Related on the Blackmon Lab site

- [Sex Chromosome Evolution](/sex-chromosome-evolution.html)
- [Source paper: *Cheirotonus formosanus* genome and demographic history](/knowledge/papers/10_1002_ece3_73483/)
- [Source paper: *Chrysina gloriosa* genome assembly](/knowledge/papers/2024_chrysina/)
- [Source paper: 2015a — Adephaga sex-chromosome evolution](/knowledge/papers/2015a/)