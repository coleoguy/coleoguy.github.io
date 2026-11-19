# Surface consistency of dental training casts

Data file: `biomedical-sciences-1.csv`

Each row is a distinct nonclinical training cast. In the simulated materials comparison, cast mold material was randomly assigned and assessed once per cast.

Simulated data; 60 observations. No real people, specimens, or institutions are represented.

## Variables

- `roughness_um`: Mean surface roughness in micrometers. Continuous response.
- `cast_width_mm`: Width of the training cast in millimeters. Continuous predictor.
- `mold_material`: Mold material assigned to the cast. Categorical predictor. Levels: `silicone`, `alginate`.
- `scan_duration_s`: Duration of surface image acquisition in seconds. Continuous predictor.
- `cure_temp_c`: Measured temperature during setting in degrees Celsius. Continuous predictor.
