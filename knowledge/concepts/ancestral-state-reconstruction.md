---
layout: default
title: "Ancestral State Reconstruction"
concept_slug: ancestral-state-reconstruction
aliases: ["ancestral state reconstruction", "ancestral state", "ancestral reconstruction", "ASR", "stochastic character mapping", "SIMMAP", "ancestral character state"]
prerequisites: [mk-model]
appears_in_topics: [ancestral_state_reconstruction, sex_chromosome_evolution, karyotype_evolution_overview]
related_concepts: [mk-model, simmap, bisse]
primary_citation: "10_1093_jhered_esw047#finding-1"
difficulty: intermediate
last_updated: 2026-04-23
permalink: /knowledge/concepts/ancestral-state-reconstruction/
---
<!-- tealc:card-start -->
# Ancestral State Reconstruction

**One-sentence definition.** Ancestral state reconstruction (ASR) is a phylogenetic method for inferring the most probable trait values of ancestral species given a tree topology, branch lengths, a model of trait evolution, and the observed trait values at the tips.

**One-sentence analogy.** ASR is like working backwards from the stories your grandchildren tell about a great-grandparent you never met — you triangulate what she was probably like from the pattern of traits distributed across her surviving descendants.

**Why it matters.** ASR is how the lab establishes evolutionary polarity — whether a given state is ancestral or derived. For sex chromosome evolution, likelihood-based ASR across a >13,000-species insect database places 100% posterior probability on male heterogamety at the insect root, confirming it as the ancestral state. Model choice matters critically: allowing irreversible vs. reversible transitions can change inferred origin counts by ~40% (e.g., 7.9 vs. 12.9 origins of haplodiploidy in mites depending on model).

**Where you meet it in the wiki.**
- [Ancestral state reconstruction](/knowledge/topics/ancestral_state_reconstruction/) — detailed treatment of methods and pitfalls.
- [Sex chromosome evolution](/knowledge/topics/sex_chromosome_evolution/) — ASR of heterogamety at insect root.
- [Karyotype evolution overview](/knowledge/topics/karyotype_evolution_overview/) — ASR of chromosome numbers and sex chromosome systems.

**Primary citation.**
> "We find strong evidence for the node leading to insects being male heterogametic (100% probability), but we have little power to distinguish between XY and XO sex chromosome systems (60% and 40% probability, respectively)."
— [Blackmon et al. 2017, Finding 1](/knowledge/papers/10_1093_jhered_esw047/#finding-1)

**Prerequisites:** [Mk model](/knowledge/concepts/mk-model/)
**Next, learn about:** [SIMMAP](/knowledge/concepts/simmap/), [BiSSE](/knowledge/concepts/bisse/)
<!-- tealc:card-end -->

<!-- tealc:explainer-start -->
## Background

Ancestral state reconstruction has a long history in comparative biology. Fitch (1971) and Farris (1970) each proposed parsimony algorithms that minimize the number of character-state changes required to explain observed tip values. Parsimony is fast and intuitive, but it is not model-based and gives no uncertainty estimates at ancestral nodes.

Pagel (1994, 1999) showed that likelihood-based ASR scores a character history against an explicit model of trait evolution and uses maximum likelihood to find the ancestral states that best fit the data. SIMMAP (Bollback 2006) extends this into a Bayesian framework, sampling from the posterior of complete character histories rather than returning a single best reconstruction.

We use ASR to ask whether a given state is ancestral or derived in a clade, and how many times it arose independently. Those questions sit at the center of karyotype evolution research.

## How it works

Likelihood ASR uses a pruning algorithm in two passes. The down-pass (tips to root) computes the conditional likelihood of all tip data given each possible ancestral state at each node. The up-pass (root to tips) combines information from both directions to produce a marginal probability distribution over states at each node. These marginal reconstructions appear as pie charts on published phylogenies.

Marginal reconstruction estimates the probability of each state at one node at a time. Joint reconstruction finds the single combination of states across all nodes that maximizes the likelihood of the whole tree. For questions about a single deep node, marginal reconstruction is appropriate.

Stochastic character mapping (SIMMAP) samples complete histories of state changes along every branch, weighted by their posterior probability. Summary statistics from many sampled histories (e.g., expected number of transitions, time in each state per branch) carry uncertainty that a single marginal reconstruction cannot provide.

The rate model matters. An equal-rates (ER) model forces all transition rates to be equal; an all-rates-different (ARD) model allows each pair of states its own rate; an irreversible model permits transitions in only one direction. Each model implies a different prior on ancestral states. We find that model choice changes inferred ancestral state counts by up to 40% in karyotype analyses, so model selection is not a formality.

## A worked example

Consider ASR of haploid chromosome number across beetles (order Coleoptera). We collect chromosome counts from museum databases, prune them to a time-calibrated phylogeny, and specify an ordered Mk model that allows chromosome number to change by one step at a time. We run marginal reconstruction at each internal node.

At a deep node, the output might show: n=9 with posterior probability 0.58, n=10 with posterior probability 0.31, and remaining probability spread across adjacent states. That spread is the honest answer. If we plot a pie chart on the tree, each slice represents that uncertainty directly.

A SIMMAP analysis of the same data produces 1,000 sampled histories. Summarizing across histories, we might find a mean of 14.2 (95% CI: 11-18) transitions from n=9 to n=10 across the Coleoptera phylogeny. That branch-level summary is only available from stochastic mapping, not from marginal node reconstruction alone.

## Common misconceptions

- **ASR is not the truth about the past.** It is the most probable state given a model, a tree, and modern tip data. The further back in time a node is, the thinner the data supporting it.
- **Parsimony is not model-neutral.** Parsimony implicitly assumes all transitions are equally costly and rates are low. In fast-evolving systems like chromosome number, parsimony systematically underestimates the number of transitions that occurred.
- **High posterior probability does not mean certainty.** A posterior of 0.70 on state X means there is a 30% chance the truth is something else, and that uncertainty compounds across chained inferences.
- **Model mismatch produces confident wrong answers.** A reversible model fit to a trait that rarely reverses will spread probability across biologically implausible states. Model selection with AIC, BIC, or Bayes factors is not optional.
- **ASR does not test for directional trends.** Showing that the reconstructed root state is X does not show that evolution proceeds from X to Y. Testing trends requires asymmetric rate models or state-dependent diversification models such as BiSSE.

## How to spot it in papers

- **Pie charts at internal nodes** on a phylogeny, where each slice represents the posterior or likelihood probability of a character state at that node.
- **Color-painted branches** where branch color or intensity reflects the most probable state or the expected time in a state from stochastic mapping.
- **SIMMAP-style branch histories** where every branch segment carries a state value drawn from a sampled history, appearing as striped or segmented branch colors.
- **"Posterior probability of state X at the root"** in Results or Table captions, with values between 0 and 1 for each state at a named node.
- **Transition counts with credible intervals** (e.g., "mean 14.2 transitions, 95% CI 11-18"), which come from summarizing many stochastic maps rather than from a single reconstructed history.

## Further reading

Within this wiki:

- [SIMMAP](/knowledge/concepts/simmap/) covers Bayesian stochastic character mapping in detail, including how to interpret sampled histories and summarize posterior transition counts.
- [Mk model](/knowledge/concepts/mk-model/) explains the continuous-time Markov model that underlies likelihood and Bayesian ASR for discrete characters.
- [chromePlus](/knowledge/methods/chromeplus/) documents the R package we use for chromosome number evolution models, which builds on likelihood ASR internally to estimate ancestral chromosome numbers and transition rates across large trees.
<!-- tealc:explainer-end -->

<!-- user-start -->
<!-- user-end -->
