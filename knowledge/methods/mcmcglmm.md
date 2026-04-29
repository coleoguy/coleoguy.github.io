---
layout: default
title: "MCMCglmm — Bayesian Phylogenetic Mixed Models"
method_slug: mcmcglmm
language: R
package: MCMCglmm
depends_on_concepts: [phylogenetic-signal]
appears_in_topics: []
appears_in_papers: []
difficulty: intermediate
last_updated: 2026-04-29
permalink: /knowledge/methods/mcmcglmm/
---
# MCMCglmm — Bayesian Phylogenetic Mixed Models

<!-- tealc:method-start -->
**What it does.** MCMCglmm fits generalised linear mixed models in a Bayesian MCMC framework, with native support for phylogenetic correlation structures via an inverse of the phylogenetic covariance matrix (the "animal model" approach). It accepts continuous, categorical, count, and censored response variables in a single unified formula interface. The model is fully Bayesian: the user specifies prior distributions over fixed effects, (co)variance components, and residual variance, and the sampler returns a posterior distribution over all parameters. The canonical implementation is Hadfield (2010)'s R package `MCMCglmm` (doi:10.18637/jss.v033.i02).

**When to use it.**
- You have species-level (or individual-level) trait data and a phylogeny and want to account for phylogenetic non-independence while estimating fixed-effect coefficients.
- You need to partition variance into phylogenetic and residual components to estimate [phylogenetic signal](/knowledge/concepts/phylogenetic-signal/) (λ or *H²*) in a mixed-model framework.
- Your response variable is non-Gaussian — e.g. binary presence/absence, counts, or ordinal scores — where PGLS-based methods break down.
- You want to fit multi-response (multivariate) models and estimate phylogenetic correlations among traits simultaneously.
- You have incomplete data (missing responses for some taxa) that you would otherwise have to drop before running a standard PGLS.

**When NOT to use it.**
- For large trees (>2,000–3,000 tips) the MCMC chains become extremely slow because the full phylogenetic covariance matrix must be inverted each iteration; consider `brms` + `cmdstanr` with sparse Cholesky decomposition instead.
- If you need ancestral-state reconstruction or stochastic character mapping as primary output, use `phytools` or `corHMM`.
- If convergence diagnostics (Gelman–Rubin, effective sample size) cannot be satisfied in reasonable run time, the posterior is not trustworthy; do not simply run more iterations without diagnosing the cause.
- For diversification analyses (speciation/extinction rates), this is the wrong tool entirely — use `hisse` or `BAMM`.
<!-- tealc:method-end -->

<!-- tealc:example-start -->
## Worked example

```r
library(MCMCglmm)
library(ape)

# --- Inputs ---
# 'tree'  : a rooted, ultrametric phylogeny (class "phylo")
# 'dat'   : data.frame with columns species, body_mass, diet (factor)
# Row names of dat must match tree$tip.label

# Build the inverse phylogenetic covariance matrix
inv_phylo <- inverseA(tree, nodes = "TIPS", scale = TRUE)$Ainv

# --- Priors ---
# G: phylogenetic random effect variance; R: residual variance
# V=1, nu=0.002 is a weakly informative inverse-Wishart prior
prior <- list(
  G = list(G1 = list(V = 1, nu = 0.002)),
  R = list(V = 1, nu = 0.002)
)

# --- Fit the model ---
# random = ~animal links the random effect to the phylogeny
set.seed(42)
model <- MCMCglmm(
  fixed   = body_mass ~ diet,
  random  = ~ animal,
  family  = "gaussian",
  ginverse = list(animal = inv_phylo),
  data    = dat,
  prior   = prior,
  nitt    = 110000,   # total MCMC iterations
  burnin  = 10000,    # iterations discarded before sampling
  thin    = 100,      # thinning interval
  verbose = FALSE
)

# --- Diagnostics ---
plot(model$Sol)          # trace and density for fixed effects
plot(model$VCV)          # trace and density for variance components
heidel.diag(model$VCV)   # stationarity test
effectiveSize(model$VCV) # should be >> 200 for each component

# --- Interpret ---
summary(model)
# Posterior mean of VCV[,"animal"] / sum(VCV) ≈ phylogenetic heritability (H²)
H2 <- model$VCV[, "animal"] / rowSums(model$VCV)
posterior.mode(H2)
HPDinterval(H2)
```
<!-- tealc:example-end -->

<!-- tealc:gotchas-start -->
## Gotchas we've hit

- **Species names must match exactly between the data frame and the phylogeny.** A mismatch silently drops taxa rather than throwing an error, inflating residual variance and shrinking the effective sample size. Always run `setdiff(dat$species, tree$tip.label)` before fitting.
- **Thin too little and your effective sample size will be misleadingly large.** `effectiveSize()` values below ~200 for variance components mean the posterior summary cannot be trusted; increase `nitt` and `thin` proportionally rather than just `nitt`.
- **The `animal` column in your data frame must be a factor whose levels include all tip labels.** If it is a character vector, `MCMCglmm` may fail or silently mis-map random effects.
- **Prior sensitivity matters most for variance components, not fixed effects.** Always refit with at least one alternative prior (e.g. parameter-expanded `V=1, nu=1, alpha.mu=0, alpha.V=1000`) and compare posterior modes; if they diverge substantially, the data are not overriding the prior.
- **Non-ultrametric trees cause `inverseA()` to warn but still run**, producing subtly wrong covariance structures. Enforce ultrametricity with `ape::chronos()` or `phytools::force.ultrametric()` before passing the tree.
<!-- tealc:gotchas-end -->

<!-- tealc:papers-start -->
## Key papers that use this method in the lab

*No lab papers ingested yet — this page will update as papers are added to /knowledge/papers/.*
<!-- tealc:papers-end -->

<!-- user-start -->
<!-- user-end -->
