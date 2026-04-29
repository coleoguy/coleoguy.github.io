---
layout: default
title: "phylolm — Phylogenetic Generalized Linear Models"
method_slug: phylolm
language: R
package: phylolm
depends_on_concepts: []
appears_in_topics: []
appears_in_papers: []
difficulty: intermediate
last_updated: 2026-04-29
permalink: /knowledge/methods/phylolm/
---
# phylolm — Phylogenetic Generalized Linear Models

<!-- tealc:method-start -->
**What it does.** `phylolm` fits linear and generalized linear models while accounting for phylogenetic non-independence among species. Given a phylogeny and a trait table, it estimates regression coefficients plus a phylogenetic signal parameter (e.g. Pagel's λ, Brownian motion, Ornstein–Uhlenbeck, or several other evolutionary models) under a likelihood framework. The canonical implementation is the R package `phylolm` (Ho & Ané 2014, *Systematic Biology* doi:10.1093/sysbio/syu005).

**When to use it.**

- You have a continuous or binary response variable measured across species and want to test whether one or more predictors explain it after removing phylogenetic signal.
- You need model selection across different evolutionary covariance structures (BM, OU, lambda, kappa, delta, ACDC) without leaving R.
- Your tree has ≥20 tips and you want faster computation than `ape::gls` or `nlme::gls` — `phylolm` scales to thousands of tips via an O(n) algorithm.
- You are fitting a logistic or Poisson regression for binary or count traits across a phylogeny (via `phyloglm`).
- You want to bootstrap uncertainty around regression coefficients using the built-in `bootphylolm` wrapper.
<!-- tealc:method-end -->

**When NOT to use it.**

- The response is a rate or a diversification parameter estimated from the tree itself — use `BAMM` or `diversitree` to avoid circular conditioning.
- You have missing data in covariates; `phylolm` does listwise deletion with no warning, which silently shrinks the effective sample.
- Your question is about ancestral state reconstruction rather than regression — use `phytools::fastAnc` or `ape::ace` instead.
- You need a fully Bayesian posterior over the signal parameter (e.g. for propagating uncertainty downstream) — consider `MCMCglmm` or `brms` with a phylogenetic covariance term.

<!-- tealc:example-start -->
## Worked example

```r
library(phylolm)
library(ape)

# Load example data bundled with phylolm
data(floweringTime)   # data frame: species in rows, traits in columns
data(floweringTree)   # phylo object with branch lengths

# Fit a phylogenetic regression of flowering time on latitude
# signal model: Ornstein-Uhlenbeck (use "BM", "lambda", "OUrandomRoot", etc.)
fit <- phylolm(
  floweringTime ~ Latitude,
  data  = floweringTime,
  phy   = floweringTree,
  model = "OUrandomRoot"
)

summary(fit)
# Key outputs:
#   Coefficients table — slope and intercept with SEs and p-values
#   alpha (OU pull parameter) — how fast evolution returns to optimum
#   logLik / AIC — use AIC to compare models (BM vs OU vs lambda, etc.)

# Bootstrap confidence intervals for the slope (999 replicates)
boot_fit <- bootphylolm(
  floweringTime ~ Latitude,
  data  = floweringTime,
  phy   = floweringTree,
  model = "OUrandomRoot",
  B     = 999
)
apply(boot_fit$boot.coefficients, 2, quantile, probs = c(0.025, 0.975))
```
<!-- tealc:example-end -->

<!-- tealc:gotchas-start -->
## Gotchas we've hit

- **Species name mismatch silently drops tips.** If `rownames(data)` do not exactly match `phy$tip.label`, `phylolm` prunes the tree without error. Always run `name.check(phy, data)` from `geiger` before fitting.
- **Branch lengths of zero cause a singular covariance matrix.** Polytomies resolved with zero-length branches will crash the likelihood. Add a small constant (e.g. `phy$edge.length[phy$edge.length == 0] <- 1e-6`) or resolve polytomies with `ape::multi2di`.
- **`phyloglm` with binary traits needs sufficient variation.** With very few 0→1 or 1→0 transitions the likelihood surface becomes flat; the optimizer stalls and `alpha` hits its upper bound. Inspect the transition count before trusting any p-value.
- **AIC comparisons across signal models are valid only when the fixed-effects design matrix is identical.** Changing predictors and changing the covariance model in the same step confounds model selection; vary one at a time.
<!-- tealc:gotchas-end -->

<!-- tealc:papers-start -->
## Key papers that use this method in the lab

*No lab papers ingested yet — this page will update as papers are added to /knowledge/papers/.*
<!-- tealc:papers-end -->

<!-- user-start -->
<!-- user-end -->
