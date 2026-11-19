# Mapped-read yield in plant archives

Data file: `genomics-1.csv`

Each row summarizes one existing sequencing library from a distinct archived birch specimen. Recording the library source type was observational.

Simulated data; 82 observations. No real people, specimens, or institutions are represented.

## Variables

- `mapped_pct`: Fraction of reads mapped to the reference, as a percent. Continuous response.
- `queue_hours`: Elapsed instrument queue time (hours). Continuous predictor.
- `extract_ph`: Recorded extract pH (unitless). Continuous predictor.
- `specimen_type`: Type of archived source sample. Categorical predictor. Levels: `pressed_leaf`, `silica_leaf`.
- `fragment_median_bp`: Median fragment length (base pairs). Continuous predictor.
