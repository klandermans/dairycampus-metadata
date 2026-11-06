# Dairy Campus Meteorological Weather Station (Weatherstation)

**Dataset Identifier:** `Weatherstation`  
**Underlying Database Source:** `T_RAW_weerstation`  
**Observation Granularity:** Hourly / ten-minute meteorological records  

## Description

On-site local meteorological data recorded at Dairy Campus in Leeuwarden. Parameters include ambient temperature, relative humidity, atmospheric pressure, wind speed, wind direction, dew point, solar radiation, and precipitation.

## Variables & Data Dictionary

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `dewpoint` | Dewpoint | `number` | °C | Measured | Dew point is the temperature to which air must be cooled to become saturated with water vapor | Direct measurement |
| `global_radiation` | Global radiation | `string` | Watt/m2 | Measured | The sum of the diffuse and direct solar radiation is called global solar radiation. | Direct measurement |
| `gust` | Wind gust | `integer` | Beaufort, over 10 minuten (meter/sec)? | Measured | A sudden, brief increase in speed of the wind | Direct measurement |
| `gust_direction` | Wind gust direction | `string` | ° Degree | Measured | Direction from which the wind gust blows | Direct measurement |
| `humidity_150` | Humidity | `number` | % | Measured | The concentration of water vapor present in the air | Direct measurement |
| `latitude` | Latitude | `string` | ° Degree | Measured | Coordinate that specifies the north–south position | Direct measurement |
| `longitude` | Longitude | `string` | ° Degree | Measured | Coordinate that specifies the east–west position | Direct measurement |
| `precipitation` | Precipitation | `string` | Millimeters | Measured | Any product of the condensation of atmospheric water vapor that falls from clouds | Direct measurement |
| `rain_chance` | Rain chance | `number` | % | Measured | Chance of precipitation | Direct measurement |
| `station_name` | Station name | `string` | short text | N/A | Station name | Direct measurement |
| `symbol_number` | Symbol number | `string` | ? | ? | Symbol number | Direct measurement |
| `temperature_10` | Temperature 10 | `number` | °C | Measured | Temperature 10 cm above ground level. | Direct measurement |
| `temperature_150` | Temperature 150 | `number` | °C | Measured | Temperature 150 cm above ground level. | Direct measurement |
| `timestamp` | Timestamp | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Timestamp | Direct measurement |
| `wet_bulb_temperature` | Wet bulb temperature | `number` | °C | Measured | Thermometer with the bulb in somthing wet | Direct measurement |
| `wind_direction` | Wind direction | `string` | ° Degree | Measured | Direction from which the wind blows | Direct measurement |
| `windchill` | Windchill | `number` | °C | Measured | The cooling effect of wind blowing on a surface | Direct measurement |
| `windspeed` | Windspeed | `integer` | Beaufort, over 10 minuten (meter/sec)? | Measured | Rate at which wind/air is moving | Direct measurement |
