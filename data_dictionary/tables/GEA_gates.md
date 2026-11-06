# GEA Separation and Smart Gate Passages (GEA_gates)

**Dataset Identifier:** `GEA_gates`  
**Underlying Database Source:** `T_RAW_Gea_Separatie`  
**Observation Granularity:** One row per smart gate passage event  

## Description

Passage records through GEA automated selection, separation, and smart routing gates. Logs animal identification, gate ID, direction, and routing decisions.

## Variables & Data Dictionary

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `cow` | Cow | `integer` | number | N/A | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. Same as AnimalNo, is unique per date. | Direct measurement |
| `date` | Date | `date` | yy-mm-dd | Measured | Date of the data record | Direct measurement |
| `event` | Event | `integer` | number | N/A | 0 = No gate action or weighting, 1 = selection gate A, 2 = selection gate B | Direct measurement |
| `gate` | Gate | `integer` | number | N/A | Number of the gate | Direct measurement |
| `message` | Message | `string` | tekst | N/A | ID and info gate action, weighting or selection has or has not taken place | Direct measurement |
