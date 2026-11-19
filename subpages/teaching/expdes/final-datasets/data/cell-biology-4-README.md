# Vesicle trafficking in cultured cells

Data file: `cell-biology-4.csv`

Each row is the median of tracked vesicles in one independently prepared culture well. The image analyst used the same tracking rules for all wells. Imaging temperature setting was assigned at random.

Simulated data; 80 observations. No real people, specimens, or institutions are represented.

## Variables

- `vesicle_speed_um_s`: Median vesicle speed, in µm per second. Continuous response.
- `cell_area_um2`: Median cell footprint in the imaged field, in µm². Continuous predictor.
- `illumination_pct`: Instrument illumination setting, in percentage points. Continuous predictor.
- `temp_setting`: Assigned stage-temperature setting. Categorical predictor. Levels: `cool`, `standard`.
- `plate_level_deg`: Signed stage-level correction, in degrees. Continuous predictor.
