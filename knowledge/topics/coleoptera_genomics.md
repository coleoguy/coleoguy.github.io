---
layout: default
title: "Coleoptera genomics"
topic_slug: coleoptera_genomics
last_updated: 2026-04-21T20:39:53.422470+00:00
papers_supporting: [0235cb8484d2982c4d4f1d13c021c95aedc035bc7214dcfec49ec3ea96ccfa84, 10.1002/ece3.73483, 31776037050f6b89b93887fa1b80196fd30073325900b9b38adb091f0516948d, baf57990bb1ab651800c9fa0878d6cc56f78093176f5b6ae7ef64f25fc8ba126, fa8d0869c6d351d791f46d2b041f9c1589e106dfa4d3f3d2ebbc59e1e3b3d80e]
category: "Insects & Coleoptera"
permalink: /knowledge/topics/coleoptera_genomics/
---
<!-- tealc:auto-start -->
# Coleoptera genomics

## Current understanding

Beetles (Coleoptera) are the most species-rich animal order, yet chromosome-level reference genomes remain scarce and Y chromosomes are almost entirely uncharacterized at the sequence level. New work on the endangered long-armed scarab *Cheirotonus formosanus* (Scarabaeidae: Euchirinae), the jewel scarab *Chrysina gloriosa* (Scarabaeidae: Rutelinae), and the southern pine beetle *Dendroctonus frontalis* (Curculionidae: Scolytinae) each provide chromosome-level reference assemblies, advancing understanding of karyotype conservation and sex-chromosome biology in the order. Complementing genomic assembly work, comparative cytogenetic surveys across Adephaga reveal that meiotic mechanism — specifically, whether males undergo achiasmatic meiosis — is a key predictor of sex-chromosome stability. At the macroevolutionary scale, a drift-based framework offers a population-genetic explanation for why chromosome-number evolution rates differ so dramatically across beetle clades.

## Supporting evidence

**Genome assemblies across Coleoptera.** High-quality reference genomes are now available for three beetle species spanning two suborders. The *C. formosanus* assembly recovered 10 primary large scaffolds (9 autosomes plus an X), consistent with the ancestral coleopteran karyotype of 2n=20 ([Chien et al. 2026](/knowledge/papers/10_1002_ece3_73483/#finding-4)). The *Chrysina gloriosa* genome spans 642 MB across 454 scaffolds with a scaffold N50 of 72 MB; the 10 largest scaffolds capture 98% of the genome at BUSCO 95.5% ([A reference quality genome 2024, Finding 1](/knowledge/papers/10_1093_g3journal_jkae084/#finding-1)). In bark beetles (Curculionidae), the *D. frontalis* (SPB) assembly is smaller but similarly dominated by a handful of large scaffolds: 173.7 Mbp total with 97.72% of sequence in eight chromosome-level scaffolds ranging from 12.4 to 42.5 Mbp and a scaffold N50 of 24.8 Mbp, achieving 94.2% BUSCO completeness against Endopterygota orthologues ([Genome assembly of the 2024, Finding 1](/knowledge/papers/10_1098_rsos_240755/#finding-1)). The shared pattern of a small number of large scaffolds dominating each assembly resonates with conserved karyotypic architecture observed cytogenetically across Coleoptera.

**Reduced gene content in Dendroctonus.** Comparison of annotated gene sets reveals a striking deficit in bark beetles: the three sequenced *Dendroctonus* species contain on average ~13,400 genes, roughly 3,600 fewer than the ~17,000 mean across 11 other beetle species ([Genome assembly of the 2024, Finding 2](/knowledge/papers/10_1098_rsos_240755/#finding-2)). Approximately 2,300 of this difference persists after correcting for transposable-element misannotation that artificially inflates gene counts in non-*Dendroctonus* assemblies, suggesting a genuine biological reduction in gene repertoire within the genus.

**Sex-chromosome identification and synteny.** Chromosome-quotient analysis in *C. formosanus* flagged a 1.1 Mbp scaffold with female:male read-depth ratios near 0, identifying hemizygous Y sequence; one gene model on this scaffold carries a JARID1/KDM5 family domain and is entirely absent from female data, paralleling *KDM5D* on the mammalian Y ([Chien et al. 2026](/knowledge/papers/10_1002_ece3_73483/#finding-1); [Chien et al. 2026](/knowledge/papers/10_1002_ece3_73483/#finding-2)). In SPB, the putative X chromosome (scaffold 8) shows synteny with scaffold 1 of *D. ponderosae*, which corresponds to that species' neoXY system, and the nine ancestral Coleopteran Stevens elements are conserved across SPB, MPB, and *Tribolium castaneum* ([Genome assembly of the 2024, Finding 3](/knowledge/papers/10_1098_rsos_240755/#finding-3)).

**Sex-chromosome stability and meiotic mechanism.** A broader comparative analysis of Adephaga demonstrates that achiasmatic clades retain Y chromosomes at strikingly elevated rates. Among 45 taxa within Trechitae only 3 XO species are observed where 16 are expected; simulation tests confirm these deficits are highly improbable under neutral Y-loss assumptions, implicating achiasmy as a stabilizing force ([Blackmon & Demuth 2015, Finding 2](/knowledge/papers/10_1002_bies_201500040/#finding-2)).

**Karyotype diversity and drift-driven evolution.** Adephaga autosome counts range from 3 to 34 (mean 15.57) with a bimodal distribution, while Polyphaga ranges from 1 to 35 (mean 10.63) with a mode at 9 autosomes ([Drift drives the evolution 2024, Finding 3](/knowledge/papers/10_1093_jhered_esae001/#finding-3)). Across 12 Coleoptera clades, those with two Ne-reducing traits show mean fusion rates of 0.05–0.11 compared with below 0.025 in higher-Ne clades; winglessness also predicts elevated fission rates in Carabidae (credible interval 0.005–0.044 entirely positive), consistent with reduced Ne acting as a permissive force for karyotype change ([Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae001/#finding-1); [Drift drives the evolution 2024, Finding 4](/knowledge/papers/10_1093_jhered_esae001/#finding-4)).

**Demographic inference.** PSMC trajectories from *C. formosanus* were nearly identical across platforms, and ROH data from ddRAD (n=46) show segments dominated by short runs (<1 Mbp) consistent with long-term low ancestral Ne rather than recent inbreeding ([Chien et al. 2026](/knowledge/papers/10_1002_ece3_73483/#finding-3); [Chien et al. 2026](/knowledge/papers/10_1002_ece3_73483/#finding-5)).

## Contradictions / open disagreements

**Assembly completeness.** Both *C. gloriosa* (642 MB vs. ~850 MB flow-cytometry estimate) and SPB (173.7 Mbp vs. 194.7 Mbp flow-cytometry estimate) assemblies are smaller than their cytometric genome sizes, likely reflecting unassembled repetitive content ([A reference quality genome 2024, Finding 1](/knowledge/papers/10_1093_g3journal_jkae084/#finding-1); [Genome assembly of the 2024, Finding 1](/knowledge/papers/10_1098_rsos_240755/#finding-1)). The *C. gloriosa* assembly also derives from a single female, leaving sex-specific sequences uncharacterized.

**Gene-count deficit and annotation methodology.** The Dendroctonus gene-count deficit relies on heuristic domain-keyword TE filtering rather than manual curation, so part of the apparent ~3,600-gene gap could reflect pipeline differences rather than genuine biology ([Genome assembly of the 2024, Finding 2](/knowledge/papers/10_1098_rsos_240755/#finding-2)).

**Sex-chromosome identification by read depth alone.** Y-linkage in *C. formosanus* was inferred from read-depth in a single male–female pair without PCR or population-level confirmation ([Chien et al. 2026](/knowledge/papers/10_1002_ece3_73483/#finding-1)), and the KDM5-like gene was assigned by domain architecture rather than orthology ([Chien et al. 2026](/knowledge/papers/10_1002_ece3_73483/#finding-2)). Similarly, SPB X-chromosome assignment rests solely on reduced male read coverage without cytogenetic confirmation ([Genome assembly of the 2024, Finding 3](/knowledge/papers/10_1098_rsos_240755/#finding-3)).

**Ne categorization and clade-size limitations.** The drift-driven rate differences rely on categorical Ne proxies rather than direct estimates, and some clades contain as few as 15–16 species, potentially inflating variance ([Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae001/#finding-1)). The elevated fission rate in wingless Carabidae is also model-dependent ([Drift drives the evolution 2024, Finding 3](/knowledge/papers/10_1093_jhered_esae001/#finding-3)).

**Achiasmy rate assumption.** The simulation test for suppressed Y loss assumes a single background Y-loss rate across all Adephaga; if loss rates vary independently of meiotic mechanism, expected counts are biased ([Blackmon & Demuth 2015, Finding 2](/knowledge/papers/10_1002_bies_201500040/#finding-2)).

## Tealc's citation-neighborhood suggestions

- Broad surveys of beetle Y-chromosome gene content (e.g., *Tribolium castaneum* work) would contextualize the KDM5-like and SPB sex-chromosome findings.
- Direct Ne estimates (e.g., from π or coalescent methods) for clades classified as low- vs. high-Ne would strengthen the drift model.
- Male *Chrysina gloriosa* genome sequencing would enable sex-chromosome identification analogous to the *C. formosanus* and SPB analyses.
- Additional *Dendroctonus* genomes with careful manual annotation would clarify whether the gene-count deficit is biological or methodological.
- Studies examining the molecular mechanism by which achiasmy stabilizes Y chromosomes would directly test the causal claim from the Adephaga comparative data.

## Related on the Blackmon Lab site

- [Sex Chromosome Evolution](/sex-chromosome-evolution.html)
- [Chien et al. 2026](/knowledge/papers/10_1002_ece3_73483/)
- [A reference quality genome 2024](/knowledge/papers/10_1093_g3journal_jkae084/)
- [Blackmon & Demuth 2015](/knowledge/papers/10_1002_bies_201500040/)
- [Source paper: 2024 drift beetles — Ne and karyotype evolution in Coleoptera](/knowledge/papers/10_1093_jhered_esae001/)
- [Source paper: 2024 SPB — *Dendroctonus frontalis* genome](/knowledge/papers/10_1098_rsos_240755/)
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
## Related topics on this site

- [Karyotype evolution overview](/knowledge/topics/karyotype_evolution_overview/) — 3 shared papers
- [Sex chromosome evolution](/knowledge/topics/sex_chromosome_evolution/) — 3 shared papers
- [Conservation Genomics](/knowledge/topics/conservation_genomics/) — 2 shared papers
- [Fragile Y hypothesis](/knowledge/topics/fragile_y_hypothesis/) — 2 shared papers
- [Genome Assembly](/knowledge/topics/genome_assembly/) — 2 shared papers
<!-- tealc:related-end -->
