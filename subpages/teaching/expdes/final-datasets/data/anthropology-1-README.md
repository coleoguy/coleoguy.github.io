# Replica stone tool mechanics

Data file: `anthropology-1.csv`

Each row describes a distinct newly made replica tool tested once using the same fixture. Replicas were randomly assigned a manufacturing material; no artifacts or people were sampled.

Simulated data; 64 observations. No real people, specimens, or institutions are represented.

## Variables

- `edge_failure_force_n`: Maximum force before visible edge failure (N). Continuous response.
- `edge_angle_deg`: Edge angle at the load point (degrees). Continuous predictor.
- `replica_length_mm`: Length of the replica tool (mm). Continuous predictor.
- `fixture_temp_c`: Fixture temperature during testing (degrees C). Continuous predictor.
- `stone_type`: Material assigned for the replica. Categorical predictor. Levels: `chert`, `quartzite`, `obsidian`.
