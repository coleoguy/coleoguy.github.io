# Eggshell integrity in laying hens

Data file: `animal-breeding-2.csv`

Each row represents the first egg measured from a different hen in a simulated breeding flock. Hens were assigned individually to nest lining treatments.

Simulated data; 190 observations. No real people, specimens, or institutions are represented.

## Variables

- `shell_intact`: Whether the egg remained visibly uncracked after a standardized handling test (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `shell_thickness_mm`: Thickness estimated non-destructively before the handling test (mm). Continuous predictor.
- `nest_lining`: Randomly assigned nest-box lining. Categorical predictor. Levels: `fiber`, `rubber`, `shavings`.
- `hen_age_weeks`: Age of the hen at sampling (weeks). Continuous predictor.
- `egg_length_mm`: Length measured along the major axis (mm). Continuous predictor.
