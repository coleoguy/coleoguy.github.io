# Shell geometry across shore zones

Data file: `evolution-1.csv`

One row represents an adult periwinkle sampled from a different rocky-shore outcrop. Shore zone was observed, not assigned.

Simulated data; 84 observations. No real people, specimens, or institutions are represented.

## Variables

- `shell_ridge_height_mm`: Mean height of a shell ridge (mm). Continuous response.
- `wave_exposure_index`: Relative wave exposure at the outcrop (unitless index from 0 to 10). Continuous predictor.
- `rock_slope_deg`: Surface slope next to the snail (degrees). Continuous predictor.
- `shore_zone`: Intertidal zone where the individual was found. Categorical predictor. Levels: `low`, `middle`, `high`.
- `collection_temp_c`: Air temperature at collection (degrees C). Continuous predictor.
