---
layout: default
title: "Genome Assembly"
topic_slug: genome_assembly
last_updated: 2026-04-21T19:10:10.973996+00:00
papers_supporting: [10.1002/ece3.73483, 31776037050f6b89b93887fa1b80196fd30073325900b9b38adb091f0516948d]
permalink: /knowledge/topics/genome_assembly/
category: "Genome structure"
---<!-- tealc:auto-start -->
# Genome Assembly

<!-- tealc:freshness-start -->
<aside class="wiki-freshness" aria-label="Page provenance">
<span class="wf-label">Composed by Tealc</span>
<span class="wf-date">2026-04-21</span>
<span class="wf-dot">·</span>
<span class="wf-sources">2 sources</span>
<span class="wf-dot">·</span>
<span class="wf-review">Last reviewed by Heath: never</span>
</aside>
<!-- tealc:freshness-end -->


## Current understanding

Chromosome-level genome assemblies — those in which sequencing contigs are scaffolded into chromosome-scale sequences — have become an essential tool for connecting raw sequence data to cytogenetic and evolutionary inference. A high-quality assembly allows researchers to count chromosomes, identify sex-linked scaffolds, and compare genome architecture across taxa without relying solely on traditional karyotyping. The quality of such assemblies is typically validated by cross-referencing scaffold counts and sizes against established cytogenetic data, and by computing completeness metrics such as BUSCO scores. A recurring finding is that a small number of large scaffolds capture the vast majority of genomic content, with hundreds of smaller scaffolds representing residual, often repetitive, sequence.

## Supporting evidence

Two chromosome-level assemblies of scarab beetles (Coleoptera: Scarabaeidae) illustrate these principles. The assembly of the endemic and endangered long-armed scarab *Cheirotonus formosanus* used Hi-C contact mapping to scaffold sequence into 10 primary large scaffolds — 9 autosomes plus an X chromosome — directly consistent with the modal Coleoptera karyotype of 2n = 20 (9AA + XY). As its authors note, "The final corrected contact map displayed 10 primary large scaffolds, including 9 autosomes and X chromosomes. This genetic architecture is highly consistent with known cytogenetic data for the group. The majority of Coleoptera possess a diploid number of 2n = 20 (9AA + XY)." This demonstrates that modern long-read sequencing combined with Hi-C scaffolding can recover biologically interpretable chromosome structure in non-model organisms (see [Chien et al. 2026, Finding 1](/knowledge/papers/10_1002_ece3_73483/#finding-1)).

The first chromosome-level assembly for the genus *Chrysina* — based on *Chrysina gloriosa* — further illustrates expected assembly characteristics. The assembly spans 642 MB across 454 scaffolds, with the 10 largest scaffolds alone capturing 98% of the genome, a scaffold N50 of 72 MB, and a BUSCO score of 95.5% ([A reference quality genome 2024, Finding 1](/knowledge/papers/10_1093_g3journal_jkae084/#finding-1)). This pattern, where a handful of chromosome-scale scaffolds dominate the assembly while hundreds of minor scaffolds account for a small fraction of sequence, is consistent with what is expected when long-read technologies successfully resolve chromosome-scale structure. The high BUSCO completeness further indicates that gene-space is well represented despite residual fragmentation.

## Contradictions / open disagreements

Two important caveats complicate interpreting assembly statistics at face value. First, in the *C. formosanus* case, chromosome number is inferred indirectly from Hi-C contact patterns and consistency with relatives rather than from direct cytogenetic counts on the focal species. If direct chromosome counts were to differ from the inferred 2n = 20, the scaffold-to-chromosome correspondence would need to be revisited.

Second, the *C. gloriosa* assembly (642 MB) is notably smaller than flow-cytometry-based genome size estimates (~850 MB) for the species. The authors attribute this discrepancy to unassembled repetitive content — a common limitation of current long-read approaches. This means that BUSCO scores and scaffold N50 values, while informative about gene-space completeness and contiguity, do not fully capture how much of a genome, particularly its repetitive fraction, has actually been assembled. Both cases underscore a broader methodological tension: assembly-based inference is powerful but benefits from orthogonal validation via cytogenetics and independent genome size estimation.

## Tealc's citation-neighborhood suggestions

Future work on this topic would benefit from comparative studies formally benchmarking Hi-C-based chromosome assignment against cytogenetic squash preparations, as well as broader surveys of chromosome-level Coleoptera assemblies that contextualize individual results within a larger phylogenetic framework. Studies specifically comparing flow-cytometry estimates to final assembly sizes across insects would help quantify the "repeatome gap" systematically.

## Related on the Blackmon Lab site

- [Chien et al. 2026](/knowledge/papers/10_1002_ece3_73483/)
- [Paper detail page: 2024 Chrysina](/knowledge/papers/10_1093_g3journal_jkae084/)
<!-- tealc:auto-end -->

<!-- tealc:related-start -->
## Related topics on this site

- [Coleoptera genomics](/knowledge/topics/coleoptera_genomics/) — 2 shared papers
- [Conservation Genomics](/knowledge/topics/conservation_genomics/) — 2 shared papers
<!-- tealc:related-end -->
