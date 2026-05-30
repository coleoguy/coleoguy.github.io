# Research Briefing: Ten Candidate Projects for Immediate Launch

*Prepared April 2026. Projects ranked by aggregate score from 3 independent expert reviewers, each scoring 20 candidates on novelty, feasibility, skill fit, impact, and student readiness. Only first and last author papers were used as signal.*

---

## 1. SAGA-Comparative: Genetic Architecture as a Phylogenetic Trait

The Fisher-Wright debate over the structure of genetic variance is almost a century old and has never been adjudicated with cross data treated as a phylogenetically-aware corpus. The core question here is sharp: does the proportion of phenotypic variance attributable to epistasis grow monotonically with parental divergence, as Wright's shifting-balance logic predicts, or does it remain a small additive-dominated fraction across divergence depths, as Fisher's infinitesimal model implies? The answer reframes how we extrapolate QTL results across species and how we interpret hybrid breakdown.

Approach is concrete. Curate 100 to 200 line-cross analyses from the published quantitative genetics literature; for each, extract or recompute additive, dominance, and epistatic variance components, using SAGA on raw cohort means where the original authors report them but did not fit the full Mather-Jinks decomposition. Place each cross on a time-calibrated phylogeny via TimeTree or clade-specific molecular dates. Fit phylogenetic mixed models in brms and metafor with parental divergence (in millions of years, or substitutions per site) as a continuous fixed effect and additive/dominance/epistasis proportions as continuous responses, with study-level random effects to absorb design heterogeneity. A residual question worth pre-registering: how to handle the variance components' compositional constraint (they sum to unity); a Dirichlet or logit-stick-breaking response will be cleaner than three independent Gaussians.

The novelty is that no one has treated LCA studies as a meta-analytic corpus on a phylogenetic backbone. SAGA becomes the inferential engine rather than a single-study tool, and the analysis delivers the first empirical, data-driven test of the Fisher vs Wright debate using actual cross data rather than theory.

Caveat: publication bias toward systems with detectable epistasis is real and must be modeled explicitly (selection models in metafor, or trim-and-fill diagnostics).

**Student entry point, week one:** literature search and a structured spreadsheet of LCA studies with parental species, generations available (P, F1, F2, BC), and reported variance components.

---

## 2. Fragile-Y as a Quantitative Phylogenetic Test Using PAR Length

The fragile-Y hypothesis posits a mechanistic prediction: as the pseudoautosomal region shrinks, the Y (or W) loses its required obligate chiasma and degenerates or is lost outright. Every comparative test to date has used a binary recombining-versus-achiasmatic state, which discards the actual continuous predictor the mechanism specifies. The question we should be asking is whether PAR length, on a continuous scale, predicts Y/W loss rates across animals.

Compile PAR length estimates (in Mb or in cM) from the rapidly growing set of chromosome-level animal assemblies with published linkage maps or cytogenetic measurements. Realistic target: 150 or more taxa across arthropods and vertebrates, drawing on DNA Zoo, VGP, Darwin Tree of Life, and i5K. Code Y/W presence-absence states from your existing Tree of Sex and karyotype databases. Fit corHMM and diversitree models in which PAR length enters as a continuous covariate on the Y-loss transition rate (using the trait-dependent rate machinery in OUwie or via custom Q-matrix parameterizations in corHMM 2.x). Include chiasmatic versus achiasmatic state as an interaction term to test whether PAR length matters only when chiasmata are required.

Novelty is unambiguous: the actual mechanistic predictor has never been used in a comparative model. If the slope is significantly negative (short PAR, faster loss) and the chiasmatic interaction is significant, the fragile-Y hypothesis gets its first quantitative empirical support; if the slope is flat, the dominant explanation needs revision.

Caveat: PAR length is measured inconsistently across studies (genetic versus physical, with or without gametologs included). A standardized recompilation rule is needed and should be documented in the supplement.

**Student entry point, week one:** pull PAR coordinates from the ten or twenty best-assembled vertebrate and arthropod genomes and write the data-extraction script.

---

## 3. Drive Polarity as a Driver of Sex-Chromosome System Turnover in Insects

Meiotic drive polarity has been linked to autosome counts in mammals (Blackmon et al. 2019), but the much richer phenomenon of sex-chromosome system turnover in insects has not been examined through the drive-polarity lens. The question: does drive polarity (female-biased versus male-biased meiotic asymmetry) co-evolve with transitions among XY, XO, ZW, and ZO systems and with autosome morphology, and does this coupling explain the long-puzzling rate variation in sex-chromosome turnover across insect orders?

Extend chromePlus to a multi-state joint model tracking sex-chromosome state, autosome morphology (mixed versus matched arm composition), and chromosome number simultaneously. The state space is large, so structured rate matrices and informative priors will be required; chromePlus's existing C++ likelihood machinery should be the starting point. Fit to the Coleoptera and Lepidoptera karyotype databases with the published phylogenies your group already maintains. Compare model fit (AIC, WAIC, posterior predictive checks) against models without drive-polarity coupling, and against models in which drive polarity is decoupled from sex-chromosome state but coupled to autosome morphology only.

Novelty: drive polarity has been treated as a mammalian story; extending it to the two largest insect orders, with their well-resolved karyotype phylogenies, is a substantial conceptual synthesis that no one has attempted. If drive polarity predicts XY-to-XO transitions in beetles but not in moths, that itself is a publishable, mechanistically interpretable result.

Caveat: identifiability with a state space this size is a real risk; simulation-based calibration before fitting empirical data is non-negotiable.

**Student entry point, week one:** fork chromePlus and write the expanded Q-matrix specification with drive polarity as a labeled state dimension; run on a small simulated dataset to confirm the likelihood compiles.

---

## 4. Quantitative Half-Life of Univalent Sex-Chromosome Systems (YO, WO)

Jonika et al. (2022) argued from cytogenetic survey data that YO and WO systems are transitory rather than stable endpoints, but the claim has never been formalized into a phylogenetic test that yields half-life estimates. The question is two-fold: are YO and WO genuinely transitory under a continuous-time Markov model, with measurable sojourn distributions, and does B-chromosome presence accelerate their origin or hasten their decay?

Build a corHMM model with the full state space {XY, XO, YO, ZW, ZO, WO}, with B-chromosome presence as a hidden binary state that modifies transition rates among the visible states. Estimate the full transition rate matrix and derive expected sojourn times analytically from the diagonal of the matrix exponential. Use the Coleoptera Karyotype Database as the primary substrate, supplemented by hexapod-wide records (Orthoptera, Hemiptera) where univalent states are most concentrated. Posterior sojourn-time distributions, not just point estimates, should be reported, since the half-life claim is fundamentally distributional.

Novelty: the first phylogenetic test of the Jonika et al. transitory-state hypothesis with a quantitative half-life estimate, and the first integration of B-chromosome data with sex-chromosome turnover models in a hidden-state framework.

Caveat: YO and WO are rare states. Statistical power depends on having enough independent transitions; a power analysis on simulated trees with realistic state frequencies should precede the empirical fit, and the conclusions should be honest about the precision floor.

**Student entry point, week one:** collate every known YO and WO record across hexapods from the existing database and recent literature, with citations and assembly-quality flags.

---

## 5. Effective Population Size as a Continuous Predictor of Karyotype Evolution Rates

The Lynch-style intuition that Ne governs the fixation probability of slightly underdominant rearrangements is theoretically clean, but every comparative test so far has used categorical proxies (winged versus wingless, range size, body size). The question is whether genomically-derived Ne, on a continuous scale, predicts fission and fusion rates across the karyotype databases your group has already curated, and crucially whether the relationship is linear, threshold-like, or absent outside a small subset of extreme clades.

Compile pi and theta estimates from public assemblies and population resequencing for taxa spanning the Coleoptera, Carnivora, and broader insect karyotype databases. PopHuman, NCBI SRA, and Dryad deposits will be the primary sources. Convert pi to Ne with clade-appropriate mutation rate priors (acknowledging that this introduces the very confound that project 6 is designed to audit). Fit chromePlus fission and fusion rates with Ne as a continuous covariate using OUwie-style trait-dependent rate machinery, and compare linear, log-linear, and threshold (changepoint) functional forms via WAIC.

Novelty: prior work in your own group has used categorical proxies; Ne as a continuous predictor with a flexible functional form has never been fit, and the shape of the relationship determines whether the Lynch story is a smooth quantitative law or a sharp regime boundary.

Caveat: Ne estimates from pi are noisy and confounded with selection at linked sites. Reporting results both with and without recombination-rate-stratified pi is good practice.

**Student entry point, week one:** pull pi or theta from the ten best-sampled Coleoptera and Carnivora datasets and benchmark the estimates against any existing PSMC or SMC++ runs in the literature.

---

## 6. Identifiability of Ne Versus Mutation Rate as Alternative Drivers of Karyotype Rate Differences

This is the methodological audit the field needs before the Ne explanation hardens into received wisdom. The question is precise: under what regions of (s, Ne, mu) parameter space does chromePlus inference incorrectly attribute rate differences to Ne when per-chromosome mutation rate variation is the actual cause, and what does the converse look like?

Simulate karyotype count time series in SLiM4 under explicit underdominance, with Ne and per-chromosome mutation rate decoupled across replicates spanning a factorial grid. Fit chromePlus to each simulated dataset and quantify bias and coverage of the inferred Ne effect. Map the (s, Ne, mu) parameter space where the model fails to discriminate. Then calibrate empirical Coleoptera and Carnivora rate estimates against independent mu proxies derived from synonymous-site divergence in the same clades (dS from OrthoFinder runs, or four-fold-degenerate-site rates from BUSCO genes).

Novelty: no identifiability analysis has been run on the Ne-karyotype-rate inference. This is the kind of audit that either licenses a body of recent work or constrains its interpretation. Either outcome is publishable, and either outcome is useful.

Caveat: SLiM4 simulations of whole-karyotype dynamics with chromosome-level fission/fusion events are computationally expensive; the simulation grid should be designed with care and the parameter axes prioritized.

**Student entry point, week one:** write a minimal SLiM4 recipe for a single-chromosome underdominance model with tracked fixation events, and pipe the output through your existing chromePlus fitting wrapper.

---

## 7. Audit and Correction of Pre-Phylogenetic Karyotype Rate Estimates

The scaled-variance estimators of Bush, Imai, Bengtsson, Petitpierre, Olmo, and Coyne still anchor textbook claims about karyotype evolution rates, despite the fact that they predate phylogenetic comparative methods entirely. The question: how quantitatively biased are these legacy estimates, and can a correction factor be predicted from clade-level properties so that the existing literature can be partially salvaged rather than discarded?

For every clade with a published scaled-variance estimate, fit chromePlus to the same data using available phylogenies from OpenTree of Life and NCBI Taxonomy. Regress the residual (chromePlus rate minus scaled-variance rate) on clade-level properties: taxon count, phylogenetic depth, tip-state variance, fossil-age uncertainty, and tree balance. Publish a correction-factor lookup table and explicitly flag which textbook claims (e.g., the rapid rate in muntjacs, the slow rate in some lepidopterans) are most vulnerable to revision.

Novelty: the discrepancy between methods is established anecdotally (tau = 0.11 rank correlation in Blackmon et al. 2024) but has never been characterized systematically. This is a service paper that any future review will cite.

Caveat: in some cases the original phylogenies are unavailable or unresolvable, and a synthetic OpenTree topology will introduce its own error; this should be quantified by sensitivity analysis on alternative topologies.

**Student entry point, week one:** compile the scaled-variance literature into a structured table with clade name, estimate, sample size, and citation, and identify which clades have a usable contemporary phylogeny.

---

## 8. X-linked Deleterious Load Purification as a Mechanistic Predictor of Haplodiploidy Origins

The chromosome-number-haplodiploidy correlation reported in Blackmon et al. (2015) is comparative; the proposed mechanism (pre-purification of X-linked deleterious load lowers the cost of transitioning to haplodiploidy) has never been tested with genomic load data. The question: do arthropod lineages that evolved haplodiploidy show elevated prior purification of X-linked deleterious alleles relative to sister diploid lineages?

For 200 or more arthropod species with chromosome-level assemblies, assign genes to sex-linked versus autosomal compartments by synteny (GENESPACE, MCScanX) and read-depth in resequencing data. Estimate X-linked deleterious load via two complementary measures: dN/dS on protein-coding genes and segregating loss-of-function variants in population resequencing where available. Contrast sister clades from the Tree of Sex dataset that differ in haplodiploidy origin using PGLS and phylogenetic ANCOVA, with X-versus-autosome ratio as the response and haplodiploidy state as the predictor.

Novelty: this is the first direct mechanistic test of the X-purification hypothesis using actual genomic load data rather than karyotype correlations as a proxy.

Caveat: this is the most genomics-heavy proposal in the set. The synteny-based gene-to-chromosome assignment and population resequencing pipelines are mature but require compute and a competent bioinformatics workflow. A student without genomics background will need scaffolding.

**Student entry point, week one:** run GENESPACE on five well-assembled arthropod genomes spanning at least one haplodiploid origin and validate the X-versus-autosome assignment against published cytogenetics.

---

## 9. Cross-Kingdom Hierarchical Bayesian Test of a Universal Ne-Karyotype Rate Law

Individual clade analyses (Blackmon et al. 2024 in Coleoptera; Jonika et al. 2024 in Carnivora; Ross et al. in Hymenoptera) each report Ne-correlated rate variation, but no one has asked the right question: is the relationship the same across kingdoms, or is each clade telling a parochial story? The scientific stakes are high. A universal slope is a candidate general law of karyotype evolution; clade-specific slopes mean we have several distinct mechanisms masquerading as one phenomenon.

Build a hierarchical Bayesian extension of chromePlus in Stan or NIMBLE, with fission and fusion rate parameters partially pooled across clades and Ne as a continuous covariate with both a global slope and clade-specific deviations. Fit simultaneously to Coleoptera, Carnivora, Hymenoptera, a polyneopteran insect order (Orthoptera or Phasmatodea), and a plant clade (Brassicaceae or Poaceae from existing ChromEvol-curated datasets). Posterior contrasts on the clade-level slope deviations directly answer the universality question.

Novelty: no one has fit a single hierarchical model across kingdoms. The result, whichever way it falls, will be cited as the canonical answer to whether karyotype evolution has a general law.

Caveat: Stan implementations of likelihoods involving matrix exponentials of large Q matrices are slow; a Felsenstein-pruning custom likelihood in Stan will be needed, and convergence diagnostics on a hierarchical model of this size require care.

**Student entry point, week one:** write the Stan model specification for a single-clade chromePlus likelihood with Ne as a covariate, and confirm it recovers parameters on simulated data before adding the hierarchy.

---

## 10. Does Chromosome Number Evolution Misrepresent Genome Reorganization?

Virtually all comparative karyotype work treats chromosome count as the trait of interest, on the implicit assumption that count is a reasonable proxy for genome reorganization rate. That assumption has never been tested, and chromosome-level assemblies now make it testable. The question: when karyotype evolution is quantified by actual rearrangement counts (from synteny graphs) rather than count changes, do clades rank in the same fast-slow order?

Apply synteny-graph methods (GENESPACE, descrambler, AGORA) to 50 to 100 chromosome-level assemblies in clades spanning the established fast-slow karyotype categories: Coleoptera, Lepidoptera, Carnivora, and rodents. Reconstruct ancestral linkage block compositions, count inferred fissions, fusions, inversions, and translocations on each branch, and refit chromePlus-style Markov models using rearrangement counts rather than chromosome number as the trait. Compare rank-order correlations and absolute rate estimates.

Novelty: a foundational assumption of the comparative karyotype literature is being tested for the first time. If rank order is preserved, several decades of count-based work is vindicated; if it is not, several published conclusions need revisiting.

Caveat: ancestral synteny reconstruction has its own error, and the comparison is between two noisy estimators. Bias in either direction must be acknowledged. Note also the complementarity with project 7: that project audits the statistical method, this one audits the trait itself.

**Student entry point, week one:** run GENESPACE on the available chromosome-level Coleoptera assemblies (Tribolium, Diabrotica, several Adephaga) and produce a first-pass synteny graph.

---

## Portfolio Perspective

The ten projects form a coherent program structured along three axes. First, theory tests with data your group already controls (projects 3, 4, 5, 1). Second, methodological audits that protect or constrain inference (projects 6, 7, 10, and partially 9). Third, mechanistic and cross-kingdom integrations (projects 2, 8, 9) that push beyond clade-bound stories. Together they consolidate chromePlus, SAGA, and the karyotype databases into a unified inferential platform.

For year one, three projects offer the highest return. Start with project 7 (audit of pre-phylogenetic estimates): it is pure R, requires no new data, produces a service paper that every reviewer will eventually cite, and trains the student on the chromePlus pipeline. Pair it with project 4 (univalent half-life): the data are largely curated, the corHMM stack is mature, and the result is a clean, narratively sharp paper. Then start project 6 (Ne-mu identifiability) in parallel, because its conclusions condition the interpretation of projects 5 and 9; running it early protects the larger Ne-karyotype program from a foundational embarrassment later.
