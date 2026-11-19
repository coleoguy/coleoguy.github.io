# Seedling persistence on alpine microsites

Data file: `ecology-4.csv`

Each row follows one initially living seedling in a different alpine meadow plot to the end of summer. The microsite was observed, not assigned.

Simulated data; 151 observations. No real people, specimens, or institutions are represented.

## Variables

- `survived_summer`: Whether the tagged seedling was alive at the late-summer census (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `slope_deg`: Slope of the plot surface (degrees). Continuous predictor.
- `snowmelt_day`: Day of year on which the plot became snow-free (Jan 1 = day 1). Continuous predictor.
- `microsite`: Surface context beside the seedling. Categorical predictor. Levels: `bare_soil`, `moss_mat`, `gravel`.
- `seedling_height_mm`: Seedling height at the first census (mm). Continuous predictor.
