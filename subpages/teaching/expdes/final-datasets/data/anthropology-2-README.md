# Surface preservation on experimental pottery

Data file: `anthropology-2.csv`

Each row represents a separately made ceramic replica placed in a different simulated burial container. The vessels were randomly assigned burial media before evaluation for surface damage.

Simulated data; 158 observations. No real people, specimens, or institutions are represented.

## Variables

- `rim_pitting`: Whether visible rim pitting was scored after burial (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `burial_medium`: Assigned burial medium. Categorical predictor. Levels: `sand`, `silt`, `mixed`.
- `initial_circumference_cm`: Initial rim circumference (cm). Continuous predictor.
- `water_content_pct`: Mean volumetric water content in the container (percent). Continuous predictor.
- `wall_thickness_mm`: Rim wall thickness before burial (mm). Continuous predictor.
