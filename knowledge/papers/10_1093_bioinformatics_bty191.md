---
layout: default
title: "10.1093/bioinformatics/bty191"
doi: "10.1093/bioinformatics/bty191"
fingerprint_sha256: e7bd86e8fef8cc79d9ebe32c0927ef45ee86b5db4478c0f789ad6861c9e995ff
authors: ""
journal: ""
year: 
topics: [RNA_seq, bioinformatics_tools, chaining_algorithm, long_read_sequencing, sequence_alignment]
tier: canon
ingested_at: 2026-04-22T13:08:03.864894+00:00
permalink: /knowledge/papers/10_1093_bioinformatics_bty191/
---
# 10.1093/bioinformatics/bty191

<!-- tealc:freshness-start -->
<aside class="wiki-freshness" aria-label="Source paper provenance">
<span class="wf-label">Source paper</span>
<span class="wf-date">ingested 2026-04-22</span>
<span class="wf-dot">·</span>
<span class="wf-sources">2 findings extracted</span>
<span class="wf-dot">·</span>
<span class="wf-review">fingerprint e7bd86e8</span>
</aside>
<!-- tealc:freshness-end -->


## Summary

_Ingested 2026-04-22. 2 findings extracted and verified._

## Findings worth citing

<a id="finding-1"></a>
### Finding 1 — Minimap2 achieves 94.0% exact intron accuracy on real ONT mouse cDNA reads, outperforming GMAP (83.8%) and SpAln (87.9%), while running over 40 times faster than either tool.

> In general, minimap2 is more consistent with existing annotations (Table 1): it finds more junctions with a higher percentage being exactly or approximately correct. Minimap2 is over 40 times faster than GMAP and SpAln.
— p. 5

*Why this is citable:* This finding establishes minimap2 as the preferred tool for spliced alignment of long noisy ONT reads, a task relevant to any study using long-read RNA-seq to characterize gene structure or alternative splicing. The speed and accuracy advantages are documented on a real mouse cDNA dataset.

*Counter / limitation:* The comparison is limited to a single mouse cDNA dataset with R9.4 ONT chemistry, and the authors themselves note that GMAP and SpAln were not optimized for noisy reads, meaning their performance with tuned parameters could be higher; the finding may not generalize to SMRT or future ONT chemistries.

*Topics:* [Sequence Alignment](/knowledge/topics/sequence_alignment/), [Long Read Sequencing](/knowledge/topics/long_read_sequencing/), [RNA_seq](/knowledge/topics/RNA_seq/), [Bioinformatics Tools](/knowledge/topics/bioinformatics_tools/)

<a id="finding-2"></a>
### Finding 2 — For long-read genomic alignment, minimap2's chaining algorithm alone is more accurate than all other long-read mappers tested, before any base-level alignment is applied.

> In fact, chaining alone is more accurate than all the other long-read mappers in Fig. 1a (data not shown). This accuracy helps to reduce downstream base-level alignment of candidate chains, which is still several times slower than chaining even with the Suzuki-Kasahara improvement.
— p. 5

*Why this is citable:* This finding highlights that minimap2's chaining algorithm is the primary driver of its accuracy advantage over competing long-read mappers, not just the downstream DP alignment step, which is important for researchers evaluating or extending the tool's algorithmic design.

*Counter / limitation:* The chaining-accuracy claim is based on unpublished supplementary data ('data not shown'), making independent verification impossible; additionally, the comparison is limited to simulated human reads, which may not reflect performance on more repeat-rich, non-human, or highly divergent genomes.

*Topics:* [Sequence Alignment](/knowledge/topics/sequence_alignment/), [Long Read Sequencing](/knowledge/topics/long_read_sequencing/), [Chaining Algorithm](/knowledge/topics/chaining_algorithm/), [Bioinformatics Tools](/knowledge/topics/bioinformatics_tools/)

<!-- tealc:related-start -->
## Read the paper

[doi.org/10.1093/bioinformatics/bty191](https://doi.org/10.1093/bioinformatics/bty191)
<!-- tealc:related-end -->
