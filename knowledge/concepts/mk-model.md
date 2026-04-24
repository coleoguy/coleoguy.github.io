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

<!-- user-start -->
<!-- user-end -->
