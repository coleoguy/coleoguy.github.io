---
layout: default
title: "Conservation Genomics"
topic_slug: conservation_genomics
last_updated: 2026-04-21T16:01:53.554400+00:00
papers_supporting: [10.1002/ece3.73483, 10.1093/jhered/esad076]
permalink: /knowledge/topics/conservation_genomics/
---
# Conservation Genomics

## Current understanding

Conservation genomics increasingly relies on high-quality reference assemblies to understand population structure, local adaptation, and extinction risk in rare or declining taxa. A key challenge has been obtaining such assemblies from species that are difficult to sample in large numbers or under ideal conditions — particularly small-bodied invertebrates like specialist bees and endemic beetles, which are both ecologically critical and acutely threatened by habitat loss and climate change. Beyond assembly quality, a second front in conservation genomics involves the interpretation of genomic homozygosity patterns to reconstruct demographic history and assess inbreeding risk — distinguishing whether elevated homozygosity reflects ancient population restriction or recent consanguineous mating within contemporary demes.

Recent work on *Perdita meconis*, the Mojave poppy bee, demonstrates that a chromosome-scale-quality draft genome is now achievable even under significant practical constraints. The assembly is 327 Mb with a contig N50 of 17.5 Mb and 95.5% complete Hymenoptera BUSCOs, generated from a single male specimen using PacBio HiFi sequencing — see [Reference genome for the Mojave poppy bee (Perdita meconis), a specialist pollinator of conservation concern., Finding 1](/knowledge/papers/10_1093_jhered_esad076/#finding-1). This level of completeness positions the assembly as a usable reference for downstream population genomic and comparative genomic studies within the family Andrenidae.

## Supporting evidence

Perhaps the most practically important result for conservation genomics workflows is that high-quality assemblies can be produced from specimens stored under non-ideal conditions. The *Perdita meconis* genome was assembled from a specimen not snap-frozen but instead stored at −20 °C — conditions common to field collections and museum repositories. As the source paper notes, "The high quality of this genome is especially impressive given both the very small size of the organism and the fact that the specimen was not preserved under ideal circumstances (i.e. not snap frozen, stored at −20 °C rather than −80 °C)" — [Reference genome for the Mojave poppy bee (Perdita meconis), a specialist pollinator of conservation concern., Finding 2](/knowledge/papers/10_1093_jhered_esad076/#finding-2). This finding expands the practical reach of reference-quality sequencing to taxa where ideal cryopreservation is logistically impossible.

ROH analysis provides a complementary lens for assessing conservation status. Work on the endemic, endangered long-armed scarab *Cheirotonus formosanus* shows that ROH length distributions can separate historical demographic signals from recent inbreeding: analysis revealed "a landscape dominated by short segments (< 1 Mbp), a pattern characteristic of historical bottlenecks or long-term persistence at a low ancestral Ne," with medium-length segments (1–5 Mbp) appearing in some individuals but a "total absence of very long segments (> 5 Mbp)" across the dataset — [Chromosome-Level Reference Genome of an Endemic, Endangered Long-Armed Scarab (<i>Cheirotonus formosanus</i>): Discovery of a Putative Y-Linked Scaffold and Demographic History., Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1). This pattern implicates long-term historical reduction in effective population size as the primary driver of genomic homozygosity, rather than ongoing consanguineous mating — a distinction with direct management implications.

## Contradictions / open disagreements

The *Perdita meconis* assembly is impressive but remains at contig level rather than true chromosome-scale because Hi-C-compatible tissue could not be obtained from the same specimen. Dot-plot comparisons against *Andrena* and *Apis* reveal structural rearrangements that may reflect real biology or assembly artifacts — a limitation the authors acknowledge. A single successful case also does not establish that −20 °C preservation will consistently yield HiFi-grade DNA across species of varying body size, tissue composition, or storage duration.

For the *C. formosanus* ROH results, a meaningful caveat exists: the inference rests on reduced-representation ddRAD data (n = 46 individuals) rather than whole-genome resequencing. The paper acknowledges that ddRAD datasets likely lack sufficient marker density and linkage information to reliably detect long ROH, meaning the observed absence of segments >5 Mbp could partly reflect data sparsity rather than true demography. These two cases together highlight a recurring tension in conservation genomics: the taxa most urgently in need of genomic tools are often those for which data collection remains most constrained.

## Tealc's citation-neighborhood suggestions

The Blackmon Lab may wish to engage with the growing Earth BioGenome Project literature on minimum-viable genome quality standards for conservation use, population-level re-sequencing studies in rare Apidae that use reference assemblies as scaffolds for demographic inference, and comparative ROH studies using whole-genome resequencing in scarabid beetles to validate the ddRAD-derived findings in *C. formosanus*.

## Related on the Blackmon Lab site

- [Perdita meconis reference genome paper](/knowledge/papers/10_1093_jhered_esad076/)
- [Cheirotonus formosanus chromosome-level genome paper](/knowledge/papers/10_1002_ece3_73483/)