---
layout: default
title: "Meiotic Drive"
topic_slug: meiotic_drive
last_updated: 2026-04-21T18:28:34.512409+00:00
papers_supporting: [2868f9fb2c04a641393569fdd996eb3a6385c0c5ef19eff83448aea96d7cfbc9]
permalink: /knowledge/topics/meiotic_drive/
category: "Sex chromosomes"
---
<!-- tealc:auto-start -->
# Meiotic Drive

## Current understanding

Meiotic drive refers to the non-Mendelian transmission of chromosomal elements — one homolog is preferentially transmitted to the egg rather than the polar body, violating the expected 50:50 segregation ratio. Because drive can distort allele frequencies independently of fitness, it is hypothesized to influence karyotype evolution, speciation, and long-term lineage diversification. A key open question is whether the *polarity* of drive (i.e., which homolog "wins" the race to the egg) is evolutionarily labile, and whether karyotypic states shaped by drive history translate into macroevolutionary differences in diversification.

Work on mammals suggests that drive polarity is indeed labile but that its switching rate varies dramatically across major clades. Cetartiodactyla shows the highest inferred rate of polarity switching, with a mean waiting time between transitions of approximately 10.8 million years, while Primates shows rates nearly an order of magnitude slower, with a median waiting time of approximately 90.9 million years [Blackmon et al. 2019, Finding 2](/knowledge/papers/2019_mammals/#finding-2). This heterogeneity implies that the evolutionary dynamics of meiotic drive are not uniform across the mammalian tree and that clade-specific biology — perhaps relating to differences in oogenesis, genome architecture, or effective population size — modulates how frequently drive polarity flips.

Despite this evolutionary lability in drive polarity, there is no detectable macroevolutionary signature of karyotype mismatch on net diversification rates. A BiSSE analysis across mammals found that lineages with matched versus mismatched karyotypes (a proxy for ongoing or recent drive) do not differ significantly in speciation or extinction rates [Blackmon et al. 2019, Finding 1](/knowledge/papers/2019_mammals/#finding-1). This is a notable negative result: even if drive reshapes karyotypes, those karyotypic states do not appear to confer consistent macroevolutionary advantages or disadvantages at the timescales captured by extant mammalian phylogenies.

## Supporting evidence

- **Clade-specific polarity switching rates** — Subclade chromePlus analyses recover substantial variation in how often meiotic drive polarity transitions occur, ranging from ~10.8 Myr (Cetartiodactyla) to ~90.9 Myr (Primates). [Blackmon et al. 2019, Finding 2](/knowledge/papers/2019_mammals/#finding-2)

- **No diversification effect of karyotype mismatch** — BiSSE modeling on the mammalian tree returns no statistically detectable difference in net diversification between matched and mismatched karyotype states, directly challenging the chromosomal speciation hypothesis as applied to drive-generated karyotype variation. [Blackmon et al. 2019, Finding 1](/knowledge/papers/2019_mammals/#finding-1)

## Contradictions / open disagreements

**BiSSE reliability vs. null diversification result.** The negative finding on karyotype-driven diversification rests on BiSSE, a method known to produce elevated false-positive rates when diversification is heterogeneous across the tree. The authors themselves document inflated false-positive rates in simulations on the cetacean tree. It is therefore possible that the method lacks power to detect a real effect, or alternatively that spurious rate variation in other regions of the tree obscures a true signal. The finding should be interpreted as "no detectable effect" rather than a strong refutation of the chromosomal speciation hypothesis [Blackmon et al. 2019, Finding 1](/knowledge/papers/2019_mammals/#finding-1).

**Mean vs. median for Primate switching rate.** The ~90.9 Myr figure for Primates is reported as a *median* waiting time in the source text, not a mean, creating a minor inconsistency in how the statistic is described. Given that transition-rate distributions are typically right-skewed, the mean could differ substantially, and rates inferred from trees sampling only 12–30% of extant species per clade carry additional uncertainty [Blackmon et al. 2019, Finding 2](/knowledge/papers/2019_mammals/#finding-2).

## Tealc's citation-neighborhood suggestions

- Studies using population-genetic models of centromere drive (e.g., Henikoff et al. on centromere-binding proteins) would complement the macroevolutionary perspective here.
- Empirical work on asymmetric female meiosis in Cetartiodactyla specifically could help explain why polarity switching is so much more frequent in that clade.

## Related on the Blackmon Lab site

- [Blackmon et al. 2019](/knowledge/papers/2019_mammals/)
<!-- tealc:auto-end -->
