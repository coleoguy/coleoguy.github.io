# Deicing runoff and leaf injury

Data file: `toxicology-3.csv`

Each row is a simulated sample from a different roadside planting bed. Bed surface type and sample properties were observed; there was no road-salt application by the study.

Simulated data; 156 observations. No real people, specimens, or institutions are represented.

## Variables

- `leaf_injury`: Whether the sampled ornamental plant showed visible leaf-edge injury (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `conductivity_ms_cm`: Electrical conductivity of a soil water extract in millisiemens per centimeter. Continuous predictor.
- `distance_to_curbstone_cm`: Distance from plant base to curb in centimeters. Continuous predictor.
- `leaf_sample_mass_g`: Fresh mass in grams of the leaf sample inspected. Continuous predictor.
- `bed_surface`: Surface cover recorded at the plant. Categorical predictor. Levels: `wood_chips`, `gravel`, `bare`.
