# Measuring streambank recovery

Data file: `conservation-1.csv`

Each row samples a different stream reach after a bank-repair project. The local project had selected the restoration approach before the observational survey.

Simulated data; 102 observations. No real people, specimens, or institutions are represented.

## Variables

- `native_cover_pct`: Ground cover by native plants on the restored bank (percent). Continuous response.
- `survey_temp_c`: Air temperature at vegetation survey (degrees C). Continuous predictor.
- `months_since_repair`: Time since installation or start of passive recovery (months). Continuous predictor.
- `restoration_method`: Recorded streambank restoration approach. Categorical predictor. Levels: `live_stakes`, `fiber_mat`, `passive`.
- `bank_height_m`: Vertical height of sampled bank (m). Continuous predictor.
