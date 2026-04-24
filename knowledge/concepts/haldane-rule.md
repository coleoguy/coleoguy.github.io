---
layout: default
title: "Haldane's Rule"
concept_slug: haldane-rule
aliases: ["Haldane's rule", "Haldane rule", "large X effect", "large-X effect"]
prerequisites: [heterogamety]
appears_in_topics: [hybrid_sterility, large_X_effect, sex_chromosome_evolution]
related_concepts: [heterogamety, hybrid-sterility, effective-population-size]
primary_citation: "10_1038_nature08441#finding-2"
difficulty: intermediate
last_updated: 2026-04-23
permalink: /knowledge/concepts/haldane-rule/
---
<!-- tealc:card-start -->
# Haldane's Rule

**One-sentence definition.** Haldane's rule states that when only one sex is sterile or inviable in interspecific hybrids, it is disproportionately the heterogametic sex (XY males or ZW females).

**One-sentence analogy.** Haldane's rule is like noticing that in a room full of paired roommates who are incompatible, it's overwhelmingly the person who doesn't have a matching roommate type (the odd-chromosome-out) who can't function.

**Why it matters.** Haldane's rule is one of the most general patterns in speciation genetics and is explained largely by hemizygosity: recessive incompatibilities on the X are fully exposed in XY males (who have only one X), while in XX females they may be masked by the second X. This creates faster accumulation of Dobzhansky-Muller incompatibilities in males. In sticklebacks, hybrid male sterility maps to the ancestral X chromosome but not to the neo-X, suggesting chromosome age and degeneration level determine which reproductive barriers accumulate on sex chromosomes — adding a temporal dimension to Haldane's rule.

**Where you meet it in the wiki.**
- [Hybrid sterility](/knowledge/topics/hybrid_sterility/) — Haldane's rule and the large-X effect in sticklebacks.
- [Large X effect](/knowledge/topics/large_X_effect/) — empirical tests and mechanisms.
- [Sex chromosome evolution](/knowledge/topics/sex_chromosome_evolution/) — chromosome age dependence of Haldane's rule patterns.

**Primary citation.**
> "Unlike male sterility, male courtship display traits conferring behavioural isolation between the Japan Sea and Pacific Ocean forms map to both the ancestral X chromosome and the neo-X chromosome."
— [Kitano et al. 2009, Finding 2](/knowledge/papers/10_1038_nature08441/#finding-2)

**Prerequisites:** [heterogamety](/knowledge/concepts/heterogamety/)
**Next, learn about:** [hybrid sterility](/knowledge/concepts/hybrid-sterility/), [effective population size](/knowledge/concepts/effective-population-size/)
<!-- tealc:card-end -->

<!-- tealc:explainer-start -->
## Background

Haldane proposed in 1922 that when hybrid offspring suffer reduced fertility or viability, the heterogametic sex (XY males in mammals and Drosophila, ZW females in birds and Lepidoptera) is disproportionately the one that fails. Haldane's rule has since been documented in hundreds of animal crosses and is one of the most general empirical patterns in speciation genetics.

Two major explanations have accumulated since 1922. The dominance theory, developed formally by Turelli and Orr in 1995, argues that hybrid incompatibilities tend to be recessive. In the heterogametic sex, the single X is hemizygous: recessive incompatibilities on the X have no second allele to mask them. In the homogametic sex (XX females in XY systems), a second X copy masks those same incompatibilities. The faster-male theory offers a complementary account: males experience stronger sexual selection and accumulate X-linked male-benefit alleles faster than autosomes accumulate divergence, so male reproductive incompatibility advances faster. These two explanations are not mutually exclusive; both likely contribute.

The large-X effect is a direct corollary. Speciation genes concentrate on the X because the X is where recessive incompatibilities are exposed first. Empirical tests consistently find that hybrid sterility and inviability loci map disproportionately to the X relative to autosomes.

## How it works

The core mechanism is Dobzhansky-Muller incompatibility expressed hemizygously. Two populations diverge in allopatry, each accumulating substitutions compatible within its own genetic background. When the populations hybridize, alleles from different backgrounds meet for the first time, and many combinations reduce fitness.

In a heterogametic hybrid (e.g., an XY male), the single X came entirely from one parental species. Every X-linked locus is hemizygous, so any recessive incompatibility between an X-linked locus and an autosomal locus from the other parent is fully expressed. In a homogametic hybrid (XX female), one X came from each parent, and recessive X-linked incompatibilities are more likely to be masked. Meiotic drive also contributes: interactions between X-linked drive elements and autosomal suppressors can break down in hybrids, producing segregation distortion that disrupts male meiosis specifically.

## A worked example

Drosophila pseudoobscura and D. persimilis produce sterile F1 males but fertile F1 females, a textbook Haldane's rule outcome. Classical mapping showed that hybrid male sterility localizes primarily to the X chromosome, with autosomal contributions substantially smaller. Substituting the D. persimilis X into an otherwise D. pseudoobscura genetic background produces sterile males, which shows that the X alone is sufficient.

Kitano et al. (2009) provided a temporally resolved example in sticklebacks. In crosses between Japan Sea and Pacific Ocean forms of Gasterosteus aculeatus, hybrid male sterility maps to the ancestral X but not to the neo-X, a recently fused chromosome that has not yet accumulated the same density of incompatibilities. Hybrid incompatibilities track chromosome age, not just sex linkage per se. We cross-reference this finding in the concept card above.

## Common misconceptions

- Haldane's rule applies to the heterogametic sex, not to males specifically. In birds, butterflies, and other ZW systems, the female is heterogametic (ZW) and the female is the sex that suffers disproportionately in hybrids. A student who reads "Haldane's rule means males are sterile in hybrids" has learned the wrong rule.
- The rule is probabilistic. Haldane's rule predicts that when hybrid fitness is reduced in only one sex, it tends to be the heterogametic sex. Exceptions occur, especially in crosses where divergence is shallow or where autosomal incompatibilities dominate.
- The dominance theory and the faster-male theory are not competing explanations that must be adjudicated. Both mechanisms operate simultaneously. The dominance theory explains why X-linked incompatibilities hit heterogametic hybrids first; the faster-male theory explains why X-linked incompatibilities accumulate faster in the first place.
- The large-X effect does not mean the X is the only chromosome that matters. Autosomes contribute to hybrid incompatibility; the X is simply enriched for speciation loci relative to its physical size.
- Haldane's rule does not require complete sterility or inviability. Partial reductions in fertility or survival in the heterogametic sex satisfy the pattern, and many documented cases involve quantitative rather than complete fitness loss.

## How to spot it in papers

- Hybrid fitness broken down by sex. Papers that measure pollen viability, sperm count, fecundity, or survival separately in male and female hybrids are testing Haldane's rule. Look for sex-by-cross interaction terms in the statistics.
- X-linkage of sterility or inviability loci. QTL mapping experiments or introgression lines that find sterility loci concentrated on the X (or Z in female-heterogametic taxa) are documenting the large-X effect as a mechanistic component of Haldane's rule.
- Sex-specific reproductive barriers reported separately from prezygotic barriers. Studies that parse postzygotic isolation by sex find Haldane's rule when the heterogametic sex shows stronger postzygotic isolation than the homogametic sex.
- Asymmetric cross results where reciprocal hybrid males differ from reciprocal hybrid females. Because the heterogametic sex is hemizygous for the X from one parental species, reciprocal crosses can reveal parent-of-origin effects on which X is exposed in males.
- Comparisons across taxa with different sex determination systems. Studies that find Haldane's rule in both XY mammals and ZW birds, with females affected in the bird crosses, confirm that heterogamety rather than maleness is the operative variable.

## Further reading

Within the wiki:

- [Hybrid sterility](/knowledge/concepts/hybrid-sterility/) for the genetic architecture of postzygotic isolation and how Haldane's rule connects to multi-locus incompatibility models.
- [Heterogamety](/knowledge/concepts/heterogamety/) for background on XY and ZW systems and why the hemizygous state matters for exposure of recessive alleles.
<!-- tealc:explainer-end -->

<!-- user-start -->
<!-- user-end -->
