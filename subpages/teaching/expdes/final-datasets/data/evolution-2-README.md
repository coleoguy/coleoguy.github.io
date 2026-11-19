# Seed dispersal from contrasting habitats

Data file: `evolution-2.csv`

One row represents one seed from a different maternal plant in a simulated common wind tunnel assay. The source habitat was observed.

Simulated data; 165 observations. No real people, specimens, or institutions are represented.

## Variables

- `cleared_marker`: Whether the seed passed the target distance (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `maternal_height_cm`: Height of the source plant (cm). Continuous predictor.
- `tunnel_humidity_pct`: Relative humidity during the assay (percent). Continuous predictor.
- `source_habitat`: Habitat where the maternal plant grew. Categorical predictor. Levels: `grassland`, `dune`, `scrub`.
- `wing_loading_mg_cm2`: Seed mass divided by wing area (mg per square cm). Continuous predictor.
