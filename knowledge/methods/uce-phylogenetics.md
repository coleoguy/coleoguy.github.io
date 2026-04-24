---
layout: default
title: "UCE phylogenetics — Ultraconserved element phylogenomics"
method_slug: uce-phylogenetics
language: Python
package: phyluce
depends_on_concepts: [sequence-alignment, phylogenomics, target-capture]
appears_in_topics: [bee_phylogenomics, uce_phylogenetics, sequencing_methods]
appears_in_papers: ["10_1093_jhered_esad076"]
difficulty: advanced
last_updated: 2026-04-23
permalink: /knowledge/methods/uce-phylogenetics/
---
<!-- tealc:method-start -->
# UCE phylogenetics

**What it does.** Ultraconserved elements (UCEs) are highly conserved genomic regions shared across distantly related taxa that can be captured using sequence-specific bait sets and sequenced via target-enrichment. The `phyluce` pipeline (Faircloth 2016) handles the full workflow from read trimming through locus alignment and supermatrix or coalescent-based tree estimation. UCE datasets routinely yield hundreds to thousands of parsimony-informative loci per taxon, making them suitable for resolving both shallow and deep phylogenetic splits. In the lab, UCEs have been used to place newly assembled insect genomes into broad phylogenomic frameworks.

**When to use it.**
- You need phylogenomic resolution across divergent taxa (insects, arachnids, vertebrates) where single-gene markers are insufficient.
- You have a reference genome or UCE probe set available for your taxon group; probe sets exist for insects, fish, amphibians, birds, and many others.
- You can sequence moderate coverage (~10–20×) enrichment libraries from 10s–100s of taxa.
- You want a scalable, community-supported pipeline with extensive documentation.

**When NOT to use it.**
- Closely related populations or recently diverged species — UCEs are too conserved; use RADseq or whole-genome resequencing instead.
- You lack tissue or DNA of adequate quality for target enrichment (degraded museum specimens may recover few loci).
- Your target clade lacks an available probe set and you don't have a reference genome to design one from.
<!-- tealc:method-end -->

<!-- tealc:example-start -->
## Worked example

The snippet below covers the core steps using `phyluce` from raw trimmed reads. Assumes conda environment `phyluce` is active.

```bash
# ---- 1. Trim reads (illumiprocessor wraps trimmomatic) ----
illumiprocessor \
    --input raw-reads/ \
    --output trimmed-reads/ \
    --config illumiprocessor.conf \
    --cores 8

# ---- 2. Assemble per-sample (trinity or spades) ----
phyluce_assembly_assemblo_spades \
    --conf assembly.conf \
    --output spades-assemblies/ \
    --cores 8

# ---- 3. Find UCE loci in assemblies ----
# probes.fasta: UCE probe set for your taxon group (e.g. Hymenoptera 2.5k)
phyluce_assembly_match_contigs_to_probes \
    --contigs spades-assemblies/contigs \
    --probes probes.fasta \
    --output uce-search-results

# ---- 4. Extract UCE loci shared across a minimum number of taxa ----
# taxon-set.conf: lists the taxa to include
phyluce_assembly_get_match_counts \
    --locus-db uce-search-results/probe.matches.sqlite \
    --taxon-list-config taxon-set.conf \
    --taxon-group "all" \
    --incomplete-matrix \
    --output taxon-sets/

phyluce_assembly_get_fastas_from_match_counts \
    --contigs spades-assemblies/contigs \
    --locus-db uce-search-results/probe.matches.sqlite \
    --match-count-output taxon-sets/all.conf \
    --output taxon-sets/all.fasta \
    --incomplete-matrix \
    --log-path log

# ---- 5. Align UCE loci (mafft + edge-trimming) ----
phyluce_align_seqcap_align \
    --input taxon-sets/all.fasta \
    --output mafft-nexus-edge-trimmed \
    --taxa 119 \
    --aligner mafft \
    --cores 8 \
    --incomplete-matrix \
    --output-format fasta \
    --log-path log

# ---- 6. Filter loci by minimum taxon occupancy ----
phyluce_align_get_only_loci_with_min_taxa \
    --alignments mafft-nexus-edge-trimmed \
    --taxa 119 \
    --percent 0.75 \
    --output mafft-nexus-min75 \
    --log-path log

# ---- 7. Build supermatrix and run IQ-TREE ----
phyluce_align_concatenate_alignments \
    --alignments mafft-nexus-min75 \
    --output supermatrix \
    --phylip

iqtree -s supermatrix/supermatrix.phylip \
       -bb 1000 \
       -nt AUTO \
       -pre supermatrix/iqtree
```
<!-- tealc:example-end -->

<!-- tealc:gotchas-start -->
## Gotchas we've hit

- **Taxon occupancy vs matrix completeness trade-off.** A 75% occupancy threshold (a locus must be present in ≥75% of taxa) is a common default. Dropping to 50% gives more loci but more missing data; raising to 90% gives cleaner data but may leave too few loci for some taxa. Run sensitivity analyses at multiple thresholds if occupancy is uneven.
- **Probe set choice matters.** Don't use vertebrate probes on insects; off-target enrichment is poor. The Hymenoptera 2.5k probe set (or insect-specific sets) should be used for bees and wasps. Confirm probe compatibility by checking capture efficiency (mean loci per sample) before committing to a large project.
- **Assembly quality affects locus recovery.** SPAdes generally outperforms Trinity for UCE recovery in insects. If a sample recovers < 200 loci and others in the same run recover > 1000, check read quality, adapter trimming logs, and whether the sample was over- or under-pooled.
- **IQ-TREE vs coalescent (ASTRAL).** The supermatrix approach (IQ-TREE on the concatenated alignment) assumes all loci share the same tree topology. For datasets with many rapidly diverging lineages or potential hybridization, run ASTRAL on per-locus gene trees as a check.
- **All-bootstrap values ≥ 99% are suspicious.** UCE datasets with hundreds of loci can produce 100% UFBoot support even for incorrect nodes. Check for model violations (e.g., base composition heterogeneity across taxa) if every node gets 100% support.
<!-- tealc:gotchas-end -->

<!-- tealc:papers-start -->
## Key papers that use this method in the lab

- [Schweizer et al. 2024 — Reference genome for the Mojave poppy bee](/knowledge/papers/10_1093_jhered_esad076/) — uses 119-genome UCE analysis to place Perdita meconis within Apoidea, resolving it as sister to Andrena within Andrenidae with predominantly 100% UFBoot support.
<!-- tealc:papers-end -->

<!-- user-start -->
<!-- user-end -->
