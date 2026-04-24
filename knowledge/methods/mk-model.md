---
layout: default
title: "Mk model — Markov model for discrete trait evolution"
method_slug: mk-model
language: R
package: ape, corHMM
depends_on_concepts: [markov-model, ancestral-state-reconstruction, maximum-likelihood]
appears_in_topics: [sex_chromosome_evolution, karyotype_evolution, comparative_methods]
appears_in_papers: ["10_1093_jhered_esw047", "10_1111_evo_12792", "10_1016_j_cois_2014_12_003"]
difficulty: intermediate
last_updated: 2026-04-23
permalink: /knowledge/methods/mk-model/
---
<!-- tealc:method-start -->
# Mk model

**What it does.** The Mk model (named for Markov-k states) describes the evolution of a discrete character on a phylogeny as a continuous-time Markov chain. At its simplest, it has two states and one or two rate parameters: the equal-rates (ER) version assumes all transitions have the same rate; the all-rates-different (ARD) version gives each ordered pair of states its own rate. The model is fit by maximizing the likelihood of the observed tip states given the tree, branch lengths, and rate matrix Q. The `ape::ace` function provides ML estimates for simple models; `corHMM` extends Mk to hidden-rate classes and ordered models.

**When to use it.**
- You have a binary or multi-state discrete character mapped on a phylogeny and want to estimate transition rates.
- You want to test whether transitions are symmetric (ER) or asymmetric (ARD) via a likelihood-ratio test.
- You want empirical Bayes ancestral state probabilities at internal nodes.
- The trait has a moderate number of states (2–8); for large state spaces (e.g. chromosome number) use chromePlus.

**When NOT to use it.**
- You also want to test whether the trait influences diversification rates — use BiSSE or HiSSE instead.
- You suspect the true rate varies across the tree in a way correlated with an unobserved variable — use corHMM's hidden-rate model.
- Tip data are heavily missing (>40% unknown) — results will be dominated by the prior.
<!-- tealc:method-end -->

<!-- tealc:example-start -->
## Worked example

```r
library(ape)
library(corHMM)

# tree: ape phylo object (ultrametric preferred)
# x: named character vector of states ("XY", "XO") with names = tip labels

# ---- Option A: ape::ace — fast, 2-state ER or ARD ----

# Equal-rates model
fit.er <- ace(x, tree, type = "discrete", model = "ER")
fit.er$rates        # single q
fit.er$lik.anc      # matrix: nodes x states, marginal probabilities

# All-rates-different model
fit.ard <- ace(x, tree, type = "discrete", model = "ARD")
fit.ard$rates       # q01 and q10

# Likelihood-ratio test: ER vs ARD
LRT_stat <- 2 * (fit.ard$loglik - fit.er$loglik)
pchisq(LRT_stat, df = 1, lower.tail = FALSE)

# ---- Option B: corHMM — hidden rates, ordered models ----

# Build rate category matrix (1 = observed state A, 2 = observed state B)
rate_mat <- getStateMat4Dat(data.frame(sp = names(x), state = x))$rate.mat

# Fit a two-rate-class hidden Markov model
fit.hmm <- corHMM(phy = tree,
                  data = data.frame(sp = names(x), state = x),
                  rate.cat = 2,           # 2 hidden rate classes
                  rate.mat = rate_mat,
                  node.states = "marginal")
fit.hmm$loglik
fit.hmm$solution   # rate matrix with hidden states

# Compare 1-class (standard Mk) to 2-class (hidden rates)
fit.mk  <- corHMM(phy = tree,
                  data = data.frame(sp = names(x), state = x),
                  rate.cat = 1,
                  rate.mat = rate_mat,
                  node.states = "marginal")
# AIC comparison
AIC(fit.mk)
AIC(fit.hmm)
```
<!-- tealc:example-end -->

<!-- tealc:gotchas-start -->
## Gotchas we've hit

- **ape::ace marginal vs. joint reconstruction.** `ace` returns marginal node probabilities, not joint reconstructions. They can give very different answers on asymmetric trees. For joint ASR use `phangorn::ancestral.pars` or `phytools::make.simmap`.
- **ARD identifiability on small trees.** With fewer than ~50 tips and rare transitions, the ARD model often has a flat likelihood surface for one of the two rates; the MLE is then on the boundary (rate near 0 or infinity). Check `fit.ard$rates` for values >10 and treat them skeptically.
- **Branch-length units matter.** Mk rates are per-branch-length unit. If branch lengths are in millions of years, rates are events per million years; if they are substitutions/site, rates are transitions per substitution. Don't mix trees from different sources without checking units.
- **corHMM data format.** The first column must be named exactly `sp` (not `species`, not `taxon`) and match `tree$tip.label` exactly. Mismatches fail silently in some corHMM versions.
- **Hidden-rate overfit.** A 2-rate-class model almost always fits better than a 1-rate model by AIC, but the rate classes may not be biologically interpretable. Use simulation to assess whether the improvement exceeds the null expectation under a 1-class model.
<!-- tealc:gotchas-end -->

<!-- tealc:papers-start -->
## Key papers that use this method in the lab

- [Blackmon, Ross & Bachtrog 2017 — Sex determination, sex chromosomes, and karyotype evolution in insects](/knowledge/papers/10_1093_jhered_esw047/) — uses likelihood-based ASR (Mk model) to infer the ancestral sex determination mode in insects.
- [Blackmon, Hardy & Ross 2015 — The evolutionary dynamics of haplodiploidy](/knowledge/papers/10_1111_evo_12792/) — fits irreversible and reversible Mk models to haplodiploidy transitions in mites; tests whether reversions are possible.
- [Blackmon & Demuth 2015 — Genomic origins of insect sex chromosomes](/knowledge/papers/10_1016_j_cois_2014_12_003/) — synthesizes Mk-based ancestral state inferences across insects to describe patterns of sex chromosome turnover.
<!-- tealc:papers-end -->

<!-- user-start -->
<!-- user-end -->
