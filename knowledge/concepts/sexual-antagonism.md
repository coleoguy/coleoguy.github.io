---
layout: default
title: "Sexual Antagonism"
concept_slug: sexual-antagonism
aliases: ["sexual antagonism", "sexually antagonistic", "intralocus sexual conflict", "sexual conflict", "SA locus", "SA allele", "sexually antagonistic selection"]
prerequisites: []
appears_in_topics: [sex_chromosome_evolution, fragile_y_hypothesis, sexual_antagonism, sexually_antagonistic_selection]
related_concepts: [sa-fusion, heterogamety, recombination-suppression]
primary_citation: "10_1098_rsbl_2020_0648#finding-2"
difficulty: intermediate
last_updated: 2026-04-23
permalink: /knowledge/concepts/sexual-antagonism/
---
<!-- tealc:card-start -->
# Sexual Antagonism

**One-sentence definition.** Sexual antagonism occurs when an allele at a locus increases the fitness of one sex while decreasing the fitness of the other — creating an evolutionary tug-of-war between males and females at the same gene.

**One-sentence analogy.** An SA allele is like a recipe ingredient that makes a dish taste great for one diner but terrible for another at the same table — natural selection cannot simultaneously satisfy both.

**Why it matters.** Sexual antagonism is the primary driver of sex chromosome evolution. Alleles that benefit males at a cost to females (or vice versa) are favored when linked to a sex-determining region that restricts their transmission to the advantaged sex. This selection drives recombination suppression, inversions, and sex-chromosome–autosome fusions. In *Habronattus* jumping spiders, 8 of 10 chromosomal fusions involve a sex chromosome and an autosome — a result significant at p < 10⁻⁵ under a null model of random fusion — consistent with SA selection driving non-random fusion accumulation.

**Where you meet it in the wiki.**
- [Sex chromosome evolution](/knowledge/topics/sex_chromosome_evolution/) — SA selection triggers recombination suppression on proto-sex chromosomes.
- [Fragile Y hypothesis](/knowledge/topics/fragile_y_hypothesis/) — SA inversions shrink the PAR and ratchet toward Y loss.
- [Sexual antagonism](/knowledge/topics/sexual_antagonism/) — detailed treatment of the SA-fusion prediction.

**Primary citation.**
> "*Habronattus* jumping spiders show a statistically significant excess of sex chromosome–autosome fusions relative to the null expectation, with the observed 8 SA-fusions out of 10 total yielding p < 10⁻⁵."
— [The probability of fusions 2020, Finding 2](/knowledge/papers/10_1098_rsbl_2020_0648/#finding-2)

**Prerequisites:** none
**Next, learn about:** [SA fusion](/knowledge/concepts/sa-fusion/), [recombination suppression](/knowledge/concepts/recombination-suppression/)
<!-- tealc:card-end -->

<!-- tealc:explainer-start -->
## Background

Sexual antagonism was formalized as a population-genetic concept by William R. Rice (1984), who showed that alleles beneficial to one sex but harmful to the other can persist as stable polymorphisms. Rice's key insight was that sex chromosomes are the natural battleground for these loci: because one sex chromosome is transmitted exclusively through one sex, it shelters alleles that benefit that sex even when those alleles are costly in the other. This dynamic produces feminization pressure on the X (recessive female-beneficial alleles accumulate there) and masculinization pressure on the Y (male-beneficial alleles accumulate, sheltered from female selection). Blackmon and Brandvain (2017, *Genetics* 207: 1621-1629) built the lab's central treatment of SA, showing analytically how SA selection shapes PAR boundaries, inversion accumulation, and aneuploidy rates. That paper is the primary framing for how we think about SA in the lab.

## How it works

We distinguish two forms of sexual conflict. Intralocus conflict is the situation Rice (1984) described: a single locus where the same allele is pulled in opposite directions by selection in males and females simultaneously. Interlocus conflict involves separate loci whose products interact antagonistically across sexes. This wiki focuses on intralocus conflict because it is the form most directly tied to sex chromosome evolution.

SA selection favors sex-linkage in a predictable way. A recessive male-beneficial allele accumulates on the X because hemizygous males express it fully while females (mostly heterozygous) pay only a partial cost. A dominant male-beneficial allele is favored on the Y, where female carriers do not exist. This asymmetry means autosomes near SA loci experience selection for fusion to a sex chromosome. Blackmon and Demuth (2014, *Genetics* 197: 561-572) showed that this "SA fusion" dynamic predicts a non-random bias toward sex chromosome-autosome fusions over autosome-autosome fusions. SA-driven inversions also suppress recombination: once an inversion links an SA allele to a sex-determining region, the suppressed region diverges, forming a new evolutionary stratum. Repeated bouts of suppression extend outward over time, producing the stratified structure we observe in old sex chromosomes.

## A worked example

In *Habronattus* jumping spiders, 8 of the 10 chromosomal fusions detected in the clade involve a sex chromosome (Blackmon and Demuth 2014). Under a null model where each fusion is equally likely to involve any chromosome pair, the probability of observing 8 or more sex-chromosome fusions out of 10 is p < 10^-5. We find the same directional bias in Coleoptera: in the suborder Adephaga, fusions involving the X chromosome are substantially more frequent than fusions involving only autosomes (Blackmon and Demuth 2014). In *Drosophila melanogaster*, quantitative genetic studies have identified fitness trade-offs where alleles that increase male mating success reduce female fecundity, confirming that SA loci segregate in natural populations at measurable frequencies.

## Common misconceptions

- **SA is about fitness, not behavior.** SA is a statement about allele fitness: the same allele raises fitness in one sex and lowers it in the other. The behavior that produced the conflict is irrelevant to the population genetics.
- **SA does not require sexual dimorphism.** An SA polymorphism can persist in a population where males and females look identical. The conflict operates at the allele-fitness level.
- **Weak SA selection can still drive chromosome change.** Blackmon and Brandvain (2017) show that even mild SA selection (s on the order of 0.01 or less) can shift PAR boundaries and drive inversion accumulation over evolutionary time.
- **SA fusions and SA inversions are distinct.** A fusion changes chromosome number by attaching an autosome to a sex chromosome. An inversion suppresses recombination without changing chromosome number. Both are driven by SA selection but leave different karyotypic signatures.
- **SA does not always resolve in favor of one sex.** More commonly, the conflict is partly resolved by sex-limited expression or sex-biased regulatory divergence, with the underlying SA polymorphism persisting or cycling.

## How to spot it in papers

- **Sex-by-genotype fitness interaction plots.** The clearest SA signature is a crossing pattern: one genotype has higher fitness in males, the other in females. Look for fitness (survival, fecundity, mating success) reported by sex and genotype simultaneously.
- **SA locus mapping.** QTL studies that map fitness components separately in each sex and test for sex-by-QTL interactions identify candidate SA regions. An SA locus shows opposite sign of effect in males and females.
- **Non-random fusion bias toward sex chromosomes.** A statistically significant excess of sex chromosome-autosome fusions over autosome-autosome fusions is consistent with SA-driven fusion accumulation (tested against a null proportional to chromosome number, as in Blackmon and Demuth 2014).
- **Evolutionary strata with divergent sex-linked sequence.** SA-driven recombination suppression leaves a divergence gradient along the sex chromosome: older strata have higher dS between X- and Y-linked paralogs.
- **PAR boundary shifts across related taxa.** Progressively shrinking pseudoautosomal regions across a clade suggest repeated SA-driven inversion accumulation; look for tests that co-vary PAR size with SA intensity proxies.

## Further reading

Within the wiki:

- [SA fusion](/knowledge/concepts/sa-fusion/) -- the chromosome-level outcome of SA selection; covers fusion bias predictions and the Coleoptera and spider evidence.
- [Recombination suppression](/knowledge/concepts/recombination-suppression/) -- how SA loci drive inversions that halt recombination and generate evolutionary strata.
- [Blackmon and Brandvain 2017](/knowledge/papers/10_1534_genetics_117_300382/) -- the lab's primary theoretical treatment of SA selection, PAR dynamics, and aneuploidy rates.
<!-- tealc:explainer-end -->

<!-- user-start -->
<!-- user-end -->
