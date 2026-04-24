---
layout: default
title: "Mk Model"
concept_slug: mk-model
aliases: ["Mk model", "Markov model", "Markov k-state model", "continuous-time Markov chain", "CTMC", "equal-rates model", "ARD model"]
prerequisites: []
appears_in_topics: [ancestral_state_reconstruction, karyotype_evolution_overview, phylogenetic_comparative_methods]
related_concepts: [ancestral-state-reconstruction, simmap, bisse]
primary_citation: null
difficulty: intermediate
last_updated: 2026-04-23
permalink: /knowledge/concepts/mk-model/
---
<!-- tealc:card-start -->
# Mk Model

**One-sentence definition.** The Mk model is a continuous-time Markov chain for discrete trait evolution on a phylogeny, where each trait state can transition to any other at a rate governed by a rate matrix Q, and likelihood is computed by integrating over all possible ancestral histories.

**One-sentence analogy.** The Mk model treats trait evolution like a random walk where a ball in one state can roll to any adjacent state at a fixed rate — the phylogeny is the track, and the observed tip states let you infer the rates and likely starting points.

**Why it matters.** The Mk model is the foundational engine behind ancestral state reconstruction, stochastic character mapping (SIMMAP), BiSSE, and most comparative discrete-trait analyses in the lab. Key choices — equal-rates vs. all-rates-different, reversible vs. irreversible, number of hidden states — critically change inferences. In haplodiploidy evolution, permitting reversions (two-rate model) versus forbidding them (one-rate model) changes the estimated number of independent origins from 12.9 to 7.9. Getting the model right is not a formality.

**Where you meet it in the wiki.**
- [Ancestral state reconstruction](/knowledge/topics/ancestral_state_reconstruction/) — Mk model is the standard likelihood engine for ASR.
- [Karyotype evolution overview](/knowledge/topics/karyotype_evolution_overview/) — Mk used to model chromosome state transitions.
- [Phylogenetic comparative methods](/knowledge/topics/phylogenetic_comparative_methods/) — Mk as the discrete-trait base model.

**Primary citation.** null

**Prerequisites:** none
**Next, learn about:** [ancestral state reconstruction](/knowledge/concepts/ancestral-state-reconstruction/), [SIMMAP](/knowledge/concepts/simmap/), [BiSSE](/knowledge/concepts/bisse/)
<!-- tealc:card-end -->

<!-- tealc:explainer-start -->
## Background

Pagel (1994) proposed the Mk model to fit discrete character evolution on phylogenies using maximum likelihood. The name comes from "Markov k-state model." The model is a continuous-time Markov chain (CTMC): a character in state i can switch to state j at any instant, governed by a rate parameter. The chain has no memory; the probability of the next transition depends only on the current state. This memoryless property is both the model's strength and its central assumption.

The Mk model also assumes that characters evolve independently along each branch. For chromosome-count evolution this matters: we treat chromosome number transitions as a single process running along the tree, not something coupled to body size or mating system, unless we explicitly model that coupling with tools like BiSSE or chromePlus.

## How it works

The Mk model specifies a rate matrix Q of size k x k, where k is the number of character states. Each off-diagonal entry q\_ij is the instantaneous rate of transitioning from state i to state j. The diagonal entries are set so each row sums to zero. The probability of transitioning from state i to state j over a branch of length t is the (i, j) entry of the matrix exponential e^(Qt).

Three common parameterizations appear in the literature. The equal-rates (ER) model forces all off-diagonal entries to a single rate. The symmetric (SYM) model allows each pair of states to share a forward and reverse rate. The all-rates-different (ARD) model estimates every entry independently. We choose among them by comparing likelihoods with AIC or BIC.

Likelihood across the whole tree comes from Felsenstein's pruning algorithm. Starting at the tips with observed states, we propagate conditional likelihoods up through the nodes, integrating over all possible ancestral states at each internal node. The result is the probability of observing the tip data given Q and the tree.

For chromosome number the state space spans dozens of integer values. The chromePlus package extends the Mk framework by building a structured Q matrix with separate rate parameters for gains, losses, and polyploidy events, and by coupling chromosome number to a binary trait so that rate parameters can differ across trait states.

## A worked example

Suppose we study chromosome number evolution in Coleoptera, where haploid counts range from 5 to 30. We define 26 states. The Q matrix has a banded structure: nonzero off-diagonal entries appear only between adjacent counts (gains: i to i+1; losses: i to i-1) and between i and 2i for polyploidy. All other entries are zero by assumption, which keeps the model identifiable.

We fit the model with MCMC. The sampler proposes new values for the gain rate, loss rate, and polyploidy rate, then computes the pruning likelihood for each proposal. After the chain converges, we have a posterior distribution over each rate. A typical result shows the loss rate three to five times higher than the gain rate, and the polyploidy rate an order of magnitude lower. This ordering is consistent with chromosome loss being common and polyploidy being rare but largely irreversible. We then reconstruct the most probable chromosome count at each internal node by integrating those posterior rates through the pruning algorithm.

## Common misconceptions

- The Mk model is not a parsimony method. Parsimony minimizes the number of transitions. The Mk model asks which rates make the observed tip data most probable. The two give different answers on unbalanced trees and when rates are high.
- "Equal rates" does not mean "no evolution." ER says every pair of states transitions at the same rate. A single-rate model with a high rate still predicts rapid evolution; it just does not predict directional asymmetry.
- State ordering matters for ordered Mk. An ordered model restricts Q so transitions must pass through intermediate states (e.g., going from count 10 to 12 requires passing through 11). This is appropriate for chromosome number but not for nominal states like sex-determination mechanism.
- The Mk model does not separate observation error from evolutionary rate. If a species is polymorphic for chromosome number, forcing it into one tip state mixes observation error into the rate estimate.
- Fitting Mk to a single fixed tree propagates tree uncertainty into rate estimates. We suggest fitting rate models across a posterior sample of trees when branch lengths are uncertain.

## How to spot it in papers

- "We fitted a continuous-time Markov model to discrete character data" is the standard phrasing; "Q-matrix" in a comparative-methods paper almost always signals Mk or a Mk-derived model.
- AIC or BIC comparisons between ER, SYM, and ARD models show that the authors used the Mk framework to select a rate parameterization.
- Posterior rate plots labeled "gain rate" and "loss rate" indicate a Bayesian Mk analysis, often run through chromePlus or diversitree.
- "Stochastic character mapping" or "SIMMAP" means the authors sampled histories from an Mk posterior, not a separate model.
- State-dependent diversification papers (BiSSE, HiSSE, MuSSE) embed an Mk process inside a birth-death model; reported transition rates between states come from that Mk component.

## Further reading

Within-wiki concepts and methods that build directly on the Mk model:

- [chromePlus](/knowledge/methods/chromeplus/) — extends Mk to chromosome number with structured gain, loss, and polyploidy rates
- [ancestral-state-reconstruction](/knowledge/concepts/ancestral-state-reconstruction/) — Mk likelihood as the engine for reconstructing ancestral states
- [simmap](/knowledge/concepts/simmap/) — stochastic character mapping samples full evolutionary histories from the Mk posterior
- [bisse](/knowledge/concepts/bisse/) — embeds an Mk transition process inside a state-dependent speciation and extinction model
<!-- tealc:explainer-end -->

<!-- user-start -->
<!-- user-end -->
