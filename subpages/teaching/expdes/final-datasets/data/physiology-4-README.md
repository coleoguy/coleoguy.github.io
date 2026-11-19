# Water loss by detached leaves

Data file: `physiology-4.csv`

Each row is one leaf from a different plant. Leaves were randomly assigned to an air-movement treatment; starting fresh mass was recorded before the trial.

Simulated data; 67 observations. No real people, specimens, or institutions are represented.

## Variables

- `water_loss_mg`: Mass of water lost in the fixed observation interval, in mg. Continuous response.
- `balance_temp_c`: Temperature next to the balance at setup, in °C. Continuous predictor.
- `tray_mass_g`: Mass of the empty sample tray, in grams. Continuous predictor.
- `starting_leaf_mass_mg`: Fresh mass at the start of the observation, in mg. Continuous predictor.
- `air_movement`: Assigned airflow category. Categorical predictor. Levels: `still`, `low`, `moderate`.
