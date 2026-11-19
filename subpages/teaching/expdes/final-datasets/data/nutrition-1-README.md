# Fiber and sensory texture in cereal samples

Data file: `nutrition-1.csv`

Each row is one independent test batch of a simulated cereal formulation. Grain base category was selected in the formulation experiment and the batch, not individual servings, was the measurement unit.

Simulated data; 66 observations. No real people, specimens, or institutions are represented.

## Variables

- `texture_score`: Panel mean texture score on a 0 to 100 scale. Continuous response.
- `fiber_g_serving`: Dietary fiber content in grams per reference serving. Continuous predictor.
- `water_activity`: Water activity as a unitless ratio between 0 and 1. Continuous predictor.
- `serving_mass_g`: Mass of the reference serving in grams. Continuous predictor.
- `grain_base`: Grain base selected for the batch. Categorical predictor. Levels: `oat`, `corn`, `rice`.
