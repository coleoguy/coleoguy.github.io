# Sediment abrasiveness and leaf surface wear

Data file: `toxicology-6.csv`

Each row represents one separately housed aquarium plant from a simulated sediment-impact comparison. Aquaria were randomly assigned a sediment texture category, with a single plant measured per aquarium.

Simulated data; 72 observations. No real people, specimens, or institutions are represented.

## Variables

- `worn_area_mm2`: Leaf surface area classified as physically worn in square millimeters. Continuous response.
- `leaf_angle_deg`: Initial angle of the sampled leaf relative to horizontal in degrees. Continuous predictor.
- `sediment_texture`: Assigned inert sediment texture category. Categorical predictor. Levels: `fine_sand`, `silty_mix`.
- `particle_flux_index`: Dimensionless optical index of suspended-particle flux. Continuous predictor.
- `tank_volume_l`: Measured aquarium water volume in liters. Continuous predictor.
