---
layout: default
title: "RAxML — Randomized Axelerated Maximum Likelihood"
method_slug: raxml
language: C
package: raxml-ng
depends_on_concepts: []
appears_in_topics: []
appears_in_papers: []
difficulty: intermediate
last_updated: 2026-04-29
permalink: /knowledge/methods/raxml/
---
# RAxML — Randomized Axelerated Maximum Likelihood

<!-- tealc:method-start -->
**What it does.** RAxML searches for the maximum-likelihood phylogenetic tree from a multiple-sequence alignment under an explicit substitution model (e.g. GTR+GAMMA for nucleotides, LG or WAG for amino acids). It accepts aligned FASTA or PHYLIP input and returns a best-scoring tree together with bootstrap support values. The search uses randomized stepwise addition parsimony starting trees combined with SPR (subtree pruning and regrafting) moves to escape local optima. The canonical modern implementation is [RAxML-NG](https://github.com/amkozlov/raxml-ng), which replaces the original `raxmlHPC` binaries.

**When to use it.**
- You have a nucleotide or amino-acid alignment and need a single best-scoring ML tree with bootstrap support under a standard substitution model.
- Your alignment is large (hundreds to thousands of taxa) and you need a faster alternative to fully Bayesian methods such as MrBayes or BEAST.
- You want to compare competing topologies with likelihood-ratio or AU tests; RAxML-NG outputs per-site log-likelihoods suitable for those tests.
- You are building gene trees for downstream species-tree inference (e.g. ASTRAL) and need batch tree estimation across many loci.
- You have a partitioned alignment (multi-locus or mixed data types) and need per-partition model fitting.

**When NOT to use it.**
- You need divergence-time estimates or a posterior distribution of trees — use BEAST or MrBayes instead.
- Your alignment has fewer than ~4 taxa; the search landscape is trivial and any parsimony tool suffices.
- You need to model complex macroevolutionary rate heterogeneity along branches (use RevBayes or a birth-death framework).
- Your data are SNP matrices with invariant-site patterns; use the `+ASC` correction or switch to IQ-TREE, which handles ascertainment bias more transparently.
- You require a graphical interface or interactive tree annotation — downstream tools such as FigTree or iTOL are better suited for that.
<!-- tealc:method-end -->

<!-- tealc:example-start -->
## Worked example

```bash
# Minimal RAxML-NG run: ML search + 100 bootstrap replicates
# Input: aligned FASTA file (DNA, GTR+GAMMA model)
# Replace 'alignment.fasta' with your file; adjust --threads to your machine.

raxml-ng \
  --all \                        # combined ML search + bootstrap in one call
  --msa alignment.fasta \        # input multiple-sequence alignment
  --model GTR+G \                # substitution model (GTR + discrete GAMMA)
  --prefix results/my_tree \     # all output files share this prefix
  --seed 12345 \                 # reproducibility
  --threads 4 \                  # parallelism; auto-detected with --threads auto
  --bs-trees 100                 # number of bootstrap replicates

# Key output files:
#   results/my_tree.raxml.bestTree       — best ML tree (Newick)
#   results/my_tree.raxml.support        — best tree annotated with BS support
#   results/my_tree.raxml.log            — per-iteration likelihood trace
#   results/my_tree.raxml.bootstraps     — all 100 bootstrap trees (for ASTRAL)

# Quick sanity check: inspect the final log-likelihood in the log file.
grep "Final LogLikelihood" results/my_tree.raxml.log
# A value that improves monotonically across runs indicates a stable optimum.
```
<!-- tealc:example-end -->

<!-- tealc:gotchas-start -->
## Gotchas we've hit

- **Alignment check fails silently on duplicate sequence names.** RAxML-NG exits with a cryptic parse error; deduplicate sequence IDs before running (`awk '/^>/{seen[$0]++; if(seen[$0]>1) skip=1; else skip=0} !skip' alignment.fasta`).
- **`--model GTR+G` vs. `GTR+G4`:** the default number of rate categories is 4; if you previously used `raxmlHPC` with 4 categories, the new flag syntax is `GTR+G4` for exact reproducibility across versions.
- **Bootstrap convergence warnings ignored.** RAxML-NG will warn when bootstrap trees have not converged (MRE-based test); running 100 replicates without checking this message can produce under-supported trees on large, poorly resolved alignments — increase `--bs-trees` or inspect the convergence log.
- **Partitioned models with very small partitions.** A partition with fewer columns than free model parameters causes RAxML-NG to crash or produce nonsense likelihoods; merge small partitions or use a simpler model (e.g. `GTR+G` → `HKY+G`) for affected loci.
<!-- tealc:gotchas-end -->

<!-- tealc:papers-start -->
## Key papers that use this method in the lab

*No lab papers ingested yet — this page will update as papers are added to /knowledge/papers/.*
<!-- tealc:papers-end -->

<!-- user-start -->
<!-- user-end -->
