---
layout: default
title: "RevBayes — Probabilistic Graphical Model Phylogenetics"
method_slug: revbayes
language: C++ / Rev
package: RevBayes
depends_on_concepts: [markov-chain-monte-carlo, probabilistic-graphical-models, state-dependent-speciation-extinction]
appears_in_topics: []
appears_in_papers: []
difficulty: advanced
last_updated: 2026-04-29
permalink: /knowledge/methods/revbayes/
---
# RevBayes — Probabilistic Graphical Model Phylogenetics

<!-- tealc:method-start -->
**What it does.** RevBayes performs fully Bayesian inference of phylogenetic trees and evolutionary model parameters using [Markov chain Monte Carlo (MCMC)](/knowledge/concepts/markov-chain-monte-carlo/). Users specify models as explicit [probabilistic graphical models](/knowledge/concepts/probabilistic-graphical-models/) in the Rev scripting language, which means every node in the model graph — substitution rates, branch lengths, clock rates, diversification parameters — is a first-class random variable with a declared prior. The canonical implementation is the C++ engine with a Rev front end; inputs are aligned sequence matrices (or morphological matrices) plus any fossil/tip-date information, and the output is a posterior sample of trees and model parameters.

**When to use it.**
- You need to compose a novel model that no point-and-click program exposes (e.g. a relaxed-clock model layered on top of a biogeographic dispersal process).
- Your analysis requires joint inference across multiple data partitions with unlinked topologies or clock rates.
- You want full posterior uncertainty on divergence times, diversification rates, or ancestral states rather than a point estimate.
- You are running a trait-evolution or state-dependent speciation/extinction model ([SSE](/knowledge/concepts/state-dependent-speciation-extinction/)) and need a transparent, auditable model specification.
- Reproducibility is essential: Rev scripts fully document the model, priors, and MCMC settings in a single plain-text file.

**When NOT to use it.**
- You need maximum-likelihood trees quickly for a large dataset (>10 k tips, routine gene-tree estimation) — use [IQ-TREE](/knowledge/topics/iq_tree/) instead.
- Your team has no scripting experience and the analysis fits a standard model: [MrBayes](https://nbisweden.github.io/MrBayes/) or BEAST2 offer GUI-driven workflows with less overhead.
- You are running very large-scale divergence-time dating with hundreds of fossils and tight deadlines; BEAST2's StarBEAST3 pipeline is more optimized for that specific workflow.
- Convergence diagnostics show persistent poor mixing and you lack the compute to run long chains — consider simplifying the model or switching to variational Bayes approaches.
<!-- tealc:method-end -->

<!-- tealc:example-start -->
## Worked example

```rev
# Minimal RevBayes script: GTR+Gamma on a single partition
# Input: aligned FASTA converted to NEXUS at data/alignment.nex

# 1. Read data
data <- readDiscreteCharacterData("data/alignment.nex")
n_taxa <- data.ntaxa()
n_branches <- 2 * n_taxa - 3

# 2. Tree topology prior (uniform on labeled histories)
topology ~ dnUniformTopology(taxa=data.taxa())

# 3. Branch lengths: exponential prior on each
for (i in 1:n_branches) {
    bl[i] ~ dnExponential(10.0)
}
psi := treeAssembly(topology, bl)

# 4. GTR substitution model
pi ~ dnDirichlet(v(1,1,1,1))
er ~ dnDirichlet(v(1,1,1,1,1,1))
Q  := fnGTR(er, pi)

# 5. Gamma rate variation (4 categories)
alpha ~ dnExponential(1.0)
site_rates := fnDiscretizeGamma(alpha, alpha, 4)

# 6. PhyloCTMC likelihood
seq ~ dnPhyloCTMC(tree=psi, Q=Q, siteRates=site_rates, type="DNA")
seq.clamp(data)

# 7. MCMC
mymodel  = model(psi)
monitors = [ mnScreen(printgen=100),
             mnFile(filename="output/run.trees", printgen=10, psi),
             mnModel(filename="output/run.log",  printgen=10) ]
mymcmc   = mcmc(mymodel, monitors, moves=[
    mvNNI(topology, weight=10.0),
    mvSPR(topology, weight=5.0),
    mvScale(bl, weight=n_branches),
    mvScale(alpha),
    mvBetaSimplex(pi, weight=2.0),
    mvBetaSimplex(er, weight=3.0)
])
mymcmc.run(generations=50000)

# Output: output/run.trees  (posterior tree sample) +
#         output/run.log    (trace of all parameters)
# Summarize with: TreeAnnotator or R package RevGadgets
```
<!-- tealc:example-end -->

<!-- tealc:gotchas-start -->
## Gotchas we've hit

- **MCMC never converges on the topology.** A uniform topology prior combined with flat branch-length priors on large trees mixes poorly. Add `mvSubtreeScale` and increase `mvSPR` weight; monitor ESS on tree height, not just log-likelihood.
- **`dnPhyloCTMC` type mismatch.** Passing a morphological matrix without setting `type="Standard"` and coding=`"variable"` silently uses the wrong likelihood, inflating branch lengths. Always declare `type` explicitly and apply the ascertainment-bias correction (`coding="variable"`) for parsimony-informative-only morphological data.
- **Rev script silently uses stale `.trees` output.** If you re-run a script with a different model but forget to change the `filename` in `mnFile`, RevBayes appends to the old file. Always version output filenames or delete old runs before restarting.
- **Mixing failure with correlated parameters.** GTR exchangeabilities and base frequencies can be strongly correlated; a `mvDirichletSimplex` proposal (not just `mvBetaSimplex`) on the full 6-vector often improves mixing markedly.
<!-- tealc:gotchas-end -->

<!-- tealc:papers-start -->
## Key papers that use this method in the lab

*No lab papers ingested yet — this page will update as papers are added to /knowledge/papers/.*
<!-- tealc:papers-end -->

<!-- user-start -->
<!-- user-end -->
