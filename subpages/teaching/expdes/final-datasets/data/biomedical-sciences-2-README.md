# Label agreement in training ultrasound phantoms

Data file: `biomedical-sciences-2.csv`

Each row is a unique nonclinical phantom image independently acquired from a different practice phantom. Imaging preset was randomly assigned.

Simulated data; 150 observations. No real people, specimens, or institutions are represented.

## Variables

- `target_identified`: Whether the embedded target was identified by the image reader (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `room_temp_c`: Room temperature in degrees Celsius at acquisition. Continuous predictor.
- `phantom_width_mm`: Width of the training phantom in millimeters. Continuous predictor.
- `imaging_preset`: Preset randomly assigned when acquiring the image. Categorical predictor. Levels: `general`, `detail`, `rapid`.
- `target_depth_mm`: Depth of the known reference target in millimeters. Continuous predictor.
