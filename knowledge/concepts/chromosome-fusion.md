---
layout: default
title: "Chromosome Fusion"
concept_slug: chromosome-fusion
aliases: ["chromosome fusion", "chromosomal fusion", "Robertsonian fusion", "centric fusion", "chromosome-autosome fusion", "fusions"]
prerequisites: [autosome]
appears_in_topics: [chromosome_fusion, sex_chromosome_evolution, karyotype_evolution_overview]
related_concepts: [sa-fusion, robertsonian-translocation, dysploidy, neo-sex-chromosome]
primary_citation: "10_1098_rsbl_2020_0648#finding-2"
difficulty: introductory
last_updated: 2026-04-23
permalink: /knowledge/concepts/chromosome-fusion/
---
<!-- tealc:card-start -->
# Chromosome Fusion

**One-sentence definition.** A chromosome fusion is a structural rearrangement that joins two previously separate chromosomes into one, reducing the total chromosome number by one and creating a new, longer chromosome.

**One-sentence analogy.** A chromosome fusion is like taping two separate rulers end-to-end into a single longer ruler — the total measuring capacity is unchanged but the count of rulers goes down by one.

**Why it matters.** Chromosome fusions are non-random events in sex-chromosome systems. Sex chromosome–autosome fusions (SA fusions) are favored when they link sexually antagonistic alleles to the sex-determining region. In *Habronattus* jumping spiders, 8 of 10 chromosomal fusions involve a sex chromosome — with p < 10⁻⁵ under a null model of random fusion partners. At the same time, fusions in the pseudoautosomal region (PAR) are actively harmful. In Carnivora, small-range lineages show higher fusion rates, suggesting drift also contributes when Ne is small.

**Where you meet it in the wiki.**
- [Chromosome fusion](/knowledge/topics/chromosome_fusion/) — statistical tests for non-random fusion accumulation.
- [Sex chromosome evolution](/knowledge/topics/sex_chromosome_evolution/) — fusions as the dominant route to neo-sex chromosomes.
- [Karyotype evolution overview](/knowledge/topics/karyotype_evolution_overview/) — rates and drivers of fusion across taxa.

**Primary citation.**
> "*Habronattus* jumping spiders show a statistically significant excess of sex chromosome–autosome fusions relative to the null expectation, with the observed 8 SA-fusions out of 10 total yielding p < 10⁻⁵."
— [The probability of fusions 2020, Finding 2](/knowledge/papers/10_1098_rsbl_2020_0648/#finding-2)

**Prerequisites:** [autosome](/knowledge/concepts/autosome/)
**Next, learn about:** [SA fusion](/knowledge/concepts/sa-fusion/), [robertsonian translocation](/knowledge/concepts/robertsonian-translocation/)
<!-- tealc:card-end -->

<!-- tealc:explainer-start -->

## Background

Fusions and fissions do not accumulate at equal rates. In Coleoptera, fission rates consistently exceed fusion rates: we estimate a mean fission rate roughly an order of magnitude higher than the corresponding fusion rate in chromePlus analyses of beetle phylogenies. This asymmetry means that fusion events stand out as phylogenetically informative deviations from the baseline fission trend.

The most studied class of fusion is the Robertsonian fusion, named after W.R.B. Robertson who described them in grasshoppers in 1916. Robertsonian fusions join two acrocentric chromosomes at their centromeres, producing a single metacentric chromosome. The pattern recurs across mammals, insects, and plants. Speciation models have invoked fusions as reproductive barriers: if a fused karyotype fails to pair normally with the unfused parental karyotype in hybrid meiosis, gene flow may be reduced. The evidence for this mechanism is mixed, and we argue that karyotype mismatch alone is insufficient to explain speciation rate differences across mammals.

## How it works

Most fusions we study in natural populations are Robertsonian fusions. The mechanism begins with double-strand breaks near the centromeres of two acrocentric chromosomes (chromosomes whose centromere sits near one end). The broken ends join, and the two short arms are typically lost because they carry mostly repetitive rDNA the cell can tolerate losing. The product is a single metacentric chromosome (centromere near the middle) with two long arms corresponding to the long arms of the two original chromosomes.

Centromere biology governs whether fusions spread. A new fusion heterozygote carries one fused chromosome and two unfused acrocentrics; at meiosis these three must pair as a trivalent. If segregation is regular, the heterozygote is viable and the fusion can spread by drift or selection. If segregation is irregular, unbalanced gametes arise and the fusion is purged. Species with chiasmatic meiosis are more constrained: fusions reduce the arm count, and each arm still needs at least one chiasma for proper segregation.

chromePlus models fusion as a rate parameter on a phylogeny. The fusion rate captures all events that reduce haploid number by one, not just Robertsonian fusions, so the estimate integrates centric fusions, telomeric fusions, and any other mechanism that produces the same numerical outcome.

## A worked example

The clearest single-lineage fusion example in vertebrates is the event that produced human chromosome 2. Other great apes carry 2n = 48; humans carry 2n = 46. Human chromosome 2 has two centromeric regions (one active, one inactivated vestige), internal telomeric repeats at the fusion site, and a gene order that aligns with chimpanzee chromosomes 2A and 2B across its full length. These molecular signatures place the fusion on the human lineage after it diverged from other apes.

In *Habronattus* jumping spiders, 8 of 10 detected fusions involve a sex chromosome, a result with p < 10⁻⁵ under a null model of random fusion partner selection. These SA fusions link autosomal loci to the X, creating neo-sex chromosomes and expanding the region under sex-specific selection.

## Common misconceptions

- **Fusions always reduce fitness.** Fusions are often deleterious while segregating as heterozygotes, but they can fix by drift in small populations or by selection when they resolve sexual antagonism. The net effect depends on Ne and on whether the fused chromosome carries alleles favored in one sex.
- **A lower chromosome number means a simpler genome.** Fusion does not delete genic content (aside from the small arms lost in Robertsonian fusions). A species with 2n = 20 from repeated fusions carries essentially the same gene number as an ancestor with 2n = 40.
- **Karyotype mismatch causes speciation.** Mismatched karyotypes are associated with elevated chromosome evolution rates in mammals, but we find no corresponding increase in speciation rate.
- **Fusions and fissions are equally likely.** Fission rates exceed fusion rates in most well-studied clades. Treating the two as symmetric in a model will bias rate estimates.
- **All fusions are Robertsonian.** Telomeric fusions, where chromosome ends join without centromere-to-centromere contact, also occur. Human chromosome 2 appears to be a telomeric fusion. The molecular signatures differ from a Robertsonian fusion, and the two mechanisms are not interchangeable in mechanistic discussions.

## How to spot it in papers

- Look for a reduction in haploid chromosome number (n) between an outgroup and a focal taxon, accompanied by a gain in chromosome arm count or by chromosomes with two centromeric regions.
- Cytogenetic papers report fusions as "Robertsonian translocation rob(A;B)" where A and B name the two participating chromosomes.
- Molecular evidence for a fusion includes internal telomeric repeat arrays at the fusion site, a vestigial or inactivated centromere, and synteny with two chromosomes in a related species.
- In comparative genomic studies, fusions appear as collinearity blocks: a single chromosome in one species aligns to two separate chromosomes in another, with no inversions needed to explain the alignment.
- Rate papers using chromePlus report separate fusion and fission rate parameters. If a study reports only a single "chromosome number change" rate, it has not separated fusion from fission, and the fusion rate is unidentifiable from that analysis.

## Further reading

Within this wiki:

- [chromePlus method](/knowledge/methods/chromeplus/) — the statistical framework we use to estimate fusion and fission rates on a phylogeny.
- [Chromosome number evolution](/knowledge/topics/chromosome_number_evolution/) — broader context for where fusions fit in the tempo and mode of karyotype change.
- [Robertsonian translocation](/knowledge/concepts/robertsonian-translocation/) — the specific mechanism of centromere-to-centromere joining covered in depth.

<!-- tealc:explainer-end -->

<!-- user-start -->
<!-- user-end -->
