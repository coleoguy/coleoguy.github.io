---
layout: default
title: "Genetic drift"
concept_slug: genetic-drift
aliases: ["drift", "stochastic allele frequency change", "random genetic drift"]
prerequisites: []
appears_in_topics: [effective_population_size, population_genetics, chromosome_number_evolution]
related_concepts: [effective-population-size, mk-model]
difficulty: introductory
last_updated: 2026-04-23
permalink: /knowledge/concepts/genetic-drift/
---
<!-- tealc:card-start -->
# Genetic drift

**One-sentence definition.** Genetic drift is the stochastic change in allele frequencies that arises because offspring in finite populations sample alleles from a finite pool of parents.

**One-sentence analogy.** Genetic drift is like drawing colored marbles from a bag without replacement: the color frequencies in the next generation depend partly on luck, and a small bag makes luck matter more.

**Why it matters.** Genetic drift is the stochastic backbone of molecular evolution. Under the neutral theory (Kimura 1968; King and Jukes 1969), most substitutions that accumulate between species fix not because they are favored but because drift carries them to fixation. The strength of drift scales inversely with effective population size (Ne): smaller Ne means faster allele frequency change per generation, higher fixation probability for weakly deleterious mutations, and faster loss of standing genetic variation. In our lab's work on chromosome number evolution, drift occupies center stage. We argue that chromosome fusions and fissions are likely deleterious while segregating, yet fix at rates far too high to be explained by selection alone. The best available explanation is that clades with small Ne accumulate karyotype changes through drift, a framing we develop in Blackmon et al. (2024, J Heredity).

**Where you meet it in the wiki.**
- [Effective population size](/knowledge/concepts/effective-population-size/)
- [Chromosome number evolution](/knowledge/topics/chromosome_number_evolution/)
- [Drift drives karyotype evolution (Blackmon et al. 2024)](/knowledge/papers/10_1093_jhered_esae001/)

**Prerequisites:** none
**Next, learn about:** [effective population size](/knowledge/concepts/effective-population-size/)
<!-- tealc:card-end -->

<!-- tealc:explainer-start -->
## Background

Genetic drift was formalized as a population-genetic force by Sewall Wright (1931) and Ronald Fisher (1930), working from nearly opposite theoretical traditions but converging on the same key insight: allele frequencies in finite populations wander. The Wright-Fisher model, the standard null model for drift, describes a population of exactly N diploid individuals reproducing randomly each generation. Each new individual draws two gene copies independently and uniformly from the parental gene pool. Because the pool is finite, the sample is imperfect, and allele frequencies shift by chance each generation. Wright (1931) showed that this sampling variance equals p(1 - p) / (2N) per generation, where p is the current allele frequency. Small populations experience large sampling variance; large populations experience small variance. This is the fundamental quantitative statement of drift.

Motoo Kimura's neutral theory (1968) and the simultaneous "non-Darwinian evolution" argument of King and Jukes (1969) elevated drift from a secondary nuisance to a primary driver of molecular evolution. Both papers argued that most amino acid substitutions observed between species are selectively neutral or nearly so, and that neutral mutations fix by drift at a rate equal to the per-genome mutation rate, independent of population size. This prediction, called the molecular clock, has held broadly across protein-coding genes. Tomoko Ohta's nearly neutral theory (1973) refined the picture: mutations with selection coefficients on the order of 1/(2Ne) behave effectively as neutral, so the boundary between "selected" and "drifting" shifts with Ne. Mutations that are efficiently purged in large populations can fix readily in small ones. Nearly neutral theory is the theoretical bridge between drift and the lab's work on karyotype evolution, because it predicts that mildly deleterious mutations accumulate fastest in lineages with small Ne.

Drift and natural selection are not opposites. They act simultaneously, and their relative contributions depend on the product of Ne and the selection coefficient (s). When |Nes| is much greater than 1, selection dominates and the allele's fate is nearly deterministic. When |Nes| is much less than 1, drift dominates and the allele behaves effectively as neutral regardless of its actual fitness effect. Chromosome number changes likely fall in the nearly neutral range in most lineages, which is why we find Ne to be the key predictor of karyotype evolution rate.

## How it works

The Wright-Fisher model generates the core predictions of drift through one simple operation: sample 2N gene copies each generation from the current allele frequency distribution. For a diploid population of size N, the frequency of an allele in generation t+1 is a binomial draw with probability equal to the allele's frequency in generation t. Three predictions follow directly. First, the fixation probability of a neutral allele equals its current frequency; a new mutation present as a single copy has a fixation probability of exactly 1/(2N). Second, the expected time to fixation for a neutral allele that does fix is approximately 4Ne generations in a diploid population (Kimura and Ohta 1969). This means fixation takes much longer in large populations than in small ones. Third, the rate of neutral substitution per unit time equals the neutral mutation rate, regardless of Ne: larger Ne generates more mutations but fixes a smaller fraction of them, and the two effects cancel exactly.

These predictions have direct consequences for the lab's work. If chromosome number changes are neutral or mildly deleterious, their rate of fixation should be elevated in lineages with small Ne, because small Ne both raises the fixation probability of mildly deleterious mutations (through the nearly neutral mechanism) and shortens the time between successive fixation events. We find this pattern consistently: traits that reduce Ne in a clade predict faster karyotype evolution rates (Blackmon et al. 2024). The Wright-Fisher model also predicts that drift erodes genetic variation over time. The expected heterozygosity declines by a factor of 1 - 1/(2Ne) per generation, so populations with small Ne lose variation quickly. This loss of variation is itself a signature of drift that molecular population genetics uses to infer Ne from sequence data.

## A worked example

Blackmon et al. (2024, J Heredity) tested whether Ne-reducing traits predict karyotype evolution rates across insects. We assembled data on body size, ecological specialization, and flight ability, all of which are expected to reduce Ne by shrinking census population size or increasing genetic drift through restricted dispersal and local extinction-recolonization dynamics. Our analyses find that traits expected to reduce Ne are associated with increased karyotype evolution rates, and this pattern holds independently of potential differences in mutation rate between lineages. Clades with small body size show higher rates of chromosome number change, consistent with the prediction that small Ne allows mildly deleterious chromosome rearrangements to fix more often. The mean estimated rate difference between Ne-reducing and baseline clades in our analysis is approximately an order of magnitude across the full insect phylogeny. This magnitude of effect is too large to attribute to mutation rate variation alone and points to drift as the primary governor of karyotype change.

## Common misconceptions

- Drift is not merely a force that matters only in small or isolated populations. Drift acts in every finite population. The question is not whether drift acts but how strong it is relative to selection, which scales with Ne.
- Drift does not produce adaptations. Drift fixes alleles randomly with respect to fitness. When drift fixes a mildly deleterious mutation, the result is a slight reduction in mean fitness, not an improvement. The conflation of drift with any kind of directional change is a frequent error.
- "Genetic drift" and "founder effects" or "bottlenecks" are not synonyms. Founder effects and bottlenecks are transient reductions in Ne that transiently amplify drift. Drift itself is the ongoing sampling process that operates at all times; bottlenecks are events that change its intensity.
- A neutral mutation is not the same as a mutation with no effect. Neutral means the selection coefficient is small enough relative to 1/(2Ne) that drift dominates the allele's fate. The same mutation can be effectively neutral in a small population and efficiently selected against in a large population.
- Drift does not require random mating or any particular mating system. Drift arises from finite population size; inbreeding, assortative mating, and geographic structure all affect effective Ne but are not required for drift to operate.

## How to spot it in papers

- Ne estimates reported alongside substitution rates. Papers that measure per-lineage substitution rates and correlate them with Ne estimates are asking whether drift governs molecular evolution in those lineages, which is the core neutral-theory test.
- The ratio dN/dS (or Ka/Ks) near 1 genome-wide, or elevated in specific lineages. A ratio near 1 for synonymous and nonsynonymous substitutions suggests that nonsynonymous changes are accumulating nearly neutrally, consistent with drift fixing many amino acid mutations.
- Coalescent analyses with Ne as a fitted parameter. BEAST, MCMC-based phylogenetic tools, and demographic inference frameworks (e.g., PSMC, SMC++) all estimate Ne from sequence data. Papers that do this are directly quantifying the parameter that governs drift strength.
- Site frequency spectra (SFS) skewed toward rare variants in large populations, toward intermediate frequencies in small populations. Drift smooths the SFS by randomly shifting allele frequencies; selection distorts it. The shape of the SFS is a standard diagnostic for the relative roles of drift and selection.
- Neutrality tests with significant negative Tajima's D in expanding populations or positive D in bottlenecked ones. These tests detect departures from the neutral Wright-Fisher expectation, and their results are interpreted against a drift null model.

## Further reading

- [Effective population size](/knowledge/concepts/effective-population-size/) — the key parameter governing drift strength.
- [Blackmon et al. 2024](/knowledge/papers/10_1093_jhered_esae001/) — drift-driven karyotype evolution.
<!-- tealc:explainer-end -->

<!-- user-start -->
<!-- user-end -->
