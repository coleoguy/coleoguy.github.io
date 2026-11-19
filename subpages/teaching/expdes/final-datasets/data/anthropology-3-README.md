# Visibility of replica painted motifs

Data file: `anthropology-3.csv`

Each row represents an independently made replica panel inspected once under the same lighting equipment. Panel substrates were independently allocated; no real cultural objects were represented.

Simulated data; 144 observations. No real people, specimens, or institutions are represented.

## Variables

- `motif_visible`: Whether a painted motif was recognizable under the capture setup (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `substrate`: Assigned replica panel material. Categorical predictor. Levels: `limestone`, `sandstone`.
- `motif_width_cm`: Width of the painted motif (cm). Continuous predictor.
- `pigment_contrast`: Measured brightness contrast between pigment and nearby substrate (unitless, 0 to 1). Continuous predictor.
- `panel_tilt_deg`: Panel tilt from vertical when inspected (degrees). Continuous predictor.
