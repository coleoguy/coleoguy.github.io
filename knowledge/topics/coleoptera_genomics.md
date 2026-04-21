---
layout: default
title: "Coleoptera genomics"
topic_slug: coleoptera_genomics
last_updated: 2026-04-21T19:21:07.619132+00:00
papers_supporting: [0235cb8484d2982c4d4f1d13c021c95aedc035bc7214dcfec49ec3ea96ccfa84, 10.1002/ece3.73483, 31776037050f6b89b93887fa1b80196fd30073325900b9b38adb091f0516948d, fa8d0869c6d351d791f46d2b041f9c1589e106dfa4d3f3d2ebbc59e1e3b3d80e]
permalink: /knowledge/topics/coleoptera_genomics/
category: "Insects & Coleoptera"
---
# Coleoptera genomics

## Current understanding

Beetles (Coleoptera) are the most species-rich animal order, yet chromosome-level reference genomes remain scarce and Y chromosomes are almost entirely uncharacterized at the sequence level. New work on the endangered long-armed scarab *Cheirotonus formosanus* (Scarabaeidae: Euchirinae) and the jewel scarab *Chrysina gloriosa* (Scarabaeidae: Rutelinae) each provide chromosome-level reference assemblies, advancing understanding of karyotype conservation and sex-chromosome biology in the order. Complementing genomic assembly work, comparative cytogenetic surveys across Adephaga reveal that meiotic mechanism — specifically, whether males undergo achiasmatic meiosis — is a key predictor of sex-chromosome stability. At the macroevolutionary scale, a drift-based framework now offers a population-genetic explanation for why chromosome-number evolution rates differ so dramatically across beetle clades: lineages with low effective population size (Ne) show markedly elevated rates of karyotype change, with reduced Ne acting as a permissive force allowing slightly deleterious fusions and fissions to fix by drift.

## Supporting evidence

**Genome assemblies across Scarabaeidae.** High-quality reference genomes are now available for two scarab genera. The *C. formosanus* assembly recovered 10 primary large scaffolds (9 autosomes plus an X), consistent with the ancestral coleopteran karyotype of 2n=20 ([Finding 4](/knowledge/papers/10_1002_ece3_73483/#finding-4)). Similarly, the *Chrysina gloriosa* genome assembly spans 642 MB across 454 scaffolds with a scaffold N50 of 72 MB, with the 10 largest scaffolds capturing 98% of the genome and a BUSCO score of 95.5% ([2024 chrysina, Finding 1](/knowledge/papers/2024_chrysina/#finding-1)). The shared pattern of ~10 large scaffolds dominating both assemblies resonates with the conserved karyotypic architecture observed cytogenetically across Scarabaeidae.

**Karyotype diversity and drift-driven evolution.** Across the two major beetle suborders, chromosome-number distributions differ strikingly. Adephaga autosome counts range from 3 to 34 (mean 15.57) with a bimodal distribution peaking at 11 and 18, while Polyphaga ranges from 1 to 35 (mean 10.63) with a single mode at 9 autosomes accounting for 29% of species ([2024 drift beetles, Finding 2](/knowledge/papers/2024_drift_beetles/#finding-2)). This disparity has a population-genetic explanation: across 12 Coleoptera clades, those with two Ne-reducing traits had mean fusion rates of 0.05–0.11 in Polyphaga compared with below 0.025 in medium- and high-Ne clades; in Adephaga, Calathus (the sole low-Ne clade surveyed) showed fusion rates more than ten times higher than all other Adephaga clades combined ([2024 drift beetles, Finding 1](/knowledge/papers/2024_drift_beetles/#finding-1)). Winglessness — another Ne proxy — also predicts elevated fission rates in Carabidae: the credible interval for the fission-rate difference between wingless and winged lineages was entirely positive (0.005–0.044), indicating that reduced dispersal and Ne accelerates chromosome-number increase as well as decrease ([2024 drift beetles, Finding 3](/knowledge/papers/2024_drift_beetles/#finding-3)).

**Y-chromosome identification.** A chromosome-quotient analysis in *C. formosanus* flagged a 1.1 Mbp scaffold with female:male read-depth ratios near 0, the hallmark of hemizygous Y sequence ([Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1)). One gene model on this scaffold carries a JARID1/KDM5 family domain architecture and is entirely absent from female data, suggesting a KDM5-like histone demethylase is Y-linked — paralleling *KDM5D* on the mammalian Y and hinting at convergent sex-linkage of this gene family across metazoans ([Finding 2](/knowledge/papers/10_1002_ece3_73483/#finding-2)).

**Sex-chromosome stability and meiotic mechanism.** A broader comparative analysis of Adephaga demonstrates that achiasmatic clades retain Y chromosomes at strikingly elevated rates. Among 45 taxa within Trechitae, only 3 XO species are observed where 16 are expected under the overall Adephaga Y-loss rate; in Cicindelinae + Colyrinae only 1 XO taxon is observed versus 6 expected. Simulation tests confirm these deficits are highly improbable under neutral Y-loss assumptions (p ≈ 0.08 and p ≈ 0.05), implicating achiasmy as a stabilizing force that suppresses Y-chromosome loss ([2015a, Finding 1](/knowledge/papers/2015a/#finding-1)).

**Demographic inference.** PSMC trajectories from a male and female *C. formosanus* genome were nearly identical across platforms, demonstrating robustness of long-term Ne signals ([Finding 3](/knowledge/papers/10_1002_ece3_73483/#finding-3)). Runs-of-homozygosity from ddRAD data (n=46) show a landscape dominated by short segments (<1 Mbp) with no segments >5 Mbp, consistent with long-term low ancestral Ne rather than recent inbreeding ([Finding 5](/knowledge/papers/10_1002_ece3_73483/#finding-5)).

## Contradictions / open disagreements

**Assembly completeness in *Chrysina*.** The *C. gloriosa* assembly (642 MB) is notably smaller than the flow-cytometry genome size estimate (~850 MB), likely reflecting unassembled repetitive content; the assembly also derives from a single female, leaving sex-specific sequences uncharacterized ([2024 chrysina, Finding 1](/knowledge/papers/2024_chrysina/#finding-1)).

**Y-scaffold and KDM5 gene validation.** Y-linkage of the 1.1 Mbp scaffold in *C. formosanus* was inferred from read-depth ratios in a single male–female pair without PCR or population-level confirmation ([Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1)), and the putative Y-linked gene was assigned to the KDM5 family by domain architecture rather than orthology, lacking experimental validation ([Finding 2](/knowledge/papers/10_1002_ece3_73483/#finding-2)).

**Ne categorization and clade-size limitations.** The drift-driven fusion and fission rate differences rely on categorical Ne classes inferred from four proxy traits rather than direct Ne estimates. Some clades (e.g., Calathus) contain as few as 15–16 species, so clade-wide rates may be dominated by outlier taxa rather than reflecting a true biological signal ([2024 drift beetles, Finding 1](/knowledge/papers/2024_drift_beetles/#finding-1)). Sampling is also uneven across families (family variance in chromosome number correlates with record count at r = 0.41), potentially biasing the karyotype distribution summaries ([2024 drift beetles, Finding 2](/knowledge/papers/2024_drift_beetles/#finding-2)).

**Model dependence of fission signal.** The elevated fission rate in wingless Carabidae is recovered under a fusions-and-fissions-only model but not under the more complex model that includes whole-genome duplication, meaning the result is contingent on model choice ([2024 drift beetles, Finding 3](/knowledge/papers/2024_drift_beetles/#finding-3)).

**Achiasmy rate assumption.** The simulation test for suppressed Y loss assumes a single background Y-loss rate across all Adephaga. If loss rates vary for reasons independent of meiotic mechanism, expected counts are biased and the inferential strength of the achiasmy hypothesis weakens ([2015a, Finding 1](/knowledge/papers/2015a/#finding-1)).

**Karyotype assignment by proxy.** The 2n=20 karyotype for *C. formosanus* is inferred from scaffold number and Hi-C contact patterns; no new cytogenetic counts were performed directly ([Finding 4](/knowledge/papers/10_1002_ece3_73483/#finding-4)).

## Tealc's citation-neighborhood suggestions

- Broad surveys of beetle Y-chromosome gene content (e.g., work on *Tribolium castaneum*) would contextualize the KDM5-like finding.
- Direct Ne estimates (e.g., from π or coalescent methods) for the clades classified as low- vs. high-Ne in the drift model would strengthen or refute the categorical proxy approach.
- Male *Chrysina gloriosa* genome sequencing would enable sex-chromosome identification analogous to the *C. formosanus* analysis.
- Studies examining the molecular mechanism by which achiasmy stabilizes Y chromosomes during meiosis would directly test the causal claim implied by the Adephaga comparative data.

## Related on the Blackmon Lab site

- [Sex Chromosome Evolution](/sex-chromosome-evolution.html)
- [Source paper: *Cheirotonus formosanus* genome and demographic history](/knowledge/papers/10_1002_ece3_73483/)
- [Source paper: *Chrysina gloriosa* genome assembly](/knowledge/papers/2024_chrysina/)
- [Source paper: 2015a — Adephaga sex-chromosome evolution](/knowledge/papers/2015a/)
- [Source paper: 2024 drift beetles — Ne and karyotype evolution in Coleoptera](/knowledge/papers/2024_drift_beetles/)