# Organelle puncta in a microscopy screen

Data file: `cell-biology-5.csv`

Each observation is one independently prepared, noninfected culture well from a teaching screen. Cell line was recorded, not assigned. A blinded analyst classified the image using a fixed scoring criterion.

Simulated data; 134 observations. No real people, specimens, or institutions are represented.

## Variables

- `puncta_present`: Whether the well image met the threshold for visible puncta. Binary response. 0 = criterion not met; 1 = criterion met.
- `reporter_intensity_au`: Median reporter intensity before image scoring, in arbitrary units. Continuous predictor.
- `reference_bead_um`: Diameter of the reference bead measured on the same slide, in µm. Continuous predictor.
- `sample_travel_min`: Minutes to move the sealed plate from prep bench to microscope. Continuous predictor.
- `cell_line`: Anonymized teaching cell line. Categorical predictor. Levels: `line_A`, `line_B`, `line_C`.
