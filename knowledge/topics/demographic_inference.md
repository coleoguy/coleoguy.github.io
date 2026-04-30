---
layout: default
title: "Demographic Inference"
topic_slug: demographic_inference
last_updated: 2026-04-21T15:54:51.025773+00:00
papers_supporting: [10.1002/ece3.73483]
permalink: /knowledge/topics/demographic_inference/
category: "Population genetics"
editor_frozen: true
---
<!-- tealc:lead-start -->
<div class="wiki-lead" data-active="researcher">
<div data-register="researcher" markdown="1">

Demographic inference from genomic data allows researchers to reconstruct the population history of species — including shifts in effective population size (Ne), bottlenecks, and patterns of inbreeding — even when sampling is limited to a handful of individuals or a single genome. Two complementary approaches are increasingly applied in conservation genomics of non-model organisms: pairwise sequentially Markovian coalescent (PSMC) analysis of whole-genome heterozygosity, and runs-of-homozygosity (ROH) analysis to decompose ancient versus recent reductions in Ne.

A key methodological question is whether PSMC trajectories are robust across sequencing platforms and between sexes. Work on the endangered *Cheirotonus formosanus* (long-armed scarab) provides direct evidence that they are: [Chien et al. 2026, Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1) showed that PSMC trajectories reconstructed from independently sequenced male (PacBio HiFi) and female (Illumina) genomes are nearly identical, with overlapping bootstrap intervals. This platform-agnosticism is practically important for conservation programs where only opportunistically collected samples may be available.

ROH analysis offers a complementary temporal lens. In *C. formosanus*, the ROH landscape is dominated by short segments (<1 Mbp), with medium-length segments (1–5 Mbp) present in some individuals but a complete absence of very long segments (>5 Mbp). As documented in [Chien et al. 2026, Finding 2](/knowledge/papers/10_1002_ece3_73483/#finding-2), this pattern is characteristic of historical bottlenecks or long-term persistence at low ancestral Ne, rather than recent consanguineous mating. The medium-length segments hint at localized recent inbreeding within demes, adding resolution that PSMC alone — which cannot reliably address the last ~10 kya — cannot provide.

Together, these two approaches illustrate a general principle: short ROH diagnose ancient demographic restriction, long ROH diagnose recent inbreeding, and PSMC captures broad multi-generational trends. Their concordance in a single endangered beetle provides a useful proof-of-concept for applying multi-method demographic inference to non-model invertebrates with limited genomic resources.

</div>
<div data-register="student" markdown="1">

<div class="wiki-lead" data-active="student">
<div data-register="student" markdown="1">

Scientists can piece together the population history of species by studying their genomes — even when they have only a few DNA samples to work with. They can figure out how many individuals lived in a population at different times in the past, spot population crashes, and detect inbreeding. Two methods work especially well for conservation of rare animals: pairwise sequentially Markovian coalescent (PSMC) analysis, which looks at genetic diversity within a single genome, and runs-of-homozygosity (ROH) analysis, which finds stretches of DNA where both copies are identical.

A practical question for scientists is whether these methods give the same answer regardless of how the DNA was sequenced or whether it came from a male or female. [Chien et al. 2026, Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1) tested this using an endangered beetle called the long-armed scarab (*Cheirotonus formosanus*). They sequenced a male's genome using one technology (PacBio HiFi) and a female's genome using another (Illumina), then ran PSMC on both. The results were nearly identical — the population-history curves overlapped almost perfectly. This is good news for conservation work, where scientists often have to use whatever DNA samples they can find.

ROH analysis adds a second perspective. In *C. formosanus*, most homozygous stretches were short (less than 1 million base pairs), some were medium-sized (1–5 million base pairs), but none were very long (over 5 million base pairs). [Chien et al. 2026, Finding 2](/knowledge/papers/10_1002_ece3_73483/#finding-2) showed this pattern points to an ancient population crash or centuries of low population size, not recent inbreeding. The medium-length segments hint at some recent inbreeding within isolated local groups. Together, PSMC and ROH tell complementary stories: short stretches reveal ancient bottlenecks, long stretches reveal recent inbreeding, and PSMC shows broad population trends over many generations.

</div>
</div>

</div>
</div>
<!-- tealc:lead-end -->

<!-- tealc:auto-start -->
# Demographic Inference

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

Demographic inference from genomic data allows researchers to reconstruct the population history of species — including shifts in effective population size (Ne), bottlenecks, and patterns of inbreeding — even when sampling is limited to a handful of individuals or a single genome. Two complementary approaches are increasingly applied in conservation genomics of non-model organisms: pairwise sequentially Markovian coalescent (PSMC) analysis of whole-genome heterozygosity, and runs-of-homozygosity (ROH) analysis to decompose ancient versus recent reductions in Ne.

A key methodological question is whether PSMC trajectories are robust across sequencing platforms and between sexes. Work on the endangered *Cheirotonus formosanus* (long-armed scarab) provides direct evidence that they are: [Chien et al. 2026, Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1) showed that PSMC trajectories reconstructed from independently sequenced male (PacBio HiFi) and female (Illumina) genomes are nearly identical, with overlapping bootstrap intervals. This platform-agnosticism is practically important for conservation programs where only opportunistically collected samples may be available.

ROH analysis offers a complementary temporal lens. In *C. formosanus*, the ROH landscape is dominated by short segments (<1 Mbp), with medium-length segments (1–5 Mbp) present in some individuals but a complete absence of very long segments (>5 Mbp). As documented in [Chien et al. 2026, Finding 2](/knowledge/papers/10_1002_ece3_73483/#finding-2), this pattern is characteristic of historical bottlenecks or long-term persistence at low ancestral Ne, rather than recent consanguineous mating. The medium-length segments hint at localized recent inbreeding within demes, adding resolution that PSMC alone — which cannot reliably address the last ~10 kya — cannot provide.

Together, these two approaches illustrate a general principle: short ROH diagnose ancient demographic restriction, long ROH diagnose recent inbreeding, and PSMC captures broad multi-generational trends. Their concordance in a single endangered beetle provides a useful proof-of-concept for applying multi-method demographic inference to non-model invertebrates with limited genomic resources.

## Supporting evidence

- **PSMC platform concordance:** [Chien et al. 2026, Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1) — PSMC trajectories from one PacBio HiFi male and one Illumina female *C. formosanus* genome are nearly identical with overlapping bootstrap intervals.

- **ROH length distribution as a demographic signature:** [Chien et al. 2026, Finding 2](/knowledge/papers/10_1002_ece3_73483/#finding-2) — A genome dominated by short ROH and lacking segments >5 Mbp points to long-term historical low Ne rather than recent consanguineous mating in this endangered species.

## Contradictions / open disagreements

**Platform concordance sample size:** The PSMC comparison rests on n=2 genomes (one individual per sex, one per platform) from a single endemic population. This is a weak test; broader sampling across populations or species is needed before platform-agnosticism can be treated as a general rule.

**ROH inference data quality:** The ROH analysis used reduced-representation ddRAD data (n=46 individuals) rather than whole-genome resequencing. The paper acknowledges that ddRAD likely lacks sufficient coverage to fully exploit linkage information, meaning the absence of segments >5 Mbp could partly reflect data sparsity rather than true demographic history. Whole-genome resequencing of the same individuals would be needed to confirm this signal.

## Tealc's citation-neighborhood suggestions

- Li & Durbin (2011) *Inference of human population history from individual whole-genome sequences* — the original PSMC paper; useful to cite explicitly when validating the method in non-model organisms.
- Kardos et al. (2018) work on ROH and inbreeding depression — provides the theoretical framework for interpreting ROH length categories in conservation contexts.

## Related on the Blackmon Lab site

- [Chien et al. 2026](/knowledge/papers/10_1002_ece3_73483/)
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
<!-- tealc:related-end -->
