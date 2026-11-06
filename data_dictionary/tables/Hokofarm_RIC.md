# Roughage Intake Control Individual Visits (Hokofarm_RIC)

**Dataset Identifier:** `Hokofarm_RIC`  
**Underlying Database Source:** `t_raw_hokofarmvr`  
**Observation Granularity:** One row per roughage trough feeding visit  

## Description

High-resolution individual visit transactions recorded by Hokofarm RIC (Roughage Intake Control) weighing feed bins. Measures cow ear tag number, bin number, start and end timestamps, initial weight, ending weight, consumed fresh feed quantity, and nutritional composition.

## Variables & Data Dictionary

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `ash` | Ash | `number` | kg | Calculated | Ash, indigestible part of the feed | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `cow` | Cow | `integer` | number | N/A | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. Same as AnimalNo, is unique per date. | Direct measurement |
| `crudeFibre` | CrudeFibre | `number` | kg | Calculated | Crude fiber in the feed | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `date` | Date | `date` | yy-mm-dd | Measured | Date of the data record | Direct measurement |
| `datetime` | Date and time | `datetime` | yyyy-mm-dd-hh-mm-ss | Measured | Date and time | Direct measurement |
| `dryMatter` | Dry matter | `number` | kg | Calculated | Dry matter | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `duration` | Duration | `integer` | sec | Calculated | Duration of action/behaviour | **Calculated**: Calculated by endTime - startTime *(Source: ?)* |
| `endTime` | End time | `number` | hh-mm-ss | Measured | End time of action/behaviour | Direct measurement |
| `endWeight` | End Weight | `number` | kg | Measured | End weight | Direct measurement |
| `energy` | Energy | `string` | VEM | Calculated | Energy content | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `fat` | Fat | `number` | kg | Calculated | Fat content | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `feedType` | Feed type | `string` | short text | N/A | Type of feed | Direct measurement |
| `intake` | Intake | `number` | kg | Calculated | Feed intake | **Calculated**: Calculated by endWeight - startWeight *(Source: ?)* |
| `protein` | Protein | `number` | kg | Calculated | Protein content | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `startTime` | Start time | `number` | hh-mm-ss | Measured | Start time of action/behaviour | Direct measurement |
| `startWeight` | Start weight | `number` | kg | Measured | Start weight | Direct measurement |
| `station` | Station | `integer` | number | Measured | Station or location of activity | Direct measurement |
| `transponder` | Transponder | `integer` | number | Measured | Transponder number of the cow | Direct measurement |
