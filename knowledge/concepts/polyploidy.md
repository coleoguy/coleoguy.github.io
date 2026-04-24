---
layout: default
title: "Polyploidy"
concept_slug: polyploidy
aliases: ["polyploidy", "polyploid", "polyploidization", "whole genome duplication", "WGD", "allopolyploidy", "autopolyploidy"]
prerequisites: [autosome]
appears_in_topics: [karyotype_evolution_overview, chromosome_number_evolution]
related_concepts: [dysploidy, demiploidy, aneuploidy]
primary_citation: "10_1098_rspb_2020_1388#finding-2"
difficulty: intermediate
last_updated: 2026-04-23
permalink: /knowledge/concepts/polyploidy/
---
<!-- tealc:card-start -->
# Polyploidy

**One-sentence definition.** Polyploidy is the state of having more than two complete sets of chromosomes in a cell — typically arising from whole-genome duplication or hybridization between species with different chromosome complements.

**One-sentence analogy.** Polyploidy is like accidentally making two complete photocopies of a book and binding them together into one volume: the result has redundant content and must be reorganized before it can function as a clean, single book.

**Why it matters.** Polyploidy is rare in animals relative to plants, partly because sex chromosomes present a special obstacle: doubling the genome creates dosage-balance problems for sex-linked genes. In Phasmatodea (stick insects), rates of polyploidy are significantly higher in asexually reproducing lineages than in sexual ones — suggesting that sexual reproduction with sex chromosomes constrains polyploidization. Polyploidy is also associated with haplodiploidy transitions in mites: haplodiploid lineages show about 2n=5 fewer chromosomes than diplodiploid relatives.

**Where you meet it in the wiki.**
- [Karyotype evolution overview](/knowledge/topics/karyotype_evolution_overview/) — polyploidy as one mode of chromosome number change.
- [Chromosome number evolution](/knowledge/topics/chromosome_number_evolution/) — comparative rates of polyploidy vs. aneuploidy vs. fission/fusion.

**Primary citation.**
> "We find that rates of polyploidy are significantly higher in asexually reproducing lineages than in sexually reproducing lineages."
— [Sylvester et al. 2020, Finding 2](/knowledge/papers/10_1098_rspb_2020_1388/#finding-2)

**Prerequisites:** [autosome](/knowledge/concepts/autosome/)
**Next, learn about:** [dysploidy](/knowledge/concepts/dysploidy/), [demiploidy](/knowledge/concepts/demiploidy/)
<!-- tealc:card-end -->

<!-- tealc:explainer-start -->
## Background

Polyploidy attracted the attention of evolutionary biologists at least as early as Müntzing (1936), who recognized that many cultivated plants carry more than two complete chromosome sets. We now distinguish two broad classes. Autopolyploidy arises within a species when a cell replicates its chromosomes but fails to divide, producing a tetraploid from a diploid progenitor. Allopolyploidy arises between species: two genetically distinct lineages hybridize, and the resulting hybrid doubles its genome so that each ancestral set can pair with itself rather than with its divergent counterpart. Ancient events visible only as blocks of duplicated genes are called paleopolyploidy; the vertebrate genome carries signatures of two such whole-genome duplications (Ohno 1970). Polyploidy is far more common in plants than in animals. Roughly 30-80% of flowering plant species have polyploid ancestry. In animals, polyploidy is rare and its rarity is not random: taxa with differentiated sex chromosomes show nearly no polyploidy, while parthenogenetic lineages show elevated rates. The meiotic challenge is real in both kingdoms. A diploid cell pairs homologs as bivalents; a tetraploid cell faces multivalent pairing, where four copies of each chromosome compete for partners. Multivalent formation increases missegregation risk at every cell division.

## How it works

Polyploidy reaches fixation through two main routes. In the first, a diploid organism produces unreduced gametes that retain both parental chromosome sets. If two unreduced gametes fuse, the offspring is autotetraploid. In the second, two species hybridize to produce an F1 sterile because its chromosomes lack pairing partners. If that hybrid undergoes whole-genome duplication, each chromosome gains a homolog and fertility can be restored. This allopolyploidization route underlies cotton, wheat, and most domesticated polyploid crops. Both routes immediately reduce effective population size (Ne): a newly arisen polyploid faces a minority disadvantage and must establish largely through selfing or clonal reproduction. Gene dosage changes immediately: a gene present in two copies in a diploid is present in four in an autotetraploid, disrupting regulatory networks built around diploid dosage. Over time, polyploid genomes return toward a diploid-like state through gene loss, a process called diploidization. In animals, sex chromosomes complicate the picture further: doubling the genome doubles both sex chromosomes, potentially disrupting sex determination and dosage compensation.

## A worked example

Salmonid fishes (trout, salmon, char) carry approximately 60-100 chromosomes rather than the 20-30 expected from their body plan. Work by Ohno and colleagues in the 1960s and 1970s established that salmonids are paleopolyploids descended from a tetraploid ancestor roughly 80-100 million years ago. Many chromosome arms are homeologous and still occasionally recombine in some taxa, a legacy of incomplete diploidization. Cotton allopolyploidy is recent enough to study directly. Cultivated upland cotton (*Gossypium hirsutum*) is an allotetraploid (2n = 4x = 52) derived from a hybrid of an Old World diploid (A genome, n = 13) and a New World diploid (D genome, n = 13). In loaches (*Misgurnus anguillicaudatus*, weatherfish), natural triploids (3n = 75) and tetraploids (4n = 100) occur alongside diploids in wild Asian populations. Triploids are generally fertile females. This system shows that polyploidy in vertebrates is not always incompatible with viability, though it is confined here to a group with no differentiated sex chromosomes.

## Common misconceptions

- **Polyploidy is not aneuploidy.** Aneuploidy is the gain or loss of one or a few chromosomes from an otherwise normal complement (e.g., trisomy 21). Polyploidy multiplies the entire genome by a whole-number factor. Both change 2n, but through different mechanisms with different fitness consequences.
- **Not all polyploids are sterile.** Sterility is most likely in odd-ploidy individuals (triploids, pentaploids) whose chromosomes cannot segregate evenly. Even-ploidy polyploids often produce balanced gametes and are fully fertile, as bread wheat (*Triticum aestivum*, hexaploid) shows.
- **Triploidy in vertebrates is usually but not always lethal.** Triploid mammals typically arrest early in development. Fishes and some amphibians tolerate triploidy, and natural triploid populations persist in weatherfish and some salamanders.
- **Paleopolyploidy is not the same as current polyploidy.** A genome that duplicated 80 million years ago has had time to lose most duplicates and rediploidize. Treating the salmonid genome as "a polyploid" in the same sense as a newly arisen tetraploid confuses historical signature with current state.

## How to spot it in papers

- **Karyotype notation.** The formula 2n = 4x = 28 signals a tetraploid with base chromosome number x = 7. Papers that report only 2n without x are harder to interpret, because aneuploidy, fission, and polyploidy all change 2n.
- **Meiotic pairing figures.** Polyploids often show multivalents: chains of four or more chromosomes joined at chiasmata. Diploids show only bivalents.
- **Ks histograms.** Synonymous substitution rate (Ks) distributions among within-genome paralog pairs show peaks at values corresponding to duplication events. A shared peak across many gene families suggests a shared whole-genome duplication.
- **Self-synteny blocks.** A genome aligned against itself shows large syntenic blocks in polyploids and paleopolyploids, because two chromosomal regions share gene order traceable to the same ancestral chromosome.

## Further reading

Within the wiki, two related concepts connect directly:
- [Aneuploidy](/knowledge/concepts/aneuploidy/) covers gain or loss of individual chromosomes, the key contrast to polyploidy.
- [Dysploidy](/knowledge/concepts/dysploidy/) covers step-wise chromosome number change through fission and fusion, which can mimic polyploidy in count surveys.
<!-- tealc:explainer-end -->

<!-- user-start -->
<!-- user-end -->
