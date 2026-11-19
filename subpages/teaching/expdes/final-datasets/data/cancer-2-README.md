# Histology review of simulated breast specimens

Data file: `cancer-2.csv`

Each row is one archived synthetic specimen from a different simulated donor. A reviewer classified the specimen once; specimen origin and slide measurements were recorded, not assigned.

Simulated data; 204 observations. No real people, specimens, or institutions are represented.

## Variables

- `review_flag`: Whether the reviewer flagged the slide for secondary review. Binary response. 0 = criterion not met; 1 = criterion met.
- `specimen_source`: Type of specimen submitted for review. Categorical predictor. Levels: `core`, `excision`.
- `scanner_temp_c`: Temperature reported by the scanner, in °C. Continuous predictor.
- `heterogeneity_index`: Dimensionless image summary of variation in nuclear shape. Continuous predictor.
- `label_width_mm`: Measured width of the slide label, in mm. Continuous predictor.
