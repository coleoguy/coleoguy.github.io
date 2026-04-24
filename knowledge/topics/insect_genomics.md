---
layout: default
title: "Insect Genomics"
topic_slug: insect_genomics
last_updated: 2026-04-22T13:35:29.736668+00:00
papers_supporting: [10.1007/978-1-4939-8775-7_2, e886b99fe0f9dcc1f5682cefed91eaf32c1cf8360d4865524975c201c00fd035]
permalink: /knowledge/topics/insect_genomics/
category: "Insects & Coleoptera"
---
<!-- tealc:auto-start -->
# Insect Genomics

<!-- tealc:freshness-start -->
<aside class="wiki-freshness" aria-label="Page provenance">
<span class="wf-label">Composed by Tealc</span>
<span class="wf-date">2026-04-22</span>
<span class="wf-dot">·</span>
<span class="wf-sources">2 sources</span>
<span class="wf-dot">·</span>
<span class="wf-review">Last reviewed by Heath: never</span>
</aside>
<!-- tealc:freshness-end -->


## Current understanding

Insect genomes vary substantially in their repeat-element dynamics, and centromere architecture appears to be one axis along which this variation is structured. Species with **monocentric chromosomes** (centromere localized to a discrete region) evolve microsatellites at higher rates than species with **holocentric chromosomes** (centromere activity distributed along the chromosome), even though both chromosome types harbor similar total microsatellite content. This decoupling of *rate* from *content* suggests that centromere type shapes the tempo of genome change rather than the equilibrium amount of repetitive sequence present at any given time.

The phylogenetic signal for this rate difference is strong — 99 of 100 posterior distribution trees favored a two-rate model over a single-rate model — but the biological interpretation requires caution. Much of the monocentric rate signal is concentrated in Diptera and Hymenoptera, while Coleoptera (also monocentric) actually shows the lowest microsatellite evolution rate of any insect order in the dataset. This pattern echoes BiSSE false-positive inflation, where a small, rate-elevated clade can make any binary trait mapped onto it appear causally linked to high rates. Monocentricity per se may therefore not be the mechanistic driver; order- or lineage-specific features are equally plausible proximate causes.

A separate but equally important issue sits upstream of any comparative analysis: how accurately can we measure insect genome sizes in the first place? Flow cytometry is the standard approach, but it carries a taxon-specific pitfall that is easy to overlook. Chromatin staining saturation is slower in large-genome insects, and if the sample and the internal standard are not allowed to reach saturation together, the apparent genome size of the focal species can increase by 10% or more over the course of a single experiment. This is not a fixed error that can be corrected post-hoc; it depends on the specific species, strain, and staining duration used. Running samples and standards at multiple time points — and reporting only saturation-plateau values — is the only reliable safeguard. Published genome size databases that include large-genome taxa without this control should be read accordingly.

## Supporting evidence

The core comparative finding on microsatellite evolution rates comes from [Jonika et al. 2020, Finding 1](/knowledge/papers/10_3390_genes11080945/#finding-1), which reports that phylogenetic model comparison strongly supports distinct microsatellite evolution rates in monocentric versus holocentric insect lineages, with monocentric lineages consistently showing higher rates across the sampled posterior distribution of trees.

The staining-saturation finding comes from [10.1007/978-1-4939-8775-7_2, Finding 1](/knowledge/papers/10_1007_978_1_4939_8775_7_2/#finding-1), a methods chapter documenting that optimal stain saturation time varies between species and between strains of the same species, and that estimates for large-genome insects like *Aedes* can increase by 10% or more between 20 minutes and 4 hours of staining if saturation is not confirmed before scoring.

## Contradictions / open disagreements

The main internal tension in the microsatellite evidence is between the **phylogenetic rate signal** (monocentric > holocentric) and the **within-monocentric variation** (Coleoptera is the slowest order despite being monocentric). The authors of the 2020 microsats study explicitly flag this as a potential confound analogous to BiSSE false positives. The existing evidence does not establish monocentricity as a *causal* driver of elevated microsatellite evolution — it remains a correlated trait that tracks with high-rate lineages in the current dataset.

On the genome size measurement side, the 10% inflation figure for *Aedes* is presented as an illustrative example in a protocols chapter without replicate data or variance estimates. The claim that optimal saturation time varies between strains of the same species is supported by *Drosophila melanogaster* DSPR strain data relative to *D. virilis* as a standard — a between-species comparison rather than a pure within-species genome size difference. These two phenomena (strain-level genome size variation and time-point inflation) are distinct but conflated in some readings of the source material.

## Tealc's citation-neighborhood suggestions

- Studies examining recombination rate variation and microsatellite instability across insect orders could help disentangle order-level effects from centromere-type effects.
- Comparative genomic work specifically within Coleoptera (to explain why this monocentric order bucks the trend) would be informative.
- Papers on holocentric chromosome biology in Lepidoptera or Hemiptera that include repeat-element dynamics would provide direct contrast cases.
- Validation studies comparing flow cytometric genome size estimates with assembly-based estimates across large-genome taxa would directly quantify how much staining-protocol variation affects published databases.

## Related on the Blackmon Lab site

- [Jonika et al. 2020](/knowledge/papers/10_3390_genes11080945/)
- [10.1007/978-1-4939-8775-7_2](/knowledge/papers/10_1007_978_1_4939_8775_7_2/)
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
<!-- tealc:related-end -->
