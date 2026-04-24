---
layout: default
title: "SIMMAP"
concept_slug: simmap
aliases: ["SIMMAP", "stochastic character mapping", "stochastic mapping", "Bayesian stochastic mapping"]
prerequisites: [mk-model, ancestral-state-reconstruction]
appears_in_topics: [ancestral_state_reconstruction, sex_chromosome_evolution, karyotype_evolution_overview]
related_concepts: [mk-model, ancestral-state-reconstruction, bisse]
primary_citation: null
difficulty: advanced
last_updated: 2026-04-23
permalink: /knowledge/concepts/simmap/
---
<!-- tealc:card-start -->
# SIMMAP

**One-sentence definition.** SIMMAP (Stochastic Mapping) is a Bayesian method that samples complete histories of character-state transitions mapped continuously onto each branch of a phylogeny, providing a posterior distribution over the number and timing of each transition.

**One-sentence analogy.** SIMMAP is like asking not just "what state was an ancestor in?" but "draw me a full movie of how the trait changed across the whole tree, accounting for uncertainty" — you get thousands of such movies and summarize them statistically.

**Why it matters.** Stochastic mapping is central to the lab's work because it allows co-occurrence analyses (e.g., do Y chromosome gains co-occur with reductions in autosome number?), expected state dwell times, and transition count posteriors — quantities that simple parsimony or marginal likelihood reconstruction cannot provide. In Adephaga beetles, stochastic mapping over karyotype and sex chromosome states simultaneously estimates that at least 49% of Y chromosome gains co-occur with autosome-number reductions consistent with X–autosome fusions. Summary statistics from 1,000 stochastic maps are routinely reported in the lab's chromosome evolution papers.

**Where you meet it in the wiki.**
- [Ancestral state reconstruction](/knowledge/topics/ancestral_state_reconstruction/) — stochastic mapping as the Bayesian complement to marginal reconstruction.
- [Sex chromosome evolution](/knowledge/topics/sex_chromosome_evolution/) — stochastic mapping used to quantify Y-gain co-occurrence with fusion events.
- [Karyotype evolution overview](/knowledge/topics/karyotype_evolution_overview/) — SIMMAP for chromosome number and state histories.

**Primary citation.** null

**Prerequisites:** [Mk model](/knowledge/concepts/mk-model/), [ancestral state reconstruction](/knowledge/concepts/ancestral-state-reconstruction/)
**Next, learn about:** [BiSSE](/knowledge/concepts/bisse/), [ancestral state reconstruction](/knowledge/concepts/ancestral-state-reconstruction/)
<!-- tealc:card-end -->

<!-- user-start -->
<!-- user-end -->
