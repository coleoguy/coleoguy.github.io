---
layout: default
title: "GeoSSE — Geographic State Speciation and Extinction"
method_slug: geosse
language: R
package: diversitree
depends_on_concepts: []
appears_in_topics: []
appears_in_papers: []
difficulty: advanced
last_updated: 2026-04-29
permalink: /knowledge/methods/geosse/
---
# GeoSSE — Geographic State Speciation and Extinction

<!-- tealc:method-start -->
**What it does.** GeoSSE is a likelihood-based state-speciation-and-extinction model that estimates region-specific speciation rates, extinction rates, and dispersal (range-transition) rates simultaneously from a time-calibrated phylogeny and a binary geographic-range coding for each tip. Each tip is coded as endemic to region A, endemic to region B, or widespread (AB); the model then fits six parameters — speciation within A (s_A), speciation within B (s_B), speciation producing widespread lineages (s_AB), extinction from A (x_A), extinction from B (x_B), and dispersal in both directions (d_A, d_B) — by integrating along the tree. The canonical implementation is `diversitree::make.geosse()` in R.

**When to use it.**
- You have a time-calibrated phylogeny and binary range data (A-only, B-only, or A+B widespread) for every tip.
- Your biological question is whether net diversification differs between two geographic regions, not just whether range characters evolved differently.
- You want to test whether geographic range expansion (dispersal) or range contraction (extinction from one region) is the dominant dynamic.
- Your tree is reasonably complete (published benchmarks suggest ≥ 50–100 tips for parameter estimates to become reliable; larger trees reduce confounding between speciation and extinction).
- You want a principled null model: fixing s_A = s_B tests geographic symmetry while still estimating dispersal and extinction.

**When NOT to use it.**
- Your range data require more than two discrete regions — use BioGeoBEARS or a multi-region SSE extension instead.
- Your tree has large incomplete sampling fractions that differ by region; unmodeled sampling bias can masquerade as rate differences.
- You suspect background rate heterogeneity unrelated to geography — the hidden-rate extension (HiSSE/GeoHiSSE) is a better starting point.
- Widespread lineages are nearly absent from your tree; GeoSSE cannot reliably estimate s_AB or dispersal rates in that case.
<!-- tealc:method-end -->

<!-- tealc:example-start -->
## Worked example

```r
library(diversitree)

# 1. Load a time-calibrated phylogeny and tip state vector.
#    States: 1 = region A only, 2 = region B only, 3 = widespread (A+B).
phy    <- read.tree("my_tree.tre")          # placeholder path
states <- setNames(tip_state_vector, phy$tip.label)

# 2. Build the GeoSSE likelihood function.
lik <- make.geosse(phy, states)

# 3. Choose sensible starting values (diversitree helper).
p0 <- starting.point.geosse(phy)

# 4. Maximum-likelihood fit — unconstrained model.
fit_full <- find.mle(lik, p0)
coef(fit_full)   # sA, sB, sAB, xA, xB, dA, dB

# 5. Constrained model: equal speciation rates in both regions.
lik_null <- constrain(lik, sA ~ sB)
fit_null <- find.mle(lik_null, p0[argnames(lik_null)])

# 6. Likelihood-ratio test for geographic asymmetry.
anova(fit_full, fit_null)
# A significant result supports region-specific diversification rates.

# 7. Optional MCMC for posterior distributions.
prior <- make.prior.exponential(1 / 2)
mcmc_out <- mcmc(lik, coef(fit_full), nsteps = 1000,
                 prior = prior, w = 0.1, print.every = 100)
profiles.plot(mcmc_out[, c("sA", "sB")], col.line = c("blue", "red"))
```
<!-- tealc:example-end -->

<!-- tealc:gotchas-start -->
## Gotchas we've hit

- **Widespread-lineage scarcity causes parameter non-identifiability.** When few tips are coded as AB, `sAB` and the dispersal rates (dA, dB) cannot be separated from noise; the likelihood surface is flat and MCMC chains fail to converge. Collapse widespread tips into one of the endemic categories only if you have a biological rationale, or use a simpler model.
- **State coding ambiguity inflates apparent dispersal rates.** Widespread codings derived from museum records (rather than field surveys) often reflect under-sampling of the rarer region. Auditing occurrence data before coding tips prevents spuriously high dispersal estimates.
- **Starting-point sensitivity with `find.mle`.** `starting.point.geosse()` sometimes lands near a local optimum. Running `find.mle` from several randomized starting points (e.g., `jitter(p0, amount = 0.1)`) and comparing log-likelihoods is worth the runtime cost.
- **Unsampled taxa produce inflated speciation estimates when missing fraction differs by region.** GeoSSE has no built-in per-state sampling correction; if one region is systematically under-sampled, apply a manual correction or prefer a model that supports state-specific sampling fractions.
<!-- tealc:gotchas-end -->

<!-- tealc:papers-start -->
## Key papers that use this method in the lab

- Goldberg, E. E., Lancaster, L. T., & Ree, R. H. (2011). Phylogenetic inference of reciprocal effects between geographic range evolution and diversification. *Systematic Biology*, 60(4), 451–465. DOI: 10.1093/sysbio/syr046 — the originating paper; derives the GeoSSE likelihood and demonstrates it on flowering-plant radiations.

*No lab papers ingested yet — this page will update as papers are added to /knowledge/papers/.*
<!-- tealc:papers-end -->

<!-- user-start -->
<!-- user-end -->
