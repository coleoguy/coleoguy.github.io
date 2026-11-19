# Floor-egg incidence and nest features

Data file: `poultry-science-2.csv`

Each row is a simulated summary from a different laying-hen pen. Nest-box layout was observed; a pen was assessed once.

Simulated data; 150 observations. No real people, specimens, or institutions are represented.

## Variables

- `floor_egg`: Whether any egg laid outside the nest box was found at the visit (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `nest_layout`: Nest-box layout observed in the pen. Categorical predictor. Levels: `single_row`, `stacked`, `corner`.
- `wall_height_cm`: Height of the partition wall in centimeters. Continuous predictor.
- `entry_light_lux`: Illuminance measured at the nest entrance in lux. Continuous predictor.
- `perch_diameter_cm`: Diameter of the pen's main perch in centimeters. Continuous predictor.
