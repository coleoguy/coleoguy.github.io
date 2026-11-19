# Daily rhythms in activity timing

Data file: `circadian-1.csv`

Each row summarizes one independently housed laboratory mouse over a week. Animals were randomly assigned to a light schedule. The time origin is the scheduled lights-off reference for that animal.

Simulated data; 72 observations. No real people, specimens, or institutions are represented.

## Variables

- `activity_onset_offset_min`: Signed mean activity onset relative to scheduled lights off, in minutes; negative means before. Continuous response.
- `light_schedule`: Assigned lighting schedule. Categorical predictor. Levels: `standard_cycle`, `extended_day`.
- `cage_rack_height_cm`: Height of the shelf supporting the cage, in cm. Continuous predictor.
- `baseline_period_h`: Free-running period measured before assignment, in hours. Continuous predictor.
- `room_humidity_pct`: Mean room relative humidity over recording, in percentage points. Continuous predictor.
