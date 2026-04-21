---
layout: default
title: "Genome structure evolution"
topic_slug: genome_structure_evolution
last_updated: 2026-04-21T18:35:32.812416+00:00
papers_supporting: [10.1093/jhered/esad076, 8d80b92951d823f89e08809b32fd3ca88f579a921d623a23f8cb3c8f588e19b5, e886b99fe0f9dcc1f5682cefed91eaf32c1cf8360d4865524975c201c00fd035]
permalink: /knowledge/topics/genome_structure_evolution/
category: "Genome structure"
---
# Genome Structure Evolution

## Current understanding

The architecture of insect genomes reflects a dynamic interplay between repetitive elements, transposable elements (TEs), the underlying gene space, and the macrostructural organization of chromosomes themselves. Characterizing this architecture in non-model organisms is increasingly tractable with long-read sequencing, though annotation quality remains tightly coupled to the availability of curated repeat libraries for the taxon in question.

**Repeat content and genome size.** A striking illustration of repeat-level dynamics comes from the newly assembled reference genome of *Perdita meconis*, the Mojave poppy bee. Repetitive elements account for 37.3% of the genome, with nearly two-thirds of that fraction (24.87% of total genome) consisting of unclassified repeats, retroelements contributing 6.07%, and DNA transposons 4.38% ([Reference genome for the Mojave poppy bee (*Perdita meconis*), Finding 1](/knowledge/papers/10_1093_jhered_esad076/#finding-1)). This pattern — a large taxonomically uncharacterized repeat compartment alongside modest contributions from known TE superfamilies — is likely pervasive in non-model bee lineages lacking reference repeat libraries. Zooming out to microsatellites across the insect tree, genome size emerges as a robust positive predictor of microsatellite content: 96 of 100 phylogenetically corrected models returned a significant result, and 99 of 100 showed a positive slope, confirming that larger insect genomes harbor proportionally more microsatellite sequence ([2020 microsats, Finding 2](/knowledge/papers/2020_microsats/#finding-2)). This proportional scaling is consistent with a broad model in which multiple classes of repetitive DNA expand and contract roughly in concert with overall genome size.

**Centromere architecture and the tempo of microsatellite evolution.** Although total microsatellite content does not differ significantly between lineages with monocentric and holocentric chromosomes, the *rate* at which that content evolves does: 99 of 100 posterior-distribution trees favored a two-rate model with consistently higher rates in monocentric lineages ([2020 microsats, Finding 3](/knowledge/papers/2020_microsats/#finding-3)). This result suggests that centromere architecture shapes the tempo of repetitive-DNA evolution even when it leaves no clear imprint on steady-state content. Notably, diploid chromosome number has no significant relationship with either microsatellite content or its rate of evolution, refuting the intuitive prediction that species with more chromosomes — and therefore more centromeres and telomeres — would accumulate more microsatellite sequence ([2020 microsats, Finding 1](/knowledge/papers/2020_microsats/#finding-1)).

**Chromosomal identity and sex chromosome origins.** At the broadest scale, comparative genomics across major insect orders reveals that sex chromosomes have independent evolutionary origins: the X chromosomes of *Drosophila melanogaster* and *Anopheles gambiae* share a region of homology, yet that region is not homologous to the X of *Tribolium castaneum* or the Z of *Bombyx mori* — each sex chromosome is instead homologous to a unique autosome in the other species ([2015b, Finding 1](/knowledge/papers/2015b/#finding-1)). This demonstrates that genome structural evolution operates simultaneously at multiple scales, from microsatellite dynamics within lineages all the way to wholesale chromosomal remodeling across deep divergences.

## Supporting evidence

- [Reference genome for the Mojave poppy bee (*Perdita meconis*), Finding 1](/knowledge/papers/10_1093_jhered_esad076/#finding-1): RepeatModeler masked 37.3% of the *P. meconis* genome; unclassified repeats (24.87%) dominated, followed by retroelements (6.07%), DNA transposons (4.38%), and rolling circles (0.24%).

- [2020 microsats, Finding 1](/knowledge/papers/2020_microsats/#finding-1): No significant relationship between diploid chromosome number and microsatellite content or rate of microsatellite evolution across insects.

- [2020 microsats, Finding 2](/knowledge/papers/2020_microsats/#finding-2): Genome size is a significant positive predictor of microsatellite content in 96 of 100 phylogenies, with a positive slope in 99 of 100 models.

- [2020 microsats, Finding 3](/knowledge/papers/2020_microsats/#finding-3): Monocentric lineages evolve microsatellite content at higher rates than holocentric lineages (99/100 posterior trees support a two-rate model), even though total microsatellite content does not differ significantly between the two groups.

- [2015b, Finding 1](/knowledge/papers/2015b/#finding-1): The X chromosomes of *D. melanogaster* and *A. gambiae* share a homologous region not homologous to the X of *T. castaneum* or the Z of *B. mori*; each sex chromosome is homologous to a unique autosome, demonstrating independent recruitment across orders.

## Contradictions / open disagreements

- **Annotation bias vs. genuine TE novelty**: Whether the high unclassified repeat fraction in *Perdita meconis* reflects genuinely novel TE families or simply gaps in available libraries remains unresolved. Broader library construction for bees is needed before family-level abundances can be compared meaningfully across Hymenoptera.

- **Monocentric rate elevation vs. clade confound**: The higher rate of microsatellite evolution in monocentric lineages is likely driven largely by Diptera and Hymenoptera; Coleoptera — also monocentric — shows the lowest rate of any order studied. The binary holocentric/monocentric contrast is therefore confounded with clade-specific factors, and the authors explicitly warn that this pattern is analogous to the inflated false-positive problem documented under BiSSE models. The finding should not be interpreted as a simple causal effect of centromere type.

- **Rate elevation without content difference**: The simultaneous finding of higher evolutionary rates in monocentric lineages but no significant difference in total microsatellite content requires explanation. Whether this reflects faster turnover (gain balanced by loss) or is an artifact of ancestral-state estimation at deeper nodes remains an open question.

- **Independent sex chromosome origins vs. shared ancestral linkage**: The claim of fully independent origins across insect orders rests on comparisons among only four reference genomes. Denser taxon sampling could reveal shared ancestral linkage groups currently obscured by limited coverage.

## Tealc's citation-neighborhood suggestions

- Studies benchmarking RepeatModeler performance on Hymenoptera with varying library completeness would contextualize the unclassified repeat fraction in *Perdita meconis*.
- Comparative surveys of microsatellite content in holocentric lineages (e.g., expanded Hemiptera sampling) would help disentangle centromere architecture effects from clade-specific rate variation.
- Expanded synteny analyses across a broader set of insect orders (e.g., Lepidoptera, Coleoptera, Hemiptera) would sharpen inference about how many times sex chromosomes have been independently recruited from autosomes.
- Simulation studies exploring whether faster microsatellite turnover in monocentric lineages could maintain content equilibrium would address the rate-without-content-difference paradox.

## Related on the Blackmon Lab site

- [Perdita meconis reference genome paper](/knowledge/papers/10_1093_jhered_esad076/)
- [2015b — sex chromosome origins and insect genome structure](/knowledge/papers/2015b/)
- [2020 microsats — microsatellite content and evolution across insects](/knowledge/papers/2020_microsats/)