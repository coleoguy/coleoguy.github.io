# Moth orientation in a flight arena

Data file: `entomology-2.csv`

Each row represents a different adult moth used only once. Individuals were randomly assigned to marked visual cue patterns before release.

Simulated data; 180 observations. No real people, specimens, or institutions are represented.

## Variables

- `reached_cue`: Whether the moth reached the marked sector within the trial (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `air_temp_c`: Room air temperature at release (degrees C). Continuous predictor.
- `cue_contrast`: Measured contrast between the marker and background (unitless, 0 to 1). Continuous predictor.
- `cue_pattern`: Randomly assigned visual marker pattern. Categorical predictor. Levels: `plain`, `bars`, `dots`.
- `wingspan_mm`: Moth wingspan (mm). Continuous predictor.
