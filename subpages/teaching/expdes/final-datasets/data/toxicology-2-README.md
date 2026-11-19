# Physical sediment stress in model marsh seedlings

Data file: `toxicology-2.csv`

Each row is an independently maintained shallow tray containing one marsh seedling. Tray settling media were randomly assigned in this simulated teaching experiment.

Simulated data; 144 observations. No real people, specimens, or institutions are represented.

## Variables

- `new_leaf`: Whether a new leaf was visible at the scheduled assessment (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `initial_height_cm`: Initial seedling height in centimeters. Continuous predictor.
- `settling_medium`: Inert settling medium assigned to the tray. Categorical predictor. Levels: `quartz`, `kaolin`.
- `tray_width_cm`: Interior tray width in centimeters. Continuous predictor.
- `turbidity_ntu`: Average water turbidity in nephelometric turbidity units. Continuous predictor.
