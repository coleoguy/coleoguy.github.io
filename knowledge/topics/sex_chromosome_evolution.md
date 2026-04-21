---
layout: default
title: "Sex chromosome evolution"
topic_slug: sex_chromosome_evolution
last_updated: 2026-04-21T15:33:54.473997+00:00
papers_supporting: [10.1002/ece3.73483]
permalink: /knowledge/topics/sex_chromosome_evolution/
---
---
layout: default
title: "Sex chromosome evolution"
topic_slug: sex_chromosome_evolution
last_updated: 2026-04-21T14:53:31.290189+00:00
papers_supporting: [10.1534/genetics.117.300382, 10.1002/ece3.73483]
permalink: /knowledge/topics/sex_chromosome_evolution/
---
# Sex chromosome evolution

## Current understanding

Sex chromosomes evolve from ordinary autosomes through a process tightly linked to the resolution of sexual antagonism — the persistent tension between alleles that benefit one sex at a cost to the other. A key driver is the spread of chromosomal inversions that physically link sexually antagonistic (SA) loci to the sex-determining region (SDR), suppressing recombination and allowing sex-specific alleles to co-evolve. This process is inherently self-reinforcing but also self-undermining: the same inversions that resolve short-term antagonism progressively erode the pseudo-autosomal region (PAR), raising aneuploidy risk and setting the stage for long-term Y chromosome fragility. The downstream products of this degeneration — gene-poor, heterochromatic Y chromosomes — are now being characterized empirically in non-model taxa, including beetles, where Y chromosomes are notoriously small and poorly assembled.

Quantitative modeling shows that the inversion-fixation dynamic is governed by three interacting parameters: the dominance of the male-beneficial allele, the strength of selection, and the recombination rate between the SDR and the SA locus. Genomic work on individual beetle lineages is beginning to supply the empirical anchors needed to evaluate these predictions.

## Supporting evidence

**Inversions can fix despite meaningful aneuploidy costs.** [Long-Term Fragility of Y Chromosomes Is Dominated by Short-Term Resolution of Sexual Antagonism., Finding 1](/knowledge/papers/10_1534_genetics_117_300382/#finding-1) demonstrates that Y chromosome inversions linking a male-beneficial allele to the SDR can fix even when they increase aneuploidy by 4–6%, as long as the male-beneficial allele is dominant and selection is at least s ≈ 0.2. This establishes a quantitative threshold: moderate selection on dominant alleles is sufficient to overcome appreciable meiotic costs, explaining why Y chromosomes can accumulate inversions and shrink their PARs over evolutionary time.

**Dominance architecture shapes whether inversions fix or generate polymorphism.** The outcome differs sharply on the X chromosome depending on allele dominance. [Long-Term Fragility of Y Chromosomes Is Dominated by Short-Term Resolution of Sexual Antagonism., Finding 2](/knowledge/papers/10_1534_genetics_117_300382/#finding-2) shows that when the male-beneficial allele is recessive (h < ~0.3), an X chromosome inversion capturing the female-beneficial allele cannot fix and is instead maintained as a stable polymorphism. This provides a mechanistic explanation for the X chromosome's role as a reservoir of sexually antagonistic variation — not every resolution event ends in fixation.

**Recombination rate amplifies the fixation window, more so on Y than X.** [Long-Term Fragility of Y Chromosomes Is Dominated by Short-Term Resolution of Sexual Antagonism., Finding 3](/knowledge/papers/10_1534_genetics_117_300382/#finding-3) shows that higher background recombination between the SDR and the SA locus allows inversions with larger aneuploidy costs to fix. This effect is more pronounced for Y chromosome inversions than for X chromosome inversions, and saturates for X inversions above recombination rates of ~0.3. Larger PARs therefore create a broader parameter space in which Y-linked inversions spread, coupling PAR size dynamics to the long-term trajectory of Y chromosome degeneration.

**Empirical characterization of a beetle Y chromosome.** A chromosome-level assembly of the long-armed scarab *Cheirotonus formosanus* (Coleoptera) has provided one of the few directly identified beetle Y chromosomes. [Chromosome-Level Reference Genome of an Endemic, Endangered Long-Armed Scarab (<i>Cheirotonus formosanus</i>): Discovery of a Putative Y-Linked Scaffold and Demographic History., Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1) identified a 1.1 Mbp scaffold with female:male read-depth ratios near 0 and male coverage at ~0.5× of autosomal depth, consistent with hemizygous, single-copy Y sequence — a rare assembly-level window into a lineage where Ys are typically punctiform and refractory to sequencing. Notably, this Y-linked scaffold carries a gene model with JARID1/KDM5 family architecture that is covered by male reads but absent from female data, interpreted as a KDM5-like demethylase on the Y ([Chromosome-Level Reference Genome of an Endemic, Endangered Long-Armed Scarab (<i>Cheirotonus formosanus</i>): Discovery of a Putative Y-Linked Scaffold and Demographic History., Finding 2](/knowledge/papers/10_1002_ece3_73483/#finding-2)). The parallel to *KDM5D* on mammalian Y chromosomes hints at convergent retention of this gene family across deeply divergent sex chromosome systems.

## Contradictions / open disagreements

The theoretical thresholds from Blackmon & Brandvain (2017) — s ≈ 0.2 for inversion fixation, h < 0.3 for stable X polymorphism, r > 0.3 for saturation of the X-inversion fixation window — derive from a deterministic three-locus model with symmetric sex-specific fitness effects, a fixed multiplicative aneuploidy cost, and no genetic drift. Real populations experience drift that could destabilize predicted polymorphisms and push near-threshold inversions to fixation or loss stochastically. The model also treats recombination rate as a free parameter rather than deriving it from explicit PAR geometry, leaving quantitative predictions difficult to test directly.

The empirical Y identification in *C. formosanus* faces its own caveats: Y-linkage was inferred from a single male and single female by sequencing coverage alone, without PCR validation or broader population sampling, so a portion of the 1.1 Mbp scaffold could reflect repeat artifacts or male-biased heterochromatic sequence rather than a true euchromatic Y. Similarly, the KDM5-like gene assignment rests on InterProScan domain architecture rather than orthology-based naming and lacks experimental validation, leaving open whether this represents a genuine KDM5 ortholog or a diverged paralog.

## Tealc's citation-neighborhood suggestions

Readers may wish to consult empirical work on PAR size variation across taxa and comparative genomic studies of Y chromosome gene content loss in beetles more broadly, which would supply the lineage-specific aneuploidy–recombination relationships the theoretical model leaves unspecified. Comparative studies of KDM5-family gene sex-linkage across Coleoptera would help evaluate whether the *C. formosanus* finding represents a conserved feature of beetle sex chromosome evolution.

## Related on the Blackmon Lab site

- [Paper: Long-Term Fragility of Y Chromosomes Is Dominated by Short-Term Resolution of Sexual Antagonism (Blackmon & Brandvain 2017)](/knowledge/papers/10_1534_genetics_117_300382/)
- [Paper: Chromosome-Level Reference Genome of an Endemic, Endangered Long-Armed Scarab (*Cheirotonus formosanus*): Discovery of a Putative Y-Linked Scaffold and Demographic History (Chien, Huang & Blackmon 2026)](/knowledge/papers/10_1002_ece3_73483/)