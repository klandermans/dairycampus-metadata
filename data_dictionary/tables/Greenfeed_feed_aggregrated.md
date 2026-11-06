# GreenFeed Bait Feed Aggregations (Greenfeed_feed_aggregrated)

**Dataset Identifier:** `Greenfeed_feed_aggregrated`  
**Underlying Database Source:** `T_RAW_Greenfeed_Feed_data`  
**Observation Granularity:** One row per cow per GreenFeed station day  

## Description

Aggregated pelleted bait feed dispensed by GreenFeed units to incentivize cow visits, including cup drops, feed mass, and visit timestamps.

## Variables & Data Dictionary

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `cow` | Cow | `integer` | number | N/A | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. Same as AnimalNo, is unique per date. | Direct measurement |
| `CurrentCup` | Current cup | `integer` | number | Measured | Current cup | Direct measurement |
| `CurrentPeriod` | Current period | `integer` | number | Measured | Current period | Direct measurement |
| `date` | Date | `date` | yy-mm-dd | Measured | Date of the data record | Direct measurement |
| `DateTime` | Date and time | `datetime` | yyyy-mm-dd hh-mm-ss | Measured | Date and time | Direct measurement |
| `DropInterval` | Drop interval | `integer` | sec | ? | Min. sec between current en new cup | Direct measurement |
| `FeedType` | Feed type | `integer` | number | N/A | Feed type | Direct measurement |
| `greenfeed` | Greenfeed | `integer` | number | Measured | Greenfeed | Direct measurement |
| `MaxCups` | Maximum cups | `integer` | number | N/A | Max. cups per period | Direct measurement |
| `MaxPeriods` | Maximum periods | `integer` | number | N/A | Max. periods per day | Direct measurement |
| `PeriodInterval` | Period interval | `integer` | sec | N/A | Min. Sec between current en next period | Direct measurement |
| `RFIDTag` | Rfid tag | `integer` | number | Measured | Rfid tag | Direct measurement |
| `user` | User | `string` | short text | N/A | User | Direct measurement |
