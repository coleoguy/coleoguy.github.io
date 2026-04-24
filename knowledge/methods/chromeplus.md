---
layout: default
title: "chromePlus — Chromosome number evolution with binary traits"
method_slug: chromeplus
language: R
package: chromePlus
depends_on_concepts: [mk-model, ancestral-state-reconstruction, markov-model]
appears_in_topics: [chromosome_number_evolution, sex_chromosome_evolution, karyotype_evolution]
appears_in_papers: ["10_1534_genetics_114_164269", "10_1111_evo_13682", "10_1093_jhered_esae025", "10_1371_journal_pgen_1009076"]
difficulty: advanced
last_updated: 2026-04-23
permalink: /knowledge/methods/chromeplus/
---
<!-- tealc:method-start -->
# chromePlus

**What it does.** chromePlus is an R package developed in the Blackmon Lab that extends the chromEvol framework within the `diversitree` ecosystem. It fits Markov chain models of chromosome number evolution on phylogenies using MCMC and crucially allows a binary trait (such as sex determination system, mating strategy, or presence of B chromosomes) to influence the rates of chromosome change. Modeled events include chromosome gain (ascending dysploidy), loss (descending dysploidy), polyploidy, and demiploidy. The binary trait adds a second dimension to the state space: each chromosome number x binary-state combination becomes a distinct state, and the model tests whether rates differ between the two states.

**When to use it.**
- You have chromosome-number data for 50+ species mapped onto a phylogeny.
- You want to test whether a binary trait modulates rates of chromosome gain, loss, polyploidy, or demiploidy.
- You need Bayesian posterior distributions for rate parameters rather than point estimates.
- You want to compare rate magnitudes (ΔR statistics) between binary-trait states with credible intervals.

**When NOT to use it.**
- Tree has fewer than ~30 tips — power is too low; a simpler Mk model without the binary trait is a better choice.
- Chromosome numbers are incomplete or highly uncertain — garbage in, garbage out.
- You need to estimate diversification rates (speciation/extinction) alongside trait evolution — use BiSSE or HiSSE instead.
- Your binary trait is continuous or ordinal — discretize it with an explicit, biologically justified threshold before using it here.
<!-- tealc:method-end -->

<!-- tealc:example-start -->
## Worked example

```r
library(chromePlus)
library(diversitree)

# dat: data.frame with columns:
#   species  — character, matching tree$tip.label
#   haploid_chrom — integer haploid chromosome count
#   prob_state_A  — numeric 0..1, probability of binary state A
#                   (use 0 or 1 for hard assignments; intermediate values
#                    integrate over tip uncertainty)
# tree: phylo object (ape format), time-calibrated

# 1. Build a probability matrix over chromosome states x binary states
pmat <- datatoMatrix(x = dat,
                     range = c(5, 25),    # must bracket all observed counts
                     hyper = TRUE,
                     state.names = c("A", "B"))

# 2. Build a diversitree mkn likelihood from the matrix
lik <- make.mkn(tree, pmat, strict = FALSE,
                control = list(method = "ode"))

# 3. Constrain to the chromePlus rate scheme
con.lik <- constrainMkn(data = pmat, lik = lik,
                        state.names = c("A", "B"))

# 4. Run MCMC through diversitree
inits <- startVals(n = 10, min = 0, max = 0.2)
post  <- mcmc(con.lik, x.init = inits, nsteps = 5000, w = 0.1)

# 5. Inspect convergence — effective sample size for each rate
library(coda)
post_mcmc <- as.mcmc(post[-(1:1000), ])   # discard burn-in
effectiveSize(post_mcmc)

# 6. Compute ΔR for gain rate: (rate in state A) - (rate in state B)
delta_R_gain <- post[-(1:1000), "asc.A"] - post[-(1:1000), "asc.B"]
quantile(delta_R_gain, c(0.025, 0.5, 0.975))

# 7. Plot posterior densities
plotChromeplus(data = post[-(1:1000), c("asc.A", "asc.B")],
               colors = c("#fb923c", "#500000"),
               x_title = "chromosome gain rate",
               main_title = "Gain rate: state A vs B")
```
<!-- tealc:example-end -->

<!-- tealc:gotchas-start -->
## Gotchas we've hit

- **False-positive rate can be substantial.** Simulation on the Carnivora phylogeny showed that 22% of neutral fusion traits and 33% of neutral fission traits reached significance at the threshold used in the original analysis. Always simulate neutral traits on your tree to calibrate expected false-positive rates before interpreting empirical ΔR values.
- **Identifiability of demiploidy and polyploidy.** These two rates trade off at small tree sizes. With fewer than 50 tips, drop demiploidy; it is rare in most empirical datasets and its estimate is unreliable at low sample sizes.
- **State boundary effects.** The `range = c(5, 25)` argument must comfortably bracket all observed chromosome numbers. A too-tight range artificially inflates rates near the boundary. Add at least 2–3 units of buffer on each side.
- **Binary trait ambiguity.** If the binary trait is uncertain at the tips, use the `prob` column in `dat` rather than a hard 0/1 coding. chromePlus integrates over the uncertainty; forcing hard 0/1 when states are ambiguous biases rate estimates.
- **Mixing issues.** If MCMC chains show effective sample sizes < 200 for rate parameters, try more iterations, tighter starting values, or a simpler model with fewer rates. Chains that don't converge should not be reported.
- **State space explosion.** A range of 40 chromosome numbers times 2 binary states gives 80 model states; the ODE solver for large state spaces can be slow. Start with a narrower range to prototype, then widen.
<!-- tealc:gotchas-end -->

<!-- tealc:papers-start -->
## Key papers that use this method in the lab

- [Blackmon & Demuth 2014 — Estimating tempo and mode of Y chromosome turnover](/knowledge/papers/10_1534_genetics_114_164269/) — early application of chromePlus-style modeling to Adephaga beetles, linking sex chromosome state to chromosome number change rates.
- [Blackmon, Justison, Mayrose & Goldberg 2019 — Meiotic drive shapes rates of karyotype evolution in mammals](/knowledge/papers/10_1111_evo_13682/) — uses chromePlus to test whether meiotic drive polarity influences chromosome fusion and fission rates in mammal subclades.
- [Jonika, Wilhoit, Chin & Arekere 2024 — Drift drives the evolution of chromosome number II](/knowledge/papers/10_1093_jhered_esae025/) — applies chromePlus in Carnivora; quantifies false-positive rates for neutral binary traits on this phylogeny.
- [Ruckman, Jonika, Casola & Blackmon 2020 — Chromosome number evolves at equal rates in holocentric and monocentric clades](/knowledge/papers/10_1371_journal_pgen_1009076/) — uses chromePlus to compare chromosome evolution rates between holocentric and monocentric lineages.
<!-- tealc:papers-end -->

<!-- user-start -->
<!-- user-end -->
