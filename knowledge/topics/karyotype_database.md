---
layout: default
title: "Karyotype database"
topic_slug: karyotype_database
last_updated: 2026-04-22T12:38:29.697504+00:00
papers_supporting: [0f1bc39e2879ec58c1a6e091a838d1861975612f9a803dea779e9576fe264d44, 10.1093/bioinformatics/btp324, 8d80b92951d823f89e08809b32fd3ca88f579a921d623a23f8cb3c8f588e19b5, a4b0b03e15616954490c13ea4d103ee11a9801d0bd20d37a97376a3d936114eb, fa8d0869c6d351d791f46d2b041f9c1589e106dfa4d3f3d2ebbc59e1e3b3d80e]
permalink: /knowledge/topics/karyotype_database/
category: "Karyotype evolution"
---
<!-- tealc:auto-start -->
# Karyotype Database

<!-- tealc:freshness-start -->
<aside class="wiki-freshness" aria-label="Page provenance">
<span class="wf-label">Composed by Tealc</span>
<span class="wf-date">2026-04-22</span>
<span class="wf-dot">·</span>
<span class="wf-sources">5 sources</span>
<span class="wf-dot">·</span>
<span class="wf-review">Last reviewed by Heath: never</span>
</aside>
<!-- tealc:freshness-end -->


## Current understanding

Comprehensive karyotype databases aggregate cytogenetic records across the animal tree of life, enabling broad comparative analyses of sex determination and chromosome evolution. Several complementary resources illustrate both the power and the limits of this approach.

At the broadest scale, a synthesis across 10,754 surveyed plant and animal species (excluding 1,453 species with multiple sex chromosomes likely arising from sex chromosome–autosome fusions) finds that 67% carry XX/XY systems and roughly 28% carry XX/XO systems, with only a single known species exhibiting a YO/WO univalent sex-specific chromosome ([Why not Y naught 2022, Finding 1](/knowledge/papers/10_1038_s41437_022_00543_z/#finding-1)). This eukaryote-wide baseline establishes XX/XY as the dominant configuration by a wide margin, though the same synthesis cautions that ZW prevalence is almost certainly underestimated because classical karyotyping protocols are less sensitive to heteromorphic W chromosomes.

For insects specifically, the Tree of Sex database underpins the finding that male heterogamety (XY or XO systems) is documented in 24 of 28 insect orders and encompasses approximately 77% of sexually reproducing insect species surveyed ([Blackmon & Demuth 2015, Finding 1](/knowledge/papers/10_1016_j_cois_2014_12_003/#finding-1)). This figure is consistent with the broader eukaryote pattern and is critical for evaluating hypotheses about ancestral states and transition rates between sex-determination systems.

Within insects, beetles (Coleoptera) offer a particularly rich karyotype record. The two major suborders differ strikingly in their autosome number distributions: Adephaga range from 3 to 34 autosomes (mean 15.57), with a bimodal distribution peaking at 11 and 18 autosomes (accounting for 23% and 20% of Adephaga records, respectively), while Polyphaga range from 1 to 35 (mean 10.63) with a pronounced single mode at 9 autosomes that accounts for 29% of all Polyphaga records ([Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae001/#finding-1)). These suborder-level statistics provide a quantitative foundation for testing whether particular chromosome-number optima are maintained by selection or shaped by drift.

For amphibians, a dedicated Amphibian Karyotype Database contains 2,124 records — more than double the records in the previous compilation published nearly 30 years earlier. The vast majority (1,833) cover frogs (Anura), while salamanders (Caudata) and caecilians (Gymnophiona) contribute only 246 and 45 records, respectively ([Perkins et al. 2019, Finding 1](/knowledge/papers/10_1007_s10577_019_09613_1/#finding-1)). The two-fold expansion makes this resource substantially more useful for macroevolutionary inference across tetrapods, even as it highlights how unevenly cytogenetic effort has been distributed across amphibian orders.

All of these resources share a structural challenge: their scope reflects decades of cumulative karyotyping effort and therefore skews toward historically well-studied groups and detection methods.

## Supporting evidence

- [Why not Y naught 2022, Finding 1](/knowledge/papers/10_1038_s41437_022_00543_z/#finding-1): Among 10,754 surveyed species, 67% exhibit XX/XY and ~28% exhibit XX/XO sex chromosome systems, establishing XX/XY as the most common configuration across eukaryotes.
- [Blackmon & Demuth 2015, Finding 1](/knowledge/papers/10_1016_j_cois_2014_12_003/#finding-1): Male heterogamety (XY/XO) has been documented in 24 of 28 insect orders and encompasses 77% of sexually reproducing insect species investigated, establishing it as the most common sex-determination mode across insects.
- [Perkins et al. 2019, Finding 1](/knowledge/papers/10_1007_s10577_019_09613_1/#finding-1): The Amphibian Karyotype Database contains 2,124 karyotype records — more than doubling the 1990 compilation — with 1,833 Anura, 246 Caudata, and 45 Gymnophiona records.
- [Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae001/#finding-1): In the Coleoptera karyotype dataset, Adephaga autosome counts range from 3 to 34 (mean 15.57, bimodal peaks at 11 and 18), while Polyphaga range from 1 to 35 (mean 10.63, single mode at 9 autosomes = 29% of records).

## Contradictions / open disagreements

The cross-eukaryote 67%/28% split ([Why not Y naught 2022, Finding 1](/knowledge/papers/10_1038_s41437_022_00543_z/#finding-1)) and the 77% insect male-heterogamety figure ([Blackmon & Demuth 2015, Finding 1](/knowledge/papers/10_1016_j_cois_2014_12_003/#finding-1)) are broadly consistent, but both rest on taxonomically uneven sampling frames. The 2022 synthesis explicitly acknowledges that female heterogamety is "undoubtedly an under-estimate," meaning ZW prevalence could be substantially higher than current records suggest.

The Coleoptera statistics ([Drift drives the evolution 2024, Finding 1](/knowledge/papers/10_1093_jhered_esae001/#finding-1)) face an analogous sampling problem: family-level variance in chromosome number correlates with record count (r = 0.41), indicating that rare or understudied families are not adequately represented, so the reported means and modes may reflect karyotyping effort as much as biological reality.

The Amphibian Karyotype Database's 2,124 records are heavily skewed toward frogs, with caecilians particularly undersampled (45 records). Any macroevolutionary inference built on these databases must account for ascertainment bias — both taxonomic and methodological.

## Tealc's citation-neighborhood suggestions

- White (1973) *Animal Cytology and Evolution* — the foundational text for insect karyotype cataloguing against which database efforts are benchmarked.
- Pennell et al. (2015) *Tree of Sex: A comprehensive database of sexual reproduction* — the primary database paper underlying the insect statistics cited here.
- Bachtrog et al. (2014) *Sex determination: Why so many ways of doing it?* — broad comparative framework situating database findings within theory.
- Bogart (1980) / Duellman & Trueb (1986) — earlier amphibian karyotype compilations against which the 2019 database expansion is benchmarked.

## Related on the Blackmon Lab site

- [Blackmon & Demuth 2015](/knowledge/papers/10_1016_j_cois_2014_12_003/)
- [Paper: 2019 amphibs](/knowledge/papers/10_1007_s10577_019_09613_1/)
- [Paper: 2022 why not](/knowledge/papers/10_1038_s41437_022_00543_z/)
- [Paper: 2024 drift beetles](/knowledge/papers/10_1093_jhered_esae001/)
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
## Related topics on this site

- [Karyotype evolution overview](/knowledge/topics/karyotype_evolution_overview/) — 2 shared papers
- [Sex chromosome evolution](/knowledge/topics/sex_chromosome_evolution/) — 2 shared papers
- [Y-naught asymmetry](/knowledge/topics/y_naught_asymmetry/) — 2 shared papers
<!-- tealc:related-end -->
