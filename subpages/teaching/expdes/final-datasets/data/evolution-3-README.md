# Jaw mechanics in lake fish

Data file: `evolution-3.csv`

One row represents an adult fish, with one fish sampled from each independent lake. Feeding guild was assigned from natural-history observations, not manipulated.

Simulated data; 73 observations. No real people, specimens, or institutions are represented.

## Variables

- `jaw_leverage_ratio`: Lower-jaw closing mechanical advantage (dimensionless ratio). Continuous response.
- `lake_elevation_m`: Elevation of the sampling lake (m). Continuous predictor.
- `feeding_guild`: Predominant feeding guild of the sampled fish. Categorical predictor. Levels: `benthic`, `pelagic`.
- `water_conductivity_us_cm`: Conductivity at capture (microsiemens per cm). Continuous predictor.
- `body_length_mm`: Standard body length (mm). Continuous predictor.
