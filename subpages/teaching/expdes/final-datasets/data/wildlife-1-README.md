# River otter camera detections

Data file: `wildlife-1.csv`

Each row represents one camera station on a separate stream reach, monitored for the same 14 nights. Bank setting was recorded without intervention.

Simulated data; 174 observations. No real people, specimens, or institutions are represented.

## Variables

- `otter_detected`: Whether a river otter was recorded at least once (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `stream_width_m`: Wetted stream width (m). Continuous predictor.
- `camera_height_cm`: Camera height above ground (cm). Continuous predictor.
- `bank_setting`: Dominant bank material near the camera. Categorical predictor. Levels: `sand`, `rock`, `rooted_soil`.
- `bank_slope_deg`: Approximate bank slope in front of camera (degrees). Continuous predictor.
