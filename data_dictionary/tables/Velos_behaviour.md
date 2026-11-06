# Nedap Velos Cow Behaviour Intervals (Velos_behaviour)

**Dataset Identifier:** `Velos_behaviour`  
**Underlying Database Source:** `T_RAW_velos_behaviour`  
**Observation Granularity:** One row per behavior state transition / interval  

## Description

Sensor-based behavioral observation intervals captured by Nedap Velos collar/leg tags (Smarttags). Classifies duration of behaviors (0: other/standing, 1: inactive/lying, 2: ruminating, 3: eating).

## Variables & Data Dictionary

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `date` | Date | `date` | yy-mm-dd | Measured | Date of the data record, UTC timezone | Direct measurement |
| `cow` | Cow | `integer` | number | N/A | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. Same as AnimalNo, is unique per date. | Direct measurement |
| `type` | Type | `string` | short text | N/A | Type of behaviour 1 - 3 | Direct measurement |
| `duration` | Duration | `integer` | sec | Calculated | Duration of action/behaviour | **Calculated**: Calculated by endTime - startTime *(Source: ?)* |
