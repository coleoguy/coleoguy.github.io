# Standability in selected dry bean lines

Data file: `plant-breeding-2.csv`

Each row is one experimental plot planted with a distinct breeding line. The simulated plots were randomly assigned a support treatment; a plot was scored once.

Simulated data; 168 observations. No real people, specimens, or institutions are represented.

## Variables

- `stands_at_harvest`: Whether at least 80% of the plot remained upright at harvest (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `early_canopy_width_cm`: Mean width of the young canopy in centimeters. Continuous predictor.
- `support`: Support option randomly assigned to the plot. Categorical predictor. Levels: `stakes`, `trellis`, `none`.
- `first_flower_day`: Days after emergence until the plot's first flower was noted. Continuous predictor.
- `mean_stem_diameter_mm`: Mean basal stem diameter in millimeters. Continuous predictor.
