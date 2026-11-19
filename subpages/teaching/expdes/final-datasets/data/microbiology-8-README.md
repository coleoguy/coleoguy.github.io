# Diatom striation visibility

Data file: `microbiology-8.csv`

Each slide came from a separate freshwater collection site, with one intact diatom valve randomly selected per slide from a teaching archive. Outline class and image measurements were recorded.

Simulated data; 156 observations. No real people, specimens, or institutions are represented.

## Variables

- `striae_resolved`: Whether adjacent striae could be resolved in the image (1 yes, 0 no). Binary response. 0 = criterion not met; 1 = criterion met.
- `outline_class`: Observed valve shape class. Categorical predictor. Levels: `oval`, `needle`, `wedge`.
- `slide_offset_um`: Distance from the valve centroid to image center (micrometers). Continuous predictor.
- `background_gray`: Mean background gray level (0–255). Continuous predictor.
- `valve_width_um`: Maximum valve width (micrometers). Continuous predictor.
