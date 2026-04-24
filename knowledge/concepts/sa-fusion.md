---
layout: default
title: "SA Fusion"
concept_slug: sa-fusion
aliases: ["SA fusion", "sex chromosome-autosome fusion", "sex-autosome fusion", "SA-fusion", "sexually antagonistic fusion"]
prerequisites: [sexual-antagonism, heterogamety, autosome]
appears_in_topics: [sex_chromosome_evolution, sexual_antagonism, chromosome_fusion, y_naught_asymmetry]
related_concepts: [sexual-antagonism, chromosome-fusion, neo-sex-chromosome, par]
primary_citation: "10_1017_s0016672300014051#finding-2"
difficulty: intermediate
last_updated: 2026-04-23
permalink: /knowledge/concepts/sa-fusion/
---
<!-- tealc:card-start -->
# SA Fusion

**One-sentence definition.** An SA fusion is a chromosomal fusion between a sex chromosome and an autosome that is favored by selection because it links a sexually antagonistic allele (one that benefits one sex at the other's expense) to the sex-determining region.

**One-sentence analogy.** Imagine two companies merging so that a profitable division (a male-benefit gene) always goes to the male headquarters — the merger is favored because it stops the profitable division from ever being sent to the female office.

**Why it matters.** SA fusions are predicted to occur at higher rates than random because they resolve intralocus sexual conflict, but this prediction is clade-specific. Theory shows that Y-autosome non-PAR fusions should establish at approximately three times the initial rate of X-autosome fusions under equivalent selection. Empirically, in *Habronattus* jumping spiders 8 of 10 fusions involve a sex chromosome — a result significant at p < 10⁻⁵ — while *Drosophila* show a paradoxical *deficit* of SA fusions. A critical refinement: fusions landing in the pseudoautosomal region (PAR) are actively harmful, not neutral.

**Where you meet it in the wiki.**
- [Sex chromosome evolution](/knowledge/topics/sex_chromosome_evolution/) — SA fusions drive sex chromosome diversification across taxa.
- [Sexual antagonism](/knowledge/topics/sexual_antagonism/) — SA-fusion theory and empirical tests.
- [Chromosome fusion](/knowledge/topics/chromosome_fusion/) — statistical framework for testing SA-fusion excess.

**Primary citation.**
> "The initial rate of increase of a rare Y-autosome fusion is about three times that of an X-autosome fusion, with the same parameter values."
— [Charlesworth & Charlesworth 1980, Finding 2](/knowledge/papers/10_1017_s0016672300014051/#finding-2)

**Prerequisites:** [sexual antagonism](/knowledge/concepts/sexual-antagonism/), [heterogamety](/knowledge/concepts/heterogamety/), [autosome](/knowledge/concepts/autosome/)
**Next, learn about:** [neo-sex chromosome](/knowledge/concepts/neo-sex-chromosome/), [pseudoautosomal region](/knowledge/concepts/par/)
<!-- tealc:card-end -->

<!-- tealc:explainer-start -->
## Background

Sexually antagonistic (SA) fusions have been a formal theoretical object since Charlesworth and Charlesworth (1980), who worked out the initial rate of increase for rare Y-autosome and X-autosome fusions under intralocus sexual conflict. Their key result: a Y-autosome fusion that captures a male-benefit allele spreads at roughly three times the rate of an equivalent X-autosome fusion, because the Y-linked copy is immediately shielded from females. van Doorn and Kirkpatrick (2007) extended this framework to include the maintenance of SA polymorphism and showed that fusions can be favored even when SA alleles are common, not just when they are rare. The Blackmon lab has used these theoretical benchmarks to interpret karyotypic turnover in Coleoptera (Blackmon and Demuth 2014, *Genetics*) and, more recently, to explain why YO and WO sex-determination systems (single sex-determining univalents without a pairing partner) are unstable: once an autosome fuses to the Y, the Y becomes neo-sex chromosome rather than disappearing, which is part of why YO systems rarely persist (Jonika et al. 2022, *Heredity*).

## How it works

The argument begins with an autosome that carries an SA locus. In a population with XY sex determination, the autosome segregates freely, so male-benefit alleles at that locus spend half their time in females, where they are harmful. A chromosomal fusion that joins this autosome to the Y immediately places the male-benefit allele in permanent linkage with the sex-determining region. From that point forward, the allele is transmitted almost exclusively through males. Selection favors the fusion whenever the fitness benefit from placing the SA allele into linkage with the Y exceeds the fitness cost of the fusion itself (typically small). Three contrasting mechanisms explain new sex chromosomes: SA fusion (selection-driven, requires an SA locus near the fusion breakpoint), drift-driven fusion (stochastic fixation of a fusion that is slightly deleterious on average), and meiotic-drive-driven fusion (a driving element that distorts segregation). SA fusion differs from the other two because it predicts an excess of sex-chromosome-autosome fusions relative to autosome-autosome fusions, and it predicts an asymmetry between Y-autosome and X-autosome fusion rates. Drift-driven fusion predicts no such excess or asymmetry.

## A worked example

*Drosophila miranda* provides the most intensively studied example of an SA fusion outcome. In this species, a metacentric autosome fused to the Y chromosome roughly 1 million years ago. The resulting neo-Y has been accumulating deleterious mutations and losing functional genes, while the neo-X (the unfused homolog) has accumulated compensatory changes in gene dosage. The neo-Y now retains only a fraction of the ancestral gene complement present before the fusion, and we can track that decay by comparing gene content between the two neo-sex chromosomes.

In Coleoptera, Blackmon and Demuth (2014, *Genetics*) analyzed karyotype data from more than 1000 beetle species and found that fusion rates differ between suborders in ways consistent with SA-driven dynamics. Adephaga show elevated Y-chromosome turnover, with a gain-or-loss rate of approximately 57% per 100 million years, while Polyphaga show lower turnover. This difference is consistent with meiotic and sex-chromosome pairing differences between the suborders.

## Common misconceptions

- SA fusion is not the only mechanism that produces new sex chromosomes. Drift, meiotic drive, and simple chromosomal rearrangements with no SA component all contribute. SA fusion is favored only in clades where SA polymorphism is maintained.
- The SA allele does not have to be fixed before a fusion is favored. The fusion spreads while the SA locus is still polymorphic, because the fusion itself places the allele into the sex-limited context.
- SA fusion does not require a large-effect SA locus. Many loci of small effect, each individually insufficient, can collectively favor fusion if they cluster near the breakpoint.
- A fusion is not favored simply because a sex chromosome is involved. Fusions that join an autosome to the pseudoautosomal region (PAR) are predicted to be deleterious, because they shorten the PAR and impair sex-chromosome pairing during meiosis.

## How to spot it in papers

- Look for fusion-age estimates combined with evidence of SA polymorphism at nearby loci. A young fusion whose SA loci map to the ancestral autosomal segment is consistent with SA fusion.
- Neo-sex chromosome age can be estimated from molecular divergence between the neo-sex chromosome and its pairing homolog. Rapid gene degeneration on the neo-Y after a recent fusion suggests that recombination suppression followed quickly.
- State-dependent fusion rate analyses (e.g., BISSE extensions on karyotype data) can test whether lineages with high sexual dimorphism show elevated sex-chromosome-autosome fusion rates.
- An excess of sex-chromosome-autosome fusions over autosome-autosome fusions in a clade, after controlling for the number of autosomes available to fuse, is the simplest population-level signature of SA-driven fusion.

## Further reading

Within the wiki:

- [Sexual antagonism](/knowledge/concepts/sexual-antagonism/) — the population-genetic basis for SA polymorphism that SA-fusion theory requires.
- [Chromosome fusion](/knowledge/concepts/chromosome-fusion/) — the mechanics and fitness costs of chromosomal fusions in general.
- [Neo-sex chromosome](/knowledge/concepts/neo-sex-chromosome/) — what SA fusion produces: the evolutionary trajectory of newly sex-linked chromosomes.
- [Blackmon and Demuth 2014](/knowledge/papers/10_1534_genetics_114_164269/) — the empirical Coleoptera study that applies SA-fusion theory at macroevolutionary scale.
<!-- tealc:explainer-end -->

<!-- user-start -->
<!-- user-end -->
