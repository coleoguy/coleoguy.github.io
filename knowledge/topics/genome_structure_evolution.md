---
layout: default
title: "Genome structure evolution"
topic_slug: genome_structure_evolution
last_updated: 2026-04-22T13:01:33.301375+00:00
papers_supporting: [10.1093/bioinformatics/btp324, 10.1093/jhered/esad076, 10.1534/genetics.116.192690, 3780c17c37d408cf1151745b75b70eea040ad4a9fa24b5d3ba4a327fa493df88, 8d80b92951d823f89e08809b32fd3ca88f579a921d623a23f8cb3c8f588e19b5, 8ec28241e312e0da2ddec048ec265c68f9b8c4b63678fb482d9e31d34a5690d6, 9b26073c4ef21e4b81ec477d50cc357c4809ccb79b53507cb54707da1d48856b, baf57990bb1ab651800c9fa0878d6cc56f78093176f5b6ae7ef64f25fc8ba126, e886b99fe0f9dcc1f5682cefed91eaf32c1cf8360d4865524975c201c00fd035]
permalink: /knowledge/topics/genome_structure_evolution/
category: "Genome structure"
editor_frozen: true
---
<!-- tealc:auto-start -->
# Genome Structure Evolution

<!-- tealc:freshness-start -->
<aside class="wiki-freshness" aria-label="Page provenance">
<span class="wf-label">Composed by Tealc</span>
<span class="wf-date">2026-04-22</span>
<span class="wf-dot">·</span>
<span class="wf-sources">9 sources</span>
<span class="wf-dot">·</span>
<span class="wf-review">Last reviewed by Heath: never</span>
</aside>
<!-- tealc:freshness-end -->


## Current understanding

*Scope: this page covers how repeat content, chromosome organization, recombination, sex chromosomes, and gene-space organization change across lineages.*

The architecture of insect genomes reflects a dynamic interplay between repetitive elements, transposable elements (TEs), the underlying gene space, and the macrostructural organization of chromosomes themselves. Characterizing this architecture in non-model organisms is increasingly tractable with long-read sequencing, though annotation quality remains tightly coupled to the availability of curated repeat libraries for the taxon in question.

**Repeat content and genome size.** A striking illustration of repeat-level dynamics comes from the newly assembled reference genome of *Perdita meconis*, the Mojave poppy bee. Repetitive elements account for 37.3% of the genome, with nearly two-thirds of that fraction (24.87% of total genome) consisting of unclassified repeats, retroelements contributing 6.07%, and DNA transposons 4.38% ([Schweizer et al. 2024, Finding 2](/knowledge/papers/10_1093_jhered_esad076/#finding-2)). This pattern — a large taxonomically uncharacterized repeat compartment alongside modest contributions from known TE superfamilies — is likely pervasive in non-model bee lineages lacking reference repeat libraries. Zooming out to microsatellites across the insect tree, genome size emerges as a robust positive predictor of microsatellite content: 96 of 100 phylogenetically corrected models returned a significant result, and 99 of 100 showed a positive slope, confirming that larger insect genomes harbor proportionally more microsatellite sequence ([Jonika et al. 2020, Finding 2](/knowledge/papers/10_3390_genes11080945/#finding-2)). This proportional scaling is consistent with a broad model in which multiple classes of repetitive DNA expand and contract roughly in concert with overall genome size.

**Direct repeats and purifying selection on genome architecture.** Not all repeat dynamics are neutral. In *Aedes aegypti*, only 5,782 of 80,498 exons are flanked by direct repeats — roughly 7-fold fewer than the ~40,000 expected under a Monte Carlo null model that randomizes repeat positions while preserving repeat sizes and inter-copy distances ([DirectRepeateR: An R package 2025, Finding 1](/knowledge/papers/10_12688_f1000research_170810_1/#finding-1)). This dramatic depletion is interpreted as evidence that purifying selection acts against direct repeats near protein-coding sequence because they create substrates for single-strand annealing (SSA)-mediated deletions — a mutational hazard that could remove exons entirely. This finding shifts the framing of repeat distribution from a purely passive, drift-driven process to one shaped by selection on structural genome integrity.

**Gene space and annotation quality.** Assembly quality and gene-space characterization vary substantially across non-model insects. The Southern Pine Beetle (*Dendroctonus frontalis*) chromosome-level assembly spans 173.7 Mbp across 381 scaffolds, with 97.72% of sequence localized to eight chromosome-level scaffolds and a BUSCO completeness of 94.2% against Endopterygota orthologues ([Genome assembly of the 2024, Finding 1](/knowledge/papers/10_1098_rsos_240755/#finding-1)). Despite this high-quality assembly, the annotated gene count (~13,400) is roughly 3,600 fewer than the mean for other beetle species (~17,000). Critically, this deficit persists at ~2,300 genes even after accounting for the tendency of TE-derived sequences to inflate gene-model counts in other beetle assemblies ([Genome assembly of the 2024, Finding 2](/knowledge/papers/10_1098_rsos_240755/#finding-2)), providing a concrete methodological warning: cross-species gene-count comparisons are unreliable unless TE misannotation has been explicitly controlled.

**Retrocopies and retrogenes.** At the individual-locus level, retroposition offers another lens on how genomes acquire and restructure gene content. A survey drawing on RetrogeneDB identified 4,426 retrocopies (106 retrogenes) paired with 1,431 parental genes in humans, and 82 retrocopies (81 retrogenes) paired with 64 parental genes in *Drosophila melanogaster* ([Lo & Blackmon 2022, Finding 1](/knowledge/papers/10_7717_peerj_12822/#finding-1)). The dramatic difference in raw counts between species reflects divergent data-collection histories as much as biological differences in retroposition rate.

**Centromere architecture and the tempo of microsatellite evolution.** Although total microsatellite content does not differ significantly between lineages with monocentric and holocentric chromosomes, the *rate* at which that content evolves does: 99 of 100 posterior-distribution trees favored a two-rate model with consistently higher rates in monocentric lineages ([Jonika et al. 2020, Finding 3](/knowledge/papers/10_3390_genes11080945/#finding-3)). Diploid chromosome number has no significant relationship with either microsatellite content or its rate of evolution, refuting the intuitive prediction that species with more chromosomes would accumulate more microsatellite sequence ([Jonika et al. 2020, Finding 1](/knowledge/papers/10_3390_genes11080945/#finding-1)).

**Recombination landscape as an evolvable genome trait.** The scale at which crossovers are distributed across chromosomes is itself subject to macroevolutionary change. Across 112 mammalian species, the chromosomal constraint on recombination — whether a crossover is required per arm or only per chromosome — has shifted independently multiple times during mammalian evolution ([10.1534/genetics.116.192690, Finding 1](/knowledge/papers/10_1534_genetics_116_192690/#finding-1)). This means the recombination architecture cannot be treated as a fixed property of a lineage; it is a genome-structural character with its own evolutionary history. Whether these shifts in crossover-distribution scale covary with chromosome number evolution, karyotype stability, or sex chromosome turnover remains an open question.

**Chromosomal identity and sex chromosome origins.** Comparative genomics across major insect orders reveals that sex chromosomes have independent evolutionary origins: the X chromosomes of *Drosophila melanogaster* and *Anopheles gambiae* share a region of homology, yet that region is not homologous to the X of *Tribolium castaneum* or the Z of *Bombyx mori* ([Blackmon & Demuth 2015, Finding 1](/knowledge/papers/10_1016_j_cois_2014_12_003/#finding-1)). Genome structural evolution therefore operates simultaneously at multiple scales, from microsatellite dynamics within lineages to wholesale chromosomal remodeling across deep divergences.

**Epistatic architecture and trait divergence.** Beyond structural organization, the genetic interactions encoded within genomes also vary systematically across the tree of life. Animals exhibit significantly greater epistatic contributions to trait divergence than plants (mean difference of −0.08, empirical p-value = .01), a pattern relevant to understanding how Bateson–Dobzhansky–Muller incompatibilities may differ between kingdoms ([Wright was right: leveraging 2024, Finding 2](/knowledge/papers/10_1093_evolut_qpae003/#finding-2)).

**Sequencing and alignment infrastructure.** Inference about genome structure increasingly depends on the short-read alignment tools used to generate the raw data. BWA, based on the Burrows-Wheeler transform, achieves 88.9% confident mapping on real 51 bp Illumina paired-end reads (98.8% in consistent pairs) — outperforming MAQ (86.1% confident, 98.7% paired) while using 23× fewer CPU hours (4.0 vs. 94.9) ([Fast and accurate short read alignment with Burrows-Wheeler transform., Finding 1](/knowledge/papers/10_1093_bioinformatics_btp324/#finding-1)). A critical scalability advantage of the BWT approach is that memory footprint is independent of read count — approximately 2.3 GB for single-end mapping regardless of dataset size — whereas MAQ's memory scales linearly with reads ([Fast and accurate short read alignment with Burrows-Wheeler transform., Finding 2](/knowledge/papers/10_1093_bioinformatics_btp324/#finding-2)). The default seeding heuristic (restricting allowed mismatches to the first 32 bp) delivers a 2.5× speedup on 70 bp reads while increasing alignment error rate only modestly, from 0.08% to 0.11% ([Fast and accurate short read alignment with Burrows-Wheeler transform., Finding 3](/knowledge/papers/10_1093_bioinformatics_btp324/#finding-3)).

## Supporting evidence

- [Schweizer et al. 2024, Finding 1](/knowledge/papers/10_1093_jhered_esad076/#finding-1): RepeatModeler masked 37.3% of the *P. meconis* genome; unclassified repeats (24.87%) dominated, followed by retroelements (6.07%), DNA transposons (4.38%), and rolling circles (0.24%).

- [DirectRepeateR: An R package 2025, Finding 1](/knowledge/papers/10_12688_f1000research_170810_1/#finding-1): In *A. aegypti*, only 5,782 of 80,498 exons were flanked by direct repeats, versus ~40,000 expected under a Monte Carlo null — roughly a 7-fold depletion interpreted as purifying selection against SSA-mediated mutational hazards near coding sequence.

- [Jonika et al. 2020, Finding 1](/knowledge/papers/10_3390_genes11080945/#finding-1): No significant relationship between diploid chromosome number and microsatellite content or rate of microsatellite evolution across insects.

- [Jonika et al. 2020, Finding 2](/knowledge/papers/10_3390_genes11080945/#finding-2): Genome size is a significant positive predictor of microsatellite content in 96 of 100 phylogenies, with a positive slope in 99 of 100 models.

- [Jonika et al. 2020, Finding 3](/knowledge/papers/10_3390_genes11080945/#finding-3): Monocentric lineages evolve microsatellite content at higher rates than holocentric lineages (99/100 posterior trees support a two-rate model), even though total microsatellite content does not differ significantly between the two groups.

- [Lo & Blackmon 2022, Finding 1](/knowledge/papers/10_7717_peerj_12822/#finding-1): 4,426 retrocopies (106 retrogenes) paired with 1,431 parental genes identified in humans; 82 retrocopies (81 retrogenes) paired with 64 parental genes in *D. melanogaster*, from RetrogeneDB.

- [Blackmon & Demuth 2015, Finding 1](/knowledge/papers/10_1016_j_cois_2014_12_003/#finding-1): The X chromosomes of *D. melanogaster* and *A. gambiae* share a homologous region not homologous to the X of *T. castaneum* or the Z of *B. mori*; each sex chromosome is homologous to a unique autosome, demonstrating independent recruitment across orders.

- [Wright was right: leveraging 2024, Finding 1](/knowledge/papers/10_1093_evolut_qpae003/#finding-1): Animals show significantly higher epistatic contributions to trait divergence than plants (mean difference of −0.08, empirical p-value = .01), based on a broad comparative analysis of hybridization experiments.

- [Genome assembly of the 2024, Finding 1](/knowledge/papers/10_1098_rsos_240755/#finding-1): The *D. frontalis* genome assembles to 173.7 Mbp with 97.72% of sequence in eight chromosome-level scaffolds (N50 24.8 Mbp) and 94.2% BUSCO completeness against Endopterygota.

- [Genome assembly of the 2024, Finding 2](/knowledge/papers/10_1098_rsos_240755/#finding-2): *Dendroctonus* species average ~13,400 annotated genes vs. ~17,000 in other beetles; ~2,300-gene deficit persists after correcting for TE-derived gene-model inflation in non-*Dendroctonus* assemblies.

- [10.1534/genetics.116.192690, Finding 1](/knowledge/papers/10_1534_genetics_116_192690/#finding-1): Across 112 mammalian species, the physical scale of the crossover distribution has shifted independently multiple times from one crossover per chromosome arm to one per chromosome, establishing recombination architecture as an evolvable genome-structural trait.

- [Fast and accurate short read alignment with Burrows-Wheeler transform., Finding 1](/knowledge/papers/10_1093_bioinformatics_btp324/#finding-1): BWA achieves 88.9% confident mapping and 98.8% consistent pairs on real 51 bp Illumina data in 4.0 CPU hours, vs. MAQ's 86.1% / 98.7% in 94.9 CPU hours.

- [Fast and accurate short read alignment with Burrows-Wheeler transform., Finding 2](/knowledge/papers/10_1093_bioinformatics_btp324/#finding-2): BWA's memory footprint (~2.3 GB single-end) is independent of read count; MAQ's scales linearly with it.

- [Fast and accurate short read alignment with Burrows-Wheeler transform., Finding 3](/knowledge/papers/10_1093_bioinformatics_btp324/#finding-3): Seeding (first 32 bp) delivers 2.5× speedup on 70 bp reads with alignment error rising only from 0.08% to 0.11%.

## Contradictions / open disagreements

- **Direct-repeat depletion: selection or composition?** The ~7-fold depletion of exons flanked by direct repeats in *A. aegypti* is interpreted as purifying selection against SSA-mediated deletion hazards, but the Monte Carlo null does not control for GC content, chromatin accessibility, or recombination landscape. The depletion could partly reflect compositional or structural differences between genic and intergenic regions rather than selection alone. The analysis is also limited to a single species, and the paper was awaiting peer review at time of writing ([DirectRepeateR: An R package 2025, Finding 1](/knowledge/papers/10_12688_f1000research_170810_1/#finding-1)).

- **Assembly gap vs. flow-cytometry estimate in SPB**: The *D. frontalis* assembly (173.7 Mbp) is smaller than the flow-cytometry genome-size estimate of 194.7 Mbp, indicating under-assembly of highly repetitive regions. Repeat-content estimates may therefore be correspondingly underestimated ([Genome assembly of the 2024, Finding 1](/knowledge/papers/10_1098_rsos_240755/#finding-1)).

- **Gene-count reduction: biology or pipeline?**: The ~3,600-gene deficit in *Dendroctonus* relative to other beetles may reflect genuine gene-space reduction, but the TE-adjustment procedure relies on domain-keyword heuristics rather than manual curation. Only three *Dendroctonus* genomes contribute to the comparison, leaving open the possibility that annotation-pipeline differences drive part of the signal ([Genome assembly of the 2024, Finding 2](/knowledge/papers/10_1098_rsos_240755/#finding-2)).

- **Annotation bias vs. genuine TE novelty**: Whether the high unclassified repeat fraction in *Perdita meconis* reflects genuinely novel TE families or gaps in available libraries remains unresolved. Broader library construction for bees is needed before family-level abundances can be compared meaningfully across Hymenoptera.

- **Monocentric rate elevation vs. clade confound**: The higher rate of microsatellite evolution in monocentric lineages is likely driven largely by Diptera and Hymenoptera; Coleoptera — also monocentric — shows the lowest rate of any order studied. The binary holocentric/monocentric contrast is therefore confounded with clade-specific factors.

- **Rate elevation without content difference**: The simultaneous finding of higher evolutionary rates in monocentric lineages but no significant difference in total microsatellite content requires explanation. Whether this reflects faster turnover or an artifact of ancestral-state estimation at deeper nodes remains open.

- **Independent sex chromosome origins vs. shared ancestral linkage**: The claim of fully independent origins across insect orders rests on comparisons among only four reference genomes. Denser taxon sampling could reveal shared ancestral linkage groups currently obscured by limited coverage.

- **Cross-species comparability of retrocopy counts**: The large disparity in retrocopy tallies between humans (4,426) and *Drosophila* (82) primarily reflects differences in curation depth in RetrogeneDB rather than true biological differences in retroposition rate ([Lo & Blackmon 2022, Finding 1](/knowledge/papers/10_7717_peerj_12822/#finding-1)).

- **Animal–plant epistasis contrast vs. mating-system confound**: The finding that animals show greater epistatic contributions to trait divergence than plants ([Wright was right: leveraging 2024, Finding 1](/knowledge/papers/10_1093_evolut_qpae003/#finding-1)) may be confounded by the plant sample being dominated by domesticated crop crosses and selfing species, which could suppress detectable epistasis independently of any genuine kingdom-level difference.

- **Crossover-scale shifts: tree quality and sex bias**: The inference that crossover-distribution scale has shifted independently multiple times across Mammalia relies on a supertree assembled manually with polytomies at poorly resolved nodes and no branch lengths. Additionally, 83.9% of crossover data are from males only; if the arm-to-chromosome shift differs between sexes — as heterochiasmy would predict — the inferred number and placement of transitions is correspondingly uncertain ([10.1534/genetics.116.192690, Finding 1](/knowledge/papers/10_1534_genetics_116_192690/#finding-1)).

- **BWA benchmark generalizability**: The accuracy and speed figures for BWA are drawn from a single individual (NA12750) at a single read length (51 bp) on a human genome; the 2.3 GB memory figure is specific to the ~3 Gb human reference. Performance on larger, more repetitive, or polyploid genomes — precisely the genomes of greatest interest for insect comparative work — may differ materially ([Fast and accurate short read alignment with Burrows-Wheeler transform., Finding 2](/knowledge/papers/10_1093_bioinformatics_btp324/#finding-2); [Fast and accurate short read alignment with Burrows-Wheeler transform., Finding 1](/knowledge/papers/10_1093_bioinformatics_btp324/#finding-1)).

## Tealc's citation-neighborhood suggestions

- Multi-species direct-repeat surveys across Diptera and other orders would test whether the SSA-mediated depletion signal observed in *A. aegypti* is general or lineage-specific; paired analysis with recombination maps and GC-content would address current confounders.
- Studies benchmarking RepeatModeler performance on Hymenoptera with varying library completeness would contextualize the unclassified repeat fraction in *Perdita meconis*.
- Comparative surveys of microsatellite content in holocentric lineages (e.g., expanded Hemiptera sampling) would help disentangle centromere architecture effects from clade-specific rate variation.
- Expanded synteny analyses across a broader set of insect orders would sharpen inference about how many times sex chromosomes have been independently recruited from autosomes.
- Manual-curation-based gene annotation pipelines for additional *Dendroctonus* species would help confirm whether the reduced gene complement is a genuine lineage-wide characteristic.
- Analyses integrating retrocopy chromosomal location data with sex chromosome content could test whether retroposition preferentially moves genes on or off sex chromosomes.
- Analyses of epistatic architecture in wild-collected plant crosses with outbreeding mating systems would help disentangle mating system from kingdom-level effects on epistasis.
- BWA performance benchmarks on non-model insect genomes with highly fragmented repeats, large genome sizes, or high heterozygosity are lacking; such data would clarify whether the mapping-rate and memory figures from the human benchmark translate to the organisms typically studied by this lab.
- Formal ancestral-state reconstruction of crossover-distribution scale in mammals, using dated supertrees with branch lengths and sex-disaggregated data, would sharpen the count and timing of transitions identified by Blackmon & Brandvain 2017.
- Testing whether crossover-distribution scale shifts covary with chromosome number change or sex chromosome turnover rates in mammals would connect this finding to the broader karyotype-evolution literature.

## Related on the Blackmon Lab site

- [DirectRepeateR: An R package 2025](/knowledge/papers/10_12688_f1000research_170810_1/)
- [Schweizer et al. 2024](/knowledge/papers/10_1093_jhered_esad076/)
- [Blackmon & Demuth 2015](/knowledge/papers/10_1016_j_cois_2014_12_003/)
- [Jonika et al. 2020](/knowledge/papers/10_3390_genes11080945/)
- [Lo & Blackmon 2022](/knowledge/papers/10_7717_peerj_12822/)
- [Wright was right: leveraging 2024](/knowledge/papers/10_1093_evolut_qpae003/)
- [Genome assembly of the 2024](/knowledge/papers/10_1098_rsos_240755/)
- [10.1534/genetics.116.192690 (Blackmon & Brandvain 2017)](/knowledge/papers/10_1534_genetics_116_192690/)
- [Fast and accurate short read alignment with Burrows-Wheeler transform. (Li & Durbin 2009)](/knowledge/papers/10_1093_bioinformatics_btp324/)
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
## Related topics on this site

- [Sex chromosome evolution](/knowledge/topics/sex_chromosome_evolution/) — 3 shared papers
<!-- tealc:related-end -->
