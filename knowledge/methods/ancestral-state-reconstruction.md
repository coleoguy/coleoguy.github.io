---
layout: default
title: "Ancestral state reconstruction — ML and Bayesian methods"
method_slug: ancestral-state-reconstruction
language: R
package: phangorn, ape, phytools
depends_on_concepts: [markov-model, maximum-likelihood, parsimony]
appears_in_topics: [ancestral_state_reconstruction, sex_chromosome_evolution, karyotype_evolution]
appears_in_papers: ["10_1093_jhered_esw047", "10_1111_evo_12792"]
difficulty: intermediate
last_updated: 2026-04-23
permalink: /knowledge/methods/ancestral-state-reconstruction/
---
<!-- tealc:method-start -->
# Ancestral state reconstruction

**What it does.** Ancestral state reconstruction (ASR) estimates the most likely character state at internal nodes of a phylogeny given tip states and a model of evolution. Three main approaches are in common use:

1. **Parsimony** — assigns node states that minimize the total number of changes. Fast and model-free, but ignores branch lengths and gives no uncertainty estimate.
2. **Maximum likelihood (ML)** — optimizes a Markov model (Mk) for the tip data, then returns marginal posterior probabilities for each node under the fitted model. Implemented in `ape::ace` and `phangorn::ancestral.pars`/`ancestral.mlphylo`.
3. **Stochastic character mapping (Bayesian)** — draws full histories of the character across the tree from the posterior distribution. Implemented in `phytools::make.simmap`. See the [simmap page](/knowledge/methods/simmap/) for full details.

**When to use it.**
- You want to determine the ancestral state for a clade (e.g., was the ancestor of insects male- or female-heterogametic?).
- You want to count the minimum or expected number of independent transitions.
- You need node-state probabilities to anchor downstream tests (e.g., is a derived state always associated with a morphological change?).

**When NOT to use it.**
- The character has very high transition rates relative to branch lengths — all nodes will converge on equal probabilities regardless of tip data; the reconstruction is uninformative.
- More than ~40% of tips are missing — node probabilities will be dominated by the prior.
- You want to count transitions while accounting for branch lengths and rate uncertainty — use SIMMAP instead of parsimony.
<!-- tealc:method-end -->

<!-- tealc:example-start -->
## Worked example

```r
library(ape)
library(phangorn)
library(phytools)

# tree: ape phylo object (ultrametric)
# x: named character vector of discrete states, names = tip labels

# ---- Method 1: Parsimony (phangorn) ----
# Convert tip data to phyDat format
x_phydat <- phyDat(matrix(x, ncol = 1,
                           dimnames = list(names(x), "trait")),
                   type = "USER",
                   levels = unique(x))

pars_anc <- ancestral.pars(tree, x_phydat, type = "MPR")
# Returns a matrix: rows = nodes, columns = states
# Values are 0 or 1 (parsimony-consistent states at each node)
plotAnc(tree, pars_anc, i = 1)   # plot first character


# ---- Method 2: ML via ape::ace ----
fit <- ace(x, tree, type = "discrete", model = "ARD")
fit$loglik
fit$rates        # q01, q10 ML estimates
fit$lik.anc      # marginal probabilities: matrix(nodes x states)

# Plot ancestral states on the tree
plot(tree, cex = 0.6, no.margin = TRUE)
nodelabels(pie = fit$lik.anc,
           piecol = c("orange", "darkred"),
           cex = 0.5)
tiplabels(pie = to.matrix(x, c("XO", "XY")),
          piecol = c("orange", "darkred"),
          cex = 0.3)


# ---- Method 3: Stochastic (phytools::make.simmap) ----
# For full details see the simmap method page.
maps <- make.simmap(tree, x, model = "ARD", nsim = 500,
                    message = FALSE)
sm  <- describe.simmap(maps, plot = FALSE)

# Marginal node probabilities averaged across maps
head(sm$ace)

# Expected number of XO -> XY transitions
mean(sapply(maps, function(m) countSimmap(m)$Tr["XO,XY"]))


# ---- Comparing methods ----
# Parsimony often gives confident (0/1) node assignments that can be
# misleading when transitions are sparse. The ML and stochastic methods
# propagate uncertainty — nodes with ~ 0.5 probability in either state
# honestly reflect ambiguity.
cat("Parsimony node 1:", which.max(pars_anc[1, ]), "\n")
cat("ML node 1 probs:", round(fit$lik.anc[1, ], 3), "\n")
```
<!-- tealc:example-end -->

<!-- tealc:gotchas-start -->
## Gotchas we've hit

- **Marginal vs. joint reconstruction.** `ape::ace` returns marginal probabilities — each node is estimated independently. Joint reconstruction (all nodes simultaneously, as in `phangorn::ancestral.mlphylo` with `type = "joint"`) is self-consistent but can behave oddly near polytomies. For most comparative questions the marginal approach is appropriate; use joint reconstruction only when you need a single coherent history.
- **Parsimony over-confidence.** Parsimony node assignments are 0 or 1 — they never express uncertainty. On long branches or when transitions are rare, parsimony may assign confident wrong states. Use ML or SIMMAP when uncertainty matters.
- **Root state.** ML node states near the root are strongly influenced by the prior (the stationary frequencies of Q). If you have a strong prior on the root state based on outgroup data, incorporate it; otherwise, use an uninformative flat prior and note that root inference is weak.
- **phyDat construction for multi-state characters.** For more than two states, `levels` in `phyDat` must list all states explicitly, including any that appear only at a few tips. Omitting a state causes silent recoding errors.
- **Branch length scaling.** Both ML and stochastic methods assume branch lengths are in units of expected substitutions (or time, for time-calibrated trees). Rates from an ace fit on a substitution-rate tree are not comparable to rates from a time-calibrated tree; report units.
<!-- tealc:gotchas-end -->

<!-- tealc:papers-start -->
## Key papers that use this method in the lab

- [Blackmon, Ross & Bachtrog 2017 — Sex determination, sex chromosomes, and karyotype evolution in insects](/knowledge/papers/10_1093_jhered_esw047/) — uses ML ancestral state reconstruction to infer the ancestral sex determination mode at the root of insects (100% probability of male heterogamety).
- [Blackmon, Hardy & Ross 2015 — The evolutionary dynamics of haplodiploidy](/knowledge/papers/10_1111_evo_12792/) — compares reversible and irreversible Mk models with stochastic character mapping to count origins of haplodiploidy and test whether reversions are possible.
<!-- tealc:papers-end -->

<!-- user-start -->
<!-- user-end -->
