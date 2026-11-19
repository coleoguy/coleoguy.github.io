# Biopsy morphology in a simulated tumor archive

Data file: `cancer-1.csv`

Each row is one simulated specimen from a different donor. Stain protocol and gross specimen characteristics were recorded rather than assigned. No record is from a real patient.

Simulated data; 112 observations. No real people, specimens, or institutions are represented.

## Variables

- `nuclear_area_um2`: Median nuclear area in the scored field, in µm². Continuous response.
- `cellularity_pct`: Estimated fraction of the scored area occupied by cells, in percentage points. Continuous predictor.
- `coverslip_width_mm`: Measured coverslip width, in mm. Continuous predictor.
- `stain_protocol`: Histology preparation category. Categorical predictor. Levels: `protocol_A`, `protocol_B`.
- `stage_temp_c`: Stage temperature at scoring, in °C. Continuous predictor.
