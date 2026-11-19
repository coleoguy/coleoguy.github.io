# Retention of sediment under dune fencing

Data file: `conservation-3.csv`

Each row represents an isolated dune plot with an independently allocated fence design. The height change is relative to a surveyed baseline before the windy season.

Simulated data; 82 observations. No real people, specimens, or institutions are represented.

## Variables

- `surface_change_cm`: Final minus baseline mean sand surface elevation (cm; negative values are possible). Continuous response.
- `initial_footslope_deg`: Baseline slope angle at the dune foot (degrees). Continuous predictor.
- `wind_speed_m_s`: Mean wind speed during windy periods (m/s). Continuous predictor.
- `fence_design`: Randomly assigned sand-fence design. Categorical predictor. Levels: `single_row`, `staggered_rows`, `none`.
- `distance_to_shore_m`: Plot distance to high-water line (m). Continuous predictor.
