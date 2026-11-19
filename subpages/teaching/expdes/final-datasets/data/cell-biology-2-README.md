# Recovery of fluorescence after photobleaching

Data file: `cell-biology-2.csv`

Each row is one cell from a separate well prepared independently. A membrane reporter preparation was randomly assigned to each well; the bleach spot radius was recorded for the cell.

Simulated data; 58 observations. No real people, specimens, or institutions are represented.

## Variables

- `recovery_half_time_s`: Time to reach half of the fitted fluorescence plateau, in seconds. Continuous response.
- `spot_radius_um`: Radius of the imaged bleach spot, in µm. Continuous predictor.
- `membrane_reporter`: Reporter construct category. Categorical predictor. Levels: `reporter_A`, `reporter_B`.
- `stage_offset_um`: Signed lateral stage correction, in µm. Continuous predictor.
- `prebleach_frame_ms`: Exposure duration of the recorded reference frame, in milliseconds. Continuous predictor.
