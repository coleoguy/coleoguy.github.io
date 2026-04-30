---
layout: default
title: "Contradictions and open disagreements"
permalink: /knowledge/contradictions/
last_updated: 2026-04-30T10:00:00.013349+00:00
---

# Contradictions and open disagreements across lab topics

Every lab topic page has a `## Contradictions / open disagreements` section. This page aggregates them across the wiki — a single place to see where the literature actively disagrees with itself.

## Bioinformatics & tools

### [Bioinformatics Methods](/knowledge/topics/bioinformatics_methods/)

The published abstract reports a 10–20× speedup while the results section of the same paper reports 6–18×. The discrepancy tracks which read-length range is used in the comparison. More broadly, the benchmarks were conducted on a single 2.5 GHz Xeon E5420 core with simulated data; whether the same gains hold on modern multi-core hardware with real sequencing reads and more complex or repeat-rich genomes has not been settled by this paper alone.

### [Bioinformatics Tools](/knowledge/topics/bioinformatics_tools/)

The minimap2 spliced-alignment benchmark has two structural limitations worth flagging. First, the comparison used a single mouse cDNA dataset sequenced with R9.4 ONT chemistry; GMAP and SpAln were not tuned for noisy reads, so their performance under optimized parameters could be meaningfully higher. Second, the chaining-accuracy claim is supported by unpublished supplementary data ("data not shown"), and the genomic benchmarks rely on simulated human reads — neither condition transfers cleanly to repeat-rich, non-human, or highly divergent genomes. The >40× speed advantage and the absolute accuracy numbers should therefore be treated as chemistry- and organism-specific baselines rather than universal rankings.

No contradictions are currently known between CaveCrawler and the minimap2 findings; they address different problems and different data types.

### [Bisse](/knowledge/topics/BiSSE/)

The magnitude of the false-positive problem documented here is tied to phylogenies with known, strong diversification heterogeneity. The cetacean tree has a well-characterized dolphin radiation that drives high rate variance across lineages. On trees with more homogeneous background rates, Type I error inflation may be considerably lower. The taxon-name-length test has a mild confounder as well: congeners share name prefixes, introducing weak phylogenetic signal into a character that is otherwise arbitrary. Some fraction of the near-100% false-positive rate in fishes could reflect that residual structure rather than diversification heterogeneity alone. Neither caveat rehabilitates BiSSE for general use, but they do mean the cetacean/fish numbers are likely upper bounds rather than universal baselines.

Whether hidden-state corrections (e.g., HiSSE) fully resolve the problem remains contested, and model adequacy testing for state-dependent diversification models is still an open area.

### [Cavefish Genomics](/knowledge/topics/cavefish_genomics/)

The *arpin* result is correlative and threshold-dependent: classifying F_ST outliers at the lowest 5% of divergence (Herman et al. 2018) and drawing on one circadian transcription dataset (Mack et al. 2021) means the double-outlier list could shift with different datasets or thresholds. No functional validation of *arpin*'s role in cavefish biology has been reported, so its candidacy remains bioinformatic rather than mechanistic. Additionally, CaveCrawler's long-term utility as a citable resource depends on continued curation; if data deposition stalls, the snapshot captured at publication may become unrepresentative of the field.

### [Chaining Algorithm](/knowledge/topics/chaining_algorithm/)

The chaining-accuracy claim from minimap2's paper rests on unpublished supplementary data ("data not shown"), which makes independent verification impossible. The benchmarks were conducted on simulated human reads; it is not clear whether the same accuracy advantage holds on more repeat-dense genomes, highly divergent sequences, or non-human organisms where anchor density and false-hit rates differ substantially. Until those comparisons appear in reproducible form, the generality of the claim should be treated cautiously.

### [Circadian rhythm evolution](/knowledge/topics/circadian_rhythm_evolution/)

The biological inference that *arpin* plays a functional role in cavefish circadian evolution remains correlative. The double-outlier status depends on both the choice of FST threshold (lowest 5% divergence in Herman et al. 2018) and the specific circadian transcription dataset used; altering either input could change the candidate gene list. No functional validation — e.g., knockouts, rescue experiments, or behavioral circadian assays — has been reported for *arpin* in this context. Additionally, *arpin*'s canonical function is in actin regulation, so its appearance in a circadian screen may reflect pleiotropic effects or limitations of the transcription dataset rather than a primary role in clock evolution. These uncertainties should be resolved before *arpin* is treated as a confirmed circadian evolution gene in cavefish.

### [Flow Cytometry](/knowledge/topics/flow_cytometry/)

The sex-chromosome correction formula assumes that autosome content is identical between the sexes — no sex-limited B chromosomes, no sex-biased satellite arrays outside the formal sex chromosomes, and no differential chromatin compaction from dosage compensation. Any of these could introduce error of unknown magnitude. The protocol acknowledges complex systems (e.g., Xi/Xj/Y) but does not supply analogous worked formulas for them, leaving practitioners without clear guidance for those cases.

The 10% saturation figure for *Aedes* is a single illustrative example from a methods chapter with no reported sample size or variance. Whether the same magnitude of inflation applies to other large-genome insects remains untested in this source.

### [Genome Resequencing](/knowledge/topics/genome_resequencing/)

The Li & Durbin (2009) benchmarks were run on a single processor core using simulated reads against the human reference genome. The abstract reports 10–20× speed gains while the Results section reports 6–18×; the discrepancy reflects which read-length range is considered. Real-world performance on non-human genomes, repeat-rich assemblies, or modern multi-core hardware is not directly addressed by this study, and no comparisons to post-2009 aligners (BWA-MEM, BWA-MEM2, Bowtie2) are available from this paper.

### [Genome Size Estimation](/knowledge/topics/genome_size_estimation/)

The sex-chromosome correction formulas assume no sex-differential autosomal content (e.g., no sex-limited B chromosomes, no sex-biased repeat arrays outside the sex chromosomes) and that dosage compensation does not alter chromatin compaction differently between sexes. Either violation could introduce error that the correction does not account for. The method chapter acknowledges more complex systems (Xi/Xj/Y) but does not provide explicit formulas for them.

The 10% saturation-time inflation figure for *Aedes* is a single illustrative example from a methods chapter without sample-size or replicate information, so its generality to other large-genome taxa is unestablished.

### [Hybrid Sterility](/knowledge/topics/hybrid_sterility/)

The sterility QTL experiment involved weakly fertile F1 males and a backcross of n = 76, meaning power to detect neo-X effects on sterility was limited. The null result for the neo-X could reflect insufficient sample size rather than a true biological difference between the two chromosomes. Broader replication — larger crosses, or parallel tests in other systems with neo-sex chromosomes of known age — would sharpen or refute the age-dependence interpretation.

### [Inversions](/knowledge/topics/inversions/)

The h < 0.3 dominance threshold is derived from a symmetric fitness model that assumes complete recombination suppression within the inversion. Under asymmetric selection coefficients or partial recombination suppression, the boundary between fixation and stable polymorphism could shift substantially or disappear altogether. Broader parameter exploration is needed before this threshold can be treated as a generalizable empirical prediction.

### [Long Read Sequencing](/knowledge/topics/long_read_sequencing/)

The spliced-alignment benchmark (Finding 1) uses a single mouse cDNA dataset sequenced with R9.4 ONT chemistry. GMAP and SpAln were not parameter-tuned for noisy long reads, so their reported accuracy may understate what those tools can achieve with careful configuration. Performance on more repeat-dense or divergent genomes — beetle chromosomes, for instance — is not directly characterized. The chaining-accuracy claim (Finding 2) is described as "data not shown," making independent verification from the paper alone impossible, and the comparison relies on simulated human reads that may not represent the structural complexity of non-model organisms.

### [Model Inadequacy](/knowledge/topics/model_inadequacy/)

The cetacean phylogeny result may overstate the general problem. That tree has unusually strong diversification heterogeneity (the dolphin radiation), and false positive rates on more rate-homogeneous trees are likely lower. Whether the problem is severe enough to disqualify BiSSE results across vertebrates broadly, or only on clades with known rate shifts, remains an open empirical question. The taxon name length test is nearly a clean null, but taxon names do carry phylogenetic signal through shared prefixes among congeners, so the false positive rate it measures is not purely attributable to tree-level rate heterogeneity.

### [Model Organism Databases](/knowledge/topics/model_organism_databases/)

None known from current findings. However, a significant open question is **sustainability**: model organism databases depend on active curation and community data deposition. If a database is not continuously updated, its value as a citable and reliable resource erodes. CaveCrawler's long-term utility will hinge on whether the *A. mexicanus* community continues to contribute new datasets to the platform.

Additionally, CaveCrawler is species-specific; whether its design principles generalize to other non-traditional model organisms with smaller research communities remains untested.

### [Mutation Rate Bias](/knowledge/topics/mutation_rate_bias/)

The male-biased mutation inference in Pennell et al. leans on human translocation data to support the mutation-rate component, while the excess Y-autosome fusions are documented in fishes and squamate reptiles. Direct evidence that the male mutation bias is of comparable magnitude in those ectothermic lineages is sparse. A female-biased reproductive sex ratio is offered as an alternative explanation that would produce the same pattern without requiring any mutation-rate asymmetry, and the two hypotheses are not currently distinguishable with available data. Broader taxonomic sampling of sex-specific mutation rates — particularly in ray-finned fishes and squamates — would be needed to determine which mechanism dominates.

### [Phylogenetic Comparative Methods](/knowledge/topics/phylogenetic_comparative_methods/)

The cetacean result is specific to a phylogeny with unusually pronounced diversification heterogeneity. Phylogenies with more homogeneous background diversification dynamics would likely show lower false-positive rates, so the 77% figure is probably an upper bound rather than a universal baseline. Additionally, taxon name length carries weak phylogenetic signal because congeners share name prefixes; the false-positive rates for that character may partly reflect residual phylogenetic structure in the names themselves, not purely tree-wide diversification heterogeneity. Whether state-dependent diversification methods can be trusted without hidden-state correction is still contested, and the degree to which newer approaches (HiSSE, BAMM-trait combinations) solve versus reframe the model adequacy problem is only starting to be tested systematically.

### [Qtl Mapping](/knowledge/topics/QTL_mapping/)

The Kitano et al. 2009 study rests on 76 backcross males from a single cross design, which gives limited power to detect QTLs of small effect and yields wide confidence intervals on mapped positions. Critically, the design does not permit direct separation of neo-X from neo-Y contributions to phenotypic variance. Until crosses with larger sample sizes or fine-mapping populations confirm the QTL positions, the intervals should be treated as provisional. Whether the same pattern holds in other neo-sex chromosome systems — or whether sticklebacks are unusual in the speed with which speciation loci accumulate on a new sex chromosome — remains an open question.

### [Repeat Annotation](/knowledge/topics/repeat_annotation/)

The single-species scope of the current evidence is a notable limitation. The Monte Carlo null model randomizes repeat positions while preserving repeat sizes and inter-copy distances but does not account for GC content gradients, chromatin accessibility, or variation in local recombination rate. Consequently, part of the observed depletion could reflect compositional or structural differences between genic and intergenic regions rather than selection per se. Broader taxonomic sampling and null models that explicitly control for sequence composition will be needed to distinguish these explanations. Additionally, the source paper was awaiting peer review at the time this finding was recorded.

### [Rna Seq](/knowledge/topics/RNA_seq/)

The minimap2 benchmark is limited to a single species and a single ONT chemistry. GMAP and SpAln were not run with parameters tuned for high-error reads, so the reported accuracy gap may overstate minimap2's advantage in a fair comparison. Performance on SMRT data or on newer, higher-accuracy ONT chemistries remains an open question.

### [Selection Theory](/knowledge/topics/selection_theory/)

The central tension here is internal to the same paper: the theoretical model predicts Y-autosome fusions should be ~3× more common than X-autosome fusions, yet the empirical data show no such excess. This discrepancy could mean the model's idealized conditions — no recombination between the selected locus and centromere, no segregation disturbance, infinite population size — are too far from biological reality for the prediction to be realized. It could also reflect that other forces, such as meiotic drive or recombination suppression costs, oppose fixation of Y fusions specifically. Broader taxonomic sampling beyond Drosophila and mammals would help distinguish these possibilities.

### [Sequence Alignment](/knowledge/topics/sequence_alignment/)

The chaining-accuracy superiority claim in Finding 2 is reported as "data not shown," so independent verification from the published figures is not possible. The spliced-alignment benchmarks (Finding 1) come from a single mouse cDNA dataset under R9.4 ONT chemistry; whether the accuracy ordering holds for SMRT reads, newer ONT chemistries, or genomes with higher repeat content is not yet documented in this paper. These two gaps leave open the possibility that performance rankings shift on non-mammalian or highly repetitive genomes — a relevant concern for insect genomics work.

### [Short Read Alignment](/knowledge/topics/short_read_alignment/)

The original benchmark figures carry a noted internal inconsistency: the abstract of Li & Durbin 2009 reports a 10–20× speedup while the results section gives 6–18×, with the difference attributable to which range of read lengths is considered. Neither figure is wrong, but citing the paper requires specifying which range is meant. More broadly, these benchmarks reflect single-core performance on 2009 hardware with simulated data; real-world speedups against modern multi-threaded aligners on current hardware and with empirical reads from complex genomes could differ substantially. No contradicting paper has been incorporated into this page yet, but the benchmarking landscape for short-read alignment has evolved considerably since 2009.

### [Software Tools](/knowledge/topics/software_tools/)

The analysis underlying Finding 1 is currently confined to a single species (*A. aegypti*), limiting the generality of the biological conclusion. Additionally, the null model randomizes repeat positions while preserving repeat sizes and inter-copy distances but does not fully control for GC content, chromatin accessibility, or recombination landscape. The observed depletion could therefore partly reflect compositional or structural differences between genic and intergenic regions rather than natural selection alone. The paper was also awaiting peer review at the time this finding was recorded, so conclusions should be treated as provisional until independent review is complete.

### [Speciation Genetics](/knowledge/topics/speciation_genetics/)

The QTL study in Kitano et al. 2009 used a single backcross design with 76 males — low power to detect loci of small effect, and insufficient to map loci to the neo-Y. Wide confidence intervals on QTL positions mean co-localization with known speciation genes remains tentative. It is also unresolved whether the clustering of barrier loci on the neo-X reflects selection specifically on hemizygous loci or is a statistical artifact of reduced recombination near the fusion point. Direct population-genomic evidence distinguishing these hypotheses is still lacking.

### [Trait Dependent Diversification](/knowledge/topics/trait_dependent_diversification/)

The cetacean result may overstate the typical false positive rate. The dolphin radiation creates unusually sharp diversification heterogeneity, and on phylogenies with more homogeneous background rates the error rate could be substantially lower. Additionally, the taxon-name-length character is not a perfectly clean null: congeners share name prefixes, so the character carries residual phylogenetic signal. Some portion of the inflated error rate in ray-finned fishes may trace to that structure rather than to diversification heterogeneity alone. Neither caveat undermines the core finding, but both mean the reported error rates should be treated as upper bounds for the specific clades tested rather than universal constants.

### [Type I Error](/knowledge/topics/type_I_error/)

The cetacean result may not generalize uniformly. The cetacean phylogeny contains one of the most dramatic radiations in vertebrate history (delphinids), so the diversification heterogeneity driving false positives is unusually pronounced. Phylogenies with more homogeneous background rates might show lower Type I error inflation, though the taxon name length analysis across many vertebrate subtrees suggests the problem is broadly distributed, not confined to especially heterogeneous trees.

Taxon name length is not a perfectly clean null: congeners share name prefixes, so the character carries residual phylogenetic signal. Some fraction of the inflated error rate could reflect that structure rather than diversification heterogeneity alone. The finding is still damning — no one would argue name length *causes* speciation — but the precise magnitude of inflation attributable purely to background rate heterogeneity remains somewhat entangled with this artifact.

Whether hidden-state extensions (e.g., HiSSE) adequately resolve the Type I error problem is contested and not directly addressed by these findings.

## Genome structure

### [Genetic Architecture](/knowledge/topics/genetic_architecture/)

The central tension in the 2024 Solanum findings is methodological: line cross analysis can attribute phenotypic variance to epistasis, but this epistasis may arise from novel multi-locus genotype combinations generated by hybridization rather than from epistatic interactions that were experienced during the evolutionary divergence of the two species. In other words, the genetic architecture inferred from an F₂ or backcross population may not faithfully represent the architecture that shaped divergence in nature. No alternative analysis within the study directly resolves this ambiguity.

Additionally, the observation that compound traits behave additively while their components do not is currently a single data point. The authors acknowledge that a systematic comparison across many compound and elemental traits is needed before this pattern can be treated as a general principle.

### [Genome Assembly](/knowledge/topics/genome_assembly/)

Two important caveats complicate interpreting assembly statistics at face value. First, in the *C. formosanus* case, chromosome number is inferred indirectly from Hi-C contact patterns and consistency with relatives rather than from direct cytogenetic counts on the focal species. If direct chromosome counts were to differ from the inferred 2n = 20, the scaffold-to-chromosome correspondence would need to be revisited.

Second, the *C. gloriosa* assembly (642 MB) is notably smaller than flow-cytometry-based genome size estimates (~850 MB) for the species. The authors attribute this discrepancy to unassembled repetitive content — a common limitation of current long-read approaches. This means that BUSCO scores and scaffold N50 values, while informative about gene-space completeness and contiguity, do not fully capture how much of a genome, particularly its repetitive fraction, has actually been assembled. Both cases underscore a broader methodological tension: assembly-based inference is powerful but benefits from orthogonal validation via cytogenetics and independent genome size estimation.

### [Genome Dynamics](/knowledge/topics/genome_dynamics/)

The rate signal attributed to monocentricity is potentially confounded by order-level biology. Diptera and Hymenoptera — both monocentric — likely contribute disproportionately to the elevated rate estimate, while Coleoptera, also monocentric, exhibits the *lowest* microsatellite evolution rate of any order examined. The authors themselves draw an analogy to BiSSE false-positive inflation, where strong signal concentrated in a small portion of a phylogeny can make any binary trait mapped there appear causally linked to elevated rates. Until the Diptera/Hymenoptera signal can be decoupled from the monocentricity signal — for instance, by denser sampling within orders or experimental approaches — the claim that centromere architecture *per se* drives rate differences should be treated as a working hypothesis rather than an established mechanism.

### [Genome structure evolution](/knowledge/topics/genome_structure_evolution/)

- **Direct-repeat depletion: selection or composition?** The ~7-fold depletion of exons flanked by direct repeats in *A. aegypti* is interpreted as purifying selection against SSA-mediated deletion hazards, but the Monte Carlo null does not control for GC content, chromatin accessibility, or recombination landscape. The depletion could partly reflect compositional or structural differences between genic and intergenic regions rather than selection alone. The analysis is also limited to a single species, and the paper was awaiting peer review at time of writing ([DirectRepeateR: An R package 2025, Finding 1](/knowledge/papers/10_12688_f1000research_170810_1/#finding-1)).

- **Assembly gap vs. flow-cytometry estimate in SPB**: The *D. frontalis* assembly (173.7 Mbp) is smaller than the flow-cytometry genome-size estimate of 194.7 Mbp, indicating under-assembly of highly repetitive regions. Repeat-content estimates may therefore be correspondingly underestimated ([Genome assembly of the 2024, Finding 1](/knowledge/papers/10_1098_rsos_240755/#finding-1)).

- **Gene-count reduction: biology or pipeline?**: The ~3,600-gene deficit in *Dendroctonus* relative to other beetles may reflect genuine gene-space reduction, but the TE-adjustment procedure relies on domain-keyword heuristics rather than manual curation. Only three *Dendroctonus* genomes contribute to the comparison, leaving open the possibility that annotation-pipeline differences drive part of the signal ([Genome assembly of the 2024, Finding 2](/knowledge/papers/10_1098_rsos_240755/#finding-2)).

- **Annotation bias vs. genuine TE novelty**: Whether the high unclassified repeat fraction in *Perdita meconis* reflects genuinely novel TE families or gaps in available libraries remains unresolved. Broader library construction for bees is needed before family-level abundances can be compared meaningfully across Hymenoptera.

- **Monocentric rate elevation vs. clade confound**: The higher rate of microsatellite evolution in monocentric lineages is likely driven largely by Diptera and Hymenoptera; Coleoptera — also monocentric — shows the lowest rate of any order studied. The binary holocentric/monocentric contrast is therefore confounded with clade-specific factors.

- **Rate elevation without content difference**: The simultaneous finding of higher evolutionary rates in monocentric lineages but no significant difference in total microsatellite content requires explanation. Whether this reflects faster turnover or an artifact of ancestral-state estimation at deeper nodes remains open.

- **Independent sex chromosome origins vs. shared ancestral linkage**: The claim of fully independent origins across insect orders rests on comparisons among only four reference genomes. Denser taxon sampling could reveal shared ancestral linkage groups currently obscured by limited coverage.

- **Cross-species comparability of retrocopy counts**: The large disparity in retrocopy tallies between humans (4,426) and *Drosophila* (82) primarily reflects differences in curation depth in RetrogeneDB rather than true biological differences in retroposition rate ([Lo & Blackmon 2022, Finding 1](/knowledge/papers/10_7717_peerj_12822/#finding-1)).

- **Animal–plant epistasis contrast vs. mating-system confound**: The finding that animals show greater epistatic contributions to trait divergence than plants ([Wright was right: leveraging 2024, Finding 1](/knowledge/papers/10_1093_evolut_qpae003/#finding-1)) may be confounded by the plant sample being dominated by domesticated crop crosses and selfing species, which could suppress detectable epistasis independently of any genuine kingdom-level difference.

- **Crossover-scale shifts: tree quality and sex bias**: The inference that crossover-distribution scale has shifted independently multiple times across Mammalia relies on a supertree assembled manually with polytomies at poorly resolved nodes and no branch lengths. Additionally, 83.9% of crossover data are from males only; if the arm-to-chromosome shift differs between sexes — as heterochiasmy would predict — the inferred number and placement of transitions is correspondingly uncertain ([10.1534/genetics.116.192690, Finding 1](/knowledge/papers/10_1534_genetics_116_192690/#finding-1)).

- **BWA benchmark generalizability**: The accuracy and speed figures for BWA are drawn from a single individual (NA12750) at a single read length (51 bp) on a human genome; the 2.3 GB memory figure is specific to the ~3 Gb human reference. Performance on larger, more repetitive, or polyploid genomes — precisely the genomes of greatest interest for insect comparative work — may differ materially ([Fast and accurate short read alignment with Burrows-Wheeler transform., Finding 2](/knowledge/papers/10_1093_bioinformatics_btp324/#finding-2); [Fast and accurate short read alignment with Burrows-Wheeler transform., Finding 1](/knowledge/papers/10_1093_bioinformatics_btp324/#finding-1)).

### [Microsatellite Evolution](/knowledge/topics/microsatellite_evolution/)

The monocentric/holocentric rate contrast is complicated by strong order-level heterogeneity. The authors of the 2020 microsats study note that Diptera and Hymenoptera likely contribute disproportionately to the elevated monocentric rate signal, while Coleoptera — also monocentric — has the lowest evolutionary rate of any order in the dataset. The authors explicitly invoke a BiSSE false-positive analogy: when a small portion of a phylogeny carries an extreme signal, any binary trait mapped onto that region can appear spuriously correlated with the rate difference. This means the association between monocentricity and elevated microsatellite evolution rates may reflect clade-specific factors (e.g., life history, effective population size, or recombination landscape in Diptera/Hymenoptera) rather than centromere architecture per se. [Jonika et al. 2020, Finding 3](/knowledge/papers/10_3390_genes11080945/#finding-3)

### [Transposable Elements](/knowledge/topics/transposable_elements/)

The dominant open question is not a contradiction between papers but an annotation gap: because nearly two-thirds of repeat content in *P. meconis* is unclassified, comparisons of specific TE family abundances across bee lineages are unreliable until more comprehensive, taxon-specific repeat libraries are developed. Estimates of retroelement vs. DNA transposon activity should therefore be treated as lower bounds rather than definitive figures.

## Insects & Coleoptera

### [Bee Genomics](/knowledge/topics/bee_genomics/)

The assembly lacks HiC scaffolding, meaning it does not reach chromosome-level contiguity. Dot-plot comparisons against *Andrena* and *Apis* genomes have revealed potential misassemblies, so downstream analyses relying on synteny or large-scale structural features should be treated with caution until a chromosome-anchored version is available. There is no direct contradiction with other published findings at this time, but the gap between contig-level and chromosome-level assemblies remains an important limitation to surface.

### [Bee Phylogenomics](/knowledge/topics/bee_phylogenomics/)

The robustness of the inferred Andrenidae topology warrants caution. Taxon sampling in the 119-genome dataset is heavily biased toward social bees in Apidae and Halictidae; only a single Andrenidae genus (*Andrena*) is represented alongside *Perdita*, and the family Stenotritidae is entirely absent. The sister-group relationship between *Perdita* and *Andrena* — and Andrenidae internal relationships more broadly — therefore remains incompletely tested. Expanded taxon sampling across Andrenidae and inclusion of Stenotritidae will be necessary to assess whether current placements are robust to denser sampling.

### [Coleoptera](/knowledge/topics/coleoptera/)

None known from the current set of findings. However, the 49% co-occurrence figure for X-autosome fusions should be interpreted cautiously: stochastic character mapping errors for both sex chromosome state and autosome number can compound, and the mechanistic basis for the remaining ~51% of Y chromosome gains is unresolved.

### [Coleoptera Karyotype](/knowledge/topics/coleoptera_karyotype/)

The verbatim source quote documenting the upper bound (2n = 70 for *Dixus capito obscuroides*) is split across two pages of the original paper, meaning the number itself does not appear in the extracted quote and cannot be independently verified from the quote alone. Readers should consult the primary source directly to confirm this value. No contradicting papers are currently indexed on this topic.

### [Coleoptera genomics](/knowledge/topics/coleoptera_genomics/)

**Assembly completeness.** Both *C. gloriosa* (642 MB vs. ~850 MB flow-cytometry estimate) and SPB (173.7 Mbp vs. 194.7 Mbp flow-cytometry estimate) assemblies are smaller than their cytometric genome sizes, likely reflecting unassembled repetitive content ([A reference quality genome 2024, Finding 1](/knowledge/papers/10_1093_g3journal_jkae084/#finding-1); [Genome assembly of the 2024, Finding 1](/knowledge/papers/10_1098_rsos_240755/#finding-1)). The *C. gloriosa* assembly also derives from a single female, leaving sex-specific sequences uncharacterized.

**Gene-count deficit and annotation methodology.** The Dendroctonus gene-count deficit relies on heuristic domain-keyword TE filtering rather than manual curation, so part of the apparent ~3,600-gene gap could reflect pipeline differences rather than genuine biology ([Genome assembly of the 2024, Finding 2](/knowledge/papers/10_1098_rsos_240755/#finding-2)).

**Sex-chromosome identification by read depth alone.** Y-linkage in *C. formosanus* was inferred from read-depth in a single male–female pair without PCR or population-level confirmation ([Chien et al. 2026](/knowledge/papers/10_1002_ece3_73483/#finding-1)), and the KDM5-like gene was assigned by domain architecture rather than orthology ([Chien et al. 2026](/knowledge/papers/10_1002_ece3_73483/#finding-2)). Similarly, SPB X-chromosome assignment rests solely on reduced male read coverage without cytogenetic confirmation ([Genome assembly of the 2024, Finding 3](/knowledge/papers/10_1098_rsos_240755/#finding-3)).

**Ne categorization and clade-size limitations.** The drift-driven rate differences rely on categorical Ne proxies rather than direct estimates, and some clades contain as few as 15–16 species, potentially inflating variance ([Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae001/#finding-1)). The elevated fission rate in wingless Carabidae is also model-dependent ([Drift drives the evolution 2024, Finding 3](/knowledge/papers/10_1093_jhered_esae001/#finding-3)).

**Achiasmy rate assumption.** The simulation test for suppressed Y loss assumes a single background Y-loss rate across all Adephaga; if loss rates vary independently of meiotic mechanism, expected counts are biased ([Blackmon & Demuth 2015, Finding 2](/knowledge/papers/10_1002_bies_201500040/#finding-2)).

### [Insect Genomics](/knowledge/topics/insect_genomics/)

The main internal tension in the microsatellite evidence is between the **phylogenetic rate signal** (monocentric > holocentric) and the **within-monocentric variation** (Coleoptera is the slowest order despite being monocentric). The authors of the 2020 microsats study explicitly flag this as a potential confound analogous to BiSSE false positives. The existing evidence does not establish monocentricity as a *causal* driver of elevated microsatellite evolution — it remains a correlated trait that tracks with high-rate lineages in the current dataset.

On the genome size measurement side, the 10% inflation figure for *Aedes* is presented as an illustrative example in a protocols chapter without replicate data or variance estimates. The claim that optimal saturation time varies between strains of the same species is supported by *Drosophila melanogaster* DSPR strain data relative to *D. virilis* as a standard — a between-species comparison rather than a pure within-species genome size difference. These two phenomena (strain-level genome size variation and time-point inflation) are distinct but conflated in some readings of the source material.

### [Tribolium](/knowledge/topics/Tribolium/)

The interpretation of the selection plateau between generations 3 and 5 is uncertain. Generation 4 data were compromised by a procedural error (delayed phenotyping), so the apparent leveling off rests on only two clean data points bookending an uninterpretable generation. It is not possible to determine from the existing data whether the plateau reflects a genuine limit on response or a transient stochastic effect.

Additionally, the epistasis inference from line cross analysis depends on a simulation model parameterized with specific assumptions (20 unlinked biallelic loci, all dispersal alleles dominant, a particular starting allele-frequency architecture). Different numbers of loci, alternative dominance relationships, or linked architectures could in principle generate larger dispersion artifacts, meaning the upper bound on spurious epistasis may be underestimated.

## Karyotype evolution

### [Centromere Evolution](/knowledge/topics/centromere_evolution/)

The two-rate result deserves cautious interpretation. The authors of the 2020 microsats paper note that the signal is likely driven disproportionately by a small number of monocentric orders — particularly Diptera and Hymenoptera — while Coleoptera, also monocentric, shows the *lowest* microsatellite evolution rate of any order examined. This means the monocentric/holocentric binary is confounded with clade-specific factors (e.g., effective population size, generation time, transposable element activity). The authors explicitly liken this risk to the inflated false-positive problem documented under BiSSE-class trait-dependent diversification models. Until broader taxonomic sampling disentangles clade identity from centromere type, the two-rate interpretation should be treated as a hypothesis rather than a settled conclusion.

### [Centromere Type](/knowledge/topics/centromere_type/)

A significant caveat to the monocentric-higher-rate finding is that the signal may not be uniformly distributed across monocentric orders. Diptera and Hymenoptera appear to drive much of the elevated rate in monocentric lineages, while Coleoptera — also monocentric — exhibits the *lowest* microsatellite evolution rate of any insect order examined. The authors themselves flag this as analogous to BiSSE false-positive inflation: a concentrated signal in one region of the phylogeny can make any binary trait mapped there appear causally associated with the rate difference. Whether monocentricity *per se* or order-level life-history and genomic features are responsible remains an open question that broader taxon sampling and more granular mechanistic models will need to resolve. [Jonika et al. 2020, Finding 3](/knowledge/papers/10_3390_genes11080945/#finding-3)

### [Chromosome Fusion](/knowledge/topics/chromosome_fusion/)

None known from the currently indexed findings. The main outstanding uncertainty is whether the SA-fusion bias in *Habronattus* generalizes to other spider genera or to arthropods more broadly; the current test covers only 10 fusion events in a single genus, and broader taxonomic sampling is needed before the pattern can be declared general. Additionally, phylogenetic uncertainty in the ancestral karyotype reconstruction could, in principle, alter the exact p-value, though the result is far below conventional significance thresholds.

### [Chromosome number evolution](/knowledge/topics/chromosome_number_evolution/)

**Scaled-variance vs. model-based rate estimates.** The most direct methodological tension in this literature is the finding that scaled-variance and phylogenetic model-based estimates of chromosome evolution rate are uncorrelated across nine beetle clades [Drift drives the evolution 2024, Finding 2](/knowledge/papers/10_1093_jhered_esae001/#finding-2). Because scaled-variance estimates appear throughout the older comparative karyology literature, this discordance means that historical rate comparisons may not be reliable guides to model-based rate variation. The caveat is that the comparison covers only nine clades with usable fossil data, and poor insect fossil records may unfairly handicap the scaled-variance approach.

**Y-A fusion rate asymmetry — detection bias.** The excess of Y-autosome fusions over X-autosome fusions in fishes and squamates [Y fuse? Sex chromosome fusions in fishes and reptiles., Finding 1](/knowledge/papers/10_1371_journal_pgen_1005237/#finding-1) depends on karyotypically detectable multiple sex chromosome systems. X-A fusions that generate neo-Y chromosomes could be lost without detection in the hemizygous sex, potentially inflating the apparent Y-A excess by making X-A fusions appear more ephemeral than Y-A fusions rather than genuinely less common at origin.

**Holocentric chromosomes and fission rates — suggestive but unsupported.** The 2020 holocentric study reports that 83% of the posterior for the fission rate difference lies above zero [Ruckman et al. 2020, Finding 1](/knowledge/papers/10_1371_journal_pgen_1009076/#finding-1), but the 95% credible interval still overlaps zero and the result is conditional on excluding polyploidy from the model. This leaves open whether holocentricity genuinely elevates fission rates or whether the signal reflects model mis-specification or limited taxon sampling.

**False positive risk in chromePlus trait-dependent models.** The Carnivora drift analysis finds elevated fusion and fission rates in small-range lineages [Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae025/#finding-1), but neutral simulations on the same phylogeny yield false positive rates of 22–33% [Drift drives the evolution 2024, Finding 2](/knowledge/papers/10_1093_jhered_esae025/#finding-2). Although only 7% of neutral runs matched the empirical effect magnitude, users of chromePlus-style models — including the mammalian meiotic drive analyses [Blackmon et al. 2019, Finding 2](/knowledge/papers/10_1111_evo_13682/#finding-2) — should interpret point estimates cautiously when effect sizes are modest. Range size is also a coarse, discretized proxy for effective population size.

**BiSSE reliability for the mammalian null result.** The finding that karyotype morphology has no detectable effect on mammalian diversification rates [Blackmon et al. 2019, Finding 1](/knowledge/papers/10_1111_evo_13682/#finding-1) rests on BiSSE, a method known to produce elevated false-positive — and potentially false-negative — rates when diversification is heterogeneous across the tree. The null result may reflect limited statistical power rather than a true absence of karyotype-driven diversification.

**Crossover-scale transitions — supertree and sex-bias limitations.** The inferred multiple independent shifts in crossover scale across mammals [10.1534/genetics.116.192690, Finding 1](/knowledge/papers/10_1534_genetics_116_192690/#finding-1) rely on an informal supertree with polytomies, absent branch lengths, and data drawn overwhelmingly from males (~83.9% of observations). The number and placement of inferred transitions could shift substantially once well-resolved, branch-length-calibrated phylogenies and female recombination data are incorporated.

**Mite-specificity of the haplodiploidy–karyotype link.** The 2015 Acari study is restricted to mites. Other invertebrate clades with low chromosome numbers have not evolved haplodiploidy, limiting the generality of the chromosome-reduction-first story.

**Phasmatodea sampling for asexual polyploidy.** The elevated polyploidy rate in asexual lineages [Sylvester et al. 2020, Finding 1](/knowledge/papers/10_1098_rspb_2020_1388/#finding-1) is based on only 13 parthenogenetic species within a single order, with additional uncertainty from ancestral reconstructions of reproductive mode.

**Upper bound for Coleoptera.** The value of 2n = 70 for *Dixus capito obscuroides* is drawn from a large database; independent verification against primary sources is advisable [Blackmon & Demuth 2015, Finding 1](/knowledge/papers/10_1649_0010_065x_69_1_174/#finding-1).

**Meiotic drive switching rates in Primates.** The reported ~90.9 million year figure is a median waiting time, and the inferred rates rely on trees representing only 12–30% of extant species per clade [Blackmon et al. 2019, Finding 2](/knowledge/papers/10_1111_evo_13682/#finding-2).

**Chromosome number and microsatellite content — assembly-coverage caveat.** The null result [Jonika et al. 2020, Finding 1](/knowledge/papers/10_3390_genes11080945/#finding-1) relies on assemblies that typically underrepresent centromeric and telomeric heterochromatin, so a real association concentrated near chromosome structural features could be masked.

### [Chromosome number optima](/knowledge/topics/chromosome_number_optima/)

No direct contradictions exist among the currently folded-in findings. However, there is internal tension between the interpretation that modal autosome counts reflect adaptive optima and the observation that sampling bias (r = 0.41 between family record count and variance) could generate apparent modes artifactually. Future phylogenetically informed analyses will need to adjudicate between these explanations.

### [Holocentric Chromosomes](/knowledge/topics/holocentric_chromosomes/)

The association between monocentricity and elevated microsatellite evolution rates is not straightforward within monocentric orders. Coleoptera, which are monocentric, display the *lowest* microsatellite evolution rate of any insect order examined — lower even than holocentric lineages in some comparisons. The authors of the 2020 microsats study explicitly flag this as a potential BiSSE-like false-positive problem: if Diptera and Hymenoptera (both monocentric, both with high rates) are driving the signal, then the binary centromere-type variable may be a proxy for some other order-level feature rather than a direct causal factor. [Jonika et al. 2020, Finding 1](/knowledge/papers/10_3390_genes11080945/#finding-1)

Until additional taxa — especially monocentric lineages outside Diptera and Hymenoptera — are sampled at comparable depth, it remains unclear whether holocentric architecture itself suppresses microsatellite turnover or whether the pattern reflects deeper phylogenetic structure.

### [Karyotype Evolution](/knowledge/topics/karyotype_evolution/)

**Adephaga X-fusion signal versus vertebrate Y-fusion excess.** Theoretical expectation and fish/reptile data agree that Y-autosome fusions should predominate, yet the Adephaga data point toward X-autosome fusion predominance. Whether the discrepancy reflects genuinely different meiotic biology, effective population sizes, or sex-ratio conditions in beetles versus vertebrates — or whether the Adephaga estimate is confounded by detection asymmetries (X-autosome fusions generate detectable neo-Y chromosomes; their subsequent loss could be over-counted) — remains unresolved. See [Blackmon & Demuth 2014, Finding 1](/knowledge/papers/10_1534_genetics_114_164269/#finding-1) versus [Y fuse? Sex chromosome fusions in fishes and reptiles., Finding 2](/knowledge/papers/10_1371_journal_pgen_1005237/#finding-2).

**Phylogenetic non-independence in fusion frequency comparisons.** The striking XY vs. ZW fusion differences in fishes and reptiles (41% vs. 5%; 33% vs. 3%) are reported with Fisher's exact tests that ignore shared evolutionary history. The phylogenetic MCMC analyses show ~98–99% posterior support, somewhat softer than the uncorrected p-values, and a full phylogenetic comparative model could shift the picture further.

**Male-biased mutation evidence is largely mammalian.** The proposed mechanism — male-biased mutation generating more fusions on the Y — draws heavily on human translocation data. Direct evidence for this bias in fishes and squamate reptiles is limited. See [Y fuse? Sex chromosome fusions in fishes and reptiles., Finding 3](/knowledge/papers/10_1371_journal_pgen_1005237/#finding-3).

**BiSSE statistical power concerns.** The null result for karyotype-driven diversification in mammals is based on BiSSE, which is known to produce elevated false-positive rates under diversification-rate heterogeneity. The authors demonstrate inflated false-positive rates for the cetacean subtree in their own simulations, so the null result may partly reflect statistical limitations rather than a true absence of effect.

**Unresolved Y-gain mechanisms in Adephaga.** The 49% X-autosome fusion co-occurrence estimate relies on simultaneous stochastic character mapping; the remaining ~51% of Y chromosome gains in Adephaga are mechanistically unaccounted for.

**Genomic vs. cytogenetic karyotype confirmation.** The 2n=20 inference for *C. formosanus* rests on scaffold counts and Hi-C contact patterns rather than direct cytogenetic preparation from this species — plausible given strong coleopteran conservation, but classically unconfirmed.

**Crossover-scale inference limited by data quality.** The multiple independent shifts in crossover scale across mammals were inferred from an informal supertree with polytomies, no branch lengths, and crossover data drawn 83.9% from males. The precision of ancestral-state reconstructions under those conditions is limited, and a formal time-calibrated phylogenetic analysis could alter both the number and placement of inferred transitions. See [10.1534/genetics.116.192690, Finding 1](/knowledge/papers/10_1534_genetics_116_192690/#finding-1).

### [Karyotype database](/knowledge/topics/karyotype_database/)

The cross-eukaryote 67%/28% split ([Why not Y naught 2022, Finding 1](/knowledge/papers/10_1038_s41437_022_00543_z/#finding-1)) and the 77% insect male-heterogamety figure ([Blackmon & Demuth 2015, Finding 1](/knowledge/papers/10_1016_j_cois_2014_12_003/#finding-1)) are broadly consistent, but both rest on taxonomically uneven sampling frames. The 2022 synthesis explicitly acknowledges that female heterogamety is "undoubtedly an under-estimate," meaning ZW prevalence could be substantially higher than current records suggest.

The Coleoptera statistics ([Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae001/#finding-1)) face an analogous sampling problem: family-level variance in chromosome number correlates with record count (r = 0.41), indicating that rare or understudied families are not adequately represented, so the reported means and modes may reflect karyotyping effort as much as biological reality.

The Amphibian Karyotype Database's 2,124 records are heavily skewed toward frogs, with caecilians particularly undersampled (45 records). Any macroevolutionary inference built on these databases must account for ascertainment bias — both taxonomic and methodological.

### [Karyotype evolution overview](/knowledge/topics/karyotype_evolution_overview/)

The ancestral-state reconstruction establishing male heterogamety at the insect root cannot resolve XY vs. XO ancestry (60% vs. 40%), limiting inferences about Y-chromosome polarity deep in insect phylogeny [Blackmon et al. 2017, Finding 1](/knowledge/papers/10_1093_jhered_esw047/#finding-1).

The theoretical necessary condition for fusion fixation [[10.1017/s0016672300014051, Finding 1](/knowledge/papers/10_1017_s0016672300014051/#finding-1)] assumes the fusion itself carries no intrinsic fitness cost. The authors acknowledge that centric fusions must lose some chromosomal material, making this assumption unlikely to hold generally — any appreciable intrinsic cost raises the threshold for sex-differential allele frequencies required for a net selective advantage, potentially restricting the conditions under which the fusion-fixation model applies to real populations.

The fusion-driven XO→XY result in Polyneoptera [Sylvester et al. 2020, Finding 1](/knowledge/papers/10_1098_rspb_2020_1388/#finding-1) sits in genuine tension with the Drosophila result, where sex-chromosome–autosome fusions are far rarer than expected [The probability of fusions 2020, Finding 1](/knowledge/papers/10_1098_rsbl_2020_0648/#finding-1). The sexual-antagonism model [Worse than nothing at 2024, Finding 1](/knowledge/papers/10_7717_peerj_17740/#finding-1) predicts non-PAR fusions should be favored when sexually antagonistic alleles are present, yet it cannot explain the Drosophila deficit on its own — indicating that clade-specific factors actively suppress fusions in some lineages.

The holocentric fission-rate elevation [Ruckman et al. 2020, Finding 1](/knowledge/papers/10_1371_journal_pgen_1009076/#finding-1) is a suggestive trend (83% posterior mass above zero) rather than a statistically supported result, and depends on excluding polyploidy from the model. The theoretical fusion-asymmetry model [Worse than nothing at 2024, Finding 2](/knowledge/papers/10_7717_peerj_17740/#finding-2) assumes obligate PAR recombination every male meiosis, an assumption violated in achiasmatic lineages [Blackmon & Demuth 2015, Finding 1](/knowledge/papers/10_1002_bies_201500040/#finding-1), so its quantitative predictions may not apply to some of the most species-rich insect clades.

The bark beetle SPB result [Genome assembly of the 2024, Finding 1](/knowledge/papers/10_1098_rsos_240755/#finding-1) identifies the X chromosome purely by reduced male read coverage without cytogenetic confirmation, and Stevens element conservation is assessed across only three taxa. Broader sampling across Curculionidae is needed to evaluate generality.

The Ne-driven rate patterns rest on indirect proxies. In Coleoptera, Ne is indexed by categorical proxy traits rather than direct estimates [Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae001/#finding-1). In Carnivora, range size was discretized at the median, and simulations found false positive rates of 22–33% for neutral traits [Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae025/#finding-1). The fission-rate elevation in wingless Carabidae was detected only in the simpler model [Drift drives the evolution 2024, Finding 3](/knowledge/papers/10_1093_jhered_esae001/#finding-3), making that result model-dependent.

Additional sample-size caveats: the uncorrelation between phylogenetic and scaled-variance rate estimates rests on only nine overlapping clades [Drift drives the evolution 2024, Finding 2](/knowledge/papers/10_1093_jhered_esae001/#finding-2); the elevated polyploidy rate in asexual Phasmatodea rests on only 13 parthenogenetic species [Sylvester et al. 2020, Finding 2](/knowledge/papers/10_1098_rspb_2020_1388/#finding-2); the haplodiploidy pattern in mites has not been confirmed across other invertebrate clades [Blackmon et al. 2015, Finding 2](/knowledge/papers/10_1111_evo_12792/#finding-2); and the Amphibian Karyotype Database is heavily biased toward Anura (86% of records) [Perkins et al. 2019, Finding 1](/knowledge/papers/10_1007_s10577_019_09613_1/#finding-1).

## Population genetics

### [Coalescent Simulation](/knowledge/topics/coalescent_simulation/)

The 700% overestimation result is specific to SNAPP and a particular simulation architecture (linear stepping stone, 10 demes, m = 0.001, TD/ND = 1). It is not yet clear whether other coalescent frameworks — such as *BEAST, SVDquartets, or MSC-based approaches in IQ-TREE — exhibit the same magnitude of bias under analogous conditions. Broader benchmarking across methods and migration geometries is needed before this finding can be treated as a general property of coalescent simulation.

### [Conservation Genetics](/knowledge/topics/conservation_genetics/)

The inflation documented above is a consequence of applying a **panmictic estimator** to data generated under a structured model. Structured coalescent frameworks, isolation-with-migration (IM) models, or spatially explicit demographic models that explicitly account for population connectivity would not suffer from the same bias. The concern is therefore specific to common-practice shortcuts rather than a universal failure of Ne estimation. Additionally, the magnitude of inflation is sensitive to the TD/ND ratio and the migration rate assumed; other parameter combinations may produce more modest or more extreme distortions, and empirical validation across diverse taxa is still needed.

### [Conservation Genomics](/knowledge/topics/conservation_genomics/)

The *Perdita meconis* assembly remains at contig rather than true chromosome-scale because Hi-C-compatible tissue could not be obtained from the same specimen, and dot-plot comparisons against *Andrena* and *Apis* reveal structural rearrangements that may reflect real biology or assembly artifacts.

For *C. formosanus*, a meaningful caveat exists: the ROH inference rests on reduced-representation ddRAD data (n = 46 individuals) rather than whole-genome resequencing. The absence of segments >5 Mbp could partly reflect data sparsity rather than true demography.

The *Chrysina gloriosa* assembly spans only ~75% of the flow-cytometry-estimated genome size (850 MB), with the paper acknowledging that the shortfall likely reflects unassembled repetitive content. The assembly is also derived from a single female specimen, so structural variation across individuals and populations remains uncaptured. These three cases together highlight a recurring tension in conservation genomics: the taxa most urgently in need of genomic tools are often those for which data collection remains most constrained.

### [Demographic Inference](/knowledge/topics/demographic_inference/)

**Platform concordance sample size:** The PSMC comparison rests on n=2 genomes (one individual per sex, one per platform) from a single endemic population. This is a weak test; broader sampling across populations or species is needed before platform-agnosticism can be treated as a general rule.

**ROH inference data quality:** The ROH analysis used reduced-representation ddRAD data (n=46 individuals) rather than whole-genome resequencing. The paper acknowledges that ddRAD likely lacks sufficient coverage to fully exploit linkage information, meaning the absence of segments >5 Mbp could partly reflect data sparsity rather than true demographic history. Whole-genome resequencing of the same individuals would be needed to confirm this signal.

### [Divergence Time Estimation](/knowledge/topics/divergence_time_estimation/)

The 700% overestimation figure and the T_D/N_D < 10 threshold both arise from a single simulation design (10 demes, linear stepping stone, three discrete migration rates, SNAPP as the inference engine). Whether these quantitative benchmarks hold for systems with continuous geography, different deme numbers, non-linear spatial arrangements, or other coalescent methods (e.g., *BEAST, BPP) remains untested. It is therefore possible that the critical ratio differs substantially in empirical systems, and that the bias is partially method-specific rather than a universal property of ancestral-structure scenarios.

### [Effective Population Size](/knowledge/topics/effective_population_size/)

The primary tension is methodological rather than empirical: the Ne inflation documented above is an artifact of applying a *panmictic* estimator to data generated under a *structured* model. Coalescent frameworks that explicitly incorporate population structure (e.g., the structured coalescent or isolation-with-migration models) would in principle recover unbiased local Ne values. Whether practitioners routinely apply such corrections — and whether the necessary demographic information is available to do so — remains an open question in applied conservation genetics. The magnitude of overestimation also varies with parameter choices (TD/ND ratio, m), so generalizing the exact 7-fold figure to real systems requires caution.

### [Isolation By Distance](/knowledge/topics/isolation_by_distance/)

The quantitative findings above all come from a single simulation framework: a 10-deme linear stepping-stone model with three discrete migration rates. It is not yet established whether the same thresholds and magnitudes apply to (a) non-linear or two-dimensional habitat geometries, (b) continuous rather than discrete population models, or (c) coalescent methods other than SNAPP. Methods that explicitly incorporate population structure (e.g., structured coalescent models) are expected to avoid the Ne inflation identified in Finding 3, but direct comparisons under IBD conditions have not been reported in this literature. These gaps represent open empirical questions rather than direct contradictions between published studies.

### [Population Genetics](/knowledge/topics/population_genetics/)

None known from current findings. The count of 83 overlapping genes is a snapshot tied to the studies included at the time of publication; as more data are deposited and integrated, this figure will change, but no contradicting claim about the degree of overlap has been identified in the supplied findings.

### [Sequencing Methods](/knowledge/topics/sequencing_methods/)

While the Mojave poppy bee case demonstrates feasibility, it represents a single anecdotal success. The same study was unable to obtain HiC-compatible tissue from the preserved specimen, indicating that suboptimal preservation does impose real limits — scaffolding to chromosome-scale likely required alternative approaches. Broader generalizability remains uncertain: outcomes may depend strongly on species biology, body size, lipid content, storage duration, and exact temperature history. No systematic comparison of preservation methods across a range of taxa has been introduced into this topic yet.

## Quantitative genetics & epistasis

### [Ancestral State Reconstruction](/knowledge/topics/ancestral_state_reconstruction/)

The two models applied to Acari haplodiploidy yield divergent origin counts (7.9 vs. 12.9), reflecting a genuine tension between parsimony-style irreversible models and more parameter-rich reversible ones. The apparent support for reversibility collapses when a single influential tip is removed, raising the question of whether the two-rate model is capturing biology or overfitting sparse data. Broader taxon sampling and independent data on ploidy in contentious families would help resolve this ambiguity.

### [Artificial Selection](/knowledge/topics/artificial_selection/)

The plateau observed between generations 3 and 5 in the *T. castaneum* experiment should be interpreted cautiously. Only three replicates per selection direction were run from a single source population, and generation 4 data are absent due to a confounding procedural error (delayed phenotyping). The apparent slowing of response therefore rests on just two usable data points (generations 3 and 5) with an uninterpretable gap. Whether this represents a true selection limit or simply sampling noise cannot be resolved without additional replicates and generations.

No contradictory findings from other papers are currently indexed on this topic.

### [Comparative Methods](/knowledge/topics/comparative_methods/)

The finding raises a tension between the headline false-positive rates and the more reassuring effect-size distribution. A reader emphasizing the raw rates (22–33%) would conclude that chromePlus inferences are poorly calibrated and routinely misleading. A reader emphasizing the ΔR distribution would argue that the method performs acceptably when users condition on large effect sizes, not merely on nominal significance. These two positions are not fully reconciled in the literature surveyed here, and it remains unclear how broadly the Carnivora-specific calibration applies to other phylogenies with different size, balance, or branch-length distributions.

### [Dispersal](/knowledge/topics/dispersal/)

None known from the current evidence base. However, the findings rest on a single species and study system. A key internal caveat is that generation 4 data in the selection experiment were compromised by a procedural error (delayed phenotyping), so the apparent plateau between generations 3 and 5 rests on limited data points. Additionally, the simulation control for spurious epistasis assumed 20 unlinked biallelic loci with dominant dispersal alleles; different genomic architectures could in principle produce larger artifacts than those simulated, leaving some residual uncertainty about the robustness of the epistasis inference.

### [Epistasis](/knowledge/topics/epistasis/)

**Detection philosophy.** The J-S test and SAGA operate under fundamentally different inferential philosophies. The 11 "missed" epistatic effects from the 2016 SAGA re-analysis were identified using a vi > 0.5 threshold chosen by the authors, not tied to a controlled false-discovery rate. A researcher committed to significance-based inference could argue that J-S is not missing real epistasis but is correctly withholding support for marginal effects. The 19% dataset failure rate under SAGA likewise conflates "not supported under this framework" with "false positive," which may overstate the implication for legacy work.

**Simulation scope.** The simulation-based dismissal of allelic dispersion uses 20 unlinked biallelic loci with all dispersal alleles dominant, matched to specific empirical lines. Different numbers of loci, linkage structures, dominance relationships, or starting allele frequencies could produce higher false-positive epistatic magnitudes.

**Taxonomic confounds in the plant–animal comparison.** The finding that animals show greater epistatic contributions than plants is plausible but potentially confounded: the plant sample is dominated by domesticated crop crosses and selfing species, which may have reduced standing genetic variation and thus lower detectable epistasis, confounding the clade comparison with mating system and domestication history. [Wright was right: leveraging 2024, Finding 2](/knowledge/papers/10_1093_evolut_qpae003/#finding-2)

**Trait-category subjectivity.** The life-history vs. morphological contrast (mean difference 0.06) is small in absolute terms, and the assignment of traits to categories involves subjective judgment. LCA is known to be conservative in detecting epistasis under sparse data, so the true contrast could be under- or overestimated. [Wright was right: leveraging 2024, Finding 1](/knowledge/papers/10_1093_evolut_qpae003/#finding-1)

**Hybridization artifacts in plant LCA.** The Solanum finding rests on only five cohorts from two parental strains. LCA can infer epistasis arising from novel multi-locus genotypes created by crossing that would never co-occur during natural divergence, meaning signals may partly reflect properties of hybrid genotype space.

### [Line Cross Analysis](/knowledge/topics/line_cross_analysis/)

The claim that the J-S test systematically underestimates epistasis rests on a convenience sample of 22 datasets drawn heavily from prior work on *Tribolium castaneum* and *Silene*, so the apparent detection gap may reflect the cross designs and organisms studied rather than a general bias. The vi > 0.5 cutoff is an author-chosen heuristic without formal type-I error control, making it difficult to directly compare the "newly detected" epistatic effects against significance-based methods.

Relatedly, the 19% of datasets in the large-scale 2024 survey that failed SAGA thresholds ([Wright was right: leveraging 2024, Finding 3](/knowledge/papers/10_1093_evolut_qpae003/#finding-3)) may reflect insufficient statistical power or cohort diversity in those studies rather than genuine false positives in prior analyses. The finding conflates "not supported under this framework" with "false positive," and different evidence thresholds would shift the failure rate in either direction.

The simulation controlling for allelic dispersion uses only 20 unlinked biallelic loci with all dispersal alleles dominant. Different numbers of loci, linkage structures, dominance relationships, or starting allele frequencies could yield higher false-positive epistatic ratios, so the simulation may not fully bracket the space of possible dispersion artifacts.

The five-cohort design demonstrated in the 2024 *Solanum* work ([Assessing the opportunity for 2024, Finding 3](/knowledge/papers/10_7717_peerj_17985/#finding-3)) cannot estimate higher-order epistatic interactions, and its cytotype and maternal-effect terms are specific to interspecific crosses with cytonuclear complexity, limiting generalization to simpler intraspecific designs.

### [Quantitative Genetics](/knowledge/topics/quantitative_genetics/)

None known from the current evidence base. However, the simulation control for dispersion artifacts (Finding 2) rests on specific assumptions — 20 unlinked biallelic loci, all dispersal alleles dominant, allele frequencies matched to this particular experiment. Different locus numbers, linkage structures, or dominance architectures could in principle produce higher false-positive epistatic signals and have not been fully explored.

### [Quantitative Genetics Methods](/knowledge/topics/quantitative_genetics_methods/)

The characterization of the 19% failure rate as evidence of "false positives" in older analyses is contested on methodological grounds. The SAGA thresholds (variable-importance ≥ 0.5; 95% CI excluding zero) are themselves chosen cutoffs, and a different choice of criteria would produce a different failure rate. It is also possible that many of these datasets simply lack statistical power or cross diversity rather than that prior inferences were incorrect. The finding documents a lack of robustness under a new framework, but does not directly demonstrate that traditional inferences were wrong — a distinction worth keeping in mind when revisiting legacy results.

### [Selection and drift](/knowledge/topics/selection_and_drift/)

Several methodological and conceptual tensions limit strong causal inference.

In the beetle and carnivore work, Ne is estimated indirectly from proxy traits (winglessness, body size, range size) rather than directly from population genomics, introducing measurement error and potentially conflating correlated ecological variables. The elevated fission rate in wingless Carabidae is also model-dependent, disappearing in a more complex model that incorporates whole-genome duplication ([Drift drives the evolution 2024, Finding 2](/knowledge/papers/10_1093_jhered_esae001/#finding-2)). In Carnivora, neutral trait simulations produced false positive rates of 22–33%, meaning the observed ΔR values must substantially exceed chance before the drift interpretation is secure ([Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae025/#finding-1)).

The Pennell et al. 2015 argument for slightly deleterious Y-autosome fusions depends partly on male-biased mutation rates in fishes and squamate reptiles, but the empirical support for that bias in those lineages is limited — the analysis draws heavily on human translocation data, which may not generalize ([Y fuse? Sex chromosome fusions in fishes and reptiles., Finding 1](/knowledge/papers/10_1371_journal_pgen_1005237/#finding-1)). This leaves open whether the Y-fusion excess is driven by mutation bias, reduced Ne alone, or some interaction of both.

The Charlesworth & Charlesworth (1980) model identifies a precise selection condition for sex-chromosome–autosome fusions, but the authors note that centric fusions likely involve some loss of chromosomal material — making the no-fitness-cost assumption "unlikely to be generally true" — which could eliminate any selective advantage in practice ([10.1017/s0016672300014051, Finding 1](/knowledge/papers/10_1017_s0016672300014051/#finding-1)). If intrinsic fitness costs are common, the boundary between "neutral drift" and "selected fusion" becomes harder to locate empirically, and it becomes even more plausible that slightly deleterious fusions fix via drift rather than selection.

The *A. aegypti* direct-repeat depletion finding demonstrates that selection can powerfully shape the repeat landscape near genes, but the analysis is limited to a single species and uses a Monte Carlo null that does not fully control for GC content, chromatin accessibility, or recombination landscape ([DirectRepeateR: An R package 2025, Finding 1](/knowledge/papers/10_12688_f1000research_170810_1/#finding-1)). Whether this depletion generalizes to the same lineages where drift signatures are strongest remains untested.

Across all systems, a deeper ambiguity persists: observed patterns are consistent with drift on neutral rearrangements, selection on weakly deleterious ones, or a mixture. Distinguishing these scenarios requires direct Ne estimates and population-genetic modeling of fixation probabilities.

### [Trait Definition](/knowledge/topics/trait_definition/)

The current evidence base consists of a single compound trait comparison from one interspecific cross in *Solanum*. It is not yet known whether the pattern — ratios tending toward additivity relative to their components — is general or idiosyncratic to this system. A systematic study across multiple trait types, taxa, and cross designs is needed before strong generalizations can be made. It is also possible that in other cases a ratio trait could *amplify* non-additive signals rather than suppress them, depending on the correlational structure of the component traits.

## Sex chromosomes

### [Fragile Y hypothesis](/knowledge/topics/fragile_y_hypothesis/)

The 3.5× stability estimate from [Blackmon & Demuth 2014, Finding 1](/knowledge/papers/10_1534_genetics_114_164269/#finding-1) rests on phylogenetic inference from a sparse supermatrix and a Markov model of karyotype evolution; taxa with poorly sampled cytogenetics could bias state assignments. Similarly, the within-Adephaga test in [Blackmon & Demuth 2015, Finding 2](/knowledge/papers/10_1002_bies_201500040/#finding-2) assumes a single background rate of Y loss across the entire suborder; if loss rates vary for reasons other than meiotic mechanism, the expected counts are biased and the inference weakens.

The Turner syndrome figure used in [Blackmon & Demuth 2015, Finding 3](/knowledge/papers/10_1002_bies_201500040/#finding-3) comes from older cytogenetic surveys with ascertainment limitations; the 3% conception frequency conflates paternal meiotic non-disjunction with maternal errors and post-zygotic X-chromosome loss events, so it only indirectly measures Y mis-segregation rate specifically.

The modeling results from [Blackmon & Brandvain 2017, Finding 1](/knowledge/papers/10_1534_genetics_117_300382/#finding-1) and [Blackmon & Brandvain 2017, Finding 2](/knowledge/papers/10_1534_genetics_117_300382/#finding-2) are derived from a deterministic framework that ignores genetic drift, mutational input biases (there are 3× more X chromosomes than Y in a population), and male mutation bias — factors the authors themselves acknowledge could alter quantitative predictions. Empirical support for the Y-vs-X inversion asymmetry is drawn from only a handful of taxa (humans, rats, papaya), and the aneuploidy cost is modeled as a simple multiplicative fitness parameter rather than being mechanistically linked to PAR size.

A more fundamental challenge to the SA-driven arm of the hypothesis comes from [The probability of fusions 2020, Finding 1](/knowledge/papers/10_1098_rsbl_2020_0648/#finding-1): Drosophila show far fewer sex-chromosome–autosome fusions than expected under a null model of SA selection (observed 0.155 vs. expected 0.43, non-overlapping credible intervals). [Worse than nothing at 2024, Finding 1](/knowledge/papers/10_7717_peerj_17740/#finding-1) offers a partial reconciliation — PAR-targeted fusions are actively deleterious, so the deficit may reflect strong selection against fusions that land in the wrong region rather than weakness of SA selection per se — but this reconciliation is itself model-dependent and lacks empirical fitness measurements of PAR-fused neo-sex chromosomes.

The two SA-inversion modeling frameworks share deterministic, symmetric-fitness assumptions and do not incorporate genetic drift; quantitative thresholds may not transfer to small-*Ne* populations where drift could overwhelm selection on mildly deleterious inversions. The achiasmy model attributes the counterintuitive permissiveness of autosomes relative to X chromosomes under aneuploidy selection to male residence time, but ploidy and linkage structure also differ, and the paper does not formally isolate residence time as the sole causal mechanism.

The *C. formosanus* Y scaffold was characterized from a single male and female using read-depth alone; Y-linkage inferred without PCR validation or broader population sampling could partly reflect repeat artifacts or male-biased heterochromatin rather than a bona fide degenerate Y.

### [Haplodiploidy Evolution](/knowledge/topics/haplodiploidy_evolution/)

The number of inferred origins is sensitive to dataset construction: origin counts differed notably between 109-taxon and 87-species-level datasets, reflecting the difficulty of matching tip taxa at genus and family levels in a group as diverse as Acari. Additionally, whether reversions are possible remains unresolved — the two-rate model technically allows them, but the empirical support collapses when the single anomalous tip is reconsidered. These analytical dependencies mean the canonical estimate of 7.9–12.9 origins should be treated as a well-motivated range rather than a precise count ([Blackmon et al. 2015, Finding 3](/knowledge/papers/10_1111_evo_12792/#finding-3)).

### [Large X Effect](/knowledge/topics/large_X_effect/)

The sterility QTL mapping in Kitano et al. 2009 was conducted on a small backcross panel of weakly fertile F1 hybrid males (n = 76). The failure to detect a neo-X effect on sterility could therefore reflect limited statistical power rather than a true biological absence. Broader mapping populations, or crosses using more diverged neo-X-bearing strains, would be needed to rule out the null statistically. More broadly, whether the pattern generalizes beyond sticklebacks — whether young neo-sex chromosomes consistently lack sterility loci while carrying behavioral loci — remains untested across taxa.

### [Meiotic Drive](/knowledge/topics/meiotic_drive/)

**BiSSE reliability vs. null diversification result.** The negative finding on karyotype-driven diversification rests on BiSSE, a method known to produce elevated false-positive rates when diversification is heterogeneous across the tree. The authors themselves document inflated false-positive rates in simulations on the cetacean tree. It is therefore possible that the method lacks power to detect a real effect, or alternatively that spurious rate variation in other regions of the tree obscures a true signal. The finding should be interpreted as "no detectable effect" rather than a strong refutation of the chromosomal speciation hypothesis [Blackmon et al. 2019, Finding 1](/knowledge/papers/10_1111_evo_13682/#finding-1).

**Mean vs. median for Primate switching rate.** The ~90.9 Myr figure for Primates is reported as a *median* waiting time in the source text, not a mean, creating a minor inconsistency in how the statistic is described. Given that transition-rate distributions are typically right-skewed, the mean could differ substantially, and rates inferred from trees sampling only 12–30% of extant species per clade carry additional uncertainty [Blackmon et al. 2019, Finding 2](/knowledge/papers/10_1111_evo_13682/#finding-2).

### [Sex chromosome evolution](/knowledge/topics/sex_chromosome_evolution/)

- **SA selection vs. drift-on-Y as the mechanism for Y-autosome fusion excess.** The SA framework ([Why not Y naught 2022, Finding 2](/knowledge/papers/10_1038_s41437_022_00543_z/#finding-2); [The probability of fusions 2020, Finding 2](/knowledge/papers/10_1098_rsbl_2020_0648/#finding-2)) attributes the observed Y-bias in fusions to sexually antagonistic selection capturing male-beneficial autosomal alleles on the Y. The fish and reptile survey ([Y fuse? Sex chromosome fusions in fishes and reptiles., Finding 3](/knowledge/papers/10_1371_journal_pgen_1005237/#finding-3)) instead argues that most such fusions are slightly deleterious and fix disproportionately on the Y because of male-biased mutation and the Y's reduced effective population size — i.e., drift rather than selection. The two mechanisms predict the same directional asymmetry but make opposite predictions about fitness consequences and parameter dependencies.
- **Drosophila SA-fusion deficit vs. the theoretical prediction of an SA-fusion excess.** If SA selection were the dominant driver of sex-chromosome–autosome fusions, SA-fusions should be overrepresented. *Drosophila* instead show a significant deficit (observed 0.155, CI 0.12–0.22, vs. null 0.43; [The probability of fusions 2020, Finding 1](/knowledge/papers/10_1098_rsbl_2020_0648/#finding-1)), while *Habronattus* match the prediction ([The probability of fusions 2020, Finding 2](/knowledge/papers/10_1098_rsbl_2020_0648/#finding-2)). The clade-specific direction of the signal is not explained by any single model on this page.
- **Charlesworth & Charlesworth (1980) 3× prediction vs. empirical fusion rates.** The analytic model predicts Y-autosome fusions should increase at ~3× the initial rate of X-autosome fusions ([10.1017/s0016672300014051, Finding 2](/knowledge/papers/10_1017_s0016672300014051/#finding-2)). Simulation under the non-PAR case recovers a qualitatively similar but quantitatively smaller asymmetry ([Worse than nothing at 2024, Finding 3](/knowledge/papers/10_7717_peerj_17740/#finding-3)), and empirical surveys in *Drosophila* and mammals do not consistently recover the predicted 3× ratio — leaving the quantitative prediction of the foundational SA-fusion model unconfirmed.

### [Sex-linkage mutation](/knowledge/topics/sex_linkage_mutation/)

The parameter thresholds reported (*s* ≈ 0.2 for Y fixation; *h* < 0.3 for X polymorphism) derive from a deterministic three-locus model with symmetric fitness effects, a fixed multiplicative aneuploidy cost, and no genetic drift. Empirical estimates of aneuploidy costs associated with PAR contraction and real-population drift effects are not incorporated, so the quantitative thresholds may not translate directly to natural populations. Whether drift destabilizes the predicted X-linked polymorphisms at low inversion frequency remains an open question not addressed by the current model.

The KDM5-like candidate from *C. formosanus* rests on domain architecture from InterProScan rather than orthology-based gene naming, and lacks experimental validation. The gene could be a diverged paralog rather than a direct equivalent of mammalian KDM5D, which would weaken the convergence interpretation. Broader sampling of beetle Y chromosome gene content is needed before the parallel can be considered robust.

The out-of-the-X retrogenesis finding replicates an established pattern rather than reporting a new discovery. The test reports *p* ≈ 0 from Monte Carlo iterations without an effect-size decomposition, making it difficult to assess the magnitude of the signal relative to earlier analyses. Whether MSCI is the primary driver, as opposed to dosage compensation or other X-linked constraints, remains contested.

### [Sexual Antagonism](/knowledge/topics/sexual_antagonism/)

No direct contradiction exists between these two findings, but they operate at different levels and their relationship is worth flagging. The *Habronattus* fusion result ([The probability of fusions 2020, Finding 1](/knowledge/papers/10_1098_rsbl_2020_0648/#finding-1)) treats chromosomal fusions as the unit of analysis and does not specify the dominance architecture of the underlying alleles. The inversion model ([Blackmon & Brandvain 2017, Finding 1](/knowledge/papers/10_1534_genetics_117_300382/#finding-1)) shows that the outcome of sexually antagonistic variants on the X depends strongly on that dominance architecture (h < 0.3 threshold). If the fusions in *Habronattus* involved recessive male-beneficial alleles on the autosomes being fused, the theoretical model would predict polymorphism rather than fixation of those variants — yet fixation is implicitly assumed in the fusion-count framework. Reconciling these frameworks requires empirical data on the dominance coefficients of the specific loci involved, which are not yet available.

Additionally, the *Habronattus* p-value is sensitive to the assumed ancestral karyotype, and the h < 0.3 threshold from the inversion model derives from a symmetric, fully recombination-suppressing scenario; alternative parameter regimes could shift both results.

### [Sexually Antagonistic Selection](/knowledge/topics/sexually_antagonistic_selection/)

- The primary tension here is between the theoretical plausibility of SA-driven fusion and alternative explanations involving genetic drift. The verbal model synthesized in [Why not Y naught 2022, Finding 1](/knowledge/papers/10_1038_s41437_022_00543_z/#finding-1) does not provide quantitative estimates of the relative contributions of SA selection versus drift, especially in small populations where stochastic forces could dominate. Empirical evidence directly demonstrating SA-driven transitions in YO or WO systems (as opposed to XO systems) is currently lacking, leaving the generality of the mechanism uncertain.

### [Y-naught asymmetry](/knowledge/topics/y_naught_asymmetry/)

The *D. miranda* case remains the primary empirical anchor for the rate of Y-naught degeneration. Because it is a single species with its own particular effective population size, mating system, and genomic architecture, the universality of this degeneration rate is uncertain. Lineages with smaller effective population sizes might degenerate faster; those with stronger purifying selection or different TE dynamics might degenerate more slowly.

The SA-fusion argument for YO/WO instability [Why not Y naught 2022, Finding 1](/knowledge/papers/10_1038_s41437_022_00543_z/#finding-1) is a verbal/theoretical synthesis that draws on Charlesworth & Charlesworth (1980) and van Doorn & Kirkpatrick (2007) but does not provide new quantitative modeling. The relative strength of SA-driven fusion versus genetic drift in small populations is not formally estimated, and the available empirical support comes from XX/XO-to-XY transitions in Polyneoptera rather than from direct observation of YO/WO system conversion. Broader comparative data from multiple independently derived neo-Y systems (e.g., in beetles, fish, or plants) would be needed to evaluate both claims.

## Speciation & macroevolution

### [Avian Evolution](/knowledge/topics/avian_evolution/)

The primary tension in this case study is internal: the finding presents the greenish warbler ring as "continuous," yet the source paper acknowledges a large distributional gap in northeastern China attributed to deforestation. A strictly continuous ring of intermediate populations — the theoretical requirement for a true ring species — cannot currently be verified across the full geographic extent. Whether the gap represents a historical break or a recent anthropogenic disruption remains unresolved, and primary empirical work (e.g., Irwin et al. 2001; Irwin 2002) should be consulted for fine-scale population genetic data.

### [Avian Hybridization](/knowledge/topics/avian_hybridization/)

**Genomic verification of inter-family records.** The paper notes that Alfieri et al. 2023 genomically refuted at least one helmeted guineafowl × Phasianidae hybrid record that had appeared in the literature. The remaining five inter-family records in the dataset lack independent molecular verification, meaning the 51 MY figure — and the claim that these represent the most diverged avian hybrids — rests on literature-sourced reports rather than confirmed genomic evidence.

**Causality of the domestication effect.** The R² of 0.06 is statistically significant but explains little variance. The domestication index is derived from text-mining a single aviculture magazine, and the analysis cannot determine whether domestication *causes* increased hybrid compatibility or whether reproductively flexible species were preferentially chosen for domestication in the first place.

### [Convergent Evolution](/knowledge/topics/convergent_evolution/)

The convergence inference rests on FST outliers defined at the lowest 5% divergence threshold and a single circadian transcription dataset (Mack et al. 2021). Altering either the divergence threshold or the expression dataset could change which genes qualify as double outliers. More fundamentally, because all three cave populations belong to the same species and may share some ancestral standing variation, it remains debated whether recurrence across these populations constitutes *independent* convergence in the strict sense, or partial sharing of pre-existing alleles. No functional validation of *arpin*'s role in cavefish circadian or actin phenotypes has been reported, leaving the biological inference correlative.

### [Diversification Rates](/knowledge/topics/diversification_rates/)

The null result for karyotype-driven diversification [Blackmon et al. 2019, Finding 1](/knowledge/papers/10_1111_evo_13682/#finding-1) must be weighed against the known statistical limitations of BiSSE: the method is prone to false positives — and by extension potentially false negatives — on phylogenies with background rate heterogeneity. The authors themselves demonstrate elevated false-positive rates for diversification inference on the cetacean subtree in simulation. It remains possible that karyotype mismatch drives diversification within particular subclades but that the signal is diluted or confounded at the level of the full mammalian tree.

Additionally, the meiotic drive polarity switching rates [Blackmon et al. 2019, Finding 2](/knowledge/papers/10_1111_evo_13682/#finding-2) are inferred from trees representing only 12–30% of extant species per clade, which limits the precision of these estimates and could introduce systematic bias if sampled taxa are not representative.

### [Domestication](/knowledge/topics/domestication/)

The primary unresolved issue is **causal direction**: the 2024 study cannot distinguish whether domestication itself reduces reproductive isolation (e.g., via relaxed selection or phenotypic changes under artificial selection) or whether species that were already reproductively compatible with close relatives were preferentially chosen for domestication in the first place. The small R² (0.06) further cautions against strong causal inference. Additionally, the domestication proxy — frequency of mention in a single aviculture magazine — introduces measurement uncertainty that could attenuate or distort the estimated effect. Broader taxonomic sampling beyond Galliformes and independent domestication indices will be needed to assess generality.

### [Domestication genomics](/knowledge/topics/domestication_genomics/)

The primary internal tension in this literature concerns causality. The finding that domestication correlates with reduced reproductive isolation is consistent with at least two opposing interpretations: (1) domestication actively breaks down reproductive barriers through relaxed selection or deliberate crossing, or (2) species that were already prone to hybridizing with relatives were selectively targeted for domestication because they are easier to manage in captivity and to cross with related forms. The low R² (0.06) means that most variation in hybrid compatibility is explained by other factors, and the reliance on a single aviculture magazine for the domestication index introduces a potential publication-bias in which poorly studied or non-hybrid-forming taxa are underrepresented. Broader taxonomic sampling beyond Galliformes will be needed to assess generality.

### [Galliformes](/knowledge/topics/Galliformes/)

**Domestication as cause vs. consequence:** The significant association between domestication and hybrid compatibility ([Domestication is associated with 2024, Finding 1](/knowledge/papers/10_1093_jhered_esad059/#finding-1)) is correlational. It is equally consistent with the interpretation that reproductively labile species are preferentially selected for domestication, rather than domestication itself reducing reproductive isolation. The low R² (0.06) and the use of a single aviculture magazine as the domestication index proxy further limit causal inference.

**Guineafowl hybrid records and molecular verification:** The 51 MY inter-family hybridization figure ([Domestication is associated with 2024, Finding 3](/knowledge/papers/10_1093_jhered_esad059/#finding-3)) rests on literature-sourced hybrid reports. The same paper notes that Alfieri et al. 2023 genomically refuted at least one guineafowl × Phasianidae hybrid record; the remaining five lack independent molecular confirmation, meaning the empirical upper bound on avian hybridization distance could shift with further genomic scrutiny.

### [Hybridization](/knowledge/topics/hybridization/)

The plant–animal contrast in epistatic contribution should be interpreted cautiously. The plant dataset is disproportionately composed of domesticated crop crosses and selfing species. Domestication and selfing both reduce effective population size and standing genetic variation, which could lower detectable epistasis independently of any fundamental biological difference between clades. It remains unclear whether the observed difference reflects a genuine divergence in genetic architecture between animals and plants, or an artifact of how the plant sample was assembled. Broader taxonomic sampling — particularly of outcrossing wild plant species — is needed to resolve this tension. [Wright was right: leveraging 2024, Finding 2](/knowledge/papers/10_1093_evolut_qpae003/#finding-2)

### [Life History Evolution](/knowledge/topics/life_history_evolution/)

The magnitude of the epistatic excess detected in [Wright was right: leveraging 2024, Finding 1](/knowledge/papers/10_1093_evolut_qpae003/#finding-1) is small (0.06), and the latent class analysis framework used is known to be conservative in detecting epistasis under sparse data. The boundary between "life-history" and "morphological" trait categories is not always sharp — body size, for instance, correlates with both — and different classification schemes could alter the result. No directly contradicting study is yet represented on this page, but the modest effect size means the finding should be interpreted cautiously until replicated with alternative methods or taxon sets.

### [Phylloscopus](/knowledge/topics/phylloscopus/)

The claim that *P. trochiloides* forms a "continuous ring" is complicated by a documented distributional gap in northeastern China. The source literature attributes this gap to anthropogenic deforestation rather than a biological break, but the distinction matters for interpreting the ring as a model of natural speciation-in-progress. Whether the system can still serve as a clean ring species example — versus a partially disrupted one — remains an interpretive tension in the literature. Primary empirical analyses by Irwin et al. (2001) and Irwin (2002) are the foundational sources for evaluating these claims directly.

### [Postzygotic Isolation](/knowledge/topics/postzygotic_isolation/)

One important caveat surrounds the 51 MY upper-bound figure itself. The source paper notes that Alfieri et al. 2023 has genomically refuted at least one guineafowl × Phasianidae hybrid record from the literature. The remaining five inter-family records in the dataset rely on literature-sourced reports without independent molecular verification. If additional records are similarly refuted, the empirical upper bound for viable (even if sterile) avian hybridization could shift. Additionally, the paper's Introduction cites a range of 51–65 MY for this cross depending on the phylogenetic source used, introducing uncertainty into the precise divergence estimate.

### [Reproductive Isolation](/knowledge/topics/reproductive_isolation/)

**Causality of the domestication–compatibility link.** The finding that domestication correlates with reduced reproductive isolation ([Domestication is associated with 2024, Finding 1](/knowledge/papers/10_1093_jhered_esad059/#finding-1)) is correlational and cannot distinguish whether domestication erodes isolating mechanisms from whether species already predisposed to hybridize are preferentially domesticated. The R² of 0.06 also leaves most variance unexplained.

**Reliability of inter-family hybrid records.** The 51 MY hybridization ceiling ([Domestication is associated with 2024, Finding 2](/knowledge/papers/10_1093_jhered_esad059/#finding-2)) rests on literature-sourced reports. Alfieri et al. 2023 genomically refuted at least one guineafowl × Phasianidae record, raising questions about independent molecular verification of the remaining five cases.

**Domestication index validity.** The proxy for domestication degree relies on text-mining a single aviculture magazine, which may not capture the full spectrum of domestication intensity across Galliformes.

**Ancestral vs. neo-X sterility distinction — power vs. biology.** [A role for a neo-sex chromosome in stickleback speciation., Finding 2](/knowledge/papers/10_1038_nature08441/#finding-2) interprets the absence of a neo-X sterility signal as biologically meaningful, attributing it to chromosome age. However, the QTL design used only 76 backcross males from a single cross, yielding low power to detect loci of small effect. The absence could reflect insufficient sample size rather than a true functional difference between ancestral and neo-X contributions to hybrid sterility.

### [Ring Species](/knowledge/topics/ring_species/)

A notable tension exists even within the greenish warbler example. Although the system is presented as demonstrating a continuous ring, a substantial distributional gap in northeastern China has been documented and attributed to recent deforestation. If the ring is not truly continuous, the system may represent a fragmented chain rather than a strict ring species, which would weaken inferences about unbroken clinal gene flow driving divergence. The claim of a "continuous ring" therefore requires qualification, and readers should consult primary empirical sources (e.g., Irwin et al. 2001; Irwin 2002) for full distributional data. [Ring Species and Speciation 2012, Finding 1](/knowledge/papers/10_1002_9780470015902_a0001751_pub3/#finding-1)

### [Speciation](/knowledge/topics/speciation/)

The "continuous ring" framing of the greenish warbler system is partly complicated by a well-documented gap in the northeastern portion of the ring, in northeastern China, attributed at least in part to recent deforestation ([Ring Species and Speciation 2012, Finding 1](/knowledge/papers/10_1002_9780470015902_a0001751_pub3/#finding-1)). If the ring is not fully continuous, the system is a less clean natural experiment than often claimed, and the degree to which historical continuity can be inferred remains debated. Broader questions — such as whether any true ring species exist in nature, and whether the ring species model is a common or exceptional route to speciation — remain open and require additional taxonomic and genomic investigation.

### [Uce Phylogenetics](/knowledge/topics/uce_phylogenetics/)

The primary open question concerns the robustness of the *Perdita*–*Andrena* sister-group relationship. Taxon sampling in the 119-genome dataset is heavily skewed toward social bees in Apidae and Halictidae; Stenotritidae is entirely absent, and only one Andrenidae genus (*Andrena*) is represented alongside *Perdita*. Broader sampling of Andrenidae diversity — and inclusion of the missing family Stenotritidae — will be required to confirm the internal topology of Andrenidae using UCE data.
