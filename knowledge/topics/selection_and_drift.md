---
layout: default
title: "Selection and drift"
topic_slug: selection_and_drift
last_updated: 2026-04-21T20:47:25.179723+00:00
papers_supporting: [3780c17c37d408cf1151745b75b70eea040ad4a9fa24b5d3ba4a327fa493df88, f9fb8e258c7b62f338b299e9c6fcbeb81259e1aef5f75ea3c782100d90b4a19c, fa8d0869c6d351d791f46d2b041f9c1589e106dfa4d3f3d2ebbc59e1e3b3d80e]
category: "Quantitative genetics & epistasis"
permalink: /knowledge/topics/selection_and_drift/
---
<!-- tealc:auto-start -->
# Selection and Drift

## Current understanding

A central question in chromosome evolution is whether changes in chromosome number and structure are driven primarily by natural selection or by genetic drift acting on nearly neutral rearrangements. The drift hypothesis predicts that lineages with smaller effective population sizes (Ne) — where drift is stronger relative to selection — should accumulate chromosomal rearrangements at elevated rates, regardless of the fitness effects of those rearrangements. The selection hypothesis, by contrast, predicts that specific genomic features (such as repeat-mediated mutational hazards near coding sequence) will be actively purged, leaving a signature of depletion rather than random accumulation.

Empirical work in Coleoptera provides quantitative clade-level evidence that reduced Ne accelerates karyotype evolution. Across 12 beetle clades, those classified as low-Ne show fusion rates substantially higher than medium- or high-Ne relatives (0.05–0.11 vs. below 0.025 in Polyphaga), and the single low-Ne genus *Calathus* shows fusion rates more than ten times higher than other Adephaga clades ([Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae001/#finding-1)). Wingless Carabidae lineages also show higher fission rates than winged relatives, with a credible interval for the rate difference entirely positive (0.005–0.044) ([Drift drives the evolution 2024, Finding 2](/knowledge/papers/10_1093_jhered_esae001/#finding-2)).

This drift signal is not confined to insects. In Carnivora, lineages with small geographic ranges show elevated rates of both chromosome fusions (ΔR = 0.101, 95% CI 0.062–0.141) and fissions (ΔR = 0.163, 95% CI 0.116–0.207), with credible intervals entirely above zero ([Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae025/#finding-1)). The convergence across beetles and mammals strengthens the case that drift is a general engine of karyotype diversification.

Yet selection also leaves its own genomic signature. In *Aedes aegypti*, only 5,782 of 80,498 exons are flanked by direct repeats — roughly 7-fold fewer than the ~40,000 expected under a random null model — indicating strong purifying selection against direct-repeat configurations near protein-coding sequence ([DirectRepeateR: An R package 2025, Finding 1](/knowledge/papers/10_12688_f1000research_170810_1/#finding-1)). This depletion is consistent with the single-strand annealing (SSA) mutational hazard hypothesis: direct repeats flanking exons create a deletion risk, and selection removes such arrangements over evolutionary time. Together, these lines of evidence suggest that drift and selection are not mutually exclusive forces; drift may dominate at the level of large-scale karyotype rearrangements (particularly in small-Ne lineages), while selection acts in parallel to constrain specific repeat-mediated deletion mechanisms near genes.

## Supporting evidence

- [Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae001/#finding-1): Low-Ne Polyphaga clades show fusion rates of 0.05–0.11 versus below 0.025 in medium/high-Ne clades; *Calathus* rates are more than ten times higher than other Adephaga clades.
- [Drift drives the evolution 2024, Finding 2](/knowledge/papers/10_1093_jhered_esae001/#finding-2): In Carabidae, wingless lineages have higher fission rates than winged lineages, with a credible interval for the rate difference entirely positive (0.005–0.044).
- [Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae025/#finding-1): In Carnivora, small-range lineages show higher rates of both fusions (ΔR = 0.101, CI 0.062–0.141) and fissions (ΔR = 0.163, CI 0.116–0.207) than large-range lineages.
- [DirectRepeateR: An R package 2025, Finding 1](/knowledge/papers/10_12688_f1000research_170810_1/#finding-1): In *A. aegypti*, only 5,782 exons are flanked by direct repeats versus ~40,000 expected by chance, indicating purifying selection against SSA-promoting repeat configurations near coding sequence.

## Contradictions / open disagreements

Several methodological and conceptual tensions limit strong causal inference.

In the beetle and carnivore work, Ne is estimated indirectly from proxy traits (winglessness, body size, range size) rather than directly from population genomics, introducing measurement error and potentially conflating correlated ecological variables. The elevated fission rate in wingless Carabidae is also model-dependent, disappearing in the more complex model that incorporates whole-genome duplication ([Drift drives the evolution 2024, Finding 2](/knowledge/papers/10_1093_jhered_esae001/#finding-2)). In Carnivora, neutral trait simulations produced false positive rates of 22–33%, meaning the observed ΔR values must substantially exceed chance before the drift interpretation is secure ([Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae025/#finding-1)).

The *A. aegypti* direct-repeat depletion finding introduces a deeper conceptual tension: it demonstrates that selection can powerfully shape the repeat landscape near genes, but the analysis is limited to a single species and uses a Monte Carlo null that does not fully control for GC content, chromatin accessibility, or recombination landscape ([DirectRepeateR: An R package 2025, Finding 1](/knowledge/papers/10_12688_f1000research_170810_1/#finding-1)). Whether the depletion pattern generalizes to the same lineages where drift signatures have been detected — and whether both forces operate simultaneously at different genomic scales — remains an open question.

Across all systems, a deeper ambiguity remains: observed patterns are consistent with drift on neutral rearrangements, selection on weakly deleterious ones, or a mixture. Distinguishing these scenarios requires direct Ne estimates and population-genetic modeling of fixation probabilities.

## Tealc's citation-neighborhood suggestions

- Studies directly estimating Ne in beetle and carnivore populations using population-genomic methods would validate or replace proxy-trait classification schemes.
- Comparative analyses of direct-repeat depletion near exons across multiple species with known Ne variation would test whether selection strength on SSA-mediated hazards tracks Ne as drift theory predicts.
- Theoretical work on fixation probability of chromosomal rearrangements under varying Ne (e.g., Lynch et al. mutational hazard models) would help assess whether observed rate ratios match drift predictions quantitatively.
- Comparative analyses in Lepidoptera, Hymenoptera, or primates could further test the generality of the drift signal.

## Related on the Blackmon Lab site

- [Drift drives the evolution 2024](/knowledge/papers/10_1093_jhered_esae001/) — source paper with beetle karyotype evolution findings.
- [Drift drives the evolution 2024](/knowledge/papers/10_1093_jhered_esae025/) — source paper with Carnivora karyotype evolution findings.
- [DirectRepeateR: An R package 2025](/knowledge/papers/10_12688_f1000research_170810_1/) — source paper on direct-repeat depletion near exons in *A. aegypti*.
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
## Related topics on this site

- [Chromosome number evolution](/knowledge/topics/chromosome_number_evolution/) — 2 shared papers
- [Karyotype evolution overview](/knowledge/topics/karyotype_evolution_overview/) — 2 shared papers
<!-- tealc:related-end -->
