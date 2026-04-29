---
layout: default
title: "MrBayes — Bayesian Phylogenetics"
method_slug: mrbayes
language: C
package: MrBayes 3.2
depends_on_concepts: []
appears_in_topics: []
appears_in_papers: []
difficulty: intermediate
last_updated: 2026-04-29
permalink: /knowledge/methods/mrbayes/
---
# MrBayes — Bayesian Phylogenetics

<!-- tealc:method-start -->
**What it does.** MrBayes estimates phylogenetic trees and model parameters using Bayesian inference with Markov chain Monte Carlo (MCMC) sampling. It accepts aligned sequence data (nucleotide, amino acid, or morphological characters) and returns a posterior distribution over topologies and branch lengths under a user-specified substitution model. The canonical implementation is MrBayes 3.2, which supports partitioned analyses, mixed models, and parallel computation via MPI.

**When to use it.**
- You want a full posterior distribution over trees rather than a single point estimate, and credible intervals on topology or divergence times matter for your conclusions.
- Your alignment is partitioned (e.g., separate models for each codon position, or combined morphological and molecular data).
- You are estimating divergence times and want to integrate over tree uncertainty alongside clock and rate parameters.
- Your dataset is small to moderate in size (roughly ≤ 1,000 tips, ≤ a few million site-by-MCMC-step evaluations) and MCMC mixing is tractable.
- You need a morphological clock analysis using the Mk model for discrete characters.

**When NOT to use it.**
- Very large trees (thousands of tips) where MCMC convergence becomes prohibitively slow — use IQ-TREE (ML) or a variational Bayes alternative instead.
- You need ultrafast bootstrap approximations for a quick topology screen; IQ-TREE's UFBoot is faster for that purpose.
- Convergence diagnostics (average standard deviation of split frequencies, PSRF) remain elevated after long runs — the chain is stuck and results should not be trusted until mixing is confirmed.
- Genome-scale alignments with millions of sites make single-machine MCMC impractical; consider ExaBayes or distributed ML approaches.
<!-- tealc:method-end -->

<!-- tealc:example-start -->
## Worked example

```bash
# Minimal MrBayes block appended to a NEXUS alignment file.
# Assumes: mydata.nex contains an aligned DNA matrix.

# 1. Open MrBayes interactively or pipe the block below:
#    mb mydata.nex

begin mrbayes;

  # 2. Set the substitution model (GTR + Gamma + Inv. sites)
  lset nst=6 rates=invgamma;

  # 3. Set priors (defaults are reasonable for most DNA data)
  #    Uncomment to override branch-length prior if tree is expected deep:
  # prset brlenspr=unconstrained:exp(10.0);

  # 4. Configure two independent runs, 4 chains each
  mcmcp nruns=2 nchains=4 ngen=1000000 samplefreq=1000
        printfreq=10000 diagnfreq=10000
        filename=mydata_out;

  # 5. Run MCMC
  mcmc;

  # 6. Summarize trees, discarding first 25% as burnin
  sumt burnin=250 contype=allcompat;

  # 7. Summarize parameter estimates
  sump burnin=250;

end;

# OUTPUT INTERPRETATION:
# sumt writes mydata_out.con.tre — the consensus tree with posterior
#   probabilities on nodes.
# sump writes ESS values and parameter means; check that ESS > 200
#   and that the ASDSF (printed during mcmc) dropped below 0.01.
# If ASDSF does not converge, extend ngen or increase chain temperatures.
```
<!-- tealc:example-end -->

<!-- tealc:gotchas-start -->
## Gotchas we've hit

- **ASDSF never drops below 0.01.** This usually means chains are exploring different modes. Try increasing `nchains` to 8, raising the heating temperature (`temp=0.4`), or running longer. Do not summarize results until the diagnostic converges.
- **Flat or improper branch-length prior inflates long branches.** The default exponential(10) prior can produce anomalously long branches on sparse or divergent taxa. Switch to `brlenspr=unconstrained:exp(100)` for shallow trees or check the marginal branch-length distributions in `sump` output.
- **Partition model combinatorics explode run time.** Adding many partitions with unlinked parameters multiplies the parameter space. Link parameters that are not biologically justified to be independent (`unlink` only what you have a reason to free).
- **Output files silently overwrite previous runs.** MrBayes appends to existing `.p` and `.t` files if the filename matches a prior run. Always set a unique `filename` or remove old output files before restarting.
<!-- tealc:gotchas-end -->

<!-- tealc:papers-start -->
## Key papers that use this method in the lab

*No lab papers ingested yet — this page will update as papers are added to /knowledge/papers/.*
<!-- tealc:papers-end -->

<!-- user-start -->
<!-- user-end -->
