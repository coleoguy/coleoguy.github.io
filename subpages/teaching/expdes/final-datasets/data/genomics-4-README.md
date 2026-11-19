# Reference-panel interval matches

Data file: `genomics-4.csv`

Each record represents a single, randomly selected genomic interval from a different independently sampled sunflower accession. Panel labels were assigned from archival provenance before scoring.

Simulated data; 182 observations. No real people, specimens, or institutions are represented.

## Variables

- `match_found`: Whether the interval met the pre-established reference-match criterion (1 yes, 0 no). Binary response. 0 = criterion not met; 1 = criterion met.
- `assembly_source`: Archival panel annotation. Categorical predictor. Levels: `heritage`, `wild`, `modern`.
- `accession_age_months`: Time accession data had been cataloged (months). Continuous predictor.
- `interval_kb`: Length of interval queried (kb). Continuous predictor.
- `repeat_pct`: Repeat annotation in a neighboring interval (percent). Continuous predictor.
