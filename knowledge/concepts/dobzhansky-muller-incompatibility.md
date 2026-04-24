---
layout: default
title: "Dobzhansky-Muller incompatibility"
concept_slug: dobzhansky-muller-incompatibility
aliases: ["DM incompatibility", "DMI", "Dobzhansky-Muller model", "Bateson-Dobzhansky-Muller incompatibility", "BDM"]
prerequisites: [heterogamety]
appears_in_topics: [hybrid_sterility, speciation, speciation_genetics, postzygotic_isolation]
related_concepts: [hybrid-sterility, haldane-rule, heterogamety]
difficulty: intermediate
last_updated: 2026-04-23
permalink: /knowledge/concepts/dobzhansky-muller-incompatibility/
---
<!-- tealc:card-start -->
# Dobzhansky-Muller incompatibility

**One-sentence definition.** A Dobzhansky-Muller incompatibility is a negative epistatic interaction between alleles at two or more loci, each of which was neutral or beneficial in its own lineage but which together cause reduced fitness when brought into a hybrid genome.

**One-sentence analogy.** Two software modules developed by separate teams each work fine on their own operating system, but crash when run together on a machine that carries both.

**Why it matters.** Dobzhansky-Muller incompatibilities are the dominant genetic model for postzygotic isolation. They explain how reproductive barriers accumulate between populations without either lineage passing through a fitness valley. The model also underpins Haldane's rule: recessive DM incompatibilities on the X chromosome are exposed in heterogametic hybrids because the hemizygous X has no masking allele on a second copy. The same logic extends to the large-X effect, where speciation loci concentrate on the X at higher density than autosomes. Orr's 1995 prediction that DM incompatibilities accumulate faster than linearly with divergence (the "snowball effect") has since been tested in Drosophila and other systems, making DMIs central to both the theory and the empirical genetics of speciation.

**Where you meet it in the wiki.**
- [Hybrid sterility](/knowledge/concepts/hybrid-sterility/)
- [Haldane's rule](/knowledge/concepts/haldane-rule/)
- [Speciation genetics](/knowledge/topics/speciation_genetics/)

**Prerequisites:** [heterogamety](/knowledge/concepts/heterogamety/)
**Next, learn about:** [hybrid sterility](/knowledge/concepts/hybrid-sterility/), [Haldane's rule](/knowledge/concepts/haldane-rule/)
<!-- tealc:card-end -->

<!-- tealc:explainer-start -->
## Background

William Bateson described hybrid incompatibility in plant crosses as early as 1909, noting cases where two parental lines each performed normally but their hybrids did not. Dobzhansky formalized a genetic interpretation in 1936 using Drosophila, and Muller independently developed the same two-locus model in 1942. The "Bateson" prefix is now often restored to the name, though "DM incompatibility" remains the most common shorthand.

The key puzzle is this: if a new allele is incompatible with foreign alleles, how does it ever spread? The DM model resolves this by distributing the incompatibility across two loci in two separate lineages. Allele A fixes in lineage 1 while allele b remains ancestral; allele B fixes in lineage 2 while allele a remains ancestral. Within each lineage, neither substitution is deleterious because each new allele pairs only with compatible partners. The incompatibility between A and B is never exposed until hybridization. Orr (1995) showed that DM incompatibilities accumulate faster than linearly with divergence (the "snowball effect"): each new substitution can be incompatible with any previously fixed substitution in the other lineage, so incompatibility counts grow roughly as the square of the number of substitutions.

## How it works

The simplest DM model uses two loci and one hybridization event. Start with an ancestral population fixed for genotype aabb at two interacting loci. One derived population fixes allele A at the first locus, reaching AAbb. The other independently fixes allele B at the second locus, reaching aaBB. Within each population, the substitution was neutral or adaptive and never co-occurred with the derived allele at the other locus. When the two populations hybridize, F1 hybrids carry AaBb, bringing A and B together for the first time. If A and B interact negatively, hybrid fitness drops. The incompatibility is directional: it matters which lineage fixed which allele, so we specify it as A-with-B rather than as a property of the locus pair alone.

Hemizygosity sharpens DM incompatibility expression in hybrids with sex chromosomes. In an F1 XY male, the X is hemizygous: no second X carries an alternative allele. Any recessive incompatibility between an X-linked derived allele and an autosomal allele from the opposite parent is fully exposed. In an F1 XX female, one X came from each parent, so the incompatibility may be masked. This asymmetry underlies Haldane's rule: recessive DM incompatibilities on the X hit heterogametic hybrids first and harder. The large-X effect follows because speciation loci accumulate on the X at higher density than on autosomes. Higher-order incompatibilities (three or more loci) are expected under the DM framework and raise the snowball exponent further.

## A worked example

Presgraves (2003) mapped hybrid inviability between Drosophila melanogaster and D. simulans to a single gene, Nup96, encoding a nucleoporin subunit. Within each species, Nup96 and its interacting partners function normally. Introgressing the D. melanogaster Nup96 allele into a D. simulans background produces lethality mapping to a narrow QTL on chromosome 3, with additional modifying loci elsewhere. This experiment satisfies the DM criteria: two loci, each fixed in its own lineage, each functional alone, and together lethal. Presgraves estimated roughly 190 DM incompatibilities affecting hybrid viability across the two genomes, consistent with snowball-rate accumulation over roughly 2.5 million years of divergence.

## Common misconceptions

- DM incompatibilities are not chromosomal rearrangements. Chromosomal incompatibilities (e.g., inversions disrupting meiotic pairing) are a separate postzygotic barrier class. DM incompatibilities are genic: they arise from negative epistasis between specific alleles, not from structural differences between chromosomes.
- The DM model does not require selection against the incompatibility during its spread. Each allele fixes within its own lineage without ever encountering the incompatible allele. Selection acts only when the lineages hybridize.
- Complex higher-order epistasis is not necessary. The two-locus model is sufficient to produce sterility or inviability, and many mapped incompatibilities involve only two loci.
- DM incompatibilities accumulate in both directions of a cross. F1 hybrids from both reciprocal crosses carry the incompatible allele combination. Fitness asymmetries between reciprocals arise from cytoplasmic-nuclear interactions and X-linkage effects, not from the DM model itself.
- The snowball prediction does not mean incompatibilities accumulate explosively at shallow divergence. The difference from linear accumulation grows and becomes detectable at intermediate to deep divergence.

## How to spot it in papers

- Introgression-line fitness failures. A paper that introgressess a chromosomal segment from one species into another background and maps fitness reductions to specific interacting regions is detecting DM incompatibilities.
- QTL-by-QTL interaction terms. Mapping studies that fit epistatic QTL models and find significant two-locus interactions between chromosomal regions from the two parental species are identifying DM incompatibilities at a coarse scale.
- Complementation tests with transgenes. Replacing a candidate gene from one species with its ortholog from the other and measuring whether hybrid fitness is restored identifies the incompatible allele and its interaction partner.
- Reciprocal F1 asymmetries that track X-linkage. When one cross direction produces sterile F1 males and the reciprocal does not, and the sterility tracks which X is hemizygous, an X-linked DM incompatibility is the likely mechanism.
- Snowball accumulation across a divergence gradient. Studies that count incompatibilities across species pairs at increasing divergence and fit linear versus quadratic accumulation models are testing the snowball prediction directly.

## Further reading

- [Haldane's rule](/knowledge/concepts/haldane-rule/): DM interactions expressed in the heterogametic sex.
- [Hybrid sterility](/knowledge/concepts/hybrid-sterility/): one of the main phenotypic outcomes of DMIs.
<!-- tealc:explainer-end -->

<!-- user-start -->
<!-- user-end -->
