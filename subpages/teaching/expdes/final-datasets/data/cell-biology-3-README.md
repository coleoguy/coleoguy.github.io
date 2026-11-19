# Nuclear localization in a reporter assay

Data file: `cell-biology-3.csv`

Each row is one independently prepared well. Wells were randomly assigned to a collection schedule, and a single image per well was summarized at collection.

Simulated data; 140 observations. No real people, specimens, or institutions are represented.

## Variables

- `nuclear_enrichment`: Whether the reporter met the prespecified nuclear-enrichment criterion. Binary response. 0 = criterion not met; 1 = criterion met.
- `stage_temp_c`: Imaging-stage temperature, in °C. Continuous predictor.
- `room_humidity_pct`: Room relative humidity at imaging, in percentage points. Continuous predictor.
- `collection_window`: Assigned collection window. Categorical predictor. Levels: `early`, `intermediate`, `late`.
- `reference_intensity_au`: Baseline reporter intensity in a reference image, in arbitrary units. Continuous predictor.
