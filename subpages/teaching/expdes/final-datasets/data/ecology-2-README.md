# Native forb establishment in old fields

Data file: `ecology-2.csv`

Each row is a separate, widely spaced old-field plot. Plots were randomly assigned mulch treatments and were scored for the focal native forb at the end of the season.

Simulated data; 170 observations. No real people, specimens, or institutions are represented.

## Variables

- `established`: Whether at least one focal forb plant established (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `soil_ph`: Pretreatment soil pH. Continuous predictor.
- `mulch_treatment`: Assigned mulch type. Categorical predictor. Levels: `none`, `leaf_litter`, `straw`.
- `light_pct`: Midday light at soil surface before treatment (percent of open-field light). Continuous predictor.
- `litter_depth_mm`: Pretreatment depth of naturally accumulated litter (mm). Continuous predictor.
