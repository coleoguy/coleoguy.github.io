---
layout: default
title: "Quantitative Genetics Methods"
topic_slug: quantitative_genetics_methods
last_updated: 2026-04-21T20:36:41.242454+00:00
papers_supporting: [9b26073c4ef21e4b81ec477d50cc357c4809ccb79b53507cb54707da1d48856b]
permalink: /knowledge/topics/quantitative_genetics_methods/
category: "Quantitative genetics & epistasis"
---
<!-- tealc:auto-start -->
# Quantitative Genetics Methods

## Current understanding

Line-cross analysis (LCA) is a foundational tool in quantitative genetics for decomposing the genetic architecture of trait differences between populations or species into additive, dominance, and epistatic components. The traditional approach uses joint-scaling tests with forward model selection — fitting progressively more complex models and retaining those that provide a significant improvement in fit. While widely used, this forward-selection framework does not account for model selection uncertainty, meaning that the chosen "best model" may be one of several plausible explanations for the data.

A model-averaging framework known as SAGA (Scale-Averaged Genetic Architecture) addresses this limitation by computing Akaike weights across all candidate models and summarizing genetic effects via weighted averaging. Applying SAGA to a large corpus of published line-cross datasets reveals a meaningful gap between what traditional analyses report and what survives rigorous information-theoretic scrutiny. Roughly 19% of analyzed datasets yield no genetic effects that clear SAGA's thresholds — a variable-importance score above 0.5 and a 95% confidence interval excluding zero — suggesting that legacy forward-selection LCA carries a non-trivial risk of reporting effects that are not robustly supported [Wright was right: leveraging 2024, Finding 1](/knowledge/papers/2024_wright/#finding-1). Across the datasets that do meet these thresholds, the number of models included in the confidence model set spans an enormous range (1 to 2002), underscoring just how variable the degree of model uncertainty is across empirical datasets.

The practical implication is that researchers re-analyzing published data or designing new line-cross experiments should prefer model-averaged approaches over traditional stepwise selection. Model averaging produces estimates that naturally reflect uncertainty over which genetic parameters are present, rather than forcing a binary include/exclude decision for each effect.

## Supporting evidence

- [Wright was right: leveraging 2024, Finding 1](/knowledge/papers/2024_wright/#finding-1): Analysis of 1,606 line-cross datasets using SAGA found that 81% met information-theoretic thresholds for at least one genetic effect, while 19% did not — indicating substantial model selection uncertainty that traditional LCA methods ignore.

## Contradictions / open disagreements

The characterization of the 19% failure rate as evidence of "false positives" in older analyses is contested on methodological grounds. The SAGA thresholds (variable-importance ≥ 0.5; 95% CI excluding zero) are themselves chosen cutoffs, and a different choice of criteria would produce a different failure rate. It is also possible that many of these datasets simply lack statistical power or cross diversity rather than that prior inferences were incorrect. The finding documents a lack of robustness under a new framework, but does not directly demonstrate that traditional inferences were wrong — a distinction worth keeping in mind when revisiting legacy results.

## Tealc's citation-neighborhood suggestions

- Papers introducing or benchmarking SAGA or other model-averaging implementations for quantitative genetics would strengthen this page.
- Reviews of joint-scaling tests (e.g., Cavalli 1952; Hayman & Mather) provide historical context for why forward-selection LCA became standard and what assumptions it rests on.
- Simulation studies comparing Type I error rates of forward-selection LCA versus model-averaging approaches would directly address the "false positive" question raised above.

## Related on the Blackmon Lab site

- [Wright was right: leveraging 2024](/knowledge/papers/2024_wright/)
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
<!-- tealc:related-end -->
