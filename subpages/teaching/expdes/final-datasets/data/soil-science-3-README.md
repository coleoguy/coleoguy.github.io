# Soil water retention in reconstructed profiles

Data file: `soil-science-3.csv`

Each row is one independently packed soil column in a simulated laboratory comparison. Surface residue type was randomly assigned, and each column was measured once.

Simulated data; 63 observations. No real people, specimens, or institutions are represented.

## Variables

- `water_content_pct`: Volumetric water content as a percentage after drainage. Continuous response.
- `clay_pct`: Measured clay content as a percentage of the soil mass. Continuous predictor.
- `column_diameter_cm`: Measured internal column diameter in centimeters. Continuous predictor.
- `soil_fill_height_cm`: Depth of packed soil in the column in centimeters. Continuous predictor.
- `residue`: Surface residue assigned to the column. Categorical predictor. Levels: `grass`, `leaf_litter`, `none`.
