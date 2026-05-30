---
layout: default
title: "phytools stochastic character mapping"
method_slug: phytools-simmap
language: R
package: phytools
depends_on_concepts: [correlated-evolution, diversification]
appears_in_topics: []
appears_in_papers: []
difficulty: intermediate
last_updated: 2026-04-29
permalink: /knowledge/methods/phytools-simmap/
---
# phytools stochastic character mapping

<!-- tealc:method-start -->
**What it does.** Stochastic character mapping (SIMMAP) samples the full posterior distribution of character-history reconstructions onto a phylogeny by drawing realizations from a continuous-time Markov model of discrete trait evolution. The method takes a rooted phylogeny and a vector of tip states as inputs, fits (or accepts user-supplied) transition-rate parameters under an equal-rates, symmetric, or all-rates-different model, and returns a set of `simmap` trees — each storing the exact timing and sequence of state transitions across every branch. The canonical implementation is `phytools::make.simmap()` (Revell 2012, doi:10.1111/j.2041-210X.2011.00169.x).

**When to use it.**
- You need branch-length-weighted summaries of ancestral state occupancy (e.g., total time spent in a state across the tree) rather than point reconstructions.
- You are computing correlated evolution tests that require a character history painted onto branches (e.g., feeding into `evol.vcv` or sister-clade comparisons).
- You want to propagate uncertainty in transition-rate estimation into downstream analyses by using a posterior sample of rate matrices (pass `Q="mcmc"` or supply a rate posterior from `fitMk`).
- You have a relatively well-resolved, time-calibrated tree and ≥ 2 discrete states with non-negligible representation at the tips.
- You need compatibility with the broader phytools/ape ecosystem for plotting or further modeling.

**When NOT to use it.**
- Your trait has more than ~6–8 states and a small tree (< 50 tips): rate estimation becomes unreliable and mapping noise dominates signal.
- You suspect diversification rates differ among states — SIMMAP ignores state-dependent speciation/extinction; use `hisse` or `diversitree` instead.
- Tip sampling is heavily biased toward one state; the Markov model will confidently paint unrealistic histories without a sampling-fraction correction.
- You need a fully Bayesian joint estimate of tree topology, rates, and histories simultaneously — use BEAST/RevBayes rather than post-hoc mapping.
<!-- tealc:method-end -->

<!-- tealc:example-start -->
## Worked example

```r
library(phytools)

# --- Inputs ---
# 'phy': a rooted phylo object (time-calibrated recommended)
# 'tip_states': named character vector of discrete states, names == tip labels
data(anoletree)          # example tree bundled with phytools
tip_states <- getStates(anoletree, "tips")   # named factor of ecomorph states

# --- Step 1: Estimate transition-rate matrix under ER model ---
fit_er <- fitMk(anoletree, tip_states, model = "ER")
Q_mat  <- as.Qmatrix(fit_er)   # extract rate matrix for inspection

# --- Step 2: Run stochastic character mapping (N = 100 maps) ---
set.seed(42)
simmaps <- make.simmap(
  tree  = anoletree,
  x     = tip_states,
  model = "ER",      # or "ARD" for all-rates-different
  nsim  = 100,
  Q     = "empirical"  # use ML estimate; set Q="mcmc" for full Bayesian sampling
)

# --- Step 3: Summarize posterior maps ---
map_summary <- summary(simmaps, plot = FALSE)
# map_summary$ace  : posterior probability of each state at each node
# map_summary$tips : tip state posteriors (should match observed)

# --- Step 4: Compute time spent in each state per branch (across all maps) ---
# describe() gives mean transitions and residence times
describe.simmap(simmaps)

# --- Step 5: Plot the density map ---
par(mfrow = c(1, 1))
plot(map_summary, fsize = 0.5, ftype = "i",
     colors = setNames(c("steelblue","tomato","goldenrod","forestgreen",
                         "orchid","darkorange"),
                       levels(tip_states)))
add.simmap.legend(colors = attr(map_summary, "colors"), x = 0, y = 10)

# --- Interpretation ---
# Each pie at internal nodes = posterior prob. of ancestral state.
# Thicker branch segments = more maps reconstruct that state on that branch.
# Transition counts from describe.simmap() feed directly into
# downstream correlated-evolution or rate-ratio tests.
```
<!-- tealc:example-end -->

<!-- tealc:gotchas-start -->
## Gotchas we've hit

- **State names must match exactly between tip vector and tree tip labels.** A single name mismatch silently drops tips and distorts rate estimation; run `setdiff(names(tip_states), phy$tip.label)` before calling `make.simmap`.
- **`Q="mcmc"` sampling is slow and not parallelized by default.** For > 500 tips or > 4 states, pre-compute a posterior of Q matrices with `fitMk(..., method="mcmc")` and pass the sample explicitly to avoid timeouts.
- **Summarizing large simmap lists with `summary()` can consume several GB of RAM.** If `nsim` is large (≥ 500) and the tree has many tips, use `describe.simmap()` for lightweight transition-count summaries first to check sanity before plotting.
- **`plot.density.map` color assignments are position-based, not name-based, in older phytools versions.** Always set colors as a named vector keyed to state names to avoid silently swapped state colors in figures.
<!-- tealc:gotchas-end -->

<!-- tealc:papers-start -->
## Key papers that use this method in the lab

- Revell, L. J. (2012). phytools: An R package for phylogenetic comparative biology (and other things). *Methods in Ecology and Evolution*, 3, 217–223. doi:10.1111/j.2041-210X.2011.00169.x — The canonical methods paper describing `make.simmap` and the summarization framework; read before interpreting output.

*No lab papers ingested yet — this page will update as papers are added to /knowledge/papers/.*
<!-- tealc:papers-end -->

<!-- user-start -->
<!-- user-end -->
