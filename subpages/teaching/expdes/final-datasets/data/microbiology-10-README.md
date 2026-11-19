# Yeast cell outline agreement

Data file: `microbiology-10.csv`

For each independently obtained sample of commercially sold baker's yeast, one cell image was selected and scored by two masked readers. Viewing orientation was recorded rather than assigned.

Simulated data; 122 observations. No real people, specimens, or institutions are represented.

## Variables

- `outline_agreement`: Whether both readers gave the same outline call (1 yes, 0 no). Binary response. 0 = criterion not met; 1 = criterion met.
- `cell_length_um`: Maximum projected cell length (micrometers). Continuous predictor.
- `slide_temp_c`: Slide-stage temperature at imaging (degrees C). Continuous predictor.
- `view_type`: Cell orientation visible in the image. Categorical predictor. Levels: `face`, `oblique`.
- `mount_index`: Cover-slip refractive index from the product sheet (unitless). Continuous predictor.
