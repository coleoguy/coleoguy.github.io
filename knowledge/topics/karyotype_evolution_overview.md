---
layout: default
title: "Karyotype evolution overview"
topic_slug: karyotype_evolution_overview
last_updated: 2026-04-21T21:24:52.494157+00:00
papers_supporting: [0235cb8484d2982c4d4f1d13c021c95aedc035bc7214dcfec49ec3ea96ccfa84, 0f1bc39e2879ec58c1a6e091a838d1861975612f9a803dea779e9576fe264d44, 1c95b7d3177f643f9388933de21d260747900051b120cf7a0774e24799ba33ca, 6e7c688c4f2e3fb47506b929ceb3f93edfad9c61210cfd2602ddcc57bf66d5be, 7252cf3de80be73c6e55d9e0bef2de22e8ff5c91259b24d33e52edebf150f528, baf57990bb1ab651800c9fa0878d6cc56f78093176f5b6ae7ef64f25fc8ba126, c6c1f45b84f53c5ec0361e367e8fab7bf3b8963db5c451a3256e09d2aed98732, f27df64e71adfbdf80f51dda1ec8b660a6fb871e76d8feb07659ebaa7c6da808, f9fb8e258c7b62f338b299e9c6fcbeb81259e1aef5f75ea3c782100d90b4a19c, fa8d0869c6d351d791f46d2b041f9c1589e106dfa4d3f3d2ebbc59e1e3b3d80e, sha256:0bc1262ecd509b5dec83643b93ac536d5495bffa47aa309736b5e3153aa38a47]
permalink: /knowledge/topics/karyotype_evolution_overview/
category: "Karyotype evolution"
---
<!-- tealc:auto-start -->
# Karyotype evolution overview

## Current understanding

Karyotype evolution — the gain, loss, or rearrangement of chromosomes over evolutionary time — is shaped by multiple forces including drift, selection, and interactions with the reproductive and ploidy system of a lineage. Several well-developed bodies of work illustrate how cellular, reproductive, ancestral-state context, and data resources constrain which karyotypic states are accessible and how they can be studied.

**Ancestral polarity of insect sex determination.** Any comparative analysis of sex-chromosome transitions needs a phylogenetic anchor. Likelihood-based ancestral state reconstruction across a database of more than 13,000 insect species places male heterogamety at the insect root with certainty (100% posterior probability), though the system cannot discriminate between XY and XO ancestry (60% and 40%, respectively) [Blackmon et al. 2017, Finding 1](/knowledge/papers/2017_sex_chromosomesa/#finding-1). This establishes that female heterogamety and haplodiploidy are derived states relative to an ancestrally male-heterogametic background, providing the polarity needed to interpret downstream transitions.

**Mechanisms of sex-chromosome system turnover.** Once a lineage is anchored to male heterogamety, how do transitions between XO and XY states occur? Work on Polyneoptera provides a compelling answer: fusions between sex chromosomes and autosomes are the dominant route for XO→XY transitions. Across the 17 genera that contain both XO and XY species, 94% (16/17) show a lower mean number of autosomes in XY species — exactly the signature expected if Y chromosomes arose via fusion rather than neo-sex-chromosome formation [Sylvester et al. 2020, Finding 1](/knowledge/papers/2020_polyneoptera/#finding-1). This fusion-centric model implies that karyotype evolution and sex-chromosome system evolution are mechanistically linked rather than independent processes.

New theoretical work refines where on the sex chromosomes such fusions are expected to land under natural selection. Simulations incorporating sexually antagonistic alleles show that fusions to the non-pseudoautosomal region (non-PAR) of a sex chromosome are favored when a sexually antagonistic locus is present, while fusions to the PAR are disfavored under the same conditions [Worse than nothing at 2024, Finding 1](/knowledge/papers/2024_worse/#finding-1). An additional asymmetry emerges between Y-autosome and X-autosome fusions: Y-autosome non-PAR fusions reach marginally higher frequencies because X-autosome fusions are present in males — the sex in which the selective benefit is realized — only one-third of the time [Worse than nothing at 2024, Finding 2](/knowledge/papers/2024_worse/#finding-2).

The Drosophila case, however, shows that fusion suppression can dominate over fusion promotion. The observed proportion of sex-chromosome–autosome fusions in Drosophila (0.155; CI 0.12–0.22) is far below the expected proportion (0.43; CI 0.42–0.44), with non-overlapping credible intervals [The probability of fusions 2020, Finding 1](/knowledge/papers/2020_probability/#finding-1). This deficit suggests that the genomic or meiotic environment of a lineage can suppress fusions rather than promote them.

**Genomic architecture and sex-chromosome identity in bark beetles.** Comparative genomics of bark beetles (Dendroctonus) provides a complementary window into sex-chromosome evolution within Coleoptera. In the southern pine beetle (SPB), the putative X chromosome identified by reduced male read coverage is syntenic with the neoX chromosome of D. ponderosae, directly linking the two species' sex-chromosome systems [Genome assembly of the 2024, Finding 1](/knowledge/papers/2024_spb/#finding-1). Beyond the sex chromosomes, the nine ancestral Coleopteran Stevens elements are conserved across SPB, mountain pine beetle (MPB), and Tribolium castaneum, indicating deep macrostructural stability of the beetle genome alongside lineage-specific sex-chromosome differentiation.

**Effective population size and drift as rate determinants.** A major open question is why fusion and fission rates vary so dramatically across clades. Work on Coleoptera provides quantitative evidence that reduced effective population size (Ne) elevates fusion rates. In Polyphaga, low-Ne clades show mean fusion rates of 0.05–0.11, compared with below 0.025 in medium and high Ne clades; in Adephaga, Calathus exhibits fusion rates more than ten times higher than the average of all other Adephaga clades [Drift drives the evolution 2024, Finding 1](/knowledge/papers/2024_drift_beetles/#finding-1). Wingless Carabidae also show elevated fission rates relative to winged relatives (CI for the difference entirely positive: 0.005–0.044) [Drift drives the evolution 2024, Finding 3](/knowledge/papers/2024_drift_beetles/#finding-3). This Ne–karyotype rate relationship extends beyond insects: in Carnivora, small-range lineages show elevated fusion rates (ΔR = 0.101, CI 0.062–0.141) and fission rates (ΔR = 0.163, CI 0.116–0.207) relative to large-range lineages [Drift drives the evolution 2024, Finding 1](/knowledge/papers/2024_drift_carnivores/#finding-1). Convergence across an insect order and a mammalian order strengthens the inference that genetic drift is a general accelerant of structural chromosome evolution. A methodological caution: phylogenetic model-based rate estimates and traditional scaled-variance estimates are uncorrelated across nine Coleoptera clades (Kendall's τ = 0.11, P = 0.76) [Drift drives the evolution 2024, Finding 2](/knowledge/papers/2024_drift_beetles/#finding-2), raising doubts about decades of scaled-variance karyotype studies.

**Meiotic mechanism, holocentricity, and sex-chromosome stability.** A complementary constraint operates through the mechanics of meiosis itself. In beetles, achiasmatic clades — those in which males lack crossover-based chromosome pairing — show dramatically fewer XO karyotypes than expected. Within Adephaga, Trechitae has only 3 XO species where 16 are expected, and Cicindelinae + Colyrinae has only 1 where 6 are expected [Blackmon & Demuth 2015, Finding 1](/knowledge/papers/2015a/#finding-1). Chromosome architecture also plays a role: in a simplified model excluding polyploidy, 83% of the posterior distribution of the holocentric–monocentric fission rate difference lies above zero, hinting at a weak elevation of fission rates in holocentric clades, although the credible interval still overlaps zero [Ruckman et al. 2020, Finding 1](/knowledge/papers/2020_holocentric/#finding-1). Together, these results suggest that both the mechanics of pairing at meiosis and the structural type of centromere influence how freely lineages explore chromosome-number space.

**Reproductive mode, polyploidy, and chromosome number.** In Phasmatodea, rates of polyploidy are significantly higher in asexually reproducing lineages than in sexual ones, while fusion and fission rates do not differ between reproductive modes [Sylvester et al. 2020, Finding 2](/knowledge/papers/2020_polyneoptera/#finding-2). This decoupling hints that the genomic consequences of sex extend beyond sex-chromosome maintenance to broader karyotypic stability.

**Chromosome number and the origin of haplodiploidy.** Bull's haploid-viability hypothesis predicts that lineages with naturally low chromosome numbers should be pre-adapted for haplodiploidy. In mites, haplodiploid species carry roughly five fewer chromosomes than their diplodiploid relatives [Blackmon et al. 2015, Finding 1](/knowledge/papers/2015_haplo/#finding-1), and ancestral state reconstructions suggest karyotype reduction preceded haplodiploidy (mean 18.4 vs. null 20.2; P = 0.017) [Blackmon et al. 2015, Finding 2](/knowledge/papers/2015_haplo/#finding-2).

**Amphibian karyotype resources.** The Amphibian Karyotype Database now contains 2,124 records — more than doubling earlier compilations — with 1,833 Anura, 246 Caudata, and 45 Gymnophiona records [Perkins et al. 2019, Finding 1](/knowledge/papers/2019_amphibs/#finding-1), enabling comparative analyses across a vertebrate outgroup with distinctive ploidy patterns.

## Supporting evidence

- [Blackmon et al. 2017, Finding 1](/knowledge/papers/2017_sex_chromosomesa/#finding-1) — Likelihood-based reconstruction across >13,000 insect species recovers male heterogamety at the insect root with 100% probability; XY vs. XO ancestry cannot be distinguished (60%/40%).
- [Sylvester et al. 2020, Finding 1](/knowledge/papers/2020_polyneoptera/#finding-1) — In Polyneoptera, 94% (16/17) of mixed-SCS genera show lower mean autosome number in XY species, establishing fusions as the dominant mechanism of XO→XY transition.
- [Sylvester et al. 2020, Finding 2](/knowledge/papers/2020_polyneoptera/#finding-2) — Polyploidy rates are significantly higher in asexually reproducing Phasmatodea lineages than in sexual ones; fusion and fission rates do not differ by reproductive mode.
- [Blackmon & Demuth 2015, Finding 1](/knowledge/papers/2015a/#finding-1) — Achiasmatic Adephaga clades are dramatically deficient in XO taxa relative to simulation-based expectations, linking meiotic mechanism to long-term sex-chromosome stability.
- [Ruckman et al. 2020, Finding 1](/knowledge/papers/2020_holocentric/#finding-1) — In a simplified model excluding polyploidy, 83% of the posterior distribution of the holocentric–monocentric fission rate difference lies above zero, suggesting a weak elevation of fission rates in holocentric clades, though the credible interval overlaps zero.
- [Blackmon et al. 2015, Finding 1](/knowledge/papers/2015_haplo/#finding-1) — Haplodiploid mites have ~2n = 5 fewer chromosomes than diplodiploid mites, significant under both taxonomic and phylogenetic comparative models.
- [Blackmon et al. 2015, Finding 2](/knowledge/papers/2015_haplo/#finding-2) — Ancestral chromosome numbers at haplodiploidy-origin nodes (mean 18.4) are significantly lower than expected under independent evolution (null 20.2, P = 0.017).
- [Perkins et al. 2019, Finding 1](/knowledge/papers/2019_amphibs/#finding-1) — The Amphibian Karyotype Database contains 2,124 records (1,833 Anura, 246 Caudata, 45 Gymnophiona), more than doubling the last compilation.
- [The probability of fusions 2020, Finding 1](/knowledge/papers/2020_probability/#finding-1) — In Drosophila, the observed proportion of sex-chromosome–autosome fusions (0.155; CI 0.12–0.22) is far below the expected proportion (0.43; CI 0.42–0.44), with non-overlapping credible intervals.
- [Drift drives the evolution 2024, Finding 1](/knowledge/papers/2024_drift_beetles/#finding-1) — Across 12 Coleoptera clades, low-Ne clades show mean fusion rates of 0.05–0.11 in Polyphaga vs. below 0.025 in medium/high Ne clades; Calathus shows fusion rates more than ten times higher than other Adephaga clades.
- [Drift drives the evolution 2024, Finding 2](/knowledge/papers/2024_drift_beetles/#finding-2) — Phylogenetic model-based rate estimates are uncorrelated with scaled-variance estimates across nine clades (Kendall's τ = 0.11, P = 0.76), challenging fossil-calibrated variance approaches.
- [Drift drives the evolution 2024, Finding 3](/knowledge/papers/2024_drift_beetles/#finding-3) — Wingless Carabidae show higher fission rates than winged relatives, with the credible interval entirely positive (0.005–0.044), consistent with drift-driven chromosome number increase.
- [Drift drives the evolution 2024, Finding 1](/knowledge/papers/2024_drift_carnivores/#finding-1) — In Carnivora, small-range lineages show elevated fusion rates (ΔR = 0.101, CI 0.062–0.141) and fission rates (ΔR = 0.163, CI 0.116–0.207) relative to large-range lineages.
- [Worse than nothing at 2024, Finding 1](/knowledge/papers/2024_worse/#finding-1) — Simulations show fusions to the non-PAR are favored under sexual antagonism, while fusions to the PAR are disfavored, conditioning fixation probability on fusion location.
- [Worse than nothing at 2024, Finding 2](/knowledge/papers/2024_worse/#finding-2) — Y-autosome non-PAR fusions reach marginally higher fixation frequencies than X-autosome fusions because X-autosome fusions are present in males — where the selective benefit is realized — only one-third of the time.
- [Genome assembly of the 2024, Finding 1](/knowledge/papers/2024_spb/#finding-1) — The SPB putative X scaffold is syntenic with the neoX of D. ponderosae, and nine ancestral Coleopteran Stevens elements are conserved across SPB, MPB, and T. castaneum.

## Contradictions / open disagreements

The ancestral-state reconstruction establishing male heterogamety at the insect root cannot resolve XY vs. XO ancestry (60% vs. 40%), limiting inferences about Y-chromosome polarity deep in insect phylogeny [Blackmon et al. 2017, Finding 1](/knowledge/papers/2017_sex_chromosomesa/#finding-1).

The fusion-driven XO→XY result in Polyneoptera [Sylvester et al. 2020, Finding 1](/knowledge/papers/2020_polyneoptera/#finding-1) sits in genuine tension with the Drosophila result, where sex-chromosome–autosome fusions are far rarer than expected [The probability of fusions 2020, Finding 1](/knowledge/papers/2020_probability/#finding-1). The new sexual-antagonism model [Worse than nothing at 2024, Finding 1](/knowledge/papers/2024_worse/#finding-1) predicts non-PAR fusions should be favored when sexually antagonistic alleles are present, yet it cannot explain the Drosophila deficit on its own — indicating that clade-specific factors actively suppress fusions in some lineages.

The holocentric fission-rate elevation [Ruckman et al. 2020, Finding 1](/knowledge/papers/2020_holocentric/#finding-1) is a suggestive trend (83% posterior mass above zero) rather than a statistically supported result, as the 95% credible interval overlaps zero. The signal also depends on excluding polyploidy from the model, and a fully specified analysis could alter the conclusion. The theoretical fusion-asymmetry model [Worse than nothing at 2024, Finding 2](/knowledge/papers/2024_worse/#finding-2) assumes obligate PAR recombination every male meiosis, an assumption violated in achiasmatic lineages [Blackmon & Demuth 2015, Finding 1](/knowledge/papers/2015a/#finding-1), so its quantitative predictions may not apply to some of the most species-rich insect clades.

The bark beetle SPB result [Genome assembly of the 2024, Finding 1](/knowledge/papers/2024_spb/#finding-1) identifies the X chromosome purely by reduced male read coverage without cytogenetic confirmation, and Stevens element conservation is assessed across only three taxa. Broader sampling across Curculionidae would be needed to determine how general the synteny and element-conservation patterns are.

The Ne-driven rate patterns rest on indirect proxies. In Coleoptera, Ne is indexed by categorical proxy traits rather than direct estimates [Drift drives the evolution 2024, Finding 1](/knowledge/papers/2024_drift_beetles/#finding-1). In Carnivora, range size was discretized at the median, and simulations found false positive rates of 22–33% for neutral traits [Drift drives the evolution 2024, Finding 1](/knowledge/papers/2024_drift_carnivores/#finding-1). The fission-rate elevation in wingless Carabidae was detected only in the simpler model [Drift drives the evolution 2024, Finding 3](/knowledge/papers/2024_drift_beetles/#finding-3), making that result model-dependent.

The uncorrelation between phylogenetic and scaled-variance rate estimates rests on only nine overlapping clades [Drift drives the evolution 2024, Finding 2](/knowledge/papers/2024_drift_beetles/#finding-2). The elevated polyploidy rate in asexual Phasmatodea rests on only 13 parthenogenetic species [Sylvester et al. 2020, Finding 2](/knowledge/papers/2020_polyneoptera/#finding-2). The haplodiploidy pattern in mites has not been confirmed across other invertebrate clades [Blackmon et al. 2015, Finding 2](/knowledge/papers/2015_haplo/#finding-2). The Amphibian Karyotype Database is heavily biased toward Anura (86% of records) [Perkins et al. 2019, Finding 1](/knowledge/papers/2019_amphibs/#finding-1).

## Tealc's citation-neighborhood suggestions

- Comparative studies of sex-chromosome system turnover in other hemimetabolous insect orders would test whether the fusion-dominated XO→XY route seen in Polyneoptera is a general feature of insect sex-chromosome evolution.
- Empirical counts of non-PAR vs. PAR fusions across diverse clades would provide a direct test of the theoretical prediction that non-PAR fusions are preferentially fixed under sexual antagonism.
- Studies examining population-genetic consequences of achiasmy (e.g., altered Hill–Robertson interference, reduced purifying selection on sex chromosomes) would help connect the macroevolutionary pattern to a mechanistic model of Y retention and the Drosophila fusion deficit.
- Direct Ne estimates (e.g., from nucleotide diversity or demographic inference) for both the Coleoptera clades and the Carnivora lineages would test whether the categorical proxy-trait classifications genuinely track realized Ne.
- Cytogenetic confirmation of X chromosome identity in SPB and related bark beetles, combined with expanded Stevens element mapping across Curculionidae, would test how general the synteny conservation findings are.
- Analyses of polyploidy in other asexual invertebrate lineages would test whether the Phasmatodea result generalizes beyond a single order.
- Broader mammalian surveys (beyond Carnivora) using range size or population genetic diversity as Ne proxies would further test whether drift-accelerated karyotype evolution is a vertebrate-wide phenomenon.
- A fully specified comparative model incorporating both polyploidy and holocentricity simultaneously would resolve whether the weak holocentric fission-rate signal survives model complexity.

## Related on the Blackmon Lab site

- [Ruckman et al. 2020](/knowledge/papers/2020_holocentric/)
- [Genome assembly of the 2024](/knowledge/papers/2024_spb/)
- [Worse than nothing at 2024](/knowledge/papers/2024_worse/)
- [Drift drives the evolution 2024](/knowledge/papers/2024_drift_carnivores/)
- [Drift drives the evolution 2024](/knowledge/papers/2024_drift_beetles/)
- [The probability of fusions 2020](/knowledge/papers/2020_probability/)
- [Sylvester et al. 2020](/knowledge/papers/2020_polyneoptera/)
- [Blackmon et al. 2017](/knowledge/papers/2017_sex_chromosomesa/)
- [Blackmon et al. 2015](/knowledge/papers/2015_haplo/)
- [Blackmon & Demuth 2015](/knowledge/papers/2015a/)
- [Perkins et al. 2019](/knowledge/papers/2019_amphibs/)
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
## Related topics on this site

- [Sex chromosome evolution](/knowledge/topics/sex_chromosome_evolution/) — 7 shared papers
- [Chromosome number evolution](/knowledge/topics/chromosome_number_evolution/) — 5 shared papers
- [Coleoptera genomics](/knowledge/topics/coleoptera_genomics/) — 3 shared papers
- [Fragile Y hypothesis](/knowledge/topics/fragile_y_hypothesis/) — 3 shared papers
- [Karyotype database](/knowledge/topics/karyotype_database/) — 2 shared papers
- [Selection and drift](/knowledge/topics/selection_and_drift/) — 2 shared papers
<!-- tealc:related-end -->
