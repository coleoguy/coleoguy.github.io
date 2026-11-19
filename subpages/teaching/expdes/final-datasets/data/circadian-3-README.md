# Leaf movement rhythms in seedlings

Data file: `circadian-3.csv`

Each row is one seedling grown individually in a separate pot. Seedlings were randomly assigned to a dawn-light treatment. Rhythms were summarized from imaging under constant conditions after the treatment.

Simulated data; 64 observations. No real people, specimens, or institutions are represented.

## Variables

- `leaf_rhythm_period_h`: Estimated leaf movement period, in hours. Continuous response.
- `camera_distance_cm`: Lens-to-bench distance for the recording, in cm. Continuous predictor.
- `dawn_light`: Assigned light color at dawn. Categorical predictor. Levels: `blue`, `amber`, `broad_spectrum`.
- `baseline_leaf_length_mm`: Length of the reference leaf at enrollment, in mm. Continuous predictor.
- `pot_rim_mm`: Measured external diameter at the pot rim, in mm. Continuous predictor.
