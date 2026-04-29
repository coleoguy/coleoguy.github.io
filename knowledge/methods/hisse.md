---
layout: default
title: "HiSSE — Hidden State Speciation and Extinction"
method_slug: hisse
language: R
package: hisse
depends_on_concepts: []
appears_in_topics: []
appears_in_papers: []
difficulty: advanced
last_updated: 2026-04-29
permalink: /knowledge/methods/hisse/
---
# HiSSE — Hidden State Speciation and Extinction

<!-- tealc:method-start -->
**What it does.** HiSSE (Hidden State Speciation and Extinction) is a likelihood-based diversification model that estimates state-dependent speciation and extinction rates while simultaneously allowing for unmeasured (hidden) states that carry their own rate classes. It takes a time-calibrated phylogeny and a binary observed-trait vector as inputs, and it estimates four rate parameters per observed state (speciation λ, extinction μ, and transitions between observed and hidden states). The canonical implementation is the R package `hisse` (Beaulieu & O'Meara 2016, *Systematic Biology*, doi:10.1093/sysbio/syw022).

**When to use it.**

- You have a binary character and want to test whether it is causally linked to shifts in speciation or extinction, while explicitly accounting for background rate heterogeneity.
- Your tree has ≥ 50–100 tips (the model's parameter count demands reasonable sample size; 300+ tips is preferable for stable Type I error rates).
- You suspect rate variation unrelated to your focal trait — HiSSE's hidden states absorb that variance rather than misattributing it to the observed character.
- You need to compare a full suite of nested models (BiSSE, CID-2, CID-4, character-independent diversification) under a single likelihood framework via AIC or AICc.
- Taxon sampling is uneven but known — HiSSE accepts per-state sampling fractions.

**When NOT to use it.**

- Your trait is continuous — use BAMM, STRAPP, or phylogenetic regression instead.
- You have fewer than ~50 tips; diversification models are poorly identified on small trees and will return wide, uninformative posteriors.
- You need a Bayesian posterior over rates rather than maximum-likelihood point estimates — consider `RevBayes` with a state-dependent birth-death model.
- Your tree contains hard polytomies or a large proportion of missing tips with unknown state — the missing-state imputation can induce bias.
- You want to model more than two observed states without collapsing them — use `MuSSE` (in `diversitree`) or `hisse`'s `muhisse` extension instead.
<!-- tealc:method-end -->

<!-- tealc:example-start -->
## Worked example

```r
library(hisse)
library(ape)

# Simulate a test tree and binary trait vector (replace with your own data)
set.seed(42)
phy <- rtree(200)
phy$edge.length <- phy$edge.length / max(branching.times(phy))  # rescale to unit height
states <- setNames(sample(c(0, 1), 200, replace = TRUE), phy$tip.label)

# Define per-state sampling fractions (observed / true species richness)
# Replace 1.0 with empirical values, e.g. c(0.8, 0.6)
f <- c(1.0, 1.0)

# Build the transition rate matrix for a 2-observed × 2-hidden state model
# trans.rate.maker() returns a 4-state q-matrix template
trans.rates <- TransMatMaker.old(hidden.states = TRUE)
trans.rates.nodual <- ParDrop(trans.rates, c(3, 5, 8, 10))  # drop dual transitions

# Fit the full HiSSE model
hisse.fit <- hisse(
  phy       = phy,
  data      = data.frame(taxon = names(states), trait = states),
  f         = f,
  hidden.states = TRUE,
  turnover  = c(1, 2, 3, 4),   # four free turnover parameters
  eps       = c(1, 2, 3, 4),   # four free extinction fraction parameters
  trans.rate = trans.rates.nodual,
  output.type = "turnover"
)

# Fit a character-independent diversification model (CID-4) as null
cid4.rates <- TransMatMaker.old(hidden.states = TRUE)
cid4.fit <- hisse(
  phy       = phy,
  data      = data.frame(taxon = names(states), trait = states),
  f         = f,
  hidden.states = TRUE,
  turnover  = c(1, 1, 2, 2),   # rates tied across observed states → CID-4 null
  eps       = c(1, 1, 2, 2),
  trans.rate = cid4.rates,
  output.type = "turnover"
)

# Compare models by AICc
AIC(hisse.fit)   # lower AICc favours HiSSE over CID-4
AIC(cid4.fit)

# Reconstruct marginal state-dependent rates across the tree
recon <- MarginRecon(phy, data.frame(taxon = names(states), trait = states),
                     f = f, pars = hisse.fit$solution,
                     hidden.states = TRUE, output.type = "turnover")
plot.hisse.states(recon, rate.param = "net.div", show.tip.label = FALSE)
# Colour gradient shows net diversification mapped onto nodes; inspect
# whether high-rate regions coincide with the focal trait.
```
<!-- tealc:example-end -->

<!-- tealc:gotchas-start -->
## Gotchas we've hit

- **Dual-transition issue.** The default `TransMatMaker` allows simultaneous changes in observed and hidden state. These "dual transitions" are biologically implausible and inflate parameter count; always use `ParDrop()` to zero them before fitting.
- **Starting value sensitivity.** HiSSE's likelihood surface can be multimodal. Run `hisse()` with multiple random starting values (`sann.restart` argument or a manual loop) and keep the run with the highest log-likelihood; a single default start frequently lands in a local optimum.
- **Model set must include CID nulls.** Comparing HiSSE only against BiSSE (which has no hidden states) produces inflated false-positive rates. Always include CID-2 and CID-4 in the comparison set — the original paper demonstrates this is the correct null.
- **`output.type` must match across model fits.** Mixing `"turnover"` and `"raw"` output types makes AICc values non-comparable and silently returns the wrong parameter table.
- **Sampling fractions per state, not overall.** Passing a single scalar to `f` applies equal sampling to both states. If your clade has state-asymmetric taxonomic coverage, estimate per-state fractions separately or rates will be biased toward the better-sampled state.
<!-- tealc:gotchas-end -->

<!-- tealc:papers-start -->
## Key papers that use this method in the lab

*No lab papers ingested yet — this page will update as papers are added to /knowledge/papers/.*
<!-- tealc:papers-end -->

<!-- user-start -->
<!-- user-end -->
