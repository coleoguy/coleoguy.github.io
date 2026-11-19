# Detection of a midday nap

Data file: `sleep-4.csv`

Each row represents one simulated volunteer participating in one nap opportunity. The room setting was assigned at random, and pre-session sleepiness was measured using a continuous slider.

Simulated data; 134 observations. No real people, specimens, or institutions are represented.

## Variables

- `nap_detected`: Whether scoring identified sleep during the nap opportunity. Binary response. 0 = criterion not met; 1 = criterion met.
- `sleepiness_slider_pct`: Position on a self-rated sleepiness slider, in percentage points. Continuous predictor.
- `sensor_mass_g`: Mass of the recording sensor, in grams. Continuous predictor.
- `room_setting`: Assigned sensory setting for the nap. Categorical predictor. Levels: `quiet`, `fan_noise`.
- `cable_run_cm`: Distance from the sensor to the cable junction, in cm. Continuous predictor.
