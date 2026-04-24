---
layout: default
title: "Ancestral State Reconstruction"
topic_slug: ancestral_state_reconstruction
last_updated: 2026-04-21T18:09:42.808876+00:00
papers_supporting: [1c95b7d3177f643f9388933de21d260747900051b120cf7a0774e24799ba33ca]
permalink: /knowledge/topics/ancestral_state_reconstruction/
category: "Quantitative genetics & epistasis"
---
<!-- tealc:lead-start -->
<div class="wiki-lead" data-active="researcher">
<div data-register="researcher" markdown="1">

Ancestral state reconstruction (ASR) is a phylogenetic toolkit for inferring the evolutionary history of discrete or continuous traits across a clade. A central practical challenge is model choice: whether to allow trait transitions in one direction only (irreversible model) or in both directions (reversible model), and how that choice shapes inferred origin counts and the apparent lability of a character.

A vivid illustration comes from the evolution of haplodiploidy in Acari (mites and ticks). Under a one-rate irreversible model — permitting only transitions from diplodiploidy to haplodiploidy — ASR recovers a mean of **12.9 independent origins** of haplodiploidy. Relaxing the constraint to a two-rate model that also allows reversions yields a lower mean of **7.9 origins**, because some internal nodes are reinterpreted as secondary losses rather than independent gains. Despite the apparent numerical support for reversibility, the evidence for actual transitions *back* to diplodiploidy is limited: the signal appears to be driven largely by a single deeply-nested haplodiploid taxon (*Parasitidae* sp.), and removing it shifts model preference back toward irreversibility ([Blackmon et al. 2015, Finding 3](/knowledge/papers/10_1111_evo_12792/#finding-3)).

This example highlights two recurring lessons in ASR practice: (1) origin counts are sensitive to which transitions the model permits, and (2) a handful of phylogenetically anomalous tips can disproportionately influence inferences about reversibility.

</div>
<div data-register="student" markdown="1">

<div class="wiki-lead" data-active="student">

[Ancestral state reconstruction](/knowledge/concepts/ancestral-state-reconstruction/) (ASR) is a method that scientists use to figure out how traits evolved across a family tree of related organisms. One key decision is whether to assume a trait can only change in one direction (like a light switch that only turns on, never off) or in both directions (like a regular switch). This choice can dramatically change how many times scientists think a trait independently evolved.

A great example comes from studying how reproduction systems evolved in mites and ticks. When scientists assumed that organisms could only switch from making males and females (diploid) to a system where some individuals are haploid, they counted an average of **12.9 separate times** this switch happened. But when they allowed the possibility of switching back to the diploid system, the count dropped to **7.9 origins**, because some cases that looked like new origins were actually reversals to the old system. However, the evidence for actually switching back is weak — it mostly comes from one unusual species buried deep in the family tree (*Parasitidae* sp.), and if you remove that one species, the data again supports the one-way model ([Blackmon et al. 2015, Finding 3](/knowledge/papers/10_1111_evo_12792/#finding-3)). This teaches two important lessons: first, the number of origins you find depends heavily on which changes your model allows, and second, a single oddball organism can sometimes tip the scales toward a conclusion that might not hold up under closer inspection.

</div>

</div>
</div>
<!-- tealc:lead-end -->

<!-- tealc:auto-start -->
# Ancestral State Reconstruction

<!-- tealc:freshness-start -->
<aside class="wiki-freshness" aria-label="Page provenance">
<span class="wf-label">Composed by Tealc</span>
<span class="wf-date">2026-04-21</span>
<span class="wf-dot">·</span>
<span class="wf-sources">1 source</span>
<span class="wf-dot">·</span>
<span class="wf-review">Last reviewed by Heath: never</span>
</aside>
<!-- tealc:freshness-end -->


## Current understanding

Ancestral state reconstruction (ASR) is a phylogenetic toolkit for inferring the evolutionary history of discrete or continuous traits across a clade. A central practical challenge is model choice: whether to allow trait transitions in one direction only (irreversible model) or in both directions (reversible model), and how that choice shapes inferred origin counts and the apparent lability of a character.

A vivid illustration comes from the evolution of haplodiploidy in Acari (mites and ticks). Under a one-rate irreversible model — permitting only transitions from diplodiploidy to haplodiploidy — ASR recovers a mean of **12.9 independent origins** of haplodiploidy. Relaxing the constraint to a two-rate model that also allows reversions yields a lower mean of **7.9 origins**, because some internal nodes are reinterpreted as secondary losses rather than independent gains. Despite the apparent numerical support for reversibility, the evidence for actual transitions *back* to diplodiploidy is limited: the signal appears to be driven largely by a single deeply-nested haplodiploid taxon (*Parasitidae* sp.), and removing it shifts model preference back toward irreversibility ([Blackmon et al. 2015, Finding 3](/knowledge/papers/10_1111_evo_12792/#finding-3)).

This example highlights two recurring lessons in ASR practice: (1) origin counts are sensitive to which transitions the model permits, and (2) a handful of phylogenetically anomalous tips can disproportionately influence inferences about reversibility.

## Supporting evidence

- **Model dependence of origin counts in Acari.** The estimated number of independent origins of haplodiploidy ranges from 7.9 (two-rate model) to 12.9 (one-rate model), with only limited support for the hypothesis that reversions from haplodiploidy back to diplodiploidy are possible. ([Blackmon et al. 2015, Finding 3](/knowledge/papers/10_1111_evo_12792/#finding-3))

## Contradictions / open disagreements

The two models applied to Acari haplodiploidy yield divergent origin counts (7.9 vs. 12.9), reflecting a genuine tension between parsimony-style irreversible models and more parameter-rich reversible ones. The apparent support for reversibility collapses when a single influential tip is removed, raising the question of whether the two-rate model is capturing biology or overfitting sparse data. Broader taxon sampling and independent data on ploidy in contentious families would help resolve this ambiguity.

## Tealc's citation-neighborhood suggestions

- Pagel (1994) on discrete character evolution methods (Discrete/BayesTraits) — directly relevant to rate-model choice in ASR.
- Maddison & Maddison (Mesquite) parsimony-based ASR approaches — useful contrast to likelihood methods used in the Acari study.
- Beaulieu & O'Meara on hidden-rates models, which can address apparent irreversibility driven by rate heterogeneity rather than true directionality.

## Related on the Blackmon Lab site

- [Blackmon et al. 2015](/knowledge/papers/10_1111_evo_12792/)
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
<!-- tealc:related-end -->
