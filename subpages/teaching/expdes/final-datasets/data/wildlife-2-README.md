# Songbird nest insulation

Data file: `wildlife-2.csv`

Each row is an unoccupied, previously used nest from a different territory. Nest support was observed, and all nests underwent the same non-destructive bench test.

Simulated data; 94 observations. No real people, specimens, or institutions are represented.

## Variables

- `cooling_rate_c_min`: Rate of cooling during the standard test (degrees C per minute). Continuous response.
- `holding_humidity_pct`: Relative humidity where nest was held before testing (percent). Continuous predictor.
- `wall_thickness_mm`: Average thickness around the nest wall (mm). Continuous predictor.
- `support_type`: Nest support formerly occupied by nest. Categorical predictor. Levels: `shrub`, `forked_tree`, `reed_clump`.
- `outer_diameter_cm`: Maximum external nest diameter (cm). Continuous predictor.
