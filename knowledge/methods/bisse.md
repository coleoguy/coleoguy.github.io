---
layout: default
title: "BiSSE — Binary State Speciation and Extinction"
method_slug: bisse
language: R
package: diversitree
depends_on_concepts: [markov-model, diversification, birth-death-model]
appears_in_topics: [diversification_rates, trait_dependent_diversification, type_I_error]
appears_in_papers: ["10_1093_sysbio_syu131", "10_1111_evo_13682"]
difficulty: advanced
last_updated: 2026-04-23
permalink: /knowledge/methods/bisse/
---
<!-- tealc:method-start -->
# BiSSE

**What it does.** BiSSE (Binary State Speciation and Extinction) is a likelihood-based method implemented in the `diversitree` R package. It fits a model in which speciation and extinction rates depend on the state of a binary trait evolving on a phylogeny, and simultaneously estimates trait transition rates. The model parameters are: two speciation rates (λ₀, λ₁), two extinction rates (μ₀, μ₁), and two transition rates between states (q₀₁, q₁₀).

**When to use it.**
- You want to test whether a binary character (e.g., presence/absence of sex chromosomes, mating system) is associated with elevated or depressed diversification rates.
- You have a time-calibrated molecular phylogeny with tip-state data.
- The phylogeny is reasonably large (>300 tips is a common threshold for adequate power while keeping Type I error manageable).
- You want full Bayesian posterior distributions for rate parameters rather than a single likelihood-ratio test.

**When NOT to use it.**
- Phylogeny has fewer than ~100 tips — power is inadequate and Type I error climbs steeply. With 300 tips the false-positive rate on empirical trees with heterogeneous diversification can still exceed 75% for neutral traits.
- The tree has strong background rate heterogeneity among clades unrelated to the focal trait — use HiSSE or MuSSE instead.
- You want to model trait evolution decoupled from diversification — use a plain Mk model or corHMM instead.
- Taxon sampling is strongly non-random with respect to the binary state.
<!-- tealc:method-end -->

<!-- tealc:example-start -->
## Worked example

```r
library(diversitree)

# tree: time-calibrated phylo object (ape format)
# states: named integer vector, 0/1, names matching tree$tip.label

# 1. Build the BiSSE likelihood function
lik <- make.bisse(tree, states)

# 2. Find ML estimates starting from reasonable initial values
p0 <- starting.point.bisse(tree)
fit.ml <- find.mle(lik, p0)
coef(fit.ml)   # lambda0, lambda1, mu0, mu1, q01, q10

# 3. Test whether lambda0 == lambda1 (no state-dependent speciation)
lik.constrained <- constrain(lik, lambda0 ~ lambda1)
fit.null <- find.mle(lik.constrained, p0[-2])
anova(fit.ml, fit.null)   # LRT: Df=1; be skeptical if tree < 300 tips

# 4. Bayesian MCMC for full posterior
prior <- make.prior.exponential(1 / (2 * (length(tree$tip.label) - 1) / max(branching.times(tree))))
post  <- mcmc(lik, coef(fit.ml), nsteps = 10000, prior = prior, w = 0.1)

# 5. Summarise posterior — compare speciation rates by state
library(coda)
post_rates <- as.mcmc(post[-(1:2000), c("lambda0", "lambda1")])
summary(post_rates)
plot(post_rates)
```
<!-- tealc:example-end -->

<!-- tealc:gotchas-start -->
## Gotchas we've hit

- **Type I error is catastrophically high on many real trees.** Rabosky & Goldberg (2015) showed that on the cetacean phylogeny >77% of neutral characters tested significant under BiSSE. Our own work (10_1111_evo_13682) found elevated false-positive rates when using BiSSE to test karyotype effects on mammal diversification. Always simulate null data on your tree and report the null rejection rate alongside your p-value.
- **Starting values matter.** `find.mle` with poor starting values often lands on a local optimum. Try `starting.point.bisse(tree)` and perturb it; run 3–5 independent ML searches.
- **Incomplete sampling.** BiSSE assumes the tree is a complete sample. For partially sampled trees use the `sampling.f` argument; its two elements give the fraction sampled in each state.
- **States need to be integers 0 or 1, not factors.** A named character vector will fail silently or produce wrong results. Use `as.integer(states == "derived")`.
- **MCMC convergence.** ESS < 200 for any rate parameter is a red flag. Run longer or narrow the prior. Don't interpret credible intervals from a poorly mixing chain.
<!-- tealc:gotchas-end -->

<!-- tealc:papers-start -->
## Key papers that use this method in the lab

- [Rabosky & Goldberg 2015 — Model inadequacy and mistaken inferences of trait-dependent speciation](/knowledge/papers/10_1093_sysbio_syu131/) — canonical demonstration of BiSSE Type I error on empirical phylogenies; required reading before running BiSSE.
- [Blackmon, Justison, Mayrose & Goldberg 2019 — Meiotic drive shapes rates of karyotype evolution in mammals](/knowledge/papers/10_1111_evo_13682/) — uses BiSSE to test karyotype morphology vs. diversification in mammals; reports a negative result and discusses false-positive risks.
<!-- tealc:papers-end -->

<!-- user-start -->
<!-- user-end -->
