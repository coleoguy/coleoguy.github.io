# Sprint recovery in a simulated exercise lab

Data file: `physiology-1.csv`

Each row is one synthetic participant completing one exercise session. Recovery posture was randomly assigned. No record corresponds to a real participant.

Simulated data; 80 observations. No real people, specimens, or institutions are represented.

## Variables

- `heart_rate_recovery_bpm`: Drop in heart rate during the fixed recovery window, in beats per minute. Continuous response.
- `recovery_posture`: Assigned recovery posture. Categorical predictor. Levels: `seated`, `standing`.
- `room_humidity_pct`: Room relative humidity, in percentage points. Continuous predictor.
- `peak_heart_rate_bpm`: Peak heart rate observed during the exercise session, in beats per minute. Continuous predictor.
- `strap_mass_g`: Mass of the heart-rate sensor strap, in grams. Continuous predictor.
