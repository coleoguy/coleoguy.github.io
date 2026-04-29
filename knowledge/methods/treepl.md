---
layout: default
title: "treePL — Divergence-time dating at scale"
method_slug: treepl
language: C++
package: treePL
depends_on_concepts: [divergence-time-estimation, penalized-likelihood, fossil-calibrations]
appears_in_topics: []
appears_in_papers: []
difficulty: intermediate
last_updated: 2026-04-29
permalink: /knowledge/methods/treepl/
---
# treePL — Divergence-time dating at scale

<!-- tealc:method-start -->
**What it does.** treePL estimates [divergence times](/knowledge/concepts/divergence-time-estimation/) on a fixed, ultrametric or non-ultrametric phylogeny using a [penalized likelihood](/knowledge/concepts/penalized-likelihood/) framework. It takes a rooted tree with branch lengths (typically substitutions/site), one or more [fossil calibrations](/knowledge/concepts/fossil-calibrations/) as node-age constraints, and a smoothing parameter λ that controls rate autocorrelation across the tree. The output is a time-calibrated (ultrametric) tree with estimated node ages. The canonical C++ implementation is the standalone `treePL` binary, and it scales to trees with thousands of tips — far beyond what Bayesian alternatives typically handle in reasonable wall-clock time.

**When to use it.**
- Your tree has hundreds to tens of thousands of tips and Bayesian node-dating (e.g., BEAST2, MCMCTree) is computationally prohibitive.
- You have a fixed, well-supported topology and want node ages without re-estimating topology.
- You have a modest number of reliable fossil calibrations (minimum one; a few well-placed calibrations are better than many uncertain ones).
- You need a quick turnaround to generate a dated tree for downstream macroevolutionary analyses (diversification rates, trait evolution).
- You are working with a supermatrix-derived tree where branch lengths are already estimated and you do not want to re-run the full model.

**When NOT to use it.**
- Your primary goal is rigorous uncertainty quantification on node ages — treePL produces point estimates via optimization, not a posterior distribution; use BEAST2 or MCMCTree instead.
- Your tree topology is uncertain and you want co-estimation of topology and dates.
- You have very few tips (< ~50) and Bayesian methods are tractable — the Bayesian posterior will better propagate calibration uncertainty.
- You need a relaxed clock model with an explicit prior on rate variation across lineages (e.g., uncorrelated lognormal); treePL's rate-smoothing is a penalty, not a mechanistic rate prior.
- You require formal statistical model testing between clock models — treePL does not provide likelihood-ratio tests or AIC/BIC in a comparable form.
<!-- tealc:method-end -->

<!-- tealc:example-start -->
## Worked example

```bash
# treePL minimal reproducible example
# Inputs:
#   my_tree.tre   — Newick tree with branch lengths in substitutions/site
#   treepl.conf   — treePL configuration file (see below)
# Output:
#   dated_tree.tre — ultrametric Newick tree with node ages

# ── Step 1: Write the configuration file ──────────────────────────────────
cat > treepl.conf << 'EOF'
treefile = my_tree.tre          # input topology + branch lengths
smooth   = 100                  # smoothing parameter (optimize this; see Step 2)
mrca     = ROOT taxon_A taxon_B # defines the MRCA to calibrate
min      = ROOT 300             # minimum age (Ma) for that MRCA
max      = ROOT 350             # maximum age (Ma) for that MRCA
nthreads = 4                    # parallelize gradient calculations
outfile  = dated_tree.tre       # output ultrametric tree
EOF

# ── Step 2: Cross-validate to choose the smoothing parameter ─────────────
# treePL can prune random subsets of calibrations and score fit.
# Run with 'prime' mode to test a range of smoothing values.
cat > treepl_cv.conf << 'EOF'
treefile = my_tree.tre
smooth   = 0.001 0.01 0.1 1 10 100 1000 10000   # values to test
prime                                             # cross-validation mode
mrca     = ROOT taxon_A taxon_B
min      = ROOT 300
max      = ROOT 350
nthreads = 4
outfile  = dated_tree_cv.tre
EOF

treePL treepl_cv.conf   # inspect output log to select best smooth value

# ── Step 3: Run final dating with the best smoothing value ───────────────
treePL treepl.conf

# ── Interpret output ─────────────────────────────────────────────────────
# dated_tree.tre is a Newick file where branch lengths are now in time units
# (same units as your calibration ages, e.g., Ma).
# Load in R:
#   library(ape)
#   tr <- read.tree("dated_tree.tre")
#   plot(tr)  # node ages are branch lengths summed from tips
```
<!-- tealc:example-end -->

<!-- tealc:gotchas-start -->
## Gotchas we've hit

- **Smoothing parameter choice dominates node-age estimates.** Running treePL with a single arbitrary λ produces confidently wrong ages. Always run the cross-validation (`prime`) mode across several orders of magnitude before the final analysis.
- **Negative branch lengths after dating.** If the input tree has very short or zero-length branches, treePL can produce negative branches in the dated output. Check and collapse near-zero branches in the input tree before running.
- **Calibration node MRCA definition errors.** The `mrca` block requires taxon names that are leaves in the tree — misspelled or absent taxa silently drop the calibration. Validate all taxon names against the tree's tip labels before submitting.
- **Wall-clock vs. substitution-rate units.** treePL expects branch lengths in substitutions per site; if your tree was inferred with rate-scaled lengths already in time, the dated output will be double-scaled. Confirm your input branch-length units before running.
<!-- tealc:gotchas-end -->

<!-- tealc:papers-start -->
## Key papers that use this method in the lab

*No lab papers ingested yet — this page will update as papers are added to /knowledge/papers/.*
<!-- tealc:papers-end -->

<!-- user-start -->
<!-- user-end -->
