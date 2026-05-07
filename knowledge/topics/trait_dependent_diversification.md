---
layout: default
title: "Trait Dependent Diversification"
topic_slug: trait_dependent_diversification
last_updated: 2026-04-22T13:13:52.436752+00:00
papers_supporting: [10.1093/sysbio/syu131]
permalink: /knowledge/topics/trait_dependent_diversification/
category: "Bioinformatics & tools"
---
<!-- tealc:lead-start -->
<div class="wiki-lead" data-active="researcher">
<div data-register="researcher" markdown="1">

Methods that test whether a binary character state is associated with shifts in speciation or extinction rates — BiSSE being the most widely used — are vulnerable to a specific and severe failure mode: elevated Type I error driven by background diversification heterogeneity in the phylogeny, entirely independent of any real trait effect. The problem is not subtle. On the empirical cetacean phylogeny, more than 77% of 400 neutral character datasets simulated with no state-dependent diversification at all returned a statistically significant BiSSE result (p < 0.05), and 58% cleared the p < 0.001 threshold ([10.1093/sysbio/syu131, Finding 1](/knowledge/papers/10_1093_sysbio_syu131/#finding-1)). That phylogeny is not pathological — it has a well-documented dolphin radiation, the kind of diversification heterogeneity present in most large empirical trees.

The taxon-name-length experiment makes the case as cleanly as possible: across vertebrate subtrees, a character defined purely by the number of letters in a species' binomial showed a significant correlation with speciation rate in more than 69% of trees, climbing toward 100% for ray-finned fishes ([10.1093/sysbio/syu131, Finding 2](/knowledge/papers/10_1093_sysbio_syu131/#finding-2)). Name length cannot cause speciation. The false positives cannot be attributed to biological confounding. They reflect the mismatch between what BiSSE's likelihood assumes — a single pair of diversification rates per character state — and the rate variation actually present in large, empirically estimated phylogenies.

The implication is that a large fraction of published BiSSE-based conclusions may be spurious, and any single significant result from an unmodified BiSSE analysis on a diverse clade warrants skepticism. Whether hidden-state extensions (HiSSE, MuSSE variants) adequately correct the problem, and whether model-adequacy tests can be made routine enough to be trusted across the breadth of empirical applications, remain open questions.

</div>
<div data-register="student" markdown="1">

<div class="wiki-lead" data-active="student">
<div data-register="student" markdown="1">

When biologists want to know whether a trait — like body size or coloration — affects how quickly a group of organisms splits into new species, they often use a statistical method called [BiSSE](/knowledge/concepts/bisse/) (Binary State Speciation and Extinction). The method compares how fast species diversify when they have one version of the trait versus another. The problem is that BiSSE can give false positives — it can say a trait matters when it actually doesn't.

The failure happens because real phylogenies (evolutionary family trees) have uneven branching: some groups radiate (split rapidly) while others don't, and BiSSE doesn't account for this messy reality well enough. On a real dolphin phylogeny, more than 77% of 400 fake datasets with no trait effect at all still came back statistically significant (p < 0.05), and 58% crossed the even stricter p < 0.001 threshold ([10.1093/sysbio/syu131, Finding 1](/knowledge/papers/10_1093_sysbio_syu131/#finding-1)). That dolphin tree is not unusual — it just has the kind of [diversification](/knowledge/concepts/diversification/) bumps that most big real trees do.

The cleanest proof comes from an odd experiment: researchers defined a character purely by how many letters are in a species' scientific name. Across vertebrate subtrees, name length showed a significant link to speciation rate in more than 69% of trees, rising toward 100% for ray-finned fishes ([10.1093/sysbio/syu131, Finding 2](/knowledge/papers/10_1093_sysbio_syu131/#finding-2)). Name length cannot cause speciation. This shows the false positives come from BiSSE's poor fit to real trees, not from hidden biology. Many published results using BiSSE may be wrong.

</div>
</div>

</div>
</div>
<!-- tealc:lead-end -->

<!-- tealc:auto-start -->
# Trait Dependent Diversification

<!-- tealc:freshness-start -->
<aside class="wiki-freshness" aria-label="Page provenance">
<span class="wf-label">Composed by Tealc</span>
<span class="wf-date">2026-04-22</span>
<span class="wf-dot">·</span>
<span class="wf-sources">1 source</span>
<span class="wf-dot">·</span>
<span class="wf-review">Last reviewed by Heath: never</span>
</aside>
<!-- tealc:freshness-end -->


## Current understanding

Methods that test whether a binary character state is associated with shifts in speciation or extinction rates — BiSSE being the most widely used — are vulnerable to a specific and severe failure mode: elevated Type I error driven by background diversification heterogeneity in the phylogeny, entirely independent of any real trait effect. The problem is not subtle. On the empirical cetacean phylogeny, more than 77% of 400 neutral character datasets simulated with no state-dependent diversification at all returned a statistically significant BiSSE result (p < 0.05), and 58% cleared the p < 0.001 threshold ([10.1093/sysbio/syu131, Finding 1](/knowledge/papers/10_1093_sysbio_syu131/#finding-1)). That phylogeny is not pathological — it has a well-documented dolphin radiation, the kind of diversification heterogeneity present in most large empirical trees.

The taxon-name-length experiment makes the case as cleanly as possible: across vertebrate subtrees, a character defined purely by the number of letters in a species' binomial showed a significant correlation with speciation rate in more than 69% of trees, climbing toward 100% for ray-finned fishes ([10.1093/sysbio/syu131, Finding 2](/knowledge/papers/10_1093_sysbio_syu131/#finding-2)). Name length cannot cause speciation. The false positives cannot be attributed to biological confounding. They reflect the mismatch between what BiSSE's likelihood assumes — a single pair of diversification rates per character state — and the rate variation actually present in large, empirically estimated phylogenies.

The implication is that a large fraction of published BiSSE-based conclusions may be spurious, and any single significant result from an unmodified BiSSE analysis on a diverse clade warrants skepticism. Whether hidden-state extensions (HiSSE, MuSSE variants) adequately correct the problem, and whether model-adequacy tests can be made routine enough to be trusted across the breadth of empirical applications, remain open questions.

## Supporting evidence

- [10.1093/sysbio/syu131, Finding 1](/knowledge/papers/10_1093_sysbio_syu131/#finding-1): On the cetacean phylogeny, 77%+ of neutral character datasets produced a significant BiSSE result; 58% rejected the character-independent model at p < 0.001.
- [10.1093/sysbio/syu131, Finding 2](/knowledge/papers/10_1093_sysbio_syu131/#finding-2): Taxon name length — a biologically meaningless character — returned significant state-dependent diversification in >69% of vertebrate subtrees and in nearly all ray-finned fish subtrees (60 of 61).

## Contradictions / open disagreements

The cetacean result may overstate the typical false positive rate. The dolphin radiation creates unusually sharp diversification heterogeneity, and on phylogenies with more homogeneous background rates the error rate could be substantially lower. Additionally, the taxon-name-length character is not a perfectly clean null: congeners share name prefixes, so the character carries residual phylogenetic signal. Some portion of the inflated error rate in ray-finned fishes may trace to that structure rather than to diversification heterogeneity alone. Neither caveat undermines the core finding, but both mean the reported error rates should be treated as upper bounds for the specific clades tested rather than universal constants.

## Tealc's citation-neighborhood suggestions

- Maddison & FitzJohn (2015, Syst. Biol.) on the many-to-one problem in SSE methods.
- Beaulieu & O'Meara (2016) introducing HiSSE as a hidden-state correction.
- Rabosky (2014) on BAMM and heterogeneous diversification as a baseline issue.

## Related on the Blackmon Lab site

- [Meiotic Drive and Karyotype Evolution](/knowledge/papers/10_1093_sysbio_syu131/) — paper permalink for the syu131 findings used on this page.
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
<!-- tealc:related-end -->
