# Day-to-day features of tumor spheroid images

Data file: `cancer-3.csv`

Each row is one independently prepared well with one spheroid, imaged at baseline and again at a scheduled endpoint. Matrix lot group was randomized across wells.

Simulated data; 86 observations. No real people, specimens, or institutions are represented.

## Variables

- `endpoint_diameter_um`: Spheroid diameter at endpoint, in µm. Continuous response.
- `scanner_warmup_min`: Minutes from scanner power-on to the reference check. Continuous predictor.
- `plate_mass_g`: Mass of the empty plate before use, in grams. Continuous predictor.
- `baseline_diameter_um`: Spheroid diameter at the first image, in µm. Continuous predictor.
- `matrix_group`: Assigned support-matrix group. Categorical predictor. Levels: `matrix_A`, `matrix_B`, `matrix_C`.
