# Winter survival among forage rye lines

Data file: `plant-breeding-3.csv`

Each row is one simulated field plot planted with a different rye line. Seedbed finish was randomly assigned to plots, and winter survival was scored once per plot.

Simulated data; 180 observations. No real people, specimens, or institutions are represented.

## Variables

- `stand_survived`: Whether at least 70% of the original stand survived late winter (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `drill_row_gap_cm`: Measured space between adjacent drill rows in centimeters. Continuous predictor.
- `early_leaf_length_cm`: Mean early leaf length in centimeters. Continuous predictor.
- `seedbed_finish`: Finishing treatment assigned to the plot. Categorical predictor. Levels: `rolled`, `unrolled`.
- `crown_diameter_mm`: Mean early-season crown diameter in millimeters. Continuous predictor.
