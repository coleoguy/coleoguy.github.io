# Viscosity of edible polysaccharides

Data file: `biochemistry-3.csv`

Each row is an independent teaching-lab preparation. Food polymer category and target concentration were assigned before measuring one viscosity per preparation.

Simulated data; 82 observations. No real people, specimens, or institutions are represented.

## Variables

- `viscosity_mpas`: Viscosity at a fixed shear setting (mPa s). Continuous response.
- `polymer_kind`: Assigned edible polysaccharide category. Categorical predictor. Levels: `pectin`, `alginate`, `cellulose_gum`.
- `temp_c`: Temperature at the viscosity reading (degrees C). Continuous predictor.
- `mix_vol_ml`: Total liquid volume in the independent preparation (mL). Continuous predictor.
- `polymer_pct`: Nominal polymer mass concentration (percent). Continuous predictor.
