# Leaf water status after a short dry spell

Data file: `physiology-2.csv`

Each row corresponds to one plant grown in a separate pot, sampled once. Pot cover was randomly assigned. Soil moisture was measured just before leaf sampling.

Simulated data; 70 observations. No real people, specimens, or institutions are represented.

## Variables

- `leaf_water_potential_mpa`: Midday leaf water potential, in MPa (values below zero). Continuous response.
- `instrument_temp_c`: Temperature of the instrument at measurement, in °C. Continuous predictor.
- `pot_cover`: Assigned cover over the soil surface. Categorical predictor. Levels: `open`, `mesh`, `solid`.
- `label_width_mm`: Width of the plant label, in mm. Continuous predictor.
- `soil_moisture_pct`: Volumetric soil moisture, in percentage points. Continuous predictor.
