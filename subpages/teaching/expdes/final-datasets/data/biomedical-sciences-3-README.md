# Flow resistance in teaching-lab tubing models

Data file: `biomedical-sciences-3.csv`

Each row is one independent nonclinical tubing assembly run once on a simulated physiology teaching bench. Connector geometry was randomly assigned.

Simulated data; 66 observations. No real people, specimens, or institutions are represented.

## Variables

- `pressure_drop_kpa`: Pressure drop across the assembly in kilopascals. Continuous response.
- `connector_geometry`: Connector geometry assigned to the assembly. Categorical predictor. Levels: `straight`, `elbow`.
- `mount_height_mm`: Mount position above the bench in millimeters. Continuous predictor.
- `label_distance_mm`: Distance from the specimen label to the proximal connector in millimeters. Continuous predictor.
- `inner_diameter_mm`: Measured internal tube diameter in millimeters. Continuous predictor.
