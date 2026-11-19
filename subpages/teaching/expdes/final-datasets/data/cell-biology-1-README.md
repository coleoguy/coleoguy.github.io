# Spreading of fibroblasts on adhesive surfaces

Data file: `cell-biology-1.csv`

Each row is one independently plated well from a separate culture preparation. Wells were randomly assigned to an extracellular matrix coating. Cell area is the median over cells imaged in that well.

Simulated data; 71 observations. No real people, specimens, or institutions are represented.

## Variables

- `spread_area_um2`: Median projected area per cell in the well, in µm². Continuous response.
- `adhesion_time_min`: Minutes between plating and fixation. Continuous predictor.
- `focus_offset_um`: Signed focus correction recorded before imaging, in µm. Continuous predictor.
- `matrix_coating`: Coating on the imaging surface. Categorical predictor. Levels: `fibronectin`, `collagen_I`, `laminin`.
- `dish_temp_c`: Temperature of the imaging dish, in °C. Continuous predictor.
