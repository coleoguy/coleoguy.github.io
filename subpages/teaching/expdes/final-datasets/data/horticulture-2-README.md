# First bloom in container marigolds

Data file: `horticulture-2.csv`

Each row is one marigold plant grown in a separately tended container. Shade cloth type was randomly assigned to containers in the simulated study.

Simulated data; 156 observations. No real people, specimens, or institutions are represented.

## Variables

- `bloomed_by_day_30`: Whether the plant had an open flower by day 30 (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `initial_leaf_area_cm2`: Initial total leaf area in square centimeters. Continuous predictor.
- `vegetative_height_cm`: Vegetative height at the first measurement in centimeters. Continuous predictor.
- `shade_cloth`: Cloth treatment assigned to the container. Categorical predictor. Levels: `none`, `light`, `moderate`.
- `pot_inner_diameter_cm`: Interior pot diameter in centimeters. Continuous predictor.
