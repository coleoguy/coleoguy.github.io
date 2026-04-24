---
layout: default
title: "Muller's ratchet"
concept_slug: mullers-ratchet
aliases: ["Muller's ratchet", "ratchet"]
prerequisites: [effective-population-size, genetic-drift]
appears_in_topics: [sex_chromosome_evolution, transposable_elements]
related_concepts: [effective-population-size, genetic-drift, recombination-suppression, neo-sex-chromosome]
difficulty: intermediate
last_updated: 2026-04-23
permalink: /knowledge/concepts/mullers-ratchet/
---
<!-- tealc:card-start -->
# Muller's ratchet

**One-sentence definition.** Muller's ratchet is the irreversible accumulation of deleterious mutations in a non-recombining genome or genomic region, because once the class of individuals carrying the fewest deleterious mutations is lost to drift, it cannot be recovered.

**One-sentence analogy.** Muller's ratchet is a downhill ratchet where each click can only move in one direction: every time drift removes the least-loaded class, the minimum possible mutation load rises and never falls back.

**Why it matters.** Muller's ratchet is one of the central explanations for Y chromosome degeneration after recombination suppression. When an ancestral autosome becomes a sex chromosome, the region that stops recombining loses the ability to purge deleterious mutations through shuffling. Drift then repeatedly removes the class of Y chromosomes carrying the fewest mutations. Each loss is permanent. Over millions of years, this process converts a gene-rich chromosome into one dominated by repetitive sequence and pseudogenes. Ratchet speed depends on effective population size (Ne) and the rate and effect of deleterious mutations, so the ratchet is fastest in lineages where Ne is already small and recombination suppression is recent. Understanding Muller's ratchet is therefore prerequisite to understanding why Y chromosomes across animals follow such a consistent trajectory of decay.

**Where you meet it in the wiki.**
- [Recombination suppression](/knowledge/concepts/recombination-suppression/)
- [Neo-sex chromosome](/knowledge/concepts/neo-sex-chromosome/)
- [Sex chromosome evolution](/knowledge/topics/sex_chromosome_evolution/)

**Prerequisites:** [effective population size](/knowledge/concepts/effective-population-size/), [genetic drift](/knowledge/concepts/genetic-drift/)
**Next, learn about:** [recombination suppression](/knowledge/concepts/recombination-suppression/)
<!-- tealc:card-end -->

<!-- tealc:explainer-start -->
## Background

Muller proposed in 1964 that asexual populations accumulate deleterious mutations in a ratchet-like fashion. Because asexual reproduction copies the entire genome, an individual with fewer mutations than its parents can arise only through back-mutation, which is rare. Felsenstein (1974) placed the ratchet on a quantitative foundation, showing that drift in finite populations repeatedly eliminates the least-loaded mutation class and that the rate of this elimination scales with population size and mutation rate. The ratchet clicks whenever the zero-class (or minimum-class) individuals leave no descendants before drift removes them; after that event, the minimum possible load in the population is one click higher.

Charlesworth (1978) and Rice (1987) applied the ratchet specifically to Y chromosome evolution. When recombination suppression spreads across a proto-Y chromosome, the Y is effectively asexual: its genes never pair with X-linked alleles and never shuffle. The ratchet therefore applies to every gene on the non-recombining segment. Unlike background selection or selective sweeps, which can be reversible or episodic, Muller's ratchet is strictly irreversible without recombination. Background selection reduces diversity around negatively selected sites but does not cause a one-way ratchet in mutation load; a selective sweep eliminates linked variants but can be broken by recombination. Muller's ratchet is distinct because each click permanently raises the floor of the mutation distribution.

## How it works

Across individuals in a population, the number of deleterious mutations per genome follows roughly a Poisson distribution. The least-loaded class contains individuals with the fewest mutations, and this class is also the smallest, because most individuals carry more than the minimum load. In a finite population, the least-loaded class can be lost by drift before any member reproduces. When that happens, the next-least-loaded class becomes the new minimum, and the population's mean load rises by one click. Without recombination, there is no way to regenerate the lost class: sex would allow the minimum class to reappear by combining low-load chromosomes from different parents, but without it, the minimum can only be recreated by reverse mutation, which is negligibly rare.

The rate at which the ratchet clicks depends on three quantities: Ne, the genomic deleterious mutation rate U, and the mean selection coefficient s against each mutation. Smaller Ne means the minimum class is smaller in absolute number, so drift eliminates it faster. Higher U means individuals accumulate more mutations per generation, which also shrinks the minimum class. Weaker selection (smaller s) allows more mutations to persist, again swelling the load and shrinking the minimum class. The ratchet click rate is approximately a function of these three parameters, often written as proportional to exp(-Ne * U / s) for the size of the minimum class; when this quantity is small, clicks are frequent. We note this formula is an approximation under specific assumptions about mutation fitness effects, and empirical rates vary.

Interaction between Ne and ratchet speed is particularly important for sex chromosomes. The Y chromosome has an effective population size of roughly one quarter that of autosomes (because there is only one Y per four gene copies in a diploid population with equal sex ratio). This smaller Ne means the ratchet runs faster on the Y than on autosomes even before any other factor is considered. When the Y also acquires inversions that suppress recombination, the two effects compound: a small effective size and no recombination put the Y chromosome in the worst possible position for resisting mutation accumulation.

## A worked example

Drosophila miranda provides one of the clearest empirical records of Muller's ratchet in action. D. miranda acquired a neo-Y chromosome roughly 1 to 2 million years ago through a fusion of an autosome with the ancestral Y. Since recombination suppression spread across this neo-Y, the chromosome has lost approximately 40% of its protein-coding genes through pseudogenization and deletion. Genes still present on the neo-Y show elevated dN/dS ratios relative to their neo-X homologs, which is consistent with relaxed purifying selection under ratchet conditions. Mammalian Y chromosomes tell a longer version of the same story: the human Y retains roughly 27 ancestral genes compared with more than 800 on the X, a pattern consistent with progressive ratchet-driven decay over hundreds of millions of years. Bdelloid rotifers, a group of invertebrates that appears to have abandoned sex entirely yet persists over geological time, are sometimes cited as a counterexample; current evidence suggests they acquire exogenous DNA through horizontal transfer at a high rate, which may provide a functional substitute for recombination, though this interpretation remains debated.

## Common misconceptions

- Muller's ratchet is not the same as background selection. Background selection reduces Ne around negatively selected sites and slows the fixation of neutral variants, but it does not irreversibly raise the minimum mutation load. Muller's ratchet is defined by the one-way, irreversible loss of the least-loaded class.
- Muller's ratchet does not require complete asexuality. It applies to any genomic region that does not recombine, including the non-pseudoautosomal region of a Y chromosome in an otherwise sexual organism.
- Muller's ratchet does not predict that all Y chromosomes will eventually disappear. Many taxa retain degenerated but functional Y chromosomes over long evolutionary timescales. The ratchet decelerates as Ne rises or as purifying selection removes individuals with very high loads.
- Elevated dN/dS on Y-linked genes is consistent with Muller's ratchet but does not prove it. Relaxed constraint and positive selection can both elevate dN/dS. We interpret elevated dN/dS as evidence for ratchet only when it co-occurs with pseudogenization, gene loss, and the expected relationship between chromosome age and degeneration level.
- The ratchet does not require that every mutation is strongly deleterious. It operates even when mutations have small individual effects, because the cumulative load is what matters, not any single mutation.
- Muller's ratchet and Hill-Robertson interference are related but distinct. Hill-Robertson interference is the general reduction in the efficacy of selection caused by linkage among selected sites; Muller's ratchet is one specific, irreversible consequence of that linkage when drift removes the minimum-load class.

## How to spot it in papers

- Elevated dN/dS ratios on Y-linked or W-linked genes relative to their X-linked or Z-linked homologs, particularly when the elevation increases with the age of recombination suppression.
- Pseudogenization rates on non-recombining chromosomes that exceed those on recombining autosomes, especially when pseudogenes accumulate progressively with chromosome age.
- Shared gene loss across independently derived sex chromosome systems at orthologous positions, which suggests that ratchet decay follows a predictable order set by gene essentiality.
- Load curves: the number of deleterious mutations per chromosome plotted against the age of the recombination-suppressed region, where load increases with suppressor age as predicted by ratchet models.
- Comparisons between neo-sex chromosomes (recent recombination suppression, early degeneration) and old sex chromosomes (ancient suppression, near-complete degeneration) that trace the trajectory of decay and match predicted ratchet rates given Ne and U estimates.

## Further reading

- [Recombination suppression](/knowledge/concepts/recombination-suppression/) — the proximate cause that sets the ratchet in motion.
- [Effective population size](/knowledge/concepts/effective-population-size/) — drift speed determines ratchet speed.
- [Neo-sex chromosome](/knowledge/concepts/neo-sex-chromosome/) — where ratchet is empirically tractable.
<!-- tealc:explainer-end -->

<!-- user-start -->
<!-- user-end -->
