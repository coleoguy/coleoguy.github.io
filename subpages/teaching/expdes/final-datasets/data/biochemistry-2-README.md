# Food pigment peak detection

Data file: `biochemistry-2.csv`

Each row is an independently assembled food-color sample. Samples were assigned one cuvette type at random, then read once for an ordinary red food dye in a spectroscopy exercise.

Simulated data; 136 observations. No real people, specimens, or institutions are represented.

## Variables

- `peak_detected`: Whether the characteristic visible-light peak met the prespecified signal criterion (1 yes, 0 no). Binary response. 0 = criterion not met; 1 = criterion met.
- `cuvette_type`: Assigned cuvette material. Categorical predictor. Levels: `glass`, `plastic`.
- `room_temp_c`: Room temperature while reading absorbance (degrees C). Continuous predictor.
- `lamp_minutes`: Minutes since instrument lamp start-up. Continuous predictor.
- `dye_ug_ml`: Nominal food-dye concentration (micrograms per mL). Continuous predictor.
