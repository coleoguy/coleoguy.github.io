---
layout: default
title: "Selection and drift"
topic_slug: selection_and_drift
last_updated: 2026-04-21T19:27:16.966475+00:00
papers_supporting: [f9fb8e258c7b62f338b299e9c6fcbeb81259e1aef5f75ea3c782100d90b4a19c, fa8d0869c6d351d791f46d2b041f9c1589e106dfa4d3f3d2ebbc59e1e3b3d80e]
permalink: /knowledge/topics/selection_and_drift/
---
# Selection and Drift

## Current understanding

A central question in chromosome evolution is whether changes in chromosome number and structure are driven primarily by natural selection or by genetic drift acting on nearly neutral rearrangements. The drift hypothesis predicts that lineages with smaller effective population sizes (Ne) — where drift is stronger relative to selection — should accumulate chromosomal rearrangements at elevated rates, regardless of the fitness effects of those rearrangements.

Empirical work in Coleoptera provides quantitative clade-level evidence that reduced Ne is associated with dramatically accelerated karyotype evolution. Across 12 beetle clades, those classified as low-Ne (possessing two or more Ne-reducing traits such as winglessness, subsocial behavior, or small body size) show fusion rates substantially higher than their medium- or high-Ne relatives. In Polyphaga, low-Ne clades exhibit mean fusion rates of 0.05–0.11, while all medium- and high-Ne clades fall below 0.025. The pattern is especially striking in Adephaga: the single low-Ne genus *Calathus* shows fusion rates more than ten times higher than the average of the other four Adephaga clades surveyed ([2024 drift beetles, Finding 1](/knowledge/papers/2024_drift_beetles/#finding-1)). Wingless Carabidae lineages — treated as a proxy for reduced Ne — also show higher fission rates than winged relatives, with a credible interval for the rate difference entirely positive (0.005–0.044) ([2024 drift beetles, Finding 2](/knowledge/papers/2024_drift_beetles/#finding-2)).

Crucially, the drift signal is not confined to insects. An independent analysis of Carnivora finds that lineages with small geographic range sizes — a proxy for reduced Ne — show elevated rates of both chromosome fusions (ΔR = 0.101, 95% CI 0.062–0.141) and fissions (ΔR = 0.163, 95% CI 0.116–0.207), with credible intervals entirely above zero in both cases ([2024 drift carnivores, Finding 1](/knowledge/papers/2024_drift_carnivores/#finding-1)). The convergence of this pattern across beetles and mammals, measured with different Ne proxies and independent phylogenetic datasets, substantially strengthens the case that drift is a general engine of karyotype diversification rather than a clade-specific artifact.

## Supporting evidence

- [2024 drift beetles, Finding 1](/knowledge/papers/2024_drift_beetles/#finding-1): Low-Ne Polyphaga clades show fusion rates of 0.05–0.11 versus below 0.025 in medium/high-Ne clades; *Calathus* rates are more than ten times higher than other Adephaga clades.
- [2024 drift beetles, Finding 2](/knowledge/papers/2024_drift_beetles/#finding-2): In Carabidae, wingless lineages have higher fission rates than winged lineages, with a credible interval for the rate difference entirely positive (0.005–0.044).
- [2024 drift carnivores, Finding 1](/knowledge/papers/2024_drift_carnivores/#finding-1): In Carnivora, small-range lineages show higher rates of both fusions (ΔR = 0.101, CI 0.062–0.141) and fissions (ΔR = 0.163, CI 0.116–0.207) than large-range lineages.

## Contradictions / open disagreements

Several methodological tensions limit strong causal inference across both study systems.

In the beetle work, Ne classes were assigned categorically from four proxy traits without direct Ne estimation, introducing measurement error and potentially conflating correlated ecological variables with Ne itself. The elevated fission rate in wingless Carabidae is also **model-dependent**: it appears in the simpler model (fusions and fissions only) but not in the more complex model that incorporates whole-genome duplication ([2024 drift beetles, Finding 2](/knowledge/papers/2024_drift_beetles/#finding-2)). Some focal clades (e.g., *Calathus*) contain as few as 15–16 species, leaving rate estimates potentially sensitive to outlier taxa.

In the carnivore work, range size was discretized at the median, making it a coarse Ne proxy. More concerning, neutral trait simulations produced false positive rates of 22–33% for detecting apparent rate differences — meaning the credible intervals must substantially exceed what chance alone could produce before the drift interpretation is secure ([2024 drift carnivores, Finding 1](/knowledge/papers/2024_drift_carnivores/#finding-1)). Whether the observed ΔR values are large enough to confidently clear this bar warrants scrutiny.

Across both systems, a deeper ambiguity remains: the observed patterns are consistent with drift acting on truly neutral rearrangements, with selection on weakly deleterious or weakly beneficial ones, or with some mixture. Distinguishing these scenarios requires direct Ne estimates and population-genetic modeling of fixation probabilities.

## Tealc's citation-neighborhood suggestions

- Studies directly estimating Ne in beetle and carnivore populations using population-genomic methods would validate or replace the proxy-trait and range-size classification schemes.
- Theoretical work on fixation probability of chromosomal rearrangements under varying Ne (e.g., Lynch et al. models of mutational hazard) would help assess whether observed rate ratios match drift predictions quantitatively.
- Comparative analyses in other taxa with well-characterized Ne variation (e.g., Lepidoptera, Hymenoptera, primates) could further test the generality of the drift signal.

## Related on the Blackmon Lab site

- [/knowledge/papers/2024_drift_beetles/](/knowledge/papers/2024_drift_beetles/) — source paper with beetle karyotype evolution findings.
- [/knowledge/papers/2024_drift_carnivores/](/knowledge/papers/2024_drift_carnivores/) — source paper with Carnivora karyotype evolution findings.