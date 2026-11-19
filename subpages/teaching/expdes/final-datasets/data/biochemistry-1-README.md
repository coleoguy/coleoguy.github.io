# Spectral peak of leaf pigment extracts

Data file: `biochemistry-1.csv`

Independent leaf extracts were represented by one leaf per plant in a teaching collection. Each extract was allocated randomly to a solvent category before a spectrum was recorded.

Simulated data; 71 observations. No real people, specimens, or institutions are represented.

## Variables

- `peak_nm`: Wavelength at the dominant recorded absorbance peak (nm). Continuous response.
- `extract_volume_ml`: Final volume of the extract (mL). Continuous predictor.
- `leaf_green_index`: Reflectance-based green index measured before extraction (unitless). Continuous predictor.
- `room_temp_c`: Room temperature while reading absorbance (degrees C). Continuous predictor.
- `solvent_class`: Teaching-assay solvent category. Categorical predictor. Levels: `aqueous`, `alcohol`.
