---
layout: default
title: "Conservation Genomics"
topic_slug: conservation_genomics
last_updated: 2026-04-21T19:10:34.295972+00:00
papers_supporting: [10.1002/ece3.73483, 10.1093/jhered/esad076, 31776037050f6b89b93887fa1b80196fd30073325900b9b38adb091f0516948d]
permalink: /knowledge/topics/conservation_genomics/
category: "Population genetics"
---
<!-- tealc:auto-start -->
# Conservation Genomics

## Current understanding

Conservation genomics increasingly relies on high-quality reference assemblies to understand population structure, local adaptation, and extinction risk in rare or declining taxa. A key challenge has been obtaining such assemblies from species that are difficult to sample in large numbers or under ideal conditions — particularly small-bodied invertebrates like specialist bees and endemic beetles, which are both ecologically critical and acutely threatened by habitat loss and climate change. Beyond assembly quality, a second front in conservation genomics involves the interpretation of genomic homozygosity patterns to reconstruct demographic history and assess inbreeding risk — distinguishing whether elevated homozygosity reflects ancient population restriction or recent consanguineous mating within contemporary demes.

Recent work across three invertebrate systems demonstrates that chromosome-scale reference genomes are now achievable even under significant practical or taxonomic constraints. The *Perdita meconis* (Mojave poppy bee) assembly is 327 Mb with a contig N50 of 17.5 Mb and 95.5% complete Hymenoptera BUSCOs, generated from a single male specimen using PacBio HiFi — [Schweizer et al. 2024, Finding 1](/knowledge/papers/10_1093_jhered_esad076/#finding-1). The endangered long-armed scarab *Cheirotonus formosanus* has a chromosome-level assembly that anchors demographic inference via ROH analysis — [Chien et al. 2026, Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1). And now the jewel scarab *Chrysina gloriosa* adds a third data point: a chromosome-level assembly spanning 642 MB across 454 scaffolds, with the 10 largest scaffolds capturing 98% of the genome, a scaffold N50 of 72 MB, and a BUSCO score of 95.5% — [A reference quality genome 2024, Finding 1](/knowledge/papers/2024_chrysina/#finding-1). Together, these cases establish that chromosome-scale quality is within reach for conservation-relevant scarabid beetles and hymenopteran pollinators alike.

## Supporting evidence

A practically important result for conservation genomics workflows is that high-quality assemblies can be produced from specimens stored under non-ideal conditions. The *Perdita meconis* genome was assembled from a specimen not snap-frozen but stored at −20 °C — conditions common to field collections and museum repositories. As noted, "The high quality of this genome is especially impressive given both the very small size of the organism and the fact that the specimen was not preserved under ideal circumstances (i.e. not snap frozen, stored at −20 °C rather than −80 °C)" — [Schweizer et al. 2024, Finding 2](/knowledge/papers/10_1093_jhered_esad076/#finding-2). This finding expands the practical reach of reference-quality sequencing to taxa where ideal cryopreservation is logistically impossible.

The *Chrysina gloriosa* assembly further illustrates what is achievable in scarabid beetles: "Our genome assembly consisted of 454 scaffolds spanning 642 MB, with the 10 largest scaffolds capturing 98% of the genome. The scaffold N50 was 72 MB, and the BUSCO score was 95.5%" — [A reference quality genome 2024, Finding 1](/knowledge/papers/2024_chrysina/#finding-1). As the first chromosome-level reference for the genus *Chrysina*, this assembly provides a scaffold for future population genomic and comparative studies across the roughly 160 species in this group, many of which face collection pressure and habitat loss.

ROH analysis provides a complementary lens for assessing conservation status. Work on *C. formosanus* shows that ROH length distributions can separate historical demographic signals from recent inbreeding: analysis revealed "a landscape dominated by short segments (< 1 Mbp), a pattern characteristic of historical bottlenecks or long-term persistence at a low ancestral Ne," with the "total absence of very long segments (> 5 Mbp)" across the dataset — [Chien et al. 2026, Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1). This implicates long-term historical reduction in effective population size as the primary driver of genomic homozygosity — a distinction with direct management implications.

## Contradictions / open disagreements

The *Perdita meconis* assembly remains at contig rather than true chromosome-scale because Hi-C-compatible tissue could not be obtained from the same specimen, and dot-plot comparisons against *Andrena* and *Apis* reveal structural rearrangements that may reflect real biology or assembly artifacts.

For *C. formosanus*, a meaningful caveat exists: the ROH inference rests on reduced-representation ddRAD data (n = 46 individuals) rather than whole-genome resequencing. The absence of segments >5 Mbp could partly reflect data sparsity rather than true demography.

The *Chrysina gloriosa* assembly spans only ~75% of the flow-cytometry-estimated genome size (850 MB), with the paper acknowledging that the shortfall likely reflects unassembled repetitive content. The assembly is also derived from a single female specimen, so structural variation across individuals and populations remains uncaptured. These three cases together highlight a recurring tension in conservation genomics: the taxa most urgently in need of genomic tools are often those for which data collection remains most constrained.

## Tealc's citation-neighborhood suggestions

The Blackmon Lab may wish to engage with the growing Earth BioGenome Project literature on minimum-viable genome quality standards for conservation use, population-level resequencing studies in rare Apidae that use reference assemblies as scaffolds for demographic inference, comparative ROH studies using whole-genome resequencing in scarabid beetles to validate ddRAD-derived findings, and broader phylogenomic work on Chrysina to contextualize the new reference assembly within the genus.

## Related on the Blackmon Lab site

- [Schweizer et al. 2024](/knowledge/papers/10_1093_jhered_esad076/)
- [Chien et al. 2026](/knowledge/papers/10_1002_ece3_73483/)
- [A reference quality genome 2024](/knowledge/papers/2024_chrysina/)
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
## Related topics on this site

- [Coleoptera genomics](/knowledge/topics/coleoptera_genomics/) — 2 shared papers
- [Genome Assembly](/knowledge/topics/genome_assembly/) — 2 shared papers
<!-- tealc:related-end -->
