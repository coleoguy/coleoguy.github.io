---
layout: default
title: "Bisse"
topic_slug: BiSSE
last_updated: 2026-04-22T13:12:59.970491+00:00
papers_supporting: [10.1093/sysbio/syu131]
permalink: /knowledge/topics/BiSSE/
category: "Bioinformatics & tools"
---
<!-- tealc:auto-start -->
# BiSSE

## Current understanding

BiSSE (Binary State Speciation and Extinction) links a binary trait to lineage-specific speciation and extinction rates. The appeal is obvious — if a character truly drives diversification, BiSSE should detect it. The problem is that BiSSE also detects associations that don't exist, and the false-positive rate is not merely elevated but catastrophically so on real phylogenies with heterogeneous diversification dynamics.

The clearest demonstration comes from neutral-character simulations on an empirical cetacean phylogeny. When characters are simulated with no state-dependent signal whatsoever, more than 77% of datasets still return a statistically significant association between character state and speciation rate at p < 0.05, and 58% reject the character-independent model at p < 0.001 — a threshold that should represent strong evidence. This is not a modest inflation of Type I error; it is near-total loss of specificity on a phylogeny that happens to capture the explosive dolphin radiation ([10.1093/sysbio/syu131, Finding 1](/knowledge/papers/10_1093_sysbio_syu131/#finding-1)).

A sharper test uses taxon name length — a character with no conceivable causal relationship to speciation. Across vertebrate subtrees, more than 69% produce a significant correlation between name length and speciation rate, and for ray-finned fishes the proportion approaches 100% (60 of 61 subtrees). Because name length cannot cause anything, this result isolates the false-positive problem from any residual biological confound ([10.1093/sysbio/syu131, Finding 2](/knowledge/papers/10_1093_sysbio_syu131/#finding-2)).

The mechanism is straightforward: BiSSE attributes rate variation among lineages to the focal trait whenever it cannot be explained by the null model. On trees where diversification is genuinely heterogeneous — fast radiations, mass extinctions, unsampled clades — there is always unexplained rate variation for BiSSE to misappropriate. Any trait that happens to correlate with lineage identity, even partially, gets recruited as the spurious explanation.

## Supporting evidence

- [10.1093/sysbio/syu131, Finding 1](/knowledge/papers/10_1093_sysbio_syu131/#finding-1): On the empirical cetacean phylogeny, >77% of neutral character datasets showed a significant (p < 0.05) association with speciation rate under BiSSE; 58% rejected the character-independent model at p < 0.001.

- [10.1093/sysbio/syu131, Finding 2](/knowledge/papers/10_1093_sysbio_syu131/#finding-2): Taxon name length, a biologically arbitrary character, produced significant speciation-rate correlations in >69% of vertebrate subtrees and in 60 of 61 ray-finned fish subtrees.

## Contradictions / open disagreements

The magnitude of the false-positive problem documented here is tied to phylogenies with known, strong diversification heterogeneity. The cetacean tree has a well-characterized dolphin radiation that drives high rate variance across lineages. On trees with more homogeneous background rates, Type I error inflation may be considerably lower. The taxon-name-length test has a mild confounder as well: congeners share name prefixes, introducing weak phylogenetic signal into a character that is otherwise arbitrary. Some fraction of the near-100% false-positive rate in fishes could reflect that residual structure rather than diversification heterogeneity alone. Neither caveat rehabilitates BiSSE for general use, but they do mean the cetacean/fish numbers are likely upper bounds rather than universal baselines.

Whether hidden-state corrections (e.g., HiSSE) fully resolve the problem remains contested, and model adequacy testing for state-dependent diversification models is still an open area.

## Tealc's citation-neighborhood suggestions

- Rabosky & Goldberg 2015 (the source paper here) cite Maddison et al. 2007 (the original BiSSE paper) and Rabosky 2014 (BAMM) as key context — both would strengthen any discussion of why rate heterogeneity confounds trait-dependent models.
- Beaulieu & O'Meara 2016 (HiSSE) is the primary methodological response and should be cited alongside BiSSE critiques.

## Related on the Blackmon Lab site

- [Meiotic drive shapes rates of karyotype evolution in mammals](/knowledge/papers/10_1093_sysbio_syu131/) — source paper for the findings above.
<!-- tealc:auto-end -->
