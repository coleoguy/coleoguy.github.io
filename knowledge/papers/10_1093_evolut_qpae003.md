---
layout: default
title: "Wright was right: leveraging old data and new methods to illustrate the critical role of epistasis in genetics and evolution"
doi: "10.1093/evolut/qpae003"
fingerprint_sha256: 9b26073c4ef21e4b81ec477d50cc357c4809ccb79b53507cb54707da1d48856b
authors: "J. B. Burch, Maximos Chin, Brian E. Fontenot, Sabyasachi Mandal"
journal: "Evolution"
year: 2024
topics: [epistasis, genome_structure_evolution, hybridization, life_history_evolution, line_cross_analysis, quantitative_genetics_methods]
tier: canon
ingested_at: 2026-04-21T20:33:57.904398+00:00
permalink: /knowledge/papers/10_1093_evolut_qpae003/
pdf: /pdfs/10_1093_evolut_qpae003.pdf
---
# Wright was right: leveraging old data and new methods to illustrate the critical role of epistasis in genetics and evolution

<!-- tealc:freshness-start -->
<aside class="wiki-freshness" aria-label="Source paper provenance">
<span class="wf-label">Source paper</span>
<span class="wf-date">ingested 2026-04-21</span>
<span class="wf-dot">·</span>
<span class="wf-sources">3 findings extracted</span>
<span class="wf-dot">·</span>
<span class="wf-review">fingerprint 9b26073c</span>
</aside>
<!-- tealc:freshness-end -->


## Summary

_Ingested 2026-04-21. 3 findings extracted and verified._

## Findings worth citing

<a id="finding-1"></a>
### Finding 1 — Life-history traits show a significantly greater epistatic contribution to trait divergence than morphological traits across 488 species-trait pairings.

> Life-history traits showed a greater proportion of epistatic contribution to trait divergence than morphological traits (mean difference of 0.06, empirical p-value .024; Figure 3A and B).
— p. 629

*Why this is citable:* This is the paper's central empirical test of the classic Crnokrak–Roff prediction that fitness-associated traits should show more nonadditive variance, and it is the result most likely to be cited in discussions of genetic architecture and fitness.

*Counter / limitation:* The effect size (0.06) is small, the trait categorization into 'life history' vs. 'morphological' is subjective, and LCA is known to be conservative in detecting epistasis under sparse data, so the true contrast could be under- or overestimated.

*Topics:* [Epistasis](/knowledge/topics/epistasis/), [Life History Evolution](/knowledge/topics/life_history_evolution/)

<a id="finding-2"></a>
### Finding 2 — Animals exhibit greater epistatic contributions to trait divergence than plants.

> In our comparison between plants and animals, we found a significantly higher epistatic contribution to trait divergence in animals than plants (mean difference of −0.08, empirical p-value = .01; Figure 3E and F).
— p. 629

*Why this is citable:* Provides a novel, large-scale taxonomic comparison that could be cited in work on hybridization rates, reproductive isolation, and BDMIs, where authors hypothesize plant–animal differences in genetic architecture.

*Counter / limitation:* The plant sample is dominated by domesticated crop crosses and selfing species, which may have reduced standing genetic variation and thus lower detectable epistasis, potentially confounding the clade comparison with mating system.

*Topics:* [Epistasis](/knowledge/topics/epistasis/), [Hybridization](/knowledge/topics/hybridization/), [Genome structure evolution](/knowledge/topics/genome_structure_evolution/)

<a id="finding-3"></a>
### Finding 3 — Traditional joint-scaling LCA ignores model selection uncertainty and roughly 19% of datasets yield no genetic effects meeting strict information-theoretic criteria, indicating a substantial false-positive risk in older analyses.

> Of the 1,606 analyzed datasets, 81% (1,297) met these thresholds. Across all analyzed datasets, the number of models included in the confidence model set ranged from 1 to 2002.
— p. 628

*Why this is citable:* This methodological finding documents that 19% of datasets collected from the literature fail information-theoretic thresholds under SAGA model averaging, indicating that traditional forward-selection LCA produces inferences that cannot be replicated under a rigorous model-selection framework. It motivates adoption of model-averaged LCA and is citable by anyone evaluating legacy quantitative genetics line-cross results.

*Counter / limitation:* The 19% failure rate reflects datasets that lack sufficient statistical power or cohort diversity under SAGA's criteria—not necessarily that prior inferences were false positives. The variable-importance cutoff of 0.5 and 95% CI exclusion of zero are themselves chosen thresholds; different criteria would yield different failure rates. The finding conflates 'not supported under this framework' with 'false positive,' which overstates the implication.

*Topics:* [Line Cross Analysis](/knowledge/topics/line_cross_analysis/), [Quantitative Genetics Methods](/knowledge/topics/quantitative_genetics_methods/), [Epistasis](/knowledge/topics/epistasis/)

<!-- tealc:related-start -->
## Read the paper

[doi.org/10.1093/evolut/qpae003](https://doi.org/10.1093/evolut/qpae003)

## Related papers on this site

- [Blackmon & Demuth 2016](/knowledge/papers/10_1111_evo_12844/) — 2 shared topics (epistasis, line_cross_analysis)
- [Ruckman & Blackmon 2020](/knowledge/papers/10_1093_jhered_esaa030/) — 2 shared topics (epistasis, line_cross_analysis)
- [Burch et al. 2024](/knowledge/papers/10_7717_peerj_17985/) — 2 shared topics (epistasis, line_cross_analysis)
<!-- tealc:related-end -->
