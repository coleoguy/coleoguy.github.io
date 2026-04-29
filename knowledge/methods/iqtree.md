---
layout: default
title: "IQ-TREE — Maximum-Likelihood Phylogenies"
method_slug: iqtree
language: C++
package: iqtree2
depends_on_concepts: []
appears_in_topics: []
appears_in_papers: []
difficulty: intermediate
last_updated: 2026-04-29
permalink: /knowledge/methods/iqtree/
---
# IQ-TREE — Maximum-Likelihood Phylogenies

<!-- tealc:method-start -->
**What it does.** IQ-TREE infers maximum-likelihood phylogenies from multiple-sequence alignments (DNA, amino acid, or morphological characters). It expects an aligned input matrix — typically a FASTA or PHYLIP file — and returns a tree topology with branch lengths scaled in substitutions per site. The core inference uses a hill-climbing nearest-neighbor interchange (NNI) search seeded by a fast parsimony starting tree, combined with an extensive library of substitution models (including the automatic model-selection routine ModelFinder). Branch support can be estimated via ultrafast bootstrap (UFBoot) or the SH-aLRT test. The canonical implementation is `iqtree2`, written in C++.

**When to use it.**
- You have an aligned nucleotide or protein matrix and need a maximum-likelihood tree with branch support.
- Model selection is uncertain — ModelFinder (-m TEST or -m MFP) selects the best-fit model in the same run, avoiding a separate ProtTest/jModelTest step.
- Datasets are large (hundreds to low thousands of taxa) and Bayesian MCMC runtimes are prohibitive.
- You need ultrafast bootstrap approximations (UFBoot2) that are less prone to overestimation than standard nonparametric bootstrap.
- You are working with partitioned data (e.g. multi-gene alignments) and want per-partition models with a shared or unlinked tree.

**When NOT to use it.**
- You need a fully Bayesian posterior distribution over trees with meaningful branch-length priors — use MrBayes or BEAST instead.
- Your goal is divergence-time estimation with a relaxed clock — IQ-TREE can fix a topology for downstream dating, but the dedicated divergence-time pipeline belongs in BEAST2 or MCMCtree.
- Sequence alignments are poorly trimmed; IQ-TREE will run but the resulting tree will reflect alignment noise rather than phylogenetic signal — clean with trimAl or Gblocks first.
- You have very few taxa (fewer than ~10) — parsimony or distance methods are faster and equally informative at that scale.
<!-- tealc:method-end -->

<!-- tealc:example-start -->
## Worked example

```bash
# Minimal IQ-TREE 2 run for a DNA alignment with automatic model selection
# and ultrafast bootstrap support values.

# Input: aligned_sequences.fasta  — FASTA multiple-sequence alignment
# Output: aligned_sequences.fasta.treefile  — best ML tree (Newick)
#         aligned_sequences.fasta.iqtree    — run report with model info

# 1. Run model selection + tree search + 1000 ultrafast bootstrap replicates
iqtree2 \
    -s aligned_sequences.fasta \   # input alignment
    -m MFP \                       # ModelFinder Plus: select best model
    -B 1000 \                      # 1000 ultrafast bootstrap replicates
    -T AUTO \                      # auto-detect number of CPU threads
    --prefix output/mytree         # all output files share this prefix

# 2. (Optional) Add SH-aLRT branch test alongside UFBoot
iqtree2 \
    -s aligned_sequences.fasta \
    -m MFP \
    -B 1000 \
    --alrt 1000 \                  # 1000 SH-aLRT replicates
    -T AUTO \
    --prefix output/mytree_alrt

# 3. Inspect support values
# Best-tree file: output/mytree.treefile
# Node labels: SH-aLRT/UFBoot — e.g. "95/98" means 95% SH-aLRT, 98% UFBoot
# Nodes with UFBoot >= 95 AND SH-aLRT >= 80 are considered well-supported.

# 4. (Optional) Partitioned analysis for multi-gene matrix
# Create a partition file: partitions.nex (RAxML or NEXUS format)
iqtree2 \
    -s concat_alignment.fasta \
    -p partitions.nex \            # partition definitions
    -m MFP+MERGE \                 # merge partitions with similar rates
    -B 1000 \
    -T AUTO \
    --prefix output/partitioned
```
<!-- tealc:example-end -->

<!-- tealc:gotchas-start -->
## Gotchas we've hit

- **UFBoot values are not standard bootstrap percentages.** UFBoot2 converges faster but the scale differs — the recommended cutoff is ≥95 (not the classical ≥70), and even 100/100 nodes can occasionally be artefactual on very short internodes. Pair with SH-aLRT ≥80 for a second opinion.
- **ModelFinder selects BIC by default, not AIC.** For small alignments BIC can favour over-simple models; pass `-AIC` or `-AICc` explicitly if your alignment has fewer sites than parameters.
- **Thread auto-detection on HPC nodes can grab all available cores.** Set `-T` to the actual number of cores allocated in your job script; otherwise the run will compete with other jobs or trigger scheduler kills.
- **Partitioned runs with `-p` (linked branch lengths) vs. `-q` (unlinked) change tree topology, not just model fit.** Use `-p` unless you have a strong biological reason to decouple branch lengths across partitions; unlinked models frequently overfit.
- **Very long alignments with many invariant sites inflate rate estimates.** Use `-m MFP+ASC` correction only for morphological or SNP-only matrices where constant sites were explicitly removed; applying ASC to a standard genomic alignment with invariants will give wrong branch lengths.
<!-- tealc:gotchas-end -->

<!-- tealc:papers-start -->
## Key papers that use this method in the lab

*No lab papers ingested yet — this page will update as papers are added to /knowledge/papers/.*
<!-- tealc:papers-end -->

<!-- user-start -->
<!-- user-end -->
