---
layout: default
title: "Ornstein-Uhlenbeck continuous-trait models"
method_slug: ou-models
language: R
package: ouch, geiger
depends_on_concepts: [ornstein-uhlenbeck-model, stabilizing-selection, phylogenetic-signal]
appears_in_topics: []
appears_in_papers: []
difficulty: intermediate
last_updated: 2026-04-29
permalink: /knowledge/methods/ou-models/
---
# Ornstein-Uhlenbeck continuous-trait models

<!-- tealc:method-start -->
**What it does.** The [Ornstein-Uhlenbeck (OU) model](/knowledge/concepts/ornstein-uhlenbeck-model/) fits a likelihood-based continuous-time stochastic process to trait values measured at the tips of a phylogeny, estimating three core parameters: the rate of random drift (σ²), the strength of pull toward an optimum (α), and the optimum trait value itself (θ). When multiple selective regimes are mapped onto the tree, each regime can carry its own θ (and optionally its own α and σ²), allowing tests of adaptive convergence or divergence. The canonical R implementations are `ouch` (Butler & King 2004) and `geiger` (via `fitContinuous`).

**When to use it.**

- You have continuous trait measurements at tips and want to test whether [stabilizing selection](/knowledge/concepts/stabilizing-selection/) has constrained trait evolution around one or more optima, rather than allowing unconstrained Brownian drift.
- You have an a priori hypothesis about selective regimes (e.g., ecology, sex, body size class) already painted onto the tree, and want to compare multi-regime OU models against a single-optimum or Brownian baseline using AIC or likelihood ratio tests.
- Trait distributions among related taxa appear overdispersed or underdispersed relative to Brownian motion predictions — OU can absorb that signal.
- You need a null-model anchor for downstream comparative analyses (e.g., correlating residuals, correcting for [phylogenetic signal](/knowledge/concepts/phylogenetic-signal/)).
- Trees are time-calibrated (ultrametric) — a prerequisite for all continuous-trait OU fitting in both `ouch` and `geiger`.

**When NOT to use it.**

- Do not use OU if your tree is not ultrametric; branch lengths must represent time, not substitutions.
- Avoid fitting many-regime OU models on small trees (< ~30 tips): parameter estimation degrades badly and AIC model selection becomes unreliable — use BM or single-optimum OU as a baseline instead.
- If you have no a priori regime map and are searching all possible regime paintings, be aware that the search space is combinatorially explosive; use dedicated tools like `l1ou` or `SURFACE` rather than brute-forcing in `ouch`.
- When traits are discrete or ordinal, use ancestral-state or threshold models rather than OU.
- If rate heterogeneity across clades (not optima heterogeneity) is your target question, use `BAMM` or `RRphylo` instead.
<!-- tealc:method-end -->

<!-- tealc:example-start -->
## Worked example

```r
# Minimal OU fit using ouch and geiger on a simulated dataset
# Requires: ape, ouch, geiger

library(ape)
library(ouch)
library(geiger)

# --- Simulate a small ultrametric tree and trait data ---
set.seed(42)
tree_ape <- rcoal(n = 40)                         # 40-tip ultrametric tree
trait_vals <- fastBM(tree_ape, a = 0, sig2 = 1)   # simulate BM trait

# ============================================================
# Option A: geiger::fitContinuous — single-optimum OU
# ============================================================
fit_BM <- fitContinuous(tree_ape, trait_vals, model = "BM")
fit_OU <- fitContinuous(tree_ape, trait_vals, model = "OU")

# Compare by AIC — lower is better
fit_BM$opt$aic   # BM AIC
fit_OU$opt$aic   # OU AIC

# Key OU parameters:
fit_OU$opt$alpha  # strength of pull to optimum
fit_OU$opt$sigsq  # diffusion rate
fit_OU$opt$z0     # optimum (= root state under single-regime OU)

# ============================================================
# Option B: ouch — multi-regime OU with a painted tree
# ============================================================
# Convert ape tree to ouchtree
otree <- ape2ouch(tree_ape)

# Build a regime painting (here: single regime for illustration)
regimes <- as.factor(rep("global", length(otree@nodes)))

# Fit single-optimum OU in ouch
h_single <- hansen(
  tree    = otree,
  data    = data.frame(trait = trait_vals[otree@nodelabels[otree@term]]),
  regimes = data.frame(regime = regimes),
  sqrt.alpha = 1,    # starting value
  sigma  = 1         # starting value
)
summary(h_single)
# alpha, sigma^2, and theta are reported with standard errors
# Compare AIC across models to select the best regime painting
```
<!-- tealc:example-end -->

<!-- tealc:gotchas-start -->
## Gotchas we've hit

- **Non-ultrametric trees crash silently or return garbage estimates.** Both `ouch` and `geiger::fitContinuous` assume branch lengths are proportional to time. Always run `is.ultrametric(tree)` before fitting; use `chronos()` or `nnls.tree()` to date the tree first.
- **`ape2ouch` drops tip labels if they don't match the data frame row names exactly.** Verify that `rownames(data)` match `tree@nodelabels[tree@term]` after conversion, or trait-to-tip alignment will be silently shuffled.
- **α near zero is not identifiable from BM on short trees.** When `fitContinuous` returns α ≈ 0 with a flat likelihood surface, the OU model is not supported — do not interpret the θ estimate as a biological optimum.
- **Multi-regime painting with many regimes on few tips overfits badly.** Each additional optimum costs a degree of freedom; with fewer than ~5 tips per regime, AIC corrections are insufficient and ΔAIC comparisons become meaningless.
- **Starting values matter in `ouch`.** The `hansen()` optimizer can land on local optima; run it from several starting values of `sqrt.alpha` (e.g., 0.1, 1, 5) and take the run with the highest log-likelihood.
<!-- tealc:gotchas-end -->

<!-- tealc:papers-start -->
## Key papers that use this method in the lab

*No lab papers ingested yet — this page will update as papers are added to /knowledge/papers/.*
<!-- tealc:papers-end -->

<!-- user-start -->
<!-- user-end -->
