---
layout: default
title: "BiSSE"
concept_slug: bisse
aliases: ["BiSSE", "Binary State Speciation and Extinction", "state-dependent diversification", "trait-dependent diversification", "HiSSE"]
prerequisites: [mk-model, ancestral-state-reconstruction]
appears_in_topics: [BiSSE, trait_dependent_diversification, phylogenetic_comparative_methods]
related_concepts: [mk-model, ancestral-state-reconstruction, simmap]
primary_citation: "10_1093_sysbio_syu131#finding-1"
difficulty: advanced
last_updated: 2026-04-23
permalink: /knowledge/concepts/bisse/
---
<!-- tealc:card-start -->
# BiSSE

**One-sentence definition.** BiSSE (Binary State Speciation and Extinction) is a phylogenetic model that jointly estimates speciation and extinction rates for each state of a binary trait, testing whether the trait causes lineage diversification to differ between the two states.

**One-sentence analogy.** BiSSE is like trying to determine whether left-handed vs. right-handed boxers win more bouts, using only the tournament bracket — but if the tournament has dramatic seeding biases, you'll find handedness "matters" even when it's coin-flipped.

**Why it matters.** BiSSE is widely used but catastrophically prone to false positives on real phylogenies with heterogeneous diversification dynamics. On the cetacean phylogeny, >77% of datasets simulated under a neutral character (no state-dependent effect) return a significant association at p < 0.05; even taxon name length — which cannot cause anything — shows significant speciation correlations in >69% of vertebrate subtrees. This means most published BiSSE results on real diversified trees require skepticism and model-adequacy testing.

**Where you meet it in the wiki.**
- [BiSSE](/knowledge/topics/BiSSE/) — detailed treatment of the false-positive problem.
- [Trait-dependent diversification](/knowledge/topics/trait_dependent_diversification/) — broader context of methods linking traits to macroevolution.
- [Phylogenetic comparative methods](/knowledge/topics/phylogenetic_comparative_methods/) — BiSSE in context.

**Primary citation.**
> "More than 77% of the 400 character sets showed a significant (p < 0.05) association between character state and speciation rate, and 58% rejected the character-independent model with great confidence (p < 0.001)."
— [Rabosky & Goldberg, Finding 1](/knowledge/papers/10_1093_sysbio_syu131/#finding-1)

**Prerequisites:** [Mk model](/knowledge/concepts/mk-model/), [ancestral state reconstruction](/knowledge/concepts/ancestral-state-reconstruction/)
**Next, learn about:** [SIMMAP](/knowledge/concepts/simmap/), [ancestral state reconstruction](/knowledge/concepts/ancestral-state-reconstruction/)
<!-- tealc:card-end -->

<!-- user-start -->
<!-- user-end -->
