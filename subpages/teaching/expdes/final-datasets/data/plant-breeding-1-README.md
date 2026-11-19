# Sorghum dry-lot seed size comparison

Data file: `plant-breeding-1.csv`

Each row is one simulated breeding plot established from a different sorghum family. Plots were randomly assigned a row spacing within a common site; measured plot summaries are used.

Simulated data; 90 observations. No real people, specimens, or institutions are represented.

## Variables

- `grain_mass_g_1000`: Mass of a 1,000-grain subsample in grams. Continuous response.
- `seedling_height_cm`: Mean plot seedling height at the early assessment in centimeters. Continuous predictor.
- `flowering_day`: Days from emergence until half the plot had flowered. Continuous predictor.
- `plot_edge_gap_cm`: Distance from the measured row to the plot border in centimeters. Continuous predictor.
- `row_spacing`: Randomly assigned row spacing category. Categorical predictor. Levels: `narrow`, `wide`.
