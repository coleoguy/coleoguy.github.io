---
layout: default
title: "BAMM — Bayesian Analysis of Macroevolutionary Mixtures"
method_slug: bamm
language: C++ / R
package: BAMMtools
depends_on_concepts: []
appears_in_topics: []
appears_in_papers: []
difficulty: advanced
last_updated: 2026-04-29
permalink: /knowledge/methods/bamm/
---
# BAMM — Bayesian Analysis of Macroevolutionary Mixtures

<!-- tealc:method-start -->
**What it does.** BAMM fits a Bayesian reversible-jump MCMC model to a time-calibrated phylogeny to detect shifts in diversification (speciation/extinction) or trait-evolution rates across lineages. It expects a rooted, ultrametric tree (in NEWICK format) plus optional species-sampling fractions per clade; outputs are posterior distributions over the number, location, and magnitude of rate shifts. The formal model places a compound Poisson process prior on rate shifts and uses birth-death dynamics for diversification or Brownian-motion dynamics for trait evolution. The canonical implementation is the C++ program `BAMM` paired with the R package `BAMMtools` for post-processing.

**When to use it.**
- You have a time-calibrated phylogeny and want to identify *where* in the tree diversification rates shifted, rather than testing a single global rate.
- Your tree has ≥ 100–200 tips; fewer tips gives the reversible-jump sampler too little signal to place shifts reliably.
- Incomplete taxon sampling is unavoidable but you can supply per-clade sampling fractions to correct for it.
- You want a full posterior distribution over shift configurations rather than a point estimate, so that downstream analyses can propagate rate uncertainty.
- You are comparing diversification dynamics across multiple independent clades under a common modeling framework.

**When NOT to use it.**
- Your primary question involves a binary or multi-state trait influencing diversification — use [HiSSE](https://cran.r-project.org/package=hisse) or [MuSSE](http://www.phytools.org/) instead, because BAMM does not condition rates on character states.
- Your tree is small (< 50 tips): the reversible-jump chain rarely mixes over shift configurations, and simpler AIC-based shift tests are more interpretable.
- You require statistically coherent Bayes factors for model comparison — Moore et al. (2016, *PNAS*) demonstrated that BAMM's prior on the number of shifts is not independent of tree size, inflating Bayes factors; use `TESS` or `RPANDA` if this property is critical.
- You are modeling trait evolution with strong measurement error on tip values — BAMM's trait module has no error term; use `mvMORPH` or `SLOUCH` instead.
<!-- tealc:method-end -->

<!-- tealc:example-start -->
## Worked example

```r
library(BAMMtools)

# 1. Load a time-calibrated tree (ultrametric, rooted NEWICK)
tree <- read.tree("my_calibrated_tree.tre")

# 2. Generate a BAMM control file.
#    Set sampling fractions if taxon coverage is incomplete.
generateControlFile(
  tree          = tree,
  type          = "diversification",   # or "trait"
  outfile       = "divcontrol.txt",
  globalSamplingFraction = 0.75,       # 75 % of species included
  numberOfGenerations    = "5000000",
  overwrite     = TRUE
)

# 3. Run BAMM from the command line (outside R):
#    $ bamm -c divcontrol.txt

# 4. Read results back into R after the run completes.
edata <- getEventData(
  tree,
  eventdata  = "event_data.txt",   # output from BAMM
  burnin     = 0.10,               # discard first 10 % as burn-in
  type       = "diversification"
)

# 5. Check MCMC convergence before interpreting anything.
mcmc <- read.csv("mcmc_out.txt", header = TRUE)
plot(mcmc$logLik ~ mcmc$generation, type = "l")
# ESS should be >> 200 for all parameters; use coda::effectiveSize()

# 6. Summarize the posterior of rate shifts.
shift_probs <- summary(edata)
print(shift_probs)          # table of cumulative shift probabilities per branch

# 7. Plot mean net diversification rates on the tree.
plot.bammdata(edata, lwd = 2, legend = TRUE)

# 8. Extract the credible shift set (CSS) — the smallest set of
#    distinct shift configurations explaining ≥ 95 % of posterior.
css <- credibleShiftSet(edata, expectedNumberOfShifts = 1, threshold = 5)
plot.credibleshiftset(css)
```
<!-- tealc:example-end -->

<!-- tealc:gotchas-start -->
## Gotchas we've hit

- **Prior sensitivity on number of shifts.** Moore et al. (2016, *PNAS*) showed the Poisson prior on the number of rate shifts is not independent of tree size, so Bayes factors comparing shift-count models are not reliable. Always report the prior you used and run a prior sensitivity check by varying `expectedNumberOfShifts`.

- **MCMC non-convergence on large trees.** On trees with > 500 tips, chains often need > 10 million generations to achieve adequate ESS. Always inspect the `mcmc_out.txt` trace in `coda` before interpreting results; low ESS on `logLik` or `N_shifts` means the chain has not mixed.

- **Ultrametric tree requirement.** BAMM silently produces nonsense if the tree deviates even slightly from ultrametricity (floating-point rounding from chronogram software is a common culprit). Run `ape::is.ultrametric(tree, tol = 1e-5)` and force ultrametricity with `phytools::force.ultrametric()` if needed before writing the control file.

- **Sampling fraction misspecification.** Passing a single global fraction when clades have very different sampling coverage inflates apparent rate shifts at the base of poorly sampled clades. Supply a clade-specific sampling fraction file whenever coverage varies by more than ~20 % across major groups.
<!-- tealc:gotchas-end -->

<!-- tealc:papers-start -->
## Key papers that use this method in the lab

*No lab papers ingested yet — this page will update as papers are added to /knowledge/papers/.*
<!-- tealc:papers-end -->

<!-- user-start -->
<!-- user-end -->
