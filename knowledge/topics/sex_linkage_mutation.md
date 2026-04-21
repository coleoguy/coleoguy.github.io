---
layout: default
title: "Sex-linkage mutation"
topic_slug: sex_linkage_mutation
last_updated: 2026-04-21T19:03:08.836659+00:00
papers_supporting: [10.1002/ece3.73483, 10.1534/genetics.117.300382, 8ec28241e312e0da2ddec048ec265c68f9b8c4b63678fb482d9e31d34a5690d6]
permalink: /knowledge/topics/sex_linkage_mutation/
---
# Sex-linkage mutation

## Current understanding

The evolution of sex-linked regions is driven, in large part, by the spread of chromosomal inversions that capture sexually antagonistic alleles and link them to the sex-determining region (SDR). A key theoretical framework holds that this process operates asymmetrically between the X and Y: Y-linked inversions tend to fix (and thereby initiate long-term Y degeneration), while X-linked inversions are more likely to be maintained as stable polymorphisms, depending critically on the dominance of the male-beneficial allele in conflict.

Under this model, the short-term "solution" to sexual antagonism — locking a male-beneficial allele onto the Y — carries a long-term cost. Because Y chromosome inversions suppress recombination, they inevitably expand a non-recombining region, predisposing the Y to the mutational decay described by the fragile-Y hypothesis. Complementing inversion-based expansion, a separate process shapes X chromosome gene content in the opposite direction: meiotic sex chromosome inactivation (MSCI) creates selection pressure for male-expressed genes to retropose off the X entirely, generating an observable out-of-the-X excess of retrogenes. Empirical work is also beginning to reveal which gene families end up sex-linked as these processes unfold, and a striking pattern of convergence is emerging: demethylases of the KDM5/JARID1 family appear on the Y chromosome independently in both mammals and beetles.

## Supporting evidence

Blackmon et al. provide quantitative parameter estimates for when Y-linked capture is evolutionarily viable. [Long-Term Fragility of Y Chromosomes Is Dominated by Short-Term Resolution of Sexual Antagonism., Finding 1](/knowledge/papers/10_1534_genetics_117_300382/#finding-1) shows that Y chromosome inversions linking a male-beneficial allele to the SDR can fix even when they increase aneuploidy by 4–6%, provided the male-beneficial allele is dominant and selection is at least *s* ≈ 0.2. This defines a surprisingly accessible parameter regime: moderate selection plus dominance is sufficient to overcome a substantial chromosomal cost.

The dynamics on the X chromosome differ qualitatively. [Long-Term Fragility of Y Chromosomes Is Dominated by Short-Term Resolution of Sexual Antagonism., Finding 2](/knowledge/papers/10_1534_genetics_117_300382/#finding-2) demonstrates that when the male-beneficial allele is recessive (*h* < ~0.3), an X-linked inversion capturing the female-beneficial allele cannot fix; instead it is maintained as a stable polymorphism. This means that the genetic architecture of the sexually antagonistic locus — particularly allele dominance — determines not just the rate but the qualitative outcome (fixation vs. balanced polymorphism) of sex-linked inversions.

A related but mechanistically distinct process also shapes which genes reside on the X. [2022 retrogenes, Finding 1](/knowledge/papers/2022_retrogenes/#finding-1) recovers the well-documented out-of-the-X excess of retrogenes in both humans and *D. melanogaster* with *p* ≈ 0, providing independent replication using the RetrogeneDB dataset. This pattern is consistent with MSCI silencing spermatogenesis genes during male meiosis and thereby selecting for retrocopy movement to autosomes — a complementary mechanism by which X chromosome gene content evolves over time, distinct from but potentially interacting with inversion dynamics.

On the empirical side, genome assembly of the long-armed scarab *Cheirotonus formosanus* has yielded evidence about which genes actually reside on a beetle Y chromosome. [Chromosome-Level Reference Genome of an Endemic, Endangered Long-Armed Scarab (<i>Cheirotonus formosanus</i>): Discovery of a Putative Y-Linked Scaffold and Demographic History., Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1) reports that a putative Y-linked scaffold carries a gene model with JARID1/KDM5 family domain architecture, covered exclusively by male reads and absent from female data — interpreted as a KDM5-like demethylase on the Y. This parallels KDM5D on the mammalian Y chromosome, raising the possibility that sex-linkage of this gene family reflects convergent retention of a dosage-sensitive regulator rather than random accumulation of male-beneficial alleles.

Together, these results support the interpretation that sex-linkage "mutations" (inversions expanding the sex-linked region) are strongly filtered by dominance and selection intensity, that the X and Y chromosomes respond differently to the same underlying sexual conflict, and that gene movement off the X via retroposition adds a further layer of dynamism to sex chromosome gene content evolution.

## Contradictions / open disagreements

The parameter thresholds reported (*s* ≈ 0.2 for Y fixation; *h* < 0.3 for X polymorphism) derive from a deterministic three-locus model with symmetric fitness effects, a fixed multiplicative aneuploidy cost, and no genetic drift. Empirical estimates of aneuploidy costs associated with PAR contraction and real-population drift effects are not incorporated, so the quantitative thresholds may not translate directly to natural populations. Whether drift destabilizes the predicted X-linked polymorphisms at low inversion frequency remains an open question not addressed by the current model.

The KDM5-like candidate from *C. formosanus* rests on domain architecture from InterProScan rather than orthology-based gene naming, and lacks experimental validation. The gene could be a diverged paralog rather than a direct equivalent of mammalian KDM5D, which would weaken the convergence interpretation. Broader sampling of beetle Y chromosome gene content is needed before the parallel can be considered robust.

The out-of-the-X retrogenesis finding replicates an established pattern rather than reporting a new discovery. The test reports *p* ≈ 0 from Monte Carlo iterations without an effect-size decomposition, making it difficult to assess the magnitude of the signal relative to earlier analyses. Whether MSCI is the primary driver, as opposed to dosage compensation or other X-linked constraints, remains contested.

## Tealc's citation-neighborhood suggestions

- Empirical studies measuring aneuploidy rates in taxa with variable PAR lengths would help calibrate the 4–6% cost assumption.
- Population-genetic models incorporating drift alongside sexually antagonistic selection could test whether the predicted X-linked balanced polymorphisms are robust at realistic effective population sizes.
- Orthology-based analyses of KDM5 family members across Coleoptera would clarify whether Y-linkage of this demethylase family is genuinely convergent or represents a single origin.
- Studies examining retrogenesis patterns in species without MSCI (e.g., organisms with holocentric chromosomes) would help disentangle MSCI from other drivers of the out-of-the-X excess.

## Related on the Blackmon Lab site

- [Long-Term Fragility of Y Chromosomes Is Dominated by Short-Term Resolution of Sexual Antagonism](/knowledge/papers/10_1534_genetics_117_300382/)
- [Chromosome-Level Reference Genome of an Endemic, Endangered Long-Armed Scarab (*Cheirotonus formosanus*): Discovery of a Putative Y-Linked Scaffold and Demographic History](/knowledge/papers/10_1002_ece3_73483/)
- [2022 retrogenes](/knowledge/papers/2022_retrogenes/)