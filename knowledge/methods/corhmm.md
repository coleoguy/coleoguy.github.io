---
layout: default
title: "corHMM — Hidden Rates Model for Discrete Traits"
method_slug: corhmm
language: R
package: corHMM
depends_on_concepts: [hidden-markov-model, maximum-likelihood, rate-heterogeneity, diversification-rate, hisse]
appears_in_topics: []
appears_in_papers: []
difficulty: intermediate
last_updated: 2026-04-29
permalink: /knowledge/methods/corhmm/
---
# corHMM — Hidden Rates Model for Discrete Traits

<!-- tealc:method-start -->
**What it does.** corHMM fits [hidden Markov models](/knowledge/concepts/hidden-markov-model/) to discrete character data on a phylogeny using [maximum likelihood](/knowledge/concepts/maximum-likelihood/). The core insight is that observed character states can be modeled as emissions from a larger latent state space — "hidden rate classes" — allowing different lineages to evolve the same observed trait at different underlying rates without requiring an a priori grouping. Inputs are a rooted phylogenetic tree and a data frame of tip-state assignments; outputs are transition rate matrices, ancestral state reconstructions, and model likelihoods. The canonical implementation is the `corHMM` R package (Beaulieu et al. 2013; Boyko & Beaulieu 2021).

**When to use it.**
- You suspect [rate heterogeneity](/knowledge/concepts/rate-heterogeneity/) in trait evolution but lack an obvious predictor variable to partition lineages.
- You want to compare models of correlated character evolution (e.g., sex-chromosome and trait co-evolution) under a rigorous likelihood framework.
- Your discrete trait has two or more states and the phylogeny has at least tens of tips — the method is flexible from moderate (~50) to large trees.
- You need ancestral state reconstructions that account for hidden rate variation rather than forcing a single-rate MK model.
- You want to test ordered or custom state-transition structures via user-specified rate index matrices.

**When NOT to use it.**
- Avoid it when you are primarily interested in the joint effect of [diversification rate](/knowledge/concepts/diversification-rate/) shifts on trait evolution — use [HiSSE](/knowledge/concepts/hisse/) instead, which explicitly models speciation and extinction.
- Do not use the default hidden-rates parameterization when your tree is very small (<20 tips); the additional latent states are poorly estimated and likelihoods are unreliable.
- If your character is continuous rather than discrete, corHMM is inappropriate — use `OUwie` or a similar continuous-trait model.
- Do not treat model selection solely by AIC when all candidate models are nested and parameter counts differ dramatically; run likelihood-ratio tests or use AICc for small trees.
<!-- tealc:method-end -->

<!-- tealc:example-start -->
## Worked example

```r
library(corHMM)
library(ape)

# --- 1. Load inputs ---
# Tree: rooted phylogeny (e.g., read.tree("my_tree.nwk"))
# Traits: data frame with columns [taxon, state]
tree  <- read.tree("my_tree.nwk")
traits <- read.csv("my_traits.csv")   # columns: taxon, state (0 or 1)

# --- 2. Fit a 1-rate Mk model (baseline) ---
fit_mk <- corHMM(
  phy        = tree,
  data       = traits,
  rate.cat   = 1,          # one hidden rate category = standard Mk
  model      = "ARD",      # all-rates-different transition matrix
  node.states = "marginal"
)
print(fit_mk$AICc)         # baseline AICc

# --- 3. Fit a 2-rate hidden-rates model ---
fit_hrm <- corHMM(
  phy        = tree,
  data       = traits,
  rate.cat   = 2,          # two hidden rate categories
  model      = "ARD",
  node.states = "marginal"
)
print(fit_hrm$AICc)        # compare to baseline

# --- 4. Compare models ---
delta_aicc <- fit_mk$AICc - fit_hrm$AICc
cat("ΔAICc (Mk vs. HRM):", delta_aicc, "\n")
# Positive ΔAICc means the hidden-rates model fits better

# --- 5. Inspect estimated rate matrix ---
print(fit_hrm$solution)    # transition rates among observed+hidden states

# --- 6. Ancestral states at nodes ---
head(fit_hrm$states)       # marginal probabilities per node
```
<!-- tealc:example-end -->

<!-- tealc:gotchas-start -->
## Gotchas we've hit

- **Identifiability with many rate categories.** Adding a third or fourth hidden rate class often produces a flat likelihood surface and near-zero rates in one class. If `fit$solution` contains many `NA` or `0` entries, reduce `rate.cat` by one and re-run.
- **Root-state sensitivity.** The default root prior is the stationary distribution, which can bias ancestral reconstructions when one state is very rare. Pass `root.p = "maddfitz"` or supply a fixed prior and compare outputs.
- **Data frame column ordering matters.** corHMM expects the *first* column to be taxon names and the *second* to be the state. Swapped columns produce silent mismatches — verify with `head(traits)` before fitting.
- **Long run times on large trees with many rate categories.** A tree with >500 tips and `rate.cat = 3` can take hours. Set `nstarts` to a modest value (e.g., 5) for exploratory runs, then increase for final inference.
- **Model string vs. index matrix.** The `model` argument accepts `"ER"`, `"SYM"`, or `"ARD"` as shortcuts, but custom constraints require passing a numeric index matrix via `rate.mat`. Mixing the two approaches in the same script without clearing objects causes the shortcut to silently override the custom matrix.
<!-- tealc:gotchas-end -->

<!-- tealc:papers-start -->
## Key papers that use this method in the lab

*No lab papers ingested yet — this page will update as papers are added to /knowledge/papers/.*
<!-- tealc:papers-end -->

<!-- user-start -->
<!-- user-end -->
