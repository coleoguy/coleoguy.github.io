---
layout: default
title: "SIMMAP — Stochastic character mapping"
method_slug: simmap
language: R
package: phytools
depends_on_concepts: [mk-model, ancestral-state-reconstruction, markov-model]
appears_in_topics: [sex_chromosome_evolution, karyotype_evolution, comparative_methods]
appears_in_papers: ["10_1098_rsbl_2020_0648", "10_1534_genetics_114_164269"]
difficulty: intermediate
last_updated: 2026-04-23
permalink: /knowledge/methods/simmap/
---
<!-- tealc:method-start -->
# Stochastic character mapping (SIMMAP)

**What it does.** Stochastic character mapping (Huelsenbeck et al. 2003; Nielsen 2002) generates a random sample of histories of a discrete trait on a phylogeny conditional on the tip states and a model of evolution (typically Mk). Each mapped history assigns a particular state to every point along every branch — not just to nodes. Running `make.simmap` in `phytools` produces many such histories (typically 100–1000); the ensemble captures phylogenetic uncertainty about when and how often transitions occurred. The `describe.simmap` function summarizes across maps: expected number of changes, proportion of time spent in each state, and state-dependent ancestral probabilities at nodes.

**When to use it.**
- You want to count the expected number of transitions between states, with full uncertainty quantification rather than a single parsimony count.
- You need branch-wise or lineage-wise estimates of trait state for downstream analyses (e.g., comparing chromosome evolution rates between mapped states).
- You want a visual representation of trait history on the tree that propagates uncertainty.
- You are computing statistics that require time in each state (e.g., dwell times, co-occurrence with another character).

**When NOT to use it.**
- The phylogeny has more than ~500 tips and you need thousands of maps — the computation becomes slow; consider subsampling or using `fastAnc` for speed.
- Tip states are mostly unknown — maps will reflect only the prior and will be uninformative.
- You need joint (not marginal) ancestral estimates — SIMMAP draws from the marginal distribution at each node; for truly joint histories use the `joint` method in `phangorn`.
<!-- tealc:method-end -->

<!-- tealc:example-start -->
## Worked example

```r
library(phytools)

# tree: ape phylo object (ultrametric)
# x: named character vector of discrete states (e.g., "XY", "XO")
#    names must match tree$tip.label exactly

# 1. Fit an Mk model to estimate Q before mapping
#    Using fitMk from phytools (wraps ace internally)
fit <- fitMk(tree, x, model = "ARD")
fit$rates   # estimated q01 and q10

# 2. Generate 1000 stochastic character maps using the estimated Q
#    model = "ARD" uses the empirical Bayes approach (Q estimated from data)
maps <- make.simmap(tree, x, model = "ARD", nsim = 1000,
                    message = FALSE)

# 3. Summarise the ensemble
summary_obj <- describe.simmap(maps, plot = FALSE)

# Mean number of changes per state transition
summary_obj$Ntransitions

# Proportion of time spent in each state per branch
# (rows = branches, columns = states)
head(summary_obj$times)

# Marginal node state probabilities (average across maps)
head(summary_obj$ace)

# 4. Plot the first 4 maps to see the range of histories
par(mfrow = c(2, 2))
for (i in 1:4) {
  plot(maps[[i]], fsize = 0.3, lwd = 2)
}

# 5. Count total XO -> XY transitions across all maps
trans <- sapply(maps, function(m) {
  countSimmap(m)$Tr["XO,XY"]
})
mean(trans)
quantile(trans, c(0.025, 0.975))
```
<!-- tealc:example-end -->

<!-- tealc:gotchas-start -->
## Gotchas we've hit

- **Q estimation strategy.** `make.simmap(..., model = "ARD")` estimates Q from the data internally using `fitMk`. For reproducibility, estimate Q separately with `fitMk` first, then pass it via the `Q` argument so you can inspect and report the estimated rates independently of the mapping step.
- **Number of maps.** 100 maps is usually enough to estimate mean transition counts; credible intervals on rare events may need 1000+. Assess convergence by checking whether summary statistics stabilize between 100 and 500 maps.
- **countSimmap vs describe.simmap.** `describe.simmap` averages tip-state assignments across maps; `countSimmap` counts transitions per map. Use both: the former for node states and dwell times, the latter for transition counts.
- **Character ordering.** If your state vector contains `NA`, `make.simmap` will error. Impute or drop tips with missing data before mapping; decide which approach is more defensible for your dataset.
- **Very rare states.** If a state is present in only 1–2 tips, the Mk Q estimate will be unreliable, and nearly all maps will show those tips as independent origins. Consider fixing Q to a biologically motivated value or merging rare states.
<!-- tealc:gotchas-end -->

<!-- tealc:papers-start -->
## Key papers that use this method in the lab

- [Blackmon et al. 2020 — The probability of fusions joining sex chromosomes and autosomes](/knowledge/papers/10_1098_rsbl_2020_0648/) — uses 1000 stochastic character maps of sex chromosome state to count sex chromosome–autosome fusion events and compare to null expectations.
- [Blackmon & Demuth 2014 — Estimating tempo and mode of Y chromosome turnover](/knowledge/papers/10_1534_genetics_114_164269/) — uses stochastic character mapping to simultaneously map sex chromosome state and chromosome number, estimating co-occurrence of Y gains with autosome number reductions.
<!-- tealc:papers-end -->

<!-- user-start -->
<!-- user-end -->
