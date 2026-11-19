# Stormwater sediment and duckweed cover

Data file: `toxicology-7.csv`

Each row is a single simulated monitoring visit to a distinct rain garden. Outlet design was observed rather than assigned; no garden was revisited.

Simulated data; 66 observations. No real people, specimens, or institutions are represented.

## Variables

- `duckweed_cover_pct`: Percent of the surveyed water surface covered by duckweed. Continuous response.
- `sediment_depth_cm`: Median deposited sediment depth in centimeters. Continuous predictor.
- `surface_area_m2`: Water surface area within the garden in square meters. Continuous predictor.
- `outlet_design`: Outlet design observed in the rain garden. Categorical predictor. Levels: `notch`, `standpipe`, `spillway`.
- `survey_hours_after_rain`: Hours between the end of the storm and the survey. Continuous predictor.
