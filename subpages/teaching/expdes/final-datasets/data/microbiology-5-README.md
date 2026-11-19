# Diatom chain length in lake samples

Data file: `microbiology-5.csv`

Each row comes from one separately sampled lake, with microscopy measurements averaged across images from that lake. The frustule shape class that dominated the images was recorded.

Simulated data; 73 observations. No real people, specimens, or institutions are represented.

## Variables

- `chain_length_um`: Mean observed chain length (micrometers). Continuous response.
- `water_temp_c`: Measured water temperature (degrees C). Continuous predictor.
- `outline_type`: Predominant diatom outline. Categorical predictor. Levels: `round`, `elongated`.
- `lake_elev_m`: Lake surface elevation (m). Continuous predictor.
- `valve_area_um2`: Mean projected valve area (square micrometers). Continuous predictor.
