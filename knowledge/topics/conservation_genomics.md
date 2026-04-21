---
layout: default
title: "Conservation Genomics"
topic_slug: conservation_genomics
last_updated: 2026-04-21T15:36:38.298660+00:00
papers_supporting: [10.1002/ece3.73483]
permalink: /knowledge/topics/conservation_genomics/
---
---
layout: default
title: "Conservation Genomics"
topic_slug: conservation_genomics
last_updated: 2026-04-21T15:33:41.329624+00:00
papers_supporting: [10.1093/jhered/esad076, 10.1002/ece3.73483]
permalink: /knowledge/topics/conservation_genomics/
---
# Conservation Genomics

## Current understanding

Conservation genomics seeks to generate genomic resources for species of concern, enabling population-level analyses, diversity assessment, and informed management decisions. A persistent challenge has been obtaining high-quality reference assemblies for rare, small-bodied, or poorly preserved specimens. Recent advances in long-read sequencing, particularly PacBio HiFi, are substantially lowering these barriers, and the resulting reference genomes are enabling increasingly sophisticated demographic inferences relevant to conservation management.

A compelling illustration of practical assembly from suboptimal material comes from work on *Perdita meconis* (Mojave poppy bee). Schweizer et al. (2024) produced a [327 Mb draft genome with a contig N50 of 17.5 Mb and 95.5% complete Hymenoptera BUSCOs from a single sub-7 mm male specimen](/knowledge/papers/10_1093_jhered_esad076/#finding-1) that had been freeze-killed at −20 °C rather than snap-frozen in liquid nitrogen. As the authors note, "The high quality of this genome is especially impressive given both the very small size of the organism and the fact that the specimen was not preserved under ideal circumstances," underscoring that [HiFi sequencing can succeed under suboptimal field-preservation conditions](/knowledge/papers/10_1093_jhered_esad076/#finding-2). For pollinators and other small invertebrates facing population declines, such assemblies unlock population genomic tools — inference of effective population size, detection of inbreeding, and identification of adaptive variation — that are critical to evidence-based management.

Once a reference genome exists, population-level genomic data can illuminate the demographic history of endangered taxa with remarkable resolution. Work on *Cheirotonus formosanus* (an endemic, endangered long-armed scarab beetle from Taiwan) exemplifies this: [runs-of-homozygosity (ROH) analysis revealed a landscape dominated by short segments (<1 Mbp), with medium-length segments (1–5 Mbp) in some individuals but a total absence of very long ROH (>5 Mbp)](/knowledge/papers/10_1002_ece3_73483/#finding-1). This pattern distinguishes long-term historical restriction of effective population size (Ne) from recent consanguineous mating — a distinction of direct relevance to conservation prioritization. Where long ROH are absent, management concern shifts toward addressing chronic low Ne over generations rather than intervening to prevent immediate inbreeding.

## Supporting evidence

- [Reference genome for the Mojave poppy bee (Perdita meconis), a specialist pollinator of conservation concern., Finding 1](/knowledge/papers/10_1093_jhered_esad076/#finding-1): The *P. meconis* assembly is 327 Mb, contig N50 of 17.5 Mb, 95.5% BUSCO completeness, generated with PacBio HiFi at ~49× coverage from a single male specimen.

- [Reference genome for the Mojave poppy bee (Perdita meconis), a specialist pollinator of conservation concern., Finding 2](/knowledge/papers/10_1093_jhered_esad076/#finding-2): High-quality HiFi genome assembly is achievable from a single small insect preserved at −20 °C rather than −80 °C, demonstrating methodological resilience relevant to field-collected conservation specimens.

- [Chromosome-Level Reference Genome of an Endemic, Endangered Long-Armed Scarab (<i>Cheirotonus formosanus</i>): Discovery of a Putative Y-Linked Scaffold and Demographic History., Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1): ROH analysis of *C. formosanus* shows short segments dominating, medium segments in some individuals, and a complete absence of long (>5 Mbp) ROH — indicating historical low Ne rather than recent inbreeding as the primary source of genomic homozygosity.

## Contradictions / open disagreements

The *P. meconis* study demonstrates successful single-specimen assembly from non-ideally-preserved material, but HiC scaffolding could not be obtained, leaving the assembly at contig level. Dot-plot comparisons against *Andrena* and *Apis* suggest possible misassemblies. It remains unclear how broadly favorable outcomes will generalize across species, body sizes, and storage durations.

For the ROH findings from *C. formosanus*, a key methodological caveat applies: the ROH inference was conducted on reduced-representation ddRAD data (n = 46) rather than whole-genome resequencing. The paper acknowledges that ddRAD likely lacks sufficient coverage to fully exploit linkage information, meaning the observed absence of ROH >5 Mbp could partly reflect data sparsity rather than true demography. Whole-genome resequencing would be needed to confirm the demographic interpretation with confidence.

## Tealc's citation-neighborhood suggestions

Future pages on this topic would benefit from citing studies that formally benchmark PacBio HiFi performance across a gradient of preservation conditions (e.g., museum specimens of varying age), population genomic studies leveraging *Perdita* or related Andrenidae genomes to estimate diversity and demographic history, and comparative ROH analyses in other endangered beetles using whole-genome resequencing to validate the ddRAD-based findings from *C. formosanus*.

## Related on the Blackmon Lab site

- [Paper: Reference genome for the Mojave poppy bee (*Perdita meconis*)](/knowledge/papers/10_1093_jhered_esad076/)
- [Paper: Chromosome-Level Reference Genome of an Endemic, Endangered Long-Armed Scarab (*Cheirotonus formosanus*)](/knowledge/papers/10_1002_ece3_73483/)