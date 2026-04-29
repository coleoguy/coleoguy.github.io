---
layout: default
title: "MuSSE — Multi-State Speciation and Extinction"
method_slug: musse
language: R
package: diversitree
depends_on_concepts: []
appears_in_topics: []
appears_in_papers: []
difficulty: advanced
last_updated: 2026-04-29
permalink: /knowledge/methods/musse/
---
# MuSSE — Multi-State Speciation and Extinction

<!-- tealc:method-start -->
**What it does.** MuSSE (Multi-State Speciation and Extinction) extends the binary-state BiSSE model to discrete traits with three or more character states, fitting a likelihood-based birth-death model in which each state carries its own speciation rate (λ), extinction rate (μ), and transition rates to every other state (q). The method expects a time-calibrated phylogeny and a vector of tip states; it estimates how speciation and extinction vary across states while jointly modeling trait evolution along the tree. The canonical implementation lives in the R package **diversitree**.

**When to use it.**

- Your focal trait is a discrete character with 3 or more states and you have a specific hypothesis about which states drive diversification differences.
- You have a well-resolved, time-calibrated phylogeny with tip-state assignments for all (or most) sampled taxa.
- You want to compare nested models (e.g., equal-rates vs. state-specific speciation) via likelihood-ratio tests or AIC.
- You need full posterior distributions on rate parameters and can supply a sampling fraction per state for incomplete taxon sampling.
- Your trait states are mutually exclusive and exhaustive (no polymorphic or ambiguous codings that would require a different likelihood approach).

**When NOT to use it.**

- You have only two trait states — use BiSSE or, if you suspect background rate heterogeneity unrelated to the trait, use HiSSE instead.
- Your tree has fewer than ~300 tips; power is low and parameter estimates become unreliable across all SSE methods at small sample sizes.
- Trait states are numerous but sparsely occupied (many states with only 1–3 tips) — the model will be over-parameterized; consider collapsing states or switching to a continuous-trait model such as QUASSE.
- Your primary concern is unobserved rate heterogeneity rather than state-specific rates — use HiSSE or a hidden-state extension.
- Tip states are known to carry measurement or classification error; SSE likelihoods are sensitive to misassigned tip states and have no built-in measurement-error layer.
<!-- tealc:method-end -->

<!-- tealc:example-start -->
## Worked example

```r
library(diversitree)

# Simulate a 3-state MuSSE tree for demonstration
set.seed(42)
pars <- c(
  lambda1 = 0.2, lambda2 = 0.15, lambda3 = 0.1,   # speciation per state
  mu1     = 0.03, mu2 = 0.03, mu3 = 0.03,          # extinction per state
  q12 = 0.01, q13 = 0.01,                           # transition rates from state 1
  q21 = 0.01, q23 = 0.01,                           # transition rates from state 2
  q31 = 0.01, q32 = 0.01                            # transition rates from state 3
)
sim <- tree.musse(pars, max.taxa = 200, x0 = 1, include.extinct = FALSE)
states <- sim$tip.state

# Build the likelihood function
# sampling = c(1,1,1) means all taxa in each state are included
lik <- make.musse(sim, states, k = 3, sampling.f = c(1, 1, 1))

# Constrain to a simpler model: equal extinction across states
lik_constrained <- constrain(lik, mu2 ~ mu1, mu3 ~ mu1)

# Find the MLE starting from true values (use diversitree::starting.point.musse in practice)
start <- c(lambda1=0.2, lambda2=0.15, lambda3=0.1,
           mu1=0.03,
           q12=0.01, q13=0.01, q21=0.01, q23=0.01, q31=0.01, q32=0.01)
fit <- find.mle(lik_constrained, start)
coef(fit)   # inspect estimated rates
logLik(fit) # log-likelihood of constrained model

# MCMC for posterior distributions (burn 100, sample 500 — increase for real analyses)
prior <- make.prior.exponential(1 / 0.2)
mcmc_out <- mcmc(lik_constrained, coef(fit), nsteps = 500,
                 prior = prior, w = 0.1, print.every = 100)

# Posterior summaries
profile <- mcmc_out[-(1:100), ]           # discard burn-in
apply(profile[, -1], 2, median)           # median posterior for each parameter
# Interpretation: lambda1 > lambda2 > lambda3 consistent with simulated truth;
# examine overlap of posterior distributions to judge support for rate differences.
```
<!-- tealc:example-end -->

<!-- tealc:gotchas-start -->
## Gotchas we've hit

- **Starting values matter more than in simpler models.** With 3+ states, the MuSSE likelihood surface has many local optima. Always try multiple starting points (e.g., perturb with `rnorm`) or use `starting.point.musse` before trusting `find.mle` output.
- **Unconstrained models are almost always over-parameterized.** A full 3-state model has 12 free parameters; fitting it unconstrained to a 150-tip tree produces very wide confidence intervals. Start with constrained models (equal extinction, equal transition rates) and relax constraints with LRT/AIC guidance.
- **Sampling fractions per state must be correct, not just overall.** Passing a single global sampling fraction when states differ in sampling completeness biases speciation rate estimates; compute and pass a per-state vector to `sampling.f`.
- **MCMC `w` (step size) needs tuning.** The default step size often yields acceptance rates outside the 20–40% target. Run a short chain, check `attr(mcmc_out, "acceptance")`, and adjust `w` before committing to a long run.
- **Large numbers of states blow up transition-rate matrices.** Each added state multiplies transition parameters by (k−1) in both directions. For k ≥ 5 states with sparse tips, the matrix becomes numerically unstable; consider reducing states or using a penalized model.
<!-- tealc:gotchas-end -->

<!-- tealc:papers-start -->
## Key papers that use this method in the lab

*No lab papers ingested yet — this page will update as papers are added to /knowledge/papers/.*
<!-- tealc:papers-end -->

<!-- user-start -->
<!-- user-end -->
