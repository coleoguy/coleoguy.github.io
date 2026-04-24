---
layout: default
title: "Selection and drift"
topic_slug: selection_and_drift
last_updated: 2026-04-22T12:45:57.677661+00:00
papers_supporting: [10.1017/s0016672300014051, 10.1371/journal.pgen.1005237, 3780c17c37d408cf1151745b75b70eea040ad4a9fa24b5d3ba4a327fa493df88, f9fb8e258c7b62f338b299e9c6fcbeb81259e1aef5f75ea3c782100d90b4a19c, fa8d0869c6d351d791f46d2b041f9c1589e106dfa4d3f3d2ebbc59e1e3b3d80e]
permalink: /knowledge/topics/selection_and_drift/
category: "Quantitative genetics & epistasis"
---
<!-- tealc:auto-start -->
# Selection and Drift

<!-- tealc:freshness-start -->
<aside class="wiki-freshness" aria-label="Page provenance">
<span class="wf-label">Composed by Tealc</span>
<span class="wf-date">2026-04-22</span>
<span class="wf-dot">·</span>
<span class="wf-sources">5 sources</span>
<span class="wf-dot">·</span>
<span class="wf-review">Last reviewed by Heath: never</span>
</aside>
<!-- tealc:freshness-end -->


## Current understanding

A central question in chromosome evolution is whether changes in chromosome number and structure are driven primarily by natural selection or by genetic drift acting on nearly neutral rearrangements. The drift hypothesis predicts that lineages with smaller effective population sizes (Ne) — where drift is stronger relative to selection — should accumulate chromosomal rearrangements at elevated rates, regardless of the fitness effects of those rearrangements. The selection hypothesis predicts that specific genomic features or allele-frequency conditions will produce detectable, non-random patterns in which rearrangements fix.

Empirical work in Coleoptera provides quantitative clade-level evidence that reduced Ne accelerates karyotype evolution. Across 12 beetle clades, those classified as low-Ne show fusion rates substantially higher than medium- or high-Ne relatives (0.05–0.11 vs. below 0.025 in Polyphaga), and the single low-Ne genus *Calathus* shows fusion rates more than ten times higher than other Adephaga clades ([Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae001/#finding-1)). Wingless Carabidae lineages also show higher fission rates than winged relatives, with a credible interval for the rate difference entirely positive (0.005–0.044) ([Drift drives the evolution 2024, Finding 2](/knowledge/papers/10_1093_jhered_esae001/#finding-2)).

This drift signal extends to mammals. In Carnivora, lineages with small geographic ranges show elevated rates of both chromosome fusions (ΔR = 0.101, 95% CI 0.062–0.141) and fissions (ΔR = 0.163, 95% CI 0.116–0.207), with credible intervals entirely above zero ([Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae025/#finding-1)). The convergence across beetles and mammals strengthens the case that drift is a general engine of karyotype diversification.

Drift can also act at the level of individual chromosome types. In fishes and reptiles, Y chromosomes fuse with autosomes far more often than X chromosomes do. The most parsimonious explanation is that such fusions are slightly deleterious yet arise disproportionately in males due to male-biased mutation rates; the Y chromosome's permanently reduced Ne then allows these weakly deleterious fusions to fix by drift at rates that would be suppressed on autosomes or X chromosomes ([Y fuse? Sex chromosome fusions in fishes and reptiles., Finding 1](/knowledge/papers/10_1371_journal_pgen_1005237/#finding-1)). This is a case where drift does not merely accelerate neutral change — it actively rescues slightly deleterious rearrangements from purifying selection.

Selection also leaves its own signatures, but the conditions under which it can favor particular rearrangements are more restrictive than is often assumed. Charlesworth & Charlesworth (1980) showed formally that a sex-chromosome–autosome fusion is selectively neutral unless alleles at the autosomal locus are maintained at different frequencies in the two sexes — a condition that holds only when sex-specific selection is already operating at that locus ([10.1017/s0016672300014051, Finding 1](/knowledge/papers/10_1017_s0016672300014051/#finding-1)). At the level of individual genomic features, *Aedes aegypti* carries only 5,782 exons flanked by direct repeats versus ~40,000 expected under a random null — roughly 7-fold depletion — indicating purifying selection against direct-repeat configurations that create single-strand annealing (SSA) deletion hazards near coding sequence ([DirectRepeateR: An R package 2025, Finding 1](/knowledge/papers/10_12688_f1000research_170810_1/#finding-1)).

Taken together, the evidence suggests drift and selection are not mutually exclusive: drift dominates large-scale karyotype turnover in low-Ne lineages, can fix slightly deleterious Y-autosome fusions that selection alone would eliminate, and selection acts in parallel to constrain repeat-mediated deletion mechanisms near genes while promoting specific fusions only when stringent allele-frequency conditions are met.

## Supporting evidence

- [Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae001/#finding-1): Low-Ne Polyphaga clades show fusion rates of 0.05–0.11 versus below 0.025 in medium/high-Ne clades; *Calathus* rates are more than ten times higher than other Adephaga clades.
- [Drift drives the evolution 2024, Finding 2](/knowledge/papers/10_1093_jhered_esae001/#finding-2): In Carabidae, wingless lineages have higher fission rates than winged lineages, with a credible interval for the rate difference entirely positive (0.005–0.044).
- [Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae025/#finding-1): In Carnivora, small-range lineages show higher rates of both fusions (ΔR = 0.101, CI 0.062–0.141) and fissions (ΔR = 0.163, CI 0.116–0.207) than large-range lineages.
- [Y fuse? Sex chromosome fusions in fishes and reptiles., Finding 1](/knowledge/papers/10_1371_journal_pgen_1005237/#finding-1): The excess of Y-autosome fusions in fishes and reptiles is best explained by fusions being slightly deleterious, arising more often in males due to male-biased mutation, and fixing on Y chromosomes because their reduced Ne allows drift to overcome purifying selection.
- [DirectRepeateR: An R package 2025, Finding 1](/knowledge/papers/10_12688_f1000research_170810_1/#finding-1): In *A. aegypti*, only 5,782 exons are flanked by direct repeats versus ~40,000 expected by chance, indicating purifying selection against SSA-promoting repeat configurations near coding sequence.
- [10.1017/s0016672300014051, Finding 1](/knowledge/papers/10_1017_s0016672300014051/#finding-1): Selection can favor a sex-chromosome–autosome fusion only when the autosomal locus has alleles maintained at different frequencies in males and females; if allele frequencies are equal across sexes, the fusion is selectively neutral under this model.

## Contradictions / open disagreements

Several methodological and conceptual tensions limit strong causal inference.

In the beetle and carnivore work, Ne is estimated indirectly from proxy traits (winglessness, body size, range size) rather than directly from population genomics, introducing measurement error and potentially conflating correlated ecological variables. The elevated fission rate in wingless Carabidae is also model-dependent, disappearing in a more complex model that incorporates whole-genome duplication ([Drift drives the evolution 2024, Finding 2](/knowledge/papers/10_1093_jhered_esae001/#finding-2)). In Carnivora, neutral trait simulations produced false positive rates of 22–33%, meaning the observed ΔR values must substantially exceed chance before the drift interpretation is secure ([Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae025/#finding-1)).

The Pennell et al. 2015 argument for slightly deleterious Y-autosome fusions depends partly on male-biased mutation rates in fishes and squamate reptiles, but the empirical support for that bias in those lineages is limited — the analysis draws heavily on human translocation data, which may not generalize ([Y fuse? Sex chromosome fusions in fishes and reptiles., Finding 1](/knowledge/papers/10_1371_journal_pgen_1005237/#finding-1)). This leaves open whether the Y-fusion excess is driven by mutation bias, reduced Ne alone, or some interaction of both.

The Charlesworth & Charlesworth (1980) model identifies a precise selection condition for sex-chromosome–autosome fusions, but the authors note that centric fusions likely involve some loss of chromosomal material — making the no-fitness-cost assumption "unlikely to be generally true" — which could eliminate any selective advantage in practice ([10.1017/s0016672300014051, Finding 1](/knowledge/papers/10_1017_s0016672300014051/#finding-1)). If intrinsic fitness costs are common, the boundary between "neutral drift" and "selected fusion" becomes harder to locate empirically, and it becomes even more plausible that slightly deleterious fusions fix via drift rather than selection.

The *A. aegypti* direct-repeat depletion finding demonstrates that selection can powerfully shape the repeat landscape near genes, but the analysis is limited to a single species and uses a Monte Carlo null that does not fully control for GC content, chromatin accessibility, or recombination landscape ([DirectRepeateR: An R package 2025, Finding 1](/knowledge/papers/10_12688_f1000research_170810_1/#finding-1)). Whether this depletion generalizes to the same lineages where drift signatures are strongest remains untested.

Across all systems, a deeper ambiguity persists: observed patterns are consistent with drift on neutral rearrangements, selection on weakly deleterious ones, or a mixture. Distinguishing these scenarios requires direct Ne estimates and population-genetic modeling of fixation probabilities.

## Tealc's citation-neighborhood suggestions

- Studies directly estimating Ne in beetle and carnivore populations using population-genomic methods would validate or replace proxy-trait classification schemes.
- Direct measurement of male-biased mutation rates in fishes and squamate reptiles would test a key assumption underlying the Y-fusion excess explanation in Pennell et al. 2015.
- Comparative analyses of direct-repeat depletion near exons across multiple species with known Ne variation would test whether selection strength on SSA-mediated hazards tracks Ne as drift theory predicts.
- Theoretical work on fixation probability of chromosomal rearrangements under varying Ne (e.g., Lynch et al. mutational hazard models) would help assess whether observed rate ratios match drift predictions quantitatively.
- Empirical tests for sex-differential allele frequencies at autosomal loci adjacent to sex-chromosome–autosome fusions would evaluate the Charlesworth & Charlesworth selection condition directly.
- Comparative analyses in Lepidoptera, Hymenoptera, or primates could further test the generality of the drift signal.

## Related on the Blackmon Lab site

- [Drift drives the evolution 2024](/knowledge/papers/10_1093_jhered_esae001/) — beetle karyotype evolution and Ne proxies.
- [Drift drives the evolution 2024](/knowledge/papers/10_1093_jhered_esae025/) — Carnivora karyotype evolution findings.
- [Y fuse? Sex chromosome fusions in fishes and reptiles. 2015](/knowledge/papers/10_1371_journal_pgen_1005237/) — Y-chromosome Ne, male-biased mutation, and slightly deleterious fusion excess in vertebrates.
- [DirectRepeateR: An R package 2025](/knowledge/papers/10_12688_f1000research_170810_1/) — direct-repeat depletion near exons in *A. aegypti*.
- [Charlesworth & Charlesworth 1980](/knowledge/papers/10_1017_s0016672300014051/) — theoretical conditions for selection on sex-chromosome–autosome fusions.
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
## Related topics on this site

- [Chromosome number evolution](/knowledge/topics/chromosome_number_evolution/) — 2 shared papers
- [Karyotype evolution overview](/knowledge/topics/karyotype_evolution_overview/) — 2 shared papers
<!-- tealc:related-end -->
