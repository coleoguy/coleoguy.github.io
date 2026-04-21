---
layout: default
title: "Genome structure evolution"
topic_slug: genome_structure_evolution
last_updated: 2026-04-21T20:46:55.095783+00:00
papers_supporting: [10.1093/jhered/esad076, 3780c17c37d408cf1151745b75b70eea040ad4a9fa24b5d3ba4a327fa493df88, 8d80b92951d823f89e08809b32fd3ca88f579a921d623a23f8cb3c8f588e19b5, 8ec28241e312e0da2ddec048ec265c68f9b8c4b63678fb482d9e31d34a5690d6, 9b26073c4ef21e4b81ec477d50cc357c4809ccb79b53507cb54707da1d48856b, baf57990bb1ab651800c9fa0878d6cc56f78093176f5b6ae7ef64f25fc8ba126, e886b99fe0f9dcc1f5682cefed91eaf32c1cf8360d4865524975c201c00fd035]
category: "Genome structure"
permalink: /knowledge/topics/genome_structure_evolution/
---
<!-- tealc:auto-start -->
# Genome Structure Evolution

## Current understanding

The architecture of insect genomes reflects a dynamic interplay between repetitive elements, transposable elements (TEs), the underlying gene space, and the macrostructural organization of chromosomes themselves. Characterizing this architecture in non-model organisms is increasingly tractable with long-read sequencing, though annotation quality remains tightly coupled to the availability of curated repeat libraries for the taxon in question.

**Repeat content and genome size.** A striking illustration of repeat-level dynamics comes from the newly assembled reference genome of *Perdita meconis*, the Mojave poppy bee. Repetitive elements account for 37.3% of the genome, with nearly two-thirds of that fraction (24.87% of total genome) consisting of unclassified repeats, retroelements contributing 6.07%, and DNA transposons 4.38% ([Schweizer et al. 2024, Finding 1](/knowledge/papers/10_1093_jhered_esad076/#finding-1)). This pattern — a large taxonomically uncharacterized repeat compartment alongside modest contributions from known TE superfamilies — is likely pervasive in non-model bee lineages lacking reference repeat libraries. Zooming out to microsatellites across the insect tree, genome size emerges as a robust positive predictor of microsatellite content: 96 of 100 phylogenetically corrected models returned a significant result, and 99 of 100 showed a positive slope, confirming that larger insect genomes harbor proportionally more microsatellite sequence ([Jonika et al. 2020, Finding 2](/knowledge/papers/2020_microsats/#finding-2)). This proportional scaling is consistent with a broad model in which multiple classes of repetitive DNA expand and contract roughly in concert with overall genome size.

**Direct repeats and purifying selection on genome architecture.** Not all repeat dynamics are neutral. In *Aedes aegypti*, only 5,782 of 80,498 exons are flanked by direct repeats — roughly 7-fold fewer than the ~40,000 expected under a Monte Carlo null model that randomizes repeat positions while preserving repeat sizes and inter-copy distances ([DirectRepeateR: An R package 2025, Finding 1](/knowledge/papers/2025_directrepeater/#finding-1)). This dramatic depletion is interpreted as evidence that purifying selection acts against direct repeats near protein-coding sequence because they create substrates for single-strand annealing (SSA)-mediated deletions — a mutational hazard that could remove exons entirely. This finding shifts the framing of repeat distribution from a purely passive, drift-driven process to one shaped by selection on structural genome integrity.

**Gene space and annotation quality.** Assembly quality and gene-space characterization vary substantially across non-model insects. The Southern Pine Beetle (*Dendroctonus frontalis*) chromosome-level assembly spans 173.7 Mbp across 381 scaffolds, with 97.72% of sequence localized to eight chromosome-level scaffolds and a BUSCO completeness of 94.2% against Endopterygota orthologues ([Genome assembly of the 2024, Finding 1](/knowledge/papers/2024_spb/#finding-1)). Despite this high-quality assembly, the annotated gene count (~13,400) is roughly 3,600 fewer than the mean for other beetle species (~17,000). Critically, this deficit persists at ~2,300 genes even after accounting for the tendency of TE-derived sequences to inflate gene-model counts in other beetle assemblies ([Genome assembly of the 2024, Finding 2](/knowledge/papers/2024_spb/#finding-2)), providing a concrete methodological warning: cross-species gene-count comparisons are unreliable unless TE misannotation has been explicitly controlled.

**Retrocopies and retrogenes.** At the individual-locus level, retroposition offers another lens on how genomes acquire and restructure gene content. A survey drawing on RetrogeneDB identified 4,426 retrocopies (106 retrogenes) paired with 1,431 parental genes in humans, and 82 retrocopies (81 retrogenes) paired with 64 parental genes in *Drosophila melanogaster* ([Lo & Blackmon 2022, Finding 1](/knowledge/papers/2022_retrogenes/#finding-1)). The dramatic difference in raw counts between species reflects divergent data-collection histories as much as biological differences in retroposition rate.

**Centromere architecture and the tempo of microsatellite evolution.** Although total microsatellite content does not differ significantly between lineages with monocentric and holocentric chromosomes, the *rate* at which that content evolves does: 99 of 100 posterior-distribution trees favored a two-rate model with consistently higher rates in monocentric lineages ([Jonika et al. 2020, Finding 3](/knowledge/papers/2020_microsats/#finding-3)). Diploid chromosome number has no significant relationship with either microsatellite content or its rate of evolution, refuting the intuitive prediction that species with more chromosomes would accumulate more microsatellite sequence ([Jonika et al. 2020, Finding 1](/knowledge/papers/2020_microsats/#finding-1)).

**Chromosomal identity and sex chromosome origins.** Comparative genomics across major insect orders reveals that sex chromosomes have independent evolutionary origins: the X chromosomes of *Drosophila melanogaster* and *Anopheles gambiae* share a region of homology, yet that region is not homologous to the X of *Tribolium castaneum* or the Z of *Bombyx mori* ([Blackmon & Demuth 2015, Finding 1](/knowledge/papers/2015b/#finding-1)). Genome structural evolution therefore operates simultaneously at multiple scales, from microsatellite dynamics within lineages to wholesale chromosomal remodeling across deep divergences.

**Epistatic architecture and trait divergence.** Beyond structural organization, the genetic interactions encoded within genomes also vary systematically across the tree of life. Animals exhibit significantly greater epistatic contributions to trait divergence than plants (mean difference of −0.08, empirical p-value = .01), a pattern relevant to understanding how Bateson–Dobzhansky–Muller incompatibilities may differ between kingdoms ([Wright was right: leveraging 2024, Finding 1](/knowledge/papers/2024_wright/#finding-1)).

## Supporting evidence

- [Schweizer et al. 2024, Finding 1](/knowledge/papers/10_1093_jhered_esad076/#finding-1): RepeatModeler masked 37.3% of the *P. meconis* genome; unclassified repeats (24.87%) dominated, followed by retroelements (6.07%), DNA transposons (4.38%), and rolling circles (0.24%).

- [DirectRepeateR: An R package 2025, Finding 1](/knowledge/papers/2025_directrepeater/#finding-1): In *A. aegypti*, only 5,782 of 80,498 exons were flanked by direct repeats, versus ~40,000 expected under a Monte Carlo null — roughly a 7-fold depletion interpreted as purifying selection against SSA-mediated mutational hazards near coding sequence.

- [Jonika et al. 2020, Finding 1](/knowledge/papers/2020_microsats/#finding-1): No significant relationship between diploid chromosome number and microsatellite content or rate of microsatellite evolution across insects.

- [Jonika et al. 2020, Finding 2](/knowledge/papers/2020_microsats/#finding-2): Genome size is a significant positive predictor of microsatellite content in 96 of 100 phylogenies, with a positive slope in 99 of 100 models.

- [Jonika et al. 2020, Finding 3](/knowledge/papers/2020_microsats/#finding-3): Monocentric lineages evolve microsatellite content at higher rates than holocentric lineages (99/100 posterior trees support a two-rate model), even though total microsatellite content does not differ significantly between the two groups.

- [Lo & Blackmon 2022, Finding 1](/knowledge/papers/2022_retrogenes/#finding-1): 4,426 retrocopies (106 retrogenes) paired with 1,431 parental genes identified in humans; 82 retrocopies (81 retrogenes) paired with 64 parental genes in *D. melanogaster*, from RetrogeneDB.

- [Blackmon & Demuth 2015, Finding 1](/knowledge/papers/2015b/#finding-1): The X chromosomes of *D. melanogaster* and *A. gambiae* share a homologous region not homologous to the X of *T. castaneum* or the Z of *B. mori*; each sex chromosome is homologous to a unique autosome, demonstrating independent recruitment across orders.

- [Wright was right: leveraging 2024, Finding 1](/knowledge/papers/2024_wright/#finding-1): Animals show significantly higher epistatic contributions to trait divergence than plants (mean difference of −0.08, empirical p-value = .01), based on a broad comparative analysis of hybridization experiments.

- [Genome assembly of the 2024, Finding 1](/knowledge/papers/2024_spb/#finding-1): The *D. frontalis* genome assembles to 173.7 Mbp with 97.72% of sequence in eight chromosome-level scaffolds (N50 24.8 Mbp) and 94.2% BUSCO completeness against Endopterygota.

- [Genome assembly of the 2024, Finding 2](/knowledge/papers/2024_spb/#finding-2): *Dendroctonus* species average ~13,400 annotated genes vs. ~17,000 in other beetles; ~2,300-gene deficit persists after correcting for TE-derived gene-model inflation in non-*Dendroctonus* assemblies.

## Contradictions / open disagreements

- **Direct-repeat depletion: selection or composition?** The ~7-fold depletion of exons flanked by direct repeats in *A. aegypti* is interpreted as purifying selection against SSA-mediated deletion hazards, but the Monte Carlo null does not control for GC content, chromatin accessibility, or recombination landscape. The depletion could partly reflect compositional or structural differences between genic and intergenic regions rather than selection alone. The analysis is also limited to a single species, and the paper was awaiting peer review at time of writing ([DirectRepeateR: An R package 2025, Finding 1](/knowledge/papers/2025_directrepeater/#finding-1)).

- **Assembly gap vs. flow-cytometry estimate in SPB**: The *D. frontalis* assembly (173.7 Mbp) is smaller than the flow-cytometry genome-size estimate of 194.7 Mbp, indicating under-assembly of highly repetitive regions. Repeat-content estimates may therefore be correspondingly underestimated ([Genome assembly of the 2024, Finding 1](/knowledge/papers/2024_spb/#finding-1)).

- **Gene-count reduction: biology or pipeline?**: The ~3,600-gene deficit in *Dendroctonus* relative to other beetles may reflect genuine gene-space reduction, but the TE-adjustment procedure relies on domain-keyword heuristics rather than manual curation. Only three *Dendroctonus* genomes contribute to the comparison, leaving open the possibility that annotation-pipeline differences drive part of the signal ([Genome assembly of the 2024, Finding 2](/knowledge/papers/2024_spb/#finding-2)).

- **Annotation bias vs. genuine TE novelty**: Whether the high unclassified repeat fraction in *Perdita meconis* reflects genuinely novel TE families or gaps in available libraries remains unresolved. Broader library construction for bees is needed before family-level abundances can be compared meaningfully across Hymenoptera.

- **Monocentric rate elevation vs. clade confound**: The higher rate of microsatellite evolution in monocentric lineages is likely driven largely by Diptera and Hymenoptera; Coleoptera — also monocentric — shows the lowest rate of any order studied. The binary holocentric/monocentric contrast is therefore confounded with clade-specific factors.

- **Rate elevation without content difference**: The simultaneous finding of higher evolutionary rates in monocentric lineages but no significant difference in total microsatellite content requires explanation. Whether this reflects faster turnover or an artifact of ancestral-state estimation at deeper nodes remains open.

- **Independent sex chromosome origins vs. shared ancestral linkage**: The claim of fully independent origins across insect orders rests on comparisons among only four reference genomes. Denser taxon sampling could reveal shared ancestral linkage groups currently obscured by limited coverage.

- **Cross-species comparability of retrocopy counts**: The large disparity in retrocopy tallies between humans (4,426) and *Drosophila* (82) primarily reflects differences in curation depth in RetrogeneDB rather than true biological differences in retroposition rate ([Lo & Blackmon 2022, Finding 1](/knowledge/papers/2022_retrogenes/#finding-1)).

- **Animal–plant epistasis contrast vs. mating-system confound**: The finding that animals show greater epistatic contributions to trait divergence than plants ([Wright was right: leveraging 2024, Finding 1](/knowledge/papers/2024_wright/#finding-1)) may be confounded by the plant sample being dominated by domesticated crop crosses and selfing species, which could suppress detectable epistasis independently of any genuine kingdom-level difference.

## Tealc's citation-neighborhood suggestions

- Multi-species direct-repeat surveys across Diptera and other orders would test whether the SSA-mediated depletion signal observed in *A. aegypti* is general or lineage-specific; paired analysis with recombination maps and GC-content would address current confounders.
- Studies benchmarking RepeatModeler performance on Hymenoptera with varying library completeness would contextualize the unclassified repeat fraction in *Perdita meconis*.
- Comparative surveys of microsatellite content in holocentric lineages (e.g., expanded Hemiptera sampling) would help disentangle centromere architecture effects from clade-specific rate variation.
- Expanded synteny analyses across a broader set of insect orders would sharpen inference about how many times sex chromosomes have been independently recruited from autosomes.
- Manual-curation-based gene annotation pipelines for additional *Dendroctonus* species would help confirm whether the reduced gene complement is a genuine lineage-wide characteristic.
- Analyses integrating retrocopy chromosomal location data with sex chromosome content could test whether retroposition preferentially moves genes on or off sex chromosomes.
- Analyses of epistatic architecture in wild-collected plant crosses with outbreeding mating systems would help disentangle mating system from kingdom-level effects on epistasis.

## Related on the Blackmon Lab site

- [DirectRepeateR: An R package 2025](/knowledge/papers/2025_directrepeater/)
- [Schweizer et al. 2024](/knowledge/papers/10_1093_jhered_esad076/)
- [Blackmon & Demuth 2015](/knowledge/papers/2015b/)
- [Jonika et al. 2020](/knowledge/papers/2020_microsats/)
- [Lo & Blackmon 2022](/knowledge/papers/2022_retrogenes/)
- [Wright was right: leveraging 2024](/knowledge/papers/2024_wright/)
- [Genome assembly of the 2024](/knowledge/papers/2024_spb/)
<!-- tealc:auto-end -->
