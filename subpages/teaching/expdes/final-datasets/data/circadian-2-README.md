# Delayed alignment after a shifted light schedule

Data file: `circadian-2.csv`

Each row is one independent fly vial summarized once after observation. Vials were randomly assigned to a shifted light schedule. Each vial used flies drawn from a separate family.

Simulated data; 150 observations. No real people, specimens, or institutions are represented.

## Variables

- `aligned_by_day_four`: Whether the vial met the activity-alignment criterion by day four. Binary response. 0 = criterion not met; 1 = criterion met.
- `shift_schedule`: Assigned shift of the light cycle. Categorical predictor. Levels: `advance`, `delay`.
- `baseline_rhythm_amplitude_au`: Pre-shift amplitude of the activity rhythm, in arbitrary units. Continuous predictor.
- `room_humidity_pct`: Mean room relative humidity, in percentage points. Continuous predictor.
- `vial_height_mm`: Measured vial height, in mm. Continuous predictor.
