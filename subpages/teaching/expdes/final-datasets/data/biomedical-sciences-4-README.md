# Artificial-skin imaging marker detection

Data file: `biomedical-sciences-4.csv`

Each row is one distinct calibration panel with a single mark embedded in a skin-like phantom. Illumination was randomly assigned for a single acquisition per panel; no clinical specimens were involved.

Simulated data; 162 observations. No real people, specimens, or institutions are represented.

## Variables

- `marker_detected`: Whether the embedded calibration marker was detected in the image (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `camera_distance_cm`: Measured camera-to-panel distance in centimeters. Continuous predictor.
- `panel_width_mm`: Width of the calibration panel in millimeters. Continuous predictor.
- `illumination`: Illumination assigned at capture. Categorical predictor. Levels: `diffuse`, `oblique`.
- `contrast_pct`: Independently measured marker-to-background contrast as a percentage. Continuous predictor.
