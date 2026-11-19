# Segmentation of simulated tumor image tiles

Data file: `cancer-4.csv`

Each row is one independently generated synthetic image tile from a distinct source scene. The image preprocessing route was randomly assigned. These are not clinical images.

Simulated data; 164 observations. No real people, specimens, or institutions are represented.

## Variables

- `boundary_detected`: Whether automated segmentation passed the fixed boundary agreement criterion. Binary response. 0 = criterion not met; 1 = criterion met.
- `edge_contrast_index`: Dimensionless contrast index at the annotated boundary. Continuous predictor.
- `preprocessing`: Assigned image preprocessing route. Categorical predictor. Levels: `raw`, `normalized`, `denoised`.
- `cpu_temp_c`: Computer temperature at preprocessing, in °C. Continuous predictor.
- `export_latency_ms`: File export latency, in milliseconds. Continuous predictor.
