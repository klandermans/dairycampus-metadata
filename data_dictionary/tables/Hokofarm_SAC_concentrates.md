# Automatic Concentrate Feeder Intake (Hokofarm_SAC_concentrates)

**Dataset Identifier:** `Hokofarm_SAC_concentrates`  
**Underlying Database Source:** `t_raw_hokofarmvb`  
**Observation Granularity:** One row per concentrate feeding station visit  

## Description

Visit-level concentrate feeding transactions recorded by SAC / Hokofarm automated concentrate feeders. Captures programmed feed allowance, actual consumed amount, feeding speed, dry matter, crude ash, protein, fat, fiber, and visit timestamps.

## Variables & Data Dictionary

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `ashA` | Ash A | `number` | kg | Calculated | Ash, indigestible part of feed A | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `ashB` | Ash B | `number` | kg | Calculated | Ash, indigestible part of feed B | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `ashC` | Ash C | `number` | kg | Calculated | Ash, indigestible part of feed C | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `ashD` | Ash D | `number` | kg | Calculated | Ash, indigestible part of feed D | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `cow` | Cow | `integer` | number | N/A | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. Same as AnimalNo, is unique per date. | Direct measurement |
| `crudeFiberA` | CrudeFibre A | `number` | kg | Calculated | Crude fiber in feed A | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `crudeFiberB` | CrudeFibre B | `number` | kg | Calculated | Crude fiber in feed B | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `crudeFiberC` | CrudeFibre C | `number` | kg | Calculated | Crude fiber in feed C | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `crudeFiberD` | CrudeFibre D | `number` | kg | Calculated | Crude fiber in feed D | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `date` | Date | `date` | yy-mm-dd | Measured | Date of the data record | Direct measurement |
| `dateTime` | Date and time | `datetime` | yyyy-mm-dd-hh-mm-ss | Measured | Date and time | Direct measurement |
| `dryMatterA` | Dry matter A | `number` | kg | Calculated | Dry matter of feed A | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `dryMatterB` | Dry matter B | `number` | kg | Calculated | Dry matter of feed B | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `dryMatterC` | Dry matter C | `number` | kg | Calculated | Dry matter of feed C | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `dryMatterD` | Dry matter D | `number` | kg | Calculated | Dry matter of feed D | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `endTime` | End time | `number` | hh-mm-ss | Measured | End time of action/behaviour | Direct measurement |
| `energyA` | Energy A | `string` | VEM | Calculated | Energy content A | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `energyB` | Energy B | `string` | VEM | Calculated | Energy content B | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `energyC` | Energy C | `string` | VEM | Calculated | Energy content C | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `energyD` | Energy D | `string` | VEM | Calculated | Energy content D | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `fatA` | Fat A | `number` | kg | Calculated | Fat content A | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `fatB` | Fat B | `number` | kg | Calculated | Fat content B | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `fatC` | Fat C | `number` | kg | Calculated | Fat content C | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `fatD` | Fat D | `number` | kg | Calculated | Fat content D | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `feedTypeA` | Feed type A | `string` | short text | N/A | Type of feed A | Direct measurement |
| `feedTypeB` | Feed type B | `string` | short text | N/A | Type of feed B | Direct measurement |
| `feedTypeC` | Feed type C | `string` | short text | N/A | Type of feed C | Direct measurement |
| `feedTypeD` | Feed type D | `string` | short text | N/A | Type of feed D | Direct measurement |
| `fileName` | File name | `string` | text | N/A | Name of a file | Direct measurement |
| `hashValue` | Hash value | `integer` | number | N/A | Validation record for data processing | Direct measurement |
| `intakeA` | Intake A | `number` | kg | Calculated | Feed intake A | **Calculated**: Calculated by endWeight - startWeight *(Source: ?)* |
| `intakeB` | Intake B | `number` | kg | Calculated | Feed intake B | **Calculated**: Calculated by endWeight - startWeight *(Source: ?)* |
| `intakeC` | Intake C | `number` | kg | Calculated | Feed intake C | **Calculated**: Calculated by endWeight - startWeight *(Source: ?)* |
| `intakeD` | Intake D | `number` | kg | Calculated | Feed intake D | **Calculated**: Calculated by endWeight - startWeight *(Source: ?)* |
| `proteinA` | Protein A | `integer` | number | Calculated | Protein content A | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `proteinB` | Protein B | `integer` | number | Calculated | Protein content B | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `proteinC` | Protein C | `integer` | number | Calculated | Protein content C | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `proteinD` | Protein D | `integer` | number | Calculated | Protein content D | **Calculated**: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `startTime` | Start time | `number` | hh-mm-ss | Measured | Start time of action/behaviour | Direct measurement |
| `station` | Station | `integer` | number | Measured | Station or location of activity | Direct measurement |
| `totalTime` | Total time | `integer` | sec | Calculated | Total duration | **Calculated**: Calculated by endTime - startTime *(Source: ?)* |
| `transponder` | Transponder | `integer` | number | Measured | Transponder number of the cow | Direct measurement |
