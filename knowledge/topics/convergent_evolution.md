---
layout: default
title: "Convergent Evolution"
topic_slug: convergent_evolution
last_updated: 2026-04-21T18:54:48.791282+00:00
papers_supporting: [74e7bc680605ee2207a1f5cf31811de0fef84fed56357b0bbe6d6ba1443f9925]
permalink: /knowledge/topics/convergent_evolution/
category: "Speciation & macroevolution"
---
<!-- tealc:lead-start -->
<div class="wiki-lead" data-active="researcher">
<div data-register="researcher" markdown="1">

Convergent evolution — the independent origin of similar traits in separate lineages — is one of the central puzzles in evolutionary biology. A key question is whether convergence at the phenotypic level is underlain by convergence at the molecular or genomic level. Answering this question requires tools and frameworks that can simultaneously interrogate multiple independent populations or lineages and identify loci whose evolutionary signals (e.g., elevated differentiation, altered expression) recur across all comparisons.

The Mexican cavefish *Astyanax mexicanus* has become a premier system for studying convergent evolution because multiple geographically distinct cave populations (e.g., Pachón, Molino, Tinaja) have independently evolved overlapping suites of traits — including eye reduction, pigment loss, and altered circadian rhythms — from surface-dwelling ancestors. By treating each cave-versus-surface population pair as a replicate, researchers can screen for genomic and transcriptomic signatures that appear in all replicates, providing statistical evidence of convergent molecular evolution rather than shared ancestry.

A bioinformatic approach demonstrated in the CaveCrawler tool exploits exactly this logic: candidate genes are flagged as "double outliers" when they appear as FST outliers (unusually low divergence relative to surface fish) *and* are differentially expressed in the phenotype of interest across every cave-surface comparison tested. Applying this framework to circadian regulation, [Perry et al. 2022, Finding 1](/knowledge/papers/10_1093_g3journal_jkac132/#finding-1) identified *arpin* — a negative regulator of actin dynamics — as a double outlier in all three Pachón, Molino, and Tinaja versus Río Choy surface fish comparisons. This makes *arpin* a high-priority candidate for functional investigation into how actin regulation might interface with circadian or behavioral evolution in cave environments.

It is important to note that this identification is correlative: neither the FST outlier threshold nor the expression dataset has been experimentally validated to confirm *arpin*'s causal role in cavefish phenotypes. The finding is best understood as a proof-of-principle for convergence-screening methodology rather than a definitive mechanistic claim.

</div>
<div data-register="student" markdown="1">

<div class="wiki-lead" data-active="student">
<div data-register="student" markdown="1">

When animals evolve in similar environments, they often develop similar traits — a pattern called [convergent evolution](/knowledge/concepts/convergent-evolution/). But do they reach these traits by the same genetic and molecular paths, or do they take completely different routes at the DNA level? Scientists studying the Mexican cavefish *Astyanax mexicanus* are using this question to test whether [convergence](/knowledge/concepts/convergent-evolution/) happens the same way at multiple levels of biology.

Multiple cave populations — such as Pachón, Molino, and Tinaja — have independently evolved the same suite of changes from their surface-dwelling ancestors: they lost their eyes, lost their pigmentation, and changed their daily activity patterns. By comparing each cave population to surface fish separately, researchers can act like they're running the same experiment three times over. If the same genes show unusual [genetic signatures](/knowledge/concepts/genetic-signatures/) or expression patterns across all three cave-surface comparisons, that's strong evidence the changes evolved the same way more than once.

A tool called CaveCrawler applies this logic by finding genes that are "double outliers" — they show unusually low genetic differentiation *and* altered expression in the trait being studied, across every comparison. When researchers screened circadian-rhythm genes this way, [Perry et al. 2022, Finding 1](/knowledge/papers/10_1093_g3journal_jkac132/#finding-1) found that *arpin*, a gene controlling actin (a protein that shapes cell structure), qualified as a double outlier in all three Pachón, Molino, and Tinaja comparisons. This makes *arpin* a strong candidate for lab experiments to test whether it actually causes the circadian changes in cave fish.

However, this is correlation, not proof. The finding shows the method works, but *arpin*'s actual role in cave evolution still needs experimental confirmation.

</div>
</div>

</div>
</div>
<!-- tealc:lead-end -->

<!-- tealc:auto-start -->
# Convergent Evolution

<!-- tealc:freshness-start -->
<aside class="wiki-freshness" aria-label="Page provenance">
<span class="wf-label">Composed by Tealc</span>
<span class="wf-date">2026-04-21</span>
<span class="wf-dot">·</span>
<span class="wf-sources">1 source</span>
<span class="wf-dot">·</span>
<span class="wf-review">Last reviewed by Heath: never</span>
</aside>
<!-- tealc:freshness-end -->


## Current understanding

Convergent evolution — the independent origin of similar traits in separate lineages — is one of the central puzzles in evolutionary biology. A key question is whether convergence at the phenotypic level is underlain by convergence at the molecular or genomic level. Answering this question requires tools and frameworks that can simultaneously interrogate multiple independent populations or lineages and identify loci whose evolutionary signals (e.g., elevated differentiation, altered expression) recur across all comparisons.

The Mexican cavefish *Astyanax mexicanus* has become a premier system for studying convergent evolution because multiple geographically distinct cave populations (e.g., Pachón, Molino, Tinaja) have independently evolved overlapping suites of traits — including eye reduction, pigment loss, and altered circadian rhythms — from surface-dwelling ancestors. By treating each cave-versus-surface population pair as a replicate, researchers can screen for genomic and transcriptomic signatures that appear in all replicates, providing statistical evidence of convergent molecular evolution rather than shared ancestry.

A bioinformatic approach demonstrated in the CaveCrawler tool exploits exactly this logic: candidate genes are flagged as "double outliers" when they appear as FST outliers (unusually low divergence relative to surface fish) *and* are differentially expressed in the phenotype of interest across every cave-surface comparison tested. Applying this framework to circadian regulation, [Perry et al. 2022, Finding 1](/knowledge/papers/10_1093_g3journal_jkac132/#finding-1) identified *arpin* — a negative regulator of actin dynamics — as a double outlier in all three Pachón, Molino, and Tinaja versus Río Choy surface fish comparisons. This makes *arpin* a high-priority candidate for functional investigation into how actin regulation might interface with circadian or behavioral evolution in cave environments.

It is important to note that this identification is correlative: neither the FST outlier threshold nor the expression dataset has been experimentally validated to confirm *arpin*'s causal role in cavefish phenotypes. The finding is best understood as a proof-of-principle for convergence-screening methodology rather than a definitive mechanistic claim.

## Supporting evidence

- [Perry et al. 2022, Finding 1](/knowledge/papers/10_1093_g3journal_jkac132/#finding-1): *arpin*, a negative regulator of actin, was identified as both an FST outlier and differentially expressed in circadian regulation across all three independent cave population comparisons (Pachón, Molino, and Tinaja vs. Río Choy surface fish), making it a candidate gene for convergent molecular evolution in cavefish.

## Contradictions / open disagreements

The convergence inference rests on FST outliers defined at the lowest 5% divergence threshold and a single circadian transcription dataset (Mack et al. 2021). Altering either the divergence threshold or the expression dataset could change which genes qualify as double outliers. More fundamentally, because all three cave populations belong to the same species and may share some ancestral standing variation, it remains debated whether recurrence across these populations constitutes *independent* convergence in the strict sense, or partial sharing of pre-existing alleles. No functional validation of *arpin*'s role in cavefish circadian or actin phenotypes has been reported, leaving the biological inference correlative.

## Tealc's citation-neighborhood suggestions

- Studies functionally characterizing *arpin* in actin dynamics and cell motility (e.g., Dang et al. 2013 *Nature*) could contextualize why this gene might be a target of selection in cave environments.
- Work on the population genetics of *Astyanax mexicanus* cave populations (e.g., Herman et al. 2018) is foundational to interpreting FST-based outlier analyses and should be read alongside convergence claims.
- Broader comparative genomics studies of convergent evolution (e.g., in Heliconius butterflies or cichlid fishes) offer useful benchmarks for what molecular convergence looks like at scale.

## Related on the Blackmon Lab site

- [Perry et al. 2022](/knowledge/papers/10_1093_g3journal_jkac132/)
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
<!-- tealc:related-end -->
