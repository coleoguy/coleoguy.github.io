# High-confidence orchid genotypes

Data file: `genomics-2.csv`

Each row describes one archived sequencing library from a different wild orchid plant. Read summaries and tissue source came from existing records.

Simulated data; 170 observations. No real people, specimens, or institutions are represented.

## Variables

- `call_pass`: Whether the focal marker met the laboratory genotype call confidence rule (1 pass, 0 fail). Binary response. 0 = criterion not met; 1 = criterion met.
- `archive_age_months`: Time archived before data review (months). Continuous predictor.
- `marker_depth`: Mean coverage at the focal marker (reads per position). Continuous predictor.
- `tissue_source`: Recorded source tissue. Categorical predictor. Levels: `leaf`, `flower`, `stem`.
- `median_gc_pct`: Median read GC percentage (percent). Continuous predictor.
