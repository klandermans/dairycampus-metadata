# Nedap Velos Daily Cow Behaviour Summary (Velos_behaviour_day)

**Dataset Identifier:** `Velos_behaviour_day`  
**Underlying Database Source:** `T_RAW_velos_behaviour (aggregated daily)`  
**Observation Granularity:** One row per cow per calendar day  

## Description

Daily aggregated behavioral budgets per cow, summing durations of eating, ruminating, inactivity (lying), and other active behaviors per 24-hour day.

## Variables & Data Dictionary

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `date` | Date | `date` | yyyy-mm-dd | Measured | Date of the data record, UTC timezone | Direct measurement |
| `cow` | Cow | `integer` | number | N/A | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. Same as AnimalNo, is unique per date. | Direct measurement |
| `total` | Total | `number` | hh-mm-ss | Calculated | Total time recorded of the animal 1 day | **Calculated**: Sum duration of all types *(Source: T_RAW_velos_behaviour)* |
| `overig` | Other | `number` | hh-mm-ss | Calculated | Time the cow is actief but not eating or ruminating | **Calculated**: Sum duration of type 0 *(Source: T_RAW_velos_behaviour)* |
| `nietactief` | Inactive | `number` | hh-mm-ss | Calculated | Time the cow is inactief | **Calculated**: Sum duration of type 1 *(Source: T_RAW_velos_behaviour)* |
| `herkouwen` | Ruminating | `number` | hh-mm-ss | Calculated | Time the cow spent ruminating | **Calculated**: Sum duration of type 2 *(Source: T_RAW_velos_behaviour)* |
| `vreten` | Eating | `number` | hh-mm-ss | Calculated | Time the cow spent eating | **Calculated**: Sum duration of type 3 *(Source: T_RAW_velos_behaviour)* |
