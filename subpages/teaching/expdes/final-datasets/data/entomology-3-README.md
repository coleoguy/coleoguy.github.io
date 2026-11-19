# Firefly flash timing

Data file: `entomology-3.csv`

Each row is a flash interval averaged for one marked male firefly from a different meadow plot. The shade category was observed and no individual was used in more than one row.

Simulated data; 68 observations. No real people, specimens, or institutions are represented.

## Variables

- `flash_interval_s`: Mean seconds between flashes during the observation. Continuous response.
- `moon_illumination_pct`: Fraction of the lunar disk illuminated (percent). Continuous predictor.
- `air_temp_c`: Local air temperature (degrees C). Continuous predictor.
- `nearby_grass_height_cm`: Mean nearby grass height (cm). Continuous predictor.
- `shade_class`: Canopy cover class at the point of observation. Categorical predictor. Levels: `open`, `partial`.
