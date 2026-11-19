# Green microalgae in park ponds

Data file: `microbiology-4.csv`

Each row is one surface-water sample from a different park pond. No treatments were assigned, and the microscopy call concerns a common non-blooming green algal form.

Simulated data; 148 observations. No real people, specimens, or institutions are represented.

## Variables

- `alga_seen`: Whether the preselected green algal morphotype appeared in a standardized image survey (1 seen, 0 not seen). Binary response. 0 = criterion not met; 1 = criterion met.
- `edge_cover`: Predominant bank cover. Categorical predictor. Levels: `grass`, `trees`, `stone`.
- `shoreline_m`: Estimated shoreline length of pond (m). Continuous predictor.
- `sampling_temp_c`: Water temperature at sample collection (degrees C). Continuous predictor.
- `secchi_cm`: Measured water transparency (cm). Continuous predictor.
