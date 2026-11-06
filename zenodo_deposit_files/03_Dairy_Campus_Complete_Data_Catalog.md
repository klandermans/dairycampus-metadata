# Dairy Campus Research Data Platform: Complete Metadata Catalog

**Authors:** Bert Klandermans & Fedde de Jong  
**Affiliation:** Dairy Campus, Wageningen University & Research  
**License:** Creative Commons Attribution 4.0 International (CC-BY 4.0)  

---

## Table of Contents

- [TVL_total](#tvl_total) (97 variables)
- [Hokofarm_SAC_concentrates](#hokofarm_sac_concentrates) (42 variables)
- [Hokofarm_RIC](#hokofarm_ric) (18 variables)
- [TVL_RIC_intake_dm](#tvl_ric_intake_dm) (12 variables)
- [Triomatic_RIC_load](#triomatic_ric_load) (46 variables)
- [Triomatic_RIC_drop](#triomatic_ric_drop) (46 variables)
- [GEA_gates](#gea_gates) (5 variables)
- [GEA_milkings](#gea_milkings) (13 variables)
- [TMR_Trioliet_cowconnect_mix](#tmr_trioliet_cowconnect_mix) (12 variables)
- [Velos_behaviour](#velos_behaviour) (4 variables)
- [Velos_behaviour_day](#velos_behaviour_day) (7 variables)
- [TMR_Trioliet_cowconnect_drop](#tmr_trioliet_cowconnect_drop) (11 variables)
- [DC_DM_content](#dc_dm_content) (16 variables)
- [Greenfeed_summarized_data](#greenfeed_summarized_data) (24 variables)
- [Greenfeed_feed_aggregrated](#greenfeed_feed_aggregrated) (13 variables)
- [Weatherstation](#weatherstation) (18 variables)
- [Missing_data](#missing_data) (17 variables)
- [Environment_barn_Animal_day](#environment_barn_animal_day) (52 variables)
- [Environment_barn_Animal_experim](#environment_barn_animal_experim) (54 variables)

---

## TVL_total

- **Underlying Source Table:** `tvl_totaal`
- **Total Variables:** 97

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `AnimalServerId` | Animal server number | `integer` | number | nan | Unique animal server identifier issued across the different systems at Dairy Campus | Direct measurement |
| `AntMlkA` | Number of milkings afternoon | `integer` | number | Measured | How often an animal was milked in the afternoon. 1 is the assumed value. 0 means a missing value/something wrong with registration. 2+ means reattachment of the milking apparatus, can be outlier values. | Direct measurement |
| `AntMlkEtm` | Number of milkings 24 hours | `integer` | number | Measured | Amount of milkings in the last 24 hours. 2 is the assumed value. 1 or 3+ means something is off during morning and/or afternoon milking. | Direct measurement |
| `AntMlkO` | Number of milkings morning | `integer` | number | Measured | How often an animal was milked in the morning. 1 is the assumed value. 0 means a missing value/something wrong with registration. 2+ means reattachment of the milking apparatus, can be outlier values. | Direct measurement |
| `bcs` | Body condition score | `integer` | number | Measured | Automatic body condition score camera | Direct measurement |
| `BegDatPrf` | Starting date experiment | `date` | yy-mm-dd | Measured | Expected start date of the experiment | Direct measurement |
| `BehCod` | Treatment code | `string` | short text | nan | Abbreviaton of the treatname name. Set by the researcher. | Direct measurement |
| `BehNam` | Treatment name | `string` | short text | nan | Full name of the treatment. Set by the researcher | Direct measurement |
| `Blk` | Blocking group | `integer` | number | nan | Number of the assigned block. Set by the researcher. | Direct measurement |
| `C21-10` | Total concentrate via station 1 till 4 | `number` | kg | Calculated | Dag totaal krachtvoer caroussel | Calculated: ??? Sum of distributed concentrate feed at the specific day? *(Source: ?)* |
| `C21-9` | Concentrate feed milking caroussel | `number` | kg | nan | Kilogram of concentrate feed dispatched at the milking caroussel. NOT the uptake, that cannot be registered currently. | Direct measurement |
| `CelStd` | Somatic cell count standard | `string` | x1000 cells/mL | Calculated | Somatic cell count of the monthly milk test | Calculated: Official somatic cell count (SCC) determined from routine 4-weekly milk recording samples (MPR), analyzed by laboratory. *(Source: T_Animal_MilkSamples (MlkCon.SCCDay))* |
| `Dat` | Date | `date` | yy-mm-dd | Measured | Date of the data record | Direct measurement |
| `DelPro-13` | Feed from the milking robot | `number` | kg | nan | Intake feed 1 from the milkingrobot | Direct measurement |
| `DrgZetDat` | Start date dry period | `date` | yy-mm-dd | Measured | Starting date of the dry period | Direct measurement |
| `EiwStd` | Protein concentration standard | `number` | % | Calculated | Protein concentration of the monthly milk test | Calculated: Milk crude protein percentage determined from official routine milk recording laboratory analysis. *(Source: T_Animal_MilkSamples (MlkCon.ProteinPercentage))* |
| `EndDatPrf` | Ending date experiment | `date` | yy-mm-dd | Measured | Expected end date of the experiment | Direct measurement |
| `GewA` | Weight afternoon | `number` | kg | Measured | Weight of the animal after milking in the afternoon | Direct measurement |
| `GewO` | Weight morning | `number` | kg | Measured | Weight of the animal after milking in the morning | Direct measurement |
| `gf_visits` | GreenFeed measurements | `string` | N/A | nan | Measurements on cow emission (summarized data) | Direct measurement |
| `gf_cupdrops` | GreenFeed cupdrops | `string` | N/A | nan | GreenFeed portions concentrate feed. | Direct measurement |
| `Hok` | Pen / Stable number | `integer` | number | nan | Location of where the cows are housed. | Direct measurement |
| `HokMin1` | Pen / Stable number day before | `integer` | number | nan | Location of where the cows are housed day before | Direct measurement |
| `AtributedKVA` | Attributed Concentrate A | `number` | kg | Calculated | Total allocated/programmed amount of concentrate feed type A for the cow on the specified date. | Calculated: Sum of programmed concentrate A quantities across feeding stations (Hokofarm / SAC). *(Source: T_Raw_HokofarmCD / TVL_Totaal_sub_kv)* |
| `TotalIntakeKVA` | Concentrate feed station 1 | `number` | kg | Calculated | Total intake feed from SAC box 1 | Calculated: Total consumed quantity of concentrate feed A by the animal at the automatic feeding station on the specified date. *(Source: T_Raw_HokofarmCD (totalIntakeKVA))* |
| `AtributedKVB` | Attributed Concentrate B | `number` | kg | Calculated | Total allocated/programmed amount of concentrate feed type B for the cow on the specified date. | Calculated: Sum of programmed concentrate B quantities across feeding stations (Hokofarm / SAC). *(Source: T_Raw_HokofarmCD / TVL_Totaal_sub_kv)* |
| `TotalIntakeKVB` | Concentrate feed station 2 | `number` | kg | Calculated | Total intake feed from SAC box 2 | Calculated: Total consumed quantity of concentrate feed B by the animal at the automatic feeding station on the specified date. *(Source: T_Raw_HokofarmCD (totalIntakeKVB))* |
| `AtributedKVC` | Attributed Concentrate C | `number` | kg | Calculated | Total allocated/programmed amount of concentrate feed type C for the cow on the specified date. | Calculated: Sum of programmed concentrate C quantities across feeding stations (Hokofarm / SAC). *(Source: T_Raw_HokofarmCD / TVL_Totaal_sub_kv)* |
| `TotalIntakeKVC` | Concentrate feed station 3 | `number` | kg | Calculated | Total intake feed from SAC box 3 | Calculated: Total consumed quantity of concentrate feed C by the animal at the automatic feeding station on the specified date. *(Source: T_Raw_HokofarmCD (totalIntakeKVC))* |
| `AtributedKVD` | Attributed Concentrate D | `number` | kg | Calculated | Total allocated/programmed amount of concentrate feed type D for the cow on the specified date. | Calculated: Sum of programmed concentrate D quantities across feeding stations (Hokofarm / SAC). *(Source: T_Raw_HokofarmCD / TVL_Totaal_sub_kv)* |
| `TotalIntakeKVD` | Concentrate feed station 4 | `number` | kg | Calculated | Total intake feed from SAC box 4 | Calculated: Total consumed quantity of concentrate feed D by the animal at the automatic feeding station on the specified date. *(Source: T_Raw_HokofarmCD (totalIntakeKVD))* |
| `HrhNum` | Repeating number | `integer` | number | nan | Number of repeat of a previously performed test | Direct measurement |
| `InsDat` | Insemination day | `date` | yy-mm-dd | Measured | Date of last insemination | Direct measurement |
| `Jar` | Year | `integer` | number | Measured | Year of the data record | Direct measurement |
| `KetStd` | Ketose concentration standard | `integer` | number | Calculated | Ketose concentration of the monthly milk test | Calculated: Ketosis diagnostic classification code (0: normal/negative, 1: suspected subclinical, 2: clinical ketosis). *(Source: T_Animal_MilkSamples (MlkCon.KetosisCode))* |
| `KgMlkA` | Kilogram milk afternoon | `number` | kg | Measured | Kilogram of milk registred at the afternoon milking event | Direct measurement |
| `KgMlkEtm` | Kilogram milk 24 hours | `number` | kg | Measured | Kilogram of milk in the last 24 hours | Direct measurement |
| `KgMlkO` | Kilogram milk morning | `number` | kg | Measured | Kilogram of milk registred at the morning milking event | Direct measurement |
| `KlfDat` | Calving date | `date` | yy-mm-dd | Measured | Date of last calving | Direct measurement |
| `LacDgn` | Days in lactation | `integer` | number | Calculated | Amount of days producing milk | Calculated: Date - calving date *(Source: ?)* |
| `LacNum` | Parity | `integer` | number | Measured | Parity (amount of calvings) of the animal | Direct measurement |
| `LacStd` | Lactose concentration standard | `number` | % | Calculated | Lactose of the monthly milk test | Calculated: Milk lactose percentage determined from official routine milk recording laboratory analysis. *(Source: T_Animal_MilkSamples (MlkCon.LactosePercentage))* |
| `LevNum` | Registration number | `integer` | text + number | nan | National registration number of the animal. | Direct measurement |
| `LftDgn` | Age | `integer` | number | Measured | Age of the animal in days | Direct measurement |
| `MlkStd` | Milk standard | `number` | kg | Calculated | Kilogram of milk produced during the standard (once a month) milk composition sampling | Calculated: Total daily milk yield recorded during the official milk control recording day. *(Source: T_Animal_MilkSamples (MlkCon.MilkQuantityMass))* |
| `mpr_dag.Fat_Concentration` | Weekly milk fat concentration | `number` | % | Measured | Weekly milk fat concentration during the AO sampling for animals in an experiment. AO = avond ochtend (eveningn morning) sample, taken on Tuesday evening and Wednesday morning. So 2 values per week. | Direct measurement |
| `mpr_dag.Lactose_Concentration` | Weekly milk lactose concentration | `number` | % | Measured | Weekly milk lactose concentration during the AO sampling for animals in an experiment. AO = avond ochtend (eveningn morning) sample, taken on Tuesday evening and Wednesday morning. So 2 values per week. | Direct measurement |
| `mpr_dag.Protein_Concentration` | Weekly milk protein concentration | `number` | % | Measured | Weekly milk protein concentration during the AO sampling for animals in an experiment. AO = avond ochtend (eveningn morning) sample, taken on Tuesday evening and Wednesday morning. So 2 values per week. | Direct measurement |
| `mpr_dag.SCC` | Weekly somatic cell count | `string` | 1000 cells/mL | Measured | Weekly somatic cell count during the AO sampling for animals in an experiment. AO = avond ochtend (eveningn morning) sample, taken on Tuesday evening and Wednesday morning. So 2 values per week. | Direct measurement |
| `mpr_dag.Urea_Concentration` | Weekly milk urea concentration | `string` | mg/dL | Measured | Weekly milk urea concentration during the AO sampling for animals in an experiment. AO = avond ochtend (eveningn morning) sample, taken on Tuesday evening and Wednesday morning. So 2 values per week. | Direct measurement |
| `mpr_week.Fat_Concentration` | Calculated day fat concentration | `number` | % | Calculated | An estimated daily milk fat concentration based on the AO sampling and the corresponding milk yield of that day.  x | Calculated: ISO-calendar week yield-weighted average milk fat concentration calculated across regular CRV/MPR test recordings: sum(Fat_Concentration * MilkingYield) / sum(MilkingYield). Used to derive Fat- and Protein-Corrected Milk (FPCM). *(Source: VL_Dier_Datum_Crv)* |
| `mpr_week.Lactose_Concentration` | Calculated day lactose concentration | `number` | % | Calculated | An estimated daily milk lactose concentration based on the AO sampling and the corresponding milk yield of that day. | Calculated: ISO-calendar week yield-weighted average milk lactose concentration calculated across regular CRV/MPR test recordings: sum(Lactose_Concentration * MilkingYield) / sum(MilkingYield). *(Source: VL_Dier_Datum_Crv)* |
| `mpr_week.Protein_Concentration` | Calculated day protein concentration | `number` | % | Calculated | An estimated daily milk protein concentration based on the AO sampling and the corresponding milk yield of that day. | Calculated: ISO-calendar week yield-weighted average milk protein concentration calculated across regular CRV/MPR test recordings: sum(Protein_Concentration * MilkingYield) / sum(MilkingYield). Used to derive Fat- and Protein-Corrected Milk (FPCM). *(Source: VL_Dier_Datum_Crv)* |
| `mpr_week.SCC` | Calculated day somatic cell count | `string` | 1000 cells/mL | Calculated | An estimated daily somatic cell count based on the AO sampling and the corresponding milk yield of that day. | Calculated: ISO-calendar week yield-weighted average somatic cell count (1,000 cells/mL) calculated across regular CRV/MPR test recordings: sum(SCC * MilkingYield) / sum(MilkingYield). *(Source: VL_Dier_Datum_Crv)* |
| `mpr_week.Urea_Concentration` | Calculated day urea concentration | `string` | mg/dL | Calculated | An estimated daily milk urea concentration based on the AO sampling and the corresponding milk yield of that day. | Calculated: ISO-calendar week yield-weighted average milk urea concentration (mg/dL) calculated across regular CRV/MPR test recordings: sum(Urea_Concentration * MilkingYield) / sum(MilkingYield). *(Source: VL_Dier_Datum_Crv)* |
| `OorNum` | Ear number | `integer` | number | nan | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. | Direct measurement |
| `OpnRvDsHans` | Intake roughage dry matter Hans | `string` | N/A | nan | Intake of dry matter from the roughage, Hans (Will be removed from table) | Direct measurement |
| `PrdSta` | Production stage | `string` | short text | nan | Identifying the stage of the cow, producing milk or not | Direct measurement |
| `PrfCod` | Experiment number | `integer` | number | nan | Code assigned by Dairy Campus to identify the experiment. Can be the same as the MyProjects number, or differ. | Direct measurement |
| `RowID` | Row ID | `integer` | number | nan | Unique number for row in a specific table. | Direct measurement |
| `rv1.ds` | Roughage 1 dry matter | `string` | N/A | nan | Roughage 1 dry matter | Direct measurement |
| `rv1.name` | Roughage name 1 | `string` | short text | nan | Name of the roughage treatment consumed by the animal | Direct measurement |
| `rv1.opnDs` | Roughage 1 intake dry matter | `string` | N/A | nan | Roughage 1 intake dry matter | Direct measurement |
| `rv1.Prod` | Roughage product 1 | `number` | kg | Calculated | Total uptake in kilograms of the roughage | Calculated: Sum of roughage intake of all visits in a single day. The roughage bin calculates uptake as: starting weight - end weight (bins contains a scale) *(Source: ?)* |
| `rv1.ProdExclWater` | Roughage 1 intake excluding water | `number` | kg | Calculated | Total uptake in kilograms of the roughage excluding water | Calculated: Daily roughage intake fraction 1 excluding added water: (TotalLoaded - AddedWaterKg) / TotalLoaded * Intake. *(Source: VL_Totaal_sub_ric_opn_prod)* |
| `rv1.ricBez` | Roughage 1 RIC bin visits | `integer` | number | Measured | Amount of times the animal visited the roughage bins to consume the roughage. | Direct measurement |
| `rv1.trBatches` | Roughage 1 batches | `integer` | number | Measured | Amount of different batches distributed by the feeding robot that the animal consumed for its total roughage uptake | Direct measurement |
| `rv2.ds` | Roughage 2 dry matter | `number` | kg | nan | Roughage 2 dry matter | Direct measurement |
| `rv2.name` | Roughage name 2 | `string` | short text | nan | Name of the roughage treatment consumed by the animal. These are only active (2, 3 and 4) when the animal consumes roughage from a treatment she isn't assigned to. | Direct measurement |
| `rv2.opnDs` | Roughage 2 intake dry matter | `number` | kg | nan | Roughage 2 intake dry matter | Direct measurement |
| `rv2.Prod` | Roughage product 2 | `number` | kg | Calculated | Total uptake in kilograms of the roughage. | Calculated: ? |
| `rv2.ProdExclWater` | Roughage 2 intake excluding water | `number` | kg | Calculated | Total uptake in kilograms of the roughage excluding water | Calculated: Daily roughage intake fraction 2 excluding added water: (TotalLoaded - AddedWaterKg) / TotalLoaded * Intake. *(Source: VL_Totaal_sub_ric_opn_prod)* |
| `rv2.ricBez` | Roughage 2 RIC bin visits | `integer` | number | Measured | Amount of times the animal visited the roughage bins to consume the roughage. | Direct measurement |
| `rv2.trBatches` | Roughage 2 batches | `integer` | number | Measured | Amount of different batches distributed by the feeding robot that the animal consumed for its total roughage uptake | Direct measurement |
| `rv3.ds` | Roughage 3 dry matter | `number` | kg | nan | Roughage 3 dry matter | Direct measurement |
| `rv3.name` | Roughage name 3 | `string` | short text | nan | Name of the roughage treatment consumed by the animal. These are only active (2, 3 and 4) when the animal consumes roughage from a treatment she isn't assigned to. | Direct measurement |
| `rv3.opnDs` | Roughage 3 intake dry matter | `number` | kg | nan | Roughage 3 intake dry matter | Direct measurement |
| `rv3.Prod` | Roughage product 3 | `number` | kg | Calculated | Total uptake in kilograms of the roughage. | Calculated: Sum of roughage intake of all visits in a single day. The roughage bin calculates uptake as: starting weight - end weight (bins contains a scale) *(Source: ?)* |
| `rv3.ProdExclWater` | Roughage 3 intake excluding water | `number` | kg | Calculated | Total uptake in kilograms of the roughage excluding water | Calculated: Daily roughage intake fraction 3 excluding added water: (TotalLoaded - AddedWaterKg) / TotalLoaded * Intake. *(Source: VL_Totaal_sub_ric_opn_prod)* |
| `rv3.ricBez` | Roughage 3 RIC bin visits | `integer` | number | Measured | Amount of times the animal visited the roughage bins to consume the roughage. | Direct measurement |
| `rv3.trBatches` | Roughage 3 batches | `integer` | number | Measured | Amount of different batches distributed by the feeding robot that the animal consumed for its total roughage uptake | Direct measurement |
| `rv4.ds` | Roughage 4 dry matter | `number` | kg | nan | Roughage 4 dry matter | Direct measurement |
| `rv4.name` | Roughage name 4 | `string` | short text | nan | Name of the roughage treatment consumed by the animal. These are only active (2, 3 and 4) when the animal consumes roughage from a treatment she isn't assigned to. | Direct measurement |
| `rv4.opnDs` | Roughage 4 intake dry matter | `number` | kg | nan | Roughage 4 intake dry matter | Direct measurement |
| `rv4.Prod` | Roughage product 4 | `number` | kg | Calculated | Total uptake in kilograms of the roughage. | Calculated: Sum of roughage intake of all visits in a single day. The roughage bin calculates uptake as: starting weight - end weight (bins contains a scale) *(Source: ?)* |
| `rv4.ProdExclWater` | Roughage 4 intake excluding water | `number` | kg | Calculated | Total uptake in kilograms of the roughage excluding water | Calculated: Daily roughage intake fraction 4 excluding added water: (TotalLoaded - AddedWaterKg) / TotalLoaded * Intake. *(Source: VL_Totaal_sub_ric_opn_prod)* |
| `rv4.ricBez` | Roughage 4 RIC bin visits | `integer` | number | Measured | Amount of times the animal visited the roughage bins to consume the roughage. | Direct measurement |
| `rv4.trBatches` | Roughage 4 batches | `integer` | number | Measured | Amount of different batches distributed by the feeding robot that the animal consumed for its total roughage uptake | Direct measurement |
| `tot.opnDs` | Total intake drymatter | `number` | kg | Calculated | Total uptake in kilograms of dry matter | Calculated: Total daily dry matter intake (kg DM/day). Calculated by summing the dry matter intake of all roughage fractions: (OpnMinWater * DryMatterPercentage). *(Source: VL_Totaal_sub_ric_opn_prod)* |
| `tot.Prod` | Total product | `number` | kg | nan | Total roughage 1 t/m 4 | Direct measurement |
| `UreStd` | Urea concentration standard | `number` | mg/100 gram | Calculated | Urea concentration of the monthly milk test | Calculated: Milk urea nitrogen content determined from official routine milk recording laboratory analysis. *(Source: T_Animal_MilkSamples (MlkCon.Urea))* |
| `VetStd` | Fat concentration standard | `number` | % | Calculated | Fat concentration of the monthly milk test | Calculated: Milk fat percentage determined from official routine milk recording laboratory analysis. *(Source: T_Animal_MilkSamples (MlkCon.FatPercentage))* |
| `VlgKlfDat` | Next calving date | `date` | yy-mm-dd | Calculated | Next calving date, not predicted, but added after calving | Calculated: ? |
| `VrwDgn` | Expected number of days | `integer` | number | Calculated | Number of days from date to expected calving date based on insemination date | Calculated: Expected calving date minus current date. *(Source: TVL_Dier_Datum_Stal)* |
| `VrwKlfDat` | Expected calving date | `date` | yy-mm-dd | Calculated | Expected calving date based on insemination date | Calculated: Insemination date + 280 days *(Source: ?)* |
| `Wek` | Week | `integer` | number | Measured | Calender week number of data record | Direct measurement |
| `WekDag` | Day of the week | `string` | short text | nan | Abbreviaton of weekday (Ma = Monday, Di = Tuesday, Wo = Wednesday, Do = Thursday, Vr = Friday, Za = Saturday, Zo = Sunday) | Direct measurement |


## Hokofarm_SAC_concentrates

- **Underlying Source Table:** `t_raw_hokofarmvb`
- **Total Variables:** 42

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `ashA` | Ash A | `number` | kg | Calculated | Ash, indigestible part of feed A | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `ashB` | Ash B | `number` | kg | Calculated | Ash, indigestible part of feed B | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `ashC` | Ash C | `number` | kg | Calculated | Ash, indigestible part of feed C | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `ashD` | Ash D | `number` | kg | Calculated | Ash, indigestible part of feed D | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `cow` | Cow | `integer` | number | nan | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. Same as AnimalNo, is unique per date. | Direct measurement |
| `crudeFiberA` | CrudeFibre A | `number` | kg | Calculated | Crude fiber in feed A | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `crudeFiberB` | CrudeFibre B | `number` | kg | Calculated | Crude fiber in feed B | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `crudeFiberC` | CrudeFibre C | `number` | kg | Calculated | Crude fiber in feed C | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `crudeFiberD` | CrudeFibre D | `number` | kg | Calculated | Crude fiber in feed D | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `date` | Date | `date` | yy-mm-dd | Measured | Date of the data record | Direct measurement |
| `dateTime` | Date and time | `datetime` | yyyy-mm-dd-hh-mm-ss | Measured | Date and time | Direct measurement |
| `dryMatterA` | Dry matter A | `number` | kg | Calculated | Dry matter of feed A | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `dryMatterB` | Dry matter B | `number` | kg | Calculated | Dry matter of feed B | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `dryMatterC` | Dry matter C | `number` | kg | Calculated | Dry matter of feed C | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `dryMatterD` | Dry matter D | `number` | kg | Calculated | Dry matter of feed D | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `endTime` | End time | `number` | hh-mm-ss | Measured | End time of action/behaviour | Direct measurement |
| `energyA` | Energy A | `string` | VEM | Calculated | Energy content A | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `energyB` | Energy B | `string` | VEM | Calculated | Energy content B | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `energyC` | Energy C | `string` | VEM | Calculated | Energy content C | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `energyD` | Energy D | `string` | VEM | Calculated | Energy content D | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `fatA` | Fat A | `number` | kg | Calculated | Fat content A | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `fatB` | Fat B | `number` | kg | Calculated | Fat content B | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `fatC` | Fat C | `number` | kg | Calculated | Fat content C | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `fatD` | Fat D | `number` | kg | Calculated | Fat content D | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `feedTypeA` | Feed type A | `string` | short text | nan | Type of feed A | Direct measurement |
| `feedTypeB` | Feed type B | `string` | short text | nan | Type of feed B | Direct measurement |
| `feedTypeC` | Feed type C | `string` | short text | nan | Type of feed C | Direct measurement |
| `feedTypeD` | Feed type D | `string` | short text | nan | Type of feed D | Direct measurement |
| `fileName` | File name | `string` | text | nan | Name of a file | Direct measurement |
| `hashValue` | Hash value | `integer` | number | nan | Validation record for data processing | Direct measurement |
| `intakeA` | Intake A | `number` | kg | Calculated | Feed intake A | Calculated: Calculated by endWeight - startWeight *(Source: ?)* |
| `intakeB` | Intake B | `number` | kg | Calculated | Feed intake B | Calculated: Calculated by endWeight - startWeight *(Source: ?)* |
| `intakeC` | Intake C | `number` | kg | Calculated | Feed intake C | Calculated: Calculated by endWeight - startWeight *(Source: ?)* |
| `intakeD` | Intake D | `number` | kg | Calculated | Feed intake D | Calculated: Calculated by endWeight - startWeight *(Source: ?)* |
| `proteinA` | Protein A | `integer` | number | Calculated | Protein content A | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `proteinB` | Protein B | `integer` | number | Calculated | Protein content B | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `proteinC` | Protein C | `integer` | number | Calculated | Protein content C | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `proteinD` | Protein D | `integer` | number | Calculated | Protein content D | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `startTime` | Start time | `number` | hh-mm-ss | Measured | Start time of action/behaviour | Direct measurement |
| `station` | Station | `integer` | number | Measured | Station or location of activity | Direct measurement |
| `totalTime` | Total time | `integer` | sec | Calculated | Total duration | Calculated: Calculated by endTime - startTime *(Source: ?)* |
| `transponder` | Transponder | `integer` | number | Measured | Transponder number of the cow | Direct measurement |


## Hokofarm_RIC

- **Underlying Source Table:** `t_raw_hokofarmvr`
- **Total Variables:** 18

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `ash` | Ash | `number` | kg | Calculated | Ash, indigestible part of the feed | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `cow` | Cow | `integer` | number | nan | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. Same as AnimalNo, is unique per date. | Direct measurement |
| `crudeFibre` | CrudeFibre | `number` | kg | Calculated | Crude fiber in the feed | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `date` | Date | `date` | yy-mm-dd | Measured | Date of the data record | Direct measurement |
| `datetime` | Date and time | `datetime` | yyyy-mm-dd-hh-mm-ss | Measured | Date and time | Direct measurement |
| `dryMatter` | Dry matter | `number` | kg | Calculated | Dry matter | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `duration` | Duration | `integer` | sec | Calculated | Duration of action/behaviour | Calculated: Calculated by endTime - startTime *(Source: ?)* |
| `endTime` | End time | `number` | hh-mm-ss | Measured | End time of action/behaviour | Direct measurement |
| `endWeight` | End Weight | `number` | kg | Measured | End weight | Direct measurement |
| `energy` | Energy | `string` | VEM | Calculated | Energy content | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `fat` | Fat | `number` | kg | Calculated | Fat content | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `feedType` | Feed type | `string` | short text | nan | Type of feed | Direct measurement |
| `intake` | Intake | `number` | kg | Calculated | Feed intake | Calculated: Calculated by endWeight - startWeight *(Source: ?)* |
| `protein` | Protein | `number` | kg | Calculated | Protein content | Calculated: Dry matter energy, protein, crude fiber and fat always 0 in this table? |
| `startTime` | Start time | `number` | hh-mm-ss | Measured | Start time of action/behaviour | Direct measurement |
| `startWeight` | Start weight | `number` | kg | Measured | Start weight | Direct measurement |
| `station` | Station | `integer` | number | Measured | Station or location of activity | Direct measurement |
| `transponder` | Transponder | `integer` | number | Measured | Transponder number of the cow | Direct measurement |


## TVL_RIC_intake_dm

- **Underlying Source Table:** `TVL_totaal_hokofarm_ds`
- **Total Variables:** 12

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `cow` | Cow | `integer` | number | nan | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. Same as AnimalNo, is unique per date. | Direct measurement |
| `date` | Date | `date` | yy-mm-dd | Measured | Date of the data record | Direct measurement |
| `dsPct` | dry matter percentage | `integer` | number | Calculated | Percentage of dry matter in the feed | Calculated: ? *(Source: ?)* |
| `feedtype` | feedtype | `string` | short text | nan | Type of feed | Direct measurement |
| `name` | Name | `string` | short text | nan | Name collected based on other value | Direct measurement |
| `opnDsVR` | Intake dry matter Roughage RIC | `number` | kg | nan | Intake of dry matter from roughage RIC | Direct measurement |
| `opnIncWater` | Intake including water | `number` | kg | Calculated | Feed intake including water | Calculated: ? *(Source: ?)* |
| `opnMinWater` | Intake subtracting water | `number` | kg | Calculated | Feed intake excluding water | Calculated: ? *(Source: ?)* |
| `opnProd` | Intake product | `number` | kg | nan | Total intake of product | Direct measurement |
| `ricBez` | Ric visits | `integer` | number | nan | Number of visits to RIC | Direct measurement |
| `RowID` | Row ID | `integer` | number | nan | Unique number for row in a specific table. | Direct measurement |
| `trBatches` | Tioliet batches | `integer` | number | nan | Number of times the triolith has released feed. | Direct measurement |


## Triomatic_RIC_load

- **Underlying Source Table:** `t_raw_trioliet`
- **Total Variables:** 46

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `AnimalCount` | Animal count | `integer` | number | nan | The number of animals | Direct measurement |
| `Date` | Date | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date | Direct measurement |
| `Extra` | Extra | `integer` | number | nan | Extra information | Direct measurement |
| `FeedingGroup` | Feeding group | `integer` | number | Measured | Log source 0 = 1, log source 1 = NULL betekenis Feeding group? | Direct measurement |
| `filename` | Filename | `string` | short text | nan | Name of the file containing information | Direct measurement |
| `FinishedReady` | Finished ready | `string` | ? | nan | NULL? | Direct measurement |
| `GroupID` | Group ID | `integer` | number | nan | Id of the group | Direct measurement |
| `GroupName` | Group name | `string` | short text | nan | Name of the group | Direct measurement |
| `Id` | ID | `integer` | number | nan | ID | Direct measurement |
| `IngredientName` | Ingredient name | `string` | short text | nan | Name of the ingredient | Direct measurement |
| `k42` | k42 | `integer` | number | nan | Validation record for data processing | Direct measurement |
| `LogSource` | Log source | `integer` | number | nan | 0 meaning feed preparation, and 1 the distribution of feed to RIC bins | Direct measurement |
| `NettoLoadedWeight` | Netto loaded weight | `number` | kg | Measured | Netto weight loaded | Direct measurement |
| `NrOfSplittings` | Number of splittings | `integer` | number | nan | Number of splittings | Direct measurement |
| `NumberRecipeLines` | Number of recipe lines | `integer` | number | nan | Total number of recipe lines | Direct measurement |
| `OpdrachtID` | Job ID | `integer` | number | nan | Job ID | Direct measurement |
| `PerformedFeedFactor` | Performed feed factor | `integer` | number | nan | Performed feed factor | Direct measurement |
| `PerformedProductDryWeightKgAfterDrop` | Kg dry weight after drop | `number` | kg | Measured | Kg dry weight after drop | Direct measurement |
| `PerformedProductDryWeightPartAfterDrop` | Part of dry weight after drop | `number` | kg | Measured | Part of dry weight after drop | Direct measurement |
| `PerformedProductError` | Performed product error | `number` | kg | Calculated | Error, difference between Scheduled kg and performed kg feed | Calculated: ? |
| `PerformedProductKgAfterDrop` | Kg product after drop | `number` | kg | Measured | Kg product after drop | Direct measurement |
| `PerformedProductKgAtStop` | Kg product at stop | `number` | kg | Measured | Kg product at stop | Direct measurement |
| `PerformedTime` | Performed time | `number` | hh-mm-ss | Measured | Performed time | Direct measurement |
| `PushingGroup` | Pushing group | `integer` | number | nan | Pushing group | Direct measurement |
| `Ready` | Ready | `integer` | number | nan | Ready | Direct measurement |
| `ReadyTime` | Ready time | `number` | hh-mm-ss | nan | Ready time, if log source 1 | Direct measurement |
| `ReceptLineNr` | Recept line number | `integer` | number | nan | Current number of recipe line | Direct measurement |
| `ReceptName` | Recipe name | `string` | short text | nan | Name of the feed recipe | Direct measurement |
| `ScheduledDryWeightContent` | Scheduled dry weight content | `integer` | number | Calculated | Scheduled dry weight content | Calculated: ? |
| `ScheduledDryWeightContentPart` | Scheduled dry weight content part | `integer` | number | Calculated | Scheduled dry weight content part | Calculated: ? |
| `ScheduledDryWeightKg` | Scheduled dry weight kg | `number` | kg | Calculated | Scheduled dry weight kg | Calculated: ? |
| `ScheduledFeedFactor` | Scheduled feed factor | `integer` | number | nan | Scheduled feed factor | Direct measurement |
| `ScheduledPart` | Scheduled part | `integer` | number | Calculated | Scheduled part | Calculated: ? |
| `ScheduledProductKg` | Scheduled product kg | `number` | kg | nan | Scheduled product kg | Direct measurement |
| `ScheduledTime` | Scheduled time | `number` | hh-mm-ss | nan | Scheduled time, if log source 1 | Direct measurement |
| `SplittedNr` | Splitted number | `integer` | number | nan | Splitted number, only 1 | Direct measurement |
| `StartPosition` | Start position | `integer` | number | Measured | Start position, if subgroup not 0 | Direct measurement |
| `StartTime` | Start time | `number` | hh-mm-ss | Measured | Start time, if subgroup not 0 | Direct measurement |
| `StartWeight` | Start weight | `number` | kg | Measured | Start weight, if subgroup not 0 | Direct measurement |
| `StopPosition` | Stop position | `integer` | number | Measured | Stop position, if subgroup not 0 | Direct measurement |
| `StopTime` | Stop time | `number` | hh-mm-ss | Measured | Stop time, if subgroup not 0 | Direct measurement |
| `StopWeight` | Stop weight | `number` | kg | Measured | Stop weight, if subgroup not 0 | Direct measurement |
| `StrawGroup` | Straw group | `integer` | number | nan | Straw group | Direct measurement |
| `SubGroupNr` | Subgroup number | `integer` | number | nan | Number of the subgroup, 0 no subgroup | Direct measurement |
| `TakeoffTime` | Take off time | `number` | hh-mm-ss | Measured | Take off time, if log source 1 | Direct measurement |
| `TrackSection` | Track section | `integer` | number | nan | Track section, if subgroup 1 if there is no subgroup 0 | Direct measurement |


## Triomatic_RIC_drop

- **Underlying Source Table:** `t_raw_trioliet`
- **Total Variables:** 46

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `AnimalCount` | Animal count | `integer` | number | nan | The number of animals | Direct measurement |
| `Date` | Date | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date | Direct measurement |
| `Extra` | Extra | `integer` | number | nan | Extra information | Direct measurement |
| `FeedingGroup` | Feeding group | `integer` | number | Measured | Log source 0 = 1, log source 1 = NULL betekenis Feeding group? | Direct measurement |
| `filename` | Filename | `string` | short text | nan | Name of the file containing information | Direct measurement |
| `FinishedReady` | Finished ready | `string` | ? | nan | NULL? | Direct measurement |
| `GroupID` | Group ID | `integer` | number | nan | Id of the group | Direct measurement |
| `GroupName` | Group name | `string` | short text | nan | Name of the group | Direct measurement |
| `Id` | ID | `integer` | number | nan | ID | Direct measurement |
| `IngredientName` | Ingredient name | `string` | short text | nan | Name of the ingredient | Direct measurement |
| `k42` | k42 | `integer` | number | nan | Validation record for data processing | Direct measurement |
| `LogSource` | Log source | `integer` | number | nan | 0 meaning feed preparation, and 1 the distribution of feed to RIC bins | Direct measurement |
| `NettoLoadedWeight` | Netto loaded weight | `number` | kg | Measured | Netto weight loaded | Direct measurement |
| `NrOfSplittings` | Number of splittings | `integer` | number | nan | Number of splittings | Direct measurement |
| `NumberRecipeLines` | Number of recipe lines | `integer` | number | nan | Total number of recipe lines | Direct measurement |
| `OpdrachtID` | Job ID | `integer` | number | nan | Job ID | Direct measurement |
| `PerformedFeedFactor` | Performed feed factor | `integer` | number | nan | Performed feed factor | Direct measurement |
| `PerformedProductDryWeightKgAfterDrop` | Kg dry weight after drop | `number` | kg | Measured | Kg dry weight after drop | Direct measurement |
| `PerformedProductDryWeightPartAfterDrop` | Part of dry weight after drop | `number` | kg | Measured | Part of dry weight after drop | Direct measurement |
| `PerformedProductError` | Performed product error | `number` | kg | Calculated | Error, difference between Scheduled kg and performed kg feed | Calculated: ? |
| `PerformedProductKgAfterDrop` | Kg product after drop | `number` | kg | Measured | Kg product after drop | Direct measurement |
| `PerformedProductKgAtStop` | Kg product at stop | `number` | kg | Measured | Kg product at stop | Direct measurement |
| `PerformedTime` | Performed time | `number` | hh-mm-ss | Measured | Performed time | Direct measurement |
| `PushingGroup` | Pushing group | `integer` | number | nan | Pushing group | Direct measurement |
| `Ready` | Ready | `integer` | number | nan | Ready | Direct measurement |
| `ReadyTime` | Ready time | `number` | hh-mm-ss | nan | Ready time, if log source 1 | Direct measurement |
| `ReceptLineNr` | Recept line number | `integer` | number | nan | Current number of recipe line | Direct measurement |
| `ReceptName` | Recipe name | `string` | short text | nan | Name of the feed recipe | Direct measurement |
| `ScheduledDryWeightContent` | Scheduled dry weight content | `integer` | number | Calculated | Scheduled dry weight content | Calculated: ? |
| `ScheduledDryWeightContentPart` | Scheduled dry weight content part | `integer` | number | Calculated | Scheduled dry weight content part | Calculated: ? |
| `ScheduledDryWeightKg` | Scheduled dry weight kg | `number` | kg | Calculated | Scheduled dry weight kg | Calculated: ? |
| `ScheduledFeedFactor` | Scheduled feed factor | `integer` | number | nan | Scheduled feed factor | Direct measurement |
| `ScheduledPart` | Scheduled part | `integer` | number | Calculated | Scheduled part | Calculated: ? |
| `ScheduledProductKg` | Scheduled product kg | `number` | kg | nan | Scheduled product kg | Direct measurement |
| `ScheduledTime` | Scheduled time | `number` | hh-mm-ss | nan | Scheduled time, if log source 1 | Direct measurement |
| `SplittedNr` | Splitted number | `integer` | number | nan | Splitted number, only 1 | Direct measurement |
| `StartPosition` | Start position | `integer` | number | Measured | Start position, if subgroup not 0 | Direct measurement |
| `StartTime` | Start time | `number` | hh-mm-ss | Measured | Start time, if subgroup not 0 | Direct measurement |
| `StartWeight` | Start weight | `number` | kg | Measured | Start weight, if subgroup not 0 | Direct measurement |
| `StopPosition` | Stop position | `integer` | number | Measured | Stop position, if subgroup not 0 | Direct measurement |
| `StopTime` | Stop time | `number` | hh-mm-ss | Measured | Stop time, if subgroup not 0 | Direct measurement |
| `StopWeight` | Stop weight | `number` | kg | Measured | Stop weight, if subgroup not 0 | Direct measurement |
| `StrawGroup` | Straw group | `integer` | number | nan | Straw group | Direct measurement |
| `SubGroupNr` | Subgroup number | `integer` | number | nan | Number of the subgroup, 0 no subgroup | Direct measurement |
| `TakeoffTime` | Take off time | `number` | hh-mm-ss | Measured | Take off time, if log source 1 | Direct measurement |
| `TrackSection` | Track section | `integer` | number | nan | Track section, if subgroup 1 if there is no subgroup 0 | Direct measurement |


## GEA_gates

- **Underlying Source Table:** `T_RAW_Gea_Separatie`
- **Total Variables:** 5

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `cow` | Cow | `integer` | number | nan | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. Same as AnimalNo, is unique per date. | Direct measurement |
| `date` | Date | `date` | yy-mm-dd | Measured | Date of the data record | Direct measurement |
| `event` | Event | `integer` | number | nan | 0 = No gate action or weighting, 1 = selection gate A, 2 = selection gate B | Direct measurement |
| `gate` | Gate | `integer` | number | nan | Number of the gate | Direct measurement |
| `message` | Message | `string` | tekst | nan | ID and info gate action, weighting or selection has or has not taken place | Direct measurement |


## GEA_milkings

- **Underlying Source Table:** `T_RAW_Gea_milk`
- **Total Variables:** 13

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `Cow` | Cow | `integer` | number | nan | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. Same as AnimalNo, is unique per date. | Direct measurement |
| `IMDat` | Gea Date and time | `datetime` | yy-mm-dd-hh-mm-ss | nan | GEA, Date and time milking | Direct measurement |
| `Reg1` | Registration number | `integer` | text + number | nan | National registration number of the animal. | Direct measurement |
| `RespISO` | Responder number | `integer` | number | nan | Number of the cows responder | Direct measurement |
| `Name` | Name | `string` | N/A | nan | Number in GEA, should be same as cow | Direct measurement |
| `IMTim` | Gea time | `string` | N/A | nan | Time? | Direct measurement |
| `IMWt` | Cow Weight at Milking | `number` | kg | Measured | Live animal body weight measured by the integrated scale inside the GEA milking stall or exit platform. | Source: T_RAW_Gea_milk |
| `IMFlg` | Milking Status Flag | `string` | code | Measured | Status/diagnostic flag from GEA milking robot/parlor indicating normal completion, kick-off, or incomplete milking. | Source: T_RAW_Gea_milk |
| `IMDim` | Days in Milk | `integer` | days | Calculated | Days in Milk (DIM) recorded in GEA at the time of the milking event. | Calculated: Milking date minus most recent calving date. *(Source: T_RAW_Gea_milk)* |
| `IMAvFlo` | Avarage milkflow | `string` | N/A | nan | Average milkflow? | Direct measurement |
| `IMMxFlow` | Max. milkflow | `string` | N/A | nan | Max. milkflowAlleen '\|\|\|\|' als waarde??? | Direct measurement |
| `IMStall` | Gea barn | `integer` | number | nan | Place in the Gea milking carousel 1-40 | Direct measurement |
| `IMStartSec` | Gea start sec | `string` | N/A | nan | Alleen '?????' als waarde??? | Direct measurement |


## TMR_Trioliet_cowconnect_mix

- **Underlying Source Table:** `t_raw_cowconnect_mix`
- **Total Variables:** 12

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `date` | Date | `date` | yy-mm-dd | Measured | Date of the data record | Direct measurement |
| `externalFeedplanID` | External feedpland ID | `string` | ? | nan | All NULL | Direct measurement |
| `feedplanId` | Feedplan ID | `integer` | number | nan | Id of the feedplan | Direct measurement |
| `feedplanName` | Feedplan name | `string` | short text | nan | Name of the feedplan | Direct measurement |
| `id` | ID | `string` | short text | nan | ID | Direct measurement |
| `isOpen` | Is Open | `integer` | number | nan | 1 or 0 process running or not. | Direct measurement |
| `loadedSum` | Loaded som | `number` | kg | Calculated | Total / sum of all loads | Calculated: ? |
| `mixDate` | Mix date | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date and time | Direct measurement |
| `mixLoaderId` | Mix loader ID | `integer` | number | nan | ID of the mix loader | Direct measurement |
| `mixLoaderName` | Mix loader name | `string` | short text | nan | Name of the mix loader | Direct measurement |
| `rationId` | Ration ID | `string` | ? | nan | All NULL | Direct measurement |
| `type` | Type | `string` | short text | nan | Type | Direct measurement |


## Velos_behaviour

- **Underlying Source Table:** `T_RAW_velos_behaviour`
- **Total Variables:** 4

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `date` | Date | `date` | yy-mm-dd | Measured | Date of the data record, UTC timezone | Direct measurement |
| `cow` | Cow | `integer` | number | nan | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. Same as AnimalNo, is unique per date. | Direct measurement |
| `type` | Type | `string` | short text | nan | Type of behaviour 1 - 3 | Direct measurement |
| `duration` | Duration | `integer` | sec | Calculated | Duration of action/behaviour | Calculated: Calculated by endTime - startTime *(Source: ?)* |


## Velos_behaviour_day

- **Underlying Source Table:** `T_RAW_velos_behaviour`
- **Total Variables:** 7

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `date` | Date | `date` | yyyy-mm-dd | Measured | Date of the data record, UTC timezone | Direct measurement |
| `cow` | Cow | `integer` | number | nan | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. Same as AnimalNo, is unique per date. | Direct measurement |
| `total` | Total | `number` | hh-mm-ss | Calculated | Total time recorded of the animal 1 day | Calculated: Sum duration of all types *(Source: T_RAW_velos_behaviour)* |
| `overig` | Other | `number` | hh-mm-ss | Calculated | Time the cow is actief but not eating or ruminating | Calculated: Sum duration of type 0 *(Source: T_RAW_velos_behaviour)* |
| `nietactief` | Inactive | `number` | hh-mm-ss | Calculated | Time the cow is inactief | Calculated: Sum duration of type 1 *(Source: T_RAW_velos_behaviour)* |
| `herkouwen` | Ruminating | `number` | hh-mm-ss | Calculated | Time the cow spent ruminating | Calculated: Sum duration of type 2 *(Source: T_RAW_velos_behaviour)* |
| `vreten` | Eating | `number` | hh-mm-ss | Calculated | Time the cow spent eating | Calculated: Sum duration of type 3 *(Source: T_RAW_velos_behaviour)* |


## TMR_Trioliet_cowconnect_drop

- **Underlying Source Table:** `t_raw_cowconnect_drop`
- **Total Variables:** 11

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `id` | ID | `string` | short text | nan | ID | Direct measurement |
| `externalMixTaskId` | External mix task ID | `string` | short text | nan | External mix task ID | Direct measurement |
| `quantity` | Quantity | `number` | kg | Measured | Quantity | Direct measurement |
| `leftOverQuantity` | Left over quantity | `number` | kg | Measured | Quantity left over | Direct measurement |
| `noOfAnimals` | Number of animals | `integer` | number | nan | Number of animals | Direct measurement |
| `feedSectionName` | Feed section name | `string` | short text | nan | Name of the feed section | Direct measurement |
| `feedsectionType` | feed section type | `integer` | number | nan | Feedsection type | Direct measurement |
| `externalFeedSectionId` | External feed sectiond ID | `integer` | number | nan | External Feed section ID if the feed section has an external ID | Direct measurement |
| `externalMixTask` | External mix task | `string` | N/A | nan | nan | Direct measurement |
| `mix_id` | Mix ID | `string` | short text | nan | Mix ID and external mix task id are foreign keys of the ID (primairy key) | Direct measurement |
| `type` | Type | `string` | short text | nan | Type | Direct measurement |


## DC_DM_content

- **Underlying Source Table:** `VL_totaal_droogstoof`
- **Total Variables:** 16

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `BlkDat` | Can date | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date the can was weighed | Direct measurement |
| `BlkGew` | Can weight | `number` | gram | Measured | Weight of the can | Direct measurement |
| `BlkNum` | Can number | `integer` | number | nan | Number of the can | Direct measurement |
| `DatMon` | Sample date | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date the sample was obtained | Direct measurement |
| `DatSes` | Date session | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date of weigh session | Direct measurement |
| `DrgDat` | Dried date | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date end of the analysis | Direct measurement |
| `DrgGew` | Dried weight | `number` | gram | Measured | Dried sample weight, with or without weight of the can? | Direct measurement |
| `DrgStfGkg` | Dry matter weight kg | `number` | gram | Measured | Weight of the dry matter | Direct measurement |
| `DrgTyd` | dry time | `number` | hh-mm-ss | Measured | Time end of the analysis when all moisture has evaporated | Direct measurement |
| `ObjCod` | Object code | `string` | short text | nan | Short description/code of the sample | Direct measurement |
| `ObjCodNum` | Object code number | `integer` | number | nan | Used when analyzing duplicate or triplicate samples | Direct measurement |
| `PrjCod` | Project code | `string` | short text | nan | Project code | Direct measurement |
| `VlgNum` | Tracking number | `integer` | number | nan | Tracking number | Direct measurement |
| `VrsDat` | fresh date | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date start of the analysis | Direct measurement |
| `VrsGew` | fresh weight | `number` | gram | Measured | Weight at the start of the analysis | Direct measurement |
| `VrsTyd` | fresh time | `number` | hh-mm-ss | Measured | Time start of the analysis, fresh sample is weighed | Direct measurement |


## Greenfeed_summarized_data

- **Underlying Source Table:** `T_RAW_Greenfeed_Summarized_Data`
- **Total Variables:** 24

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `AirflowCf` | Airflow correction factor | `integer` | number | nan | Airflow correction factor | Direct measurement |
| `AirflowLitersPerSec` | Airflow liters per second | `integer` | Liter/sec | Measured | Airflow liters per second | Direct measurement |
| `AnimalName` | Animal name | `integer` | number | Measured | Animal name | Direct measurement |
| `CH4GramsPerDay` | CH4 grams per day | `integer` | number | Measured | CH4 grams per day, methane | Direct measurement |
| `CO2GramsPerDay` | CO2 grams per day | `integer` | number | Measured | CO2 grams per day, carbon dioxide | Direct measurement |
| `cow` | Cow | `integer` | number | nan | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. Same as AnimalNo, is unique per date. | Direct measurement |
| `date` | Date | `date` | yy-mm-dd | Measured | Date of the data record | Direct measurement |
| `EndTime` | End time | `number` | yy-mm-dd-hh-mm-ss | Measured | End time | Direct measurement |
| `GoodDataDuration` | Good data duration | `datetime` | hh-mm-ss | nan | Good data duration | Direct measurement |
| `greenfeed` | Greenfeed | `integer` | number | Measured | Greenfeed | Direct measurement |
| `H2GramsPerDay` | H2 grams per day | `integer` | number | Measured | H2 grams per day, hydrogen | Direct measurement |
| `H2SGramsPerDay` | H2S grams per day | `integer` | number | Measured | H2S grams per day, hydrogen sulfide | Direct measurement |
| `InterruptingTags` | Interrupting tags | `integer` | number | nan | Interrupting tags | Direct measurement |
| `IsPreliminary` | Is preliminary | `integer` | number | nan | Is preliminary data, validated data comes directly from C-lock. | Direct measurement |
| `O2GramsPerDay` | O2 grams per day | `integer` | number | Measured | O2 grams per day, oxygen | Direct measurement |
| `RFID` | Rfid | `integer` | number | nan | Rfid | Direct measurement |
| `RunTime` | Run time | `number` | yy-mm-dd-hh-mm-ss | Measured | Run time | Direct measurement |
| `StartTime` | Start time | `number` | hh-mm-ss | Measured | Start time, if subgroup not 0 | Direct measurement |
| `TempPipeDegreesCelsius` | Temperature pipe degrees celsius | `number` | °C | Measured | Temperature pipe degrees celsius | Direct measurement |
| `user` | User | `string` | short text | nan | User | Direct measurement |
| `WasInterrupted` | Was interrupted | `integer` | number | nan | Was interrupted | Direct measurement |
| `WindCf` | Wind correction factor | `integer` | number | nan | Wind correction factor | Direct measurement |
| `WindDirDeg` | Wind direction degrees | `integer` | number | Measured | Wind direction degrees | Direct measurement |
| `WindSpeedMetersPerSec` | Wind speed meters per second | `integer` | meter/sec | Measured | Wind speed meters per second | Direct measurement |


## Greenfeed_feed_aggregrated

- **Underlying Source Table:** `T_RAW_Greenfeed_Feed_data`
- **Total Variables:** 13

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `cow` | Cow | `integer` | number | nan | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. Same as AnimalNo, is unique per date. | Direct measurement |
| `CurrentCup` | Current cup | `integer` | number | Measured | Current cup | Direct measurement |
| `CurrentPeriod` | Current period | `integer` | number | Measured | Current period | Direct measurement |
| `date` | Date | `date` | yy-mm-dd | Measured | Date of the data record | Direct measurement |
| `DateTime` | Date and time | `datetime` | yyyy-mm-dd hh-mm-ss | Measured | Date and time | Direct measurement |
| `DropInterval` | Drop interval | `integer` | sec | ? | Min. sec between current en new cup | Direct measurement |
| `FeedType` | Feed type | `integer` | number | nan | Feed type | Direct measurement |
| `greenfeed` | Greenfeed | `integer` | number | Measured | Greenfeed | Direct measurement |
| `MaxCups` | Maximum cups | `integer` | number | nan | Max. cups per period | Direct measurement |
| `MaxPeriods` | Maximum periods | `integer` | number | nan | Max. periods per day | Direct measurement |
| `PeriodInterval` | Period interval | `integer` | sec | nan | Min. Sec between current en next period | Direct measurement |
| `RFIDTag` | Rfid tag | `integer` | number | Measured | Rfid tag | Direct measurement |
| `user` | User | `string` | short text | nan | User | Direct measurement |


## Weatherstation

- **Underlying Source Table:** `T_RAW_weerstation`
- **Total Variables:** 18

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
| `station_name` | Station name | `string` | short text | nan | Station name | Direct measurement |
| `symbol_number` | Symbol number | `string` | ? | ? | Symbol number | Direct measurement |
| `temperature_10` | Temperature 10 | `number` | °C | Measured | Temperature 10 cm above ground level. | Direct measurement |
| `temperature_150` | Temperature 150 | `number` | °C | Measured | Temperature 150 cm above ground level. | Direct measurement |
| `timestamp` | Timestamp | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Timestamp | Direct measurement |
| `wet_bulb_temperature` | Wet bulb temperature | `number` | °C | Measured | Thermometer with the bulb in somthing wet | Direct measurement |
| `wind_direction` | Wind direction | `string` | ° Degree | Measured | Direction from which the wind blows | Direct measurement |
| `windchill` | Windchill | `number` | °C | Measured | The cooling effect of wind blowing on a surface | Direct measurement |
| `windspeed` | Windspeed | `integer` | Beaufort, over 10 minuten (meter/sec)? | Measured | Rate at which wind/air is moving | Direct measurement |


## Missing_data

- **Underlying Source Table:** `tvl_totaal_missende_data_proef`
- **Total Variables:** 17

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `bcs` | Body condition score | `boolean` | Ja/Nee | Measured | Automatic body condition score camera | Direct measurement |
| `behcod` | Treatment code | `string` | Ja/Nee | Measured | Treatment code | Direct measurement |
| `bijzonderheden` | Particularities | `boolean` | Ja/Nee | Measured | Particularities | Direct measurement |
| `date` | Date | `date` | yy-mm-dd | Measured | Date of the data record | Direct measurement |
| `gewa` | Weight evening | `boolean` | Ja/Nee | Measured | Weight evening | Direct measurement |
| `gewgeaa` | Weight gea evening | `boolean` | Ja/Nee | Measured | Weight gea evening | Direct measurement |
| `gewgeao` | Weight gea morning | `boolean` | Ja/Nee | Measured | Weight gea morning | Direct measurement |
| `gewo` | Weight morning | `boolean` | Ja/Nee | Measured | Weight morning | Direct measurement |
| `hok` | Barn | `boolean` | Ja/Nee | Measured | Barn | Direct measurement |
| `kgmlka` | Kg milk evening | `boolean` | Ja/Nee | Measured | Kg milk evening | Direct measurement |
| `kgmlko` | Kg milk morning | `boolean` | Ja/Nee | Measured | Kg milk morning | Direct measurement |
| `oornum` | Ear number | `integer` | number | nan | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. | Direct measurement |
| `opnkv` | Intake feed | `boolean` | Ja/Nee | Measured | Intake feed | Direct measurement |
| `opnrv` | Intake roughage | `string` | Ja/Nee | Measured | Intake roughage | Direct measurement |
| `prdsta` | Production stage | `boolean` | Ja/Nee | Measured | Identifying the stage of the cow, producing milk or not | Direct measurement |
| `prfcod` | Trial code | `string` | Ja/Nee | Measured | Trial code | Direct measurement |
| `velos` | Velos | `boolean` | Ja/Nee | Measured | Velos cow behavior | Direct measurement |


## Environment_barn_Animal_day

- **Underlying Source Table:** `TVL_Dier_Datum_Stal`
- **Total Variables:** 52

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `AgeDAys` | Age | `integer` | number | Measured | Age of the animal in days | Direct measurement |
| `AnimalNumber` | Animal Number | `integer` | number | nan | Unique animal server identifier issued across the different systems at Dairy Campus | Direct measurement |
| `AntGewA` | Weight afternoon | `number` | kg | Measured | Weight of the animal after milking in the afternoon | Direct measurement |
| `AntGewO` | Weight morning | `number` | kg | Measured | Weight of the animal after milking in the morning | Direct measurement |
| `BirthDate` | Date of birth | `date` | yyyy-mm-dd | Measured | The cows date of birth | Direct measurement |
| `DateMelkCon4Wk` | Date of 4-Weekly Milk Recording | `date` | yyyy-mm-dd | Measured | Date of the most recent official 4-weekly milk control / recording event (MPR). | Source: T_Animal_MilkSamples |
| `DatGldTot` | Valid Until Date | `datetime` | yyyy-mm-dd | Calculated | Date until which the current housing, lactation, or trial assignment status remains valid. | Calculated: End validity date of status record. *(Source: TVL_Dier_Datum_Stal)* |
| `DaysInLactation` | Days in lactation | `integer` | number | Calculated | Amount of days producing milk | Calculated: Date - calving date *(Source: ?)* |
| `DryDate` | Start date dry period | `date` | yy-mm-dd | Measured | Starting date of the dry period | Direct measurement |
| `EarNumber` | Ear number | `integer` | number | nan | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. | Direct measurement |
| `Eiw` | Protein concentration standard | `number` | % | Calculated | Protein concentration of the monthly milk test | Calculated: Calculated by whom or what or how? *(Source: ?)* |
| `EndDate` | Ending date experiment | `date` | yy-mm-dd | Measured | Expected end date of the experiment | Direct measurement |
| `Ket` | Ketose concentration of the monthly milk test | `string` | Calculated | Calculated | number | Calculated: Laboratory diagnostic score from milk recording analysis. *(Source: T_Animal_MilkSamples)* |
| `ExpecCalvingDate` | Expected calving date | `date` | yy-mm-dd | Calculated | Expected calving date based on insemination date | Calculated: Calculated by ExpectedCalvingDate() function from last successful insemination. *(Source: t_animal_matings / ExpectedCalvingDate)* |
| `Fat%` | Calculated day fat concentration | `number` | % | Calculated | An estimated daily milk fat concentration based on the AO sampling and the corresponding milk yield of that day.  x | Calculated: Calculated by whom or what or how? *(Source: ?)* |
| `GewTot` | Weight totaal | `number` | kg | Measured | Average weight of the animal for the day. | Source: TVL_Dier_Gewicht_Etmaal |
| `IDNumber` | ID nummer | `integer` | National registration number of the animal. | Measured | Registration number same as LevNum | Source: t_animals |
| `InsiminationDate` | Insemination day | `date` | yy-mm-dd | Measured | Date of last insemination | Direct measurement |
| `Lac` | Lactose concentration standard | `number` | % | Calculated | Lactose of the monthly milk test | Calculated: Calculated by whom or what or how? *(Source: ?)* |
| `Lactose%` | Calculated day lactose concentration | `number` | % | Calculated | An estimated daily milk lactose concentration based on the AO sampling and the corresponding milk yield of that day. | Calculated: Calculated by whom or what or how? *(Source: ?)* |
| `LastCalvingDate` | Last calving date | `date` | yy-mm-dd | Measured | Date of last calving | Direct measurement |
| `Milk_Yield` | Milk Yield | `number` | kg | Calculated | Milk yield | Calculated: Verschil Milk_Yield, MilkYield en MilkDay? |
| `MilkAfternoon` | Milk Yield afternoon | `number` | kg | Calculated | Milk Yield afternoon | Calculated: nan |
| `MilkDay` | Milk Yield day | `number` | kg | Calculated | Milk Yield day | Calculated: nan |
| `MilkMorning` | Milk Yield morning | `number` | kg | Calculated | Milk Yield morning | Calculated: nan |
| `MilkYield` | Milk Yield | `number` | kg | Calculated | Milk yield | Calculated: nan |
| `MlkCon` | Milk Con? | `boolean` | boolean | Calculated | Indicator flag showing whether official milk recording (MPR) data was collected on this date. | Calculated: Boolean flag indicating presence of milk laboratory sample record. *(Source: T_Animal_MilkSamples)* |
| `NumberAnimal` | Number Animal | `integer` | number | nan | Unique animal server identifier issued across the different systems at Dairy Campus | Direct measurement |
| `NumberOLactations` | Parity | `integer` | number | Measured | Parity (amount of calvings) of the animal | Direct measurement |
| `NumbOfDates` | Number of dates? | `date` | count | Calculated | Count of observation days recorded for the animal within the experimental reporting period. | Calculated: Count of distinct active recording dates. *(Source: TVL_Dier_Datum_Proef)* |
| `Protein%` | Calculated day protein concentration | `number` | % | Calculated | An estimated daily milk protein concentration based on the AO sampling and the corresponding milk yield of that day. | Calculated: Calculated by whom or what or how? *(Source: ?)* |
| `SampleDateEvening` | Sample date evening | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date the sample was obtained during the evening | Direct measurement |
| `SampleDateMorning` | Sample date morning | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date the sample was obtained during the morning | Direct measurement |
| `SCC` | Calculated day somatic cell count | `string` | 1000 cells/mL | Calculated | An estimated daily somatic cell count based on the AO sampling and the corresponding milk yield of that day. | Calculated: Calculated by whom or what or how? *(Source: ?)* |
| `StartDate` | Start date | `datetime` | hh-mm-ss | Measured | Start date | Direct measurement |
| `Stl` | Barn Section | `string` | identifier | Measured | Physical barn building or housing section identifier at Dairy Campus. | Source: TVL_Dier_Datum_Stal |
| `SumVoeGft` | Total Feed Granted | `number` | kg | Calculated | Total amount of concentrate feed programmed/granted to the animal over the period. | Calculated: Sum of programmed concentrate feeding amounts. *(Source: TVL_Dier_Voeropname_KV_Etmaal)* |
| `SumVoeOpnm` | Total Feed Intake | `number` | kg | Calculated | Total actual concentrate feed consumed by the animal over the period. | Calculated: Sum of consumed concentrate intake amounts. *(Source: TVL_Dier_Voeropname_KV_Etmaal)* |
| `SumVoeRst` | Total Feed Residual | `number` | kg | Calculated | Total amount of unconsumed concentrate feed remaining in the troughs. | Calculated: Total Feed Granted minus Total Feed Intake. *(Source: TVL_Dier_Voeropname_KV_Etmaal)* |
| `Unit` | Unit / barn number | `integer` | number | nan | Location of where the cows are housed. | Direct measurement |
| `Ure` | Calculated day urea concentration | `string` | mg/dL | Calculated | An estimated daily milk urea concentration based on the AO sampling and the corresponding milk yield of that day. | Calculated: Calculated by whom or what or how? *(Source: ?)* |
| `Urea (mg/100g)` | Weekly milk urea concentration | `string` | mg/dL | Measured | Weekly milk urea concentration during the AO sampling for animals in an experiment. AO = avond ochtend (eveningn morning) sample, taken on Tuesday evening and Wednesday morning. So 2 values per week. | Direct measurement |
| `Vet` | Weekly milk fat concentration | `number` | % | Measured | Weekly milk fat concentration during the AO sampling for animals in an experiment. AO = avond ochtend (eveningn morning) sample, taken on Tuesday evening and Wednesday morning. So 2 values per week. | Direct measurement |
| `Week` | Week | `integer` | number | Measured | Calender week number of data record | Direct measurement |
| `WeekDay` | Day of the week | `string` | short text | nan | Abbreviaton of weekday (Ma = Monday, Di = Tuesday, Wo = Wednesday, Do = Thursday, Vr = Friday, Za = Saturday, Zo = Sunday) | Direct measurement |
| `WeightAfternoon` | Weight afternoon | `number` | kg | Measured | Weight of the animal after milking in the afternoon | Direct measurement |
| `WeightMorning` | Weight morning | `number` | kg | Measured | Weight of the animal after milking in the morning | Direct measurement |
| `Year` | number | `string` | N/A | nan | Measured | Direct measurement |
| `VrwDgn` | Expected Days | `integer` | days | Calculated | Expected remaining gestation days or planned days dry prior to the anticipated calving date. | Calculated: Expected calving date minus current date. *(Source: TVL_Dier_Datum_Stal)* |
| `AntMlkO` | Number of milkings morning | `integer` | number | Measured | How often an animal was milked in the morning. 1 is the assumed value. 0 means a missing value/something wrong with registration. 2+ means reattachment of the milking apparatus, can be outlier values. | Direct measurement |
| `AntMlkA` | Number of milkings afternoon | `integer` | number | Measured | How often an animal was milked in the afternoon. 1 is the assumed value. 0 means a missing value/something wrong with registration. 2+ means reattachment of the milking apparatus, can be outlier values. | Direct measurement |
| `Date` | Date | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date | Direct measurement |


## Environment_barn_Animal_experim

- **Underlying Source Table:** `?`
- **Total Variables:** 54

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `AntMlkA` | Number of milkings afternoon | `integer` | number | Measured | How often an animal was milked in the afternoon. 1 is the assumed value. 0 means a missing value/something wrong with registration. 2+ means reattachment of the milking apparatus, can be outlier values. | Direct measurement |
| `AntMlkO` | Number of milkings morning | `integer` | number | Measured | How often an animal was milked in the morning. 1 is the assumed value. 0 means a missing value/something wrong with registration. 2+ means reattachment of the milking apparatus, can be outlier values. | Direct measurement |
| `Date` | Date | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date | Direct measurement |
| `VrwDgn` | Expected Days | `integer` | days | Calculated | Expected remaining gestation days or planned days dry prior to the anticipated calving date. | Calculated: Expected calving date minus current date. *(Source: TVL_Dier_Datum_Stal)* |
| `AgeDays` | Age in Days | `integer` | days | Calculated | Age of the animal in days calculated as recording date minus birth date. | Calculated: Recording date - Birth date. *(Source: TVL_Dier_Datum_Stal)* |
| `AnimalNumber` | Animal Number | `integer` | number | nan | Unique animal server identifier issued across the different systems at Dairy Campus | Direct measurement |
| `BirthDate` | Date of birth | `date` | yyyy-mm-dd | Measured | The cows date of birth | Direct measurement |
| `DaysInLactation` | Days in lactation | `integer` | number | Calculated | Amount of days producing milk | Calculated: Date - calving date *(Source: ?)* |
| `DryDate` | Start date dry period | `date` | yy-mm-dd | Measured | Starting date of the dry period | Direct measurement |
| `EarNumber` | Ear number | `integer` | number | nan | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. | Direct measurement |
| `EndDate` | Ending date experiment | `date` | yy-mm-dd | Measured | Expected end date of the experiment | Direct measurement |
| `Fat%` | Calculated day fat concentration | `number` | % | Calculated | An estimated daily milk fat concentration based on the AO sampling and the corresponding milk yield of that day.  x | Calculated: Calculated by whom or what or how? *(Source: ?)* |
| `GewTot` | Total Weight | `number` | kg | Measured | Total live animal body weight (average or latest measurement for the date). | Source: TVL_Dier_Gewicht_Etmaal |
| `InsiminationDate` | Insemination day | `date` | yy-mm-dd | Measured | Date of last insemination | Direct measurement |
| `Ket` | Ketosis Indicator | `string` | code | Calculated | Ketosis classification indicator (0: healthy/negative, 1: suspected subclinical ketosis, 2: clinical ketosis). | Calculated: Laboratory diagnostic score from milk recording analysis. *(Source: T_Animal_MilkSamples)* |
| `Lactose%` | Calculated day lactose concentration | `number` | % | Calculated | An estimated daily milk lactose concentration based on the AO sampling and the corresponding milk yield of that day. | Calculated: Calculated by whom or what or how? *(Source: ?)* |
| `LastCalvingDate` | Last calving date | `date` | yy-mm-dd | Measured | Date of last calving | Direct measurement |
| `NumberAnimal` | Number Animal | `integer` | number | nan | Unique animal server identifier issued across the different systems at Dairy Campus | Direct measurement |
| `NumberOLactations` | Parity | `integer` | number | Measured | Parity (amount of calvings) of the animal | Direct measurement |
| `NumbOfDates` | Number of Dates | `date` | count | Calculated | Count of observation days recorded for the animal within the experimental reporting period. | Calculated: Count of distinct active recording dates. *(Source: TVL_Dier_Datum_Proef)* |
| `Projectcode` | Project Code | `string` | identifier | Measured | Unique research experiment / trial code (e.g. 4400003634). Same as prfcod. | Source: t_proef |
| `ProjectName` | Project Name | `string` | text | Measured | Official descriptive name of the research project or trial. Same as prfnam. | Source: t_proef |
| `Protein%` | Calculated day protein concentration | `number` | % | Calculated | An estimated daily milk protein concentration based on the AO sampling and the corresponding milk yield of that day. | Calculated: Calculated by whom or what or how? *(Source: ?)* |
| `SampleDateEvening` | Sample date evening | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date the sample was obtained during the evening | Direct measurement |
| `SampleDateMorning` | Sample date morning | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date the sample was obtained during the morning | Direct measurement |
| `SCC` | Calculated day somatic cell count | `string` | 1000 cells/mL | Calculated | An estimated daily somatic cell count based on the AO sampling and the corresponding milk yield of that day. | Calculated: Calculated by whom or what or how? *(Source: ?)* |
| `StartDate` | Start date | `datetime` | hh-mm-ss | Measured | Start date | Direct measurement |
| `SumVoeGft` | Total Feed Granted | `number` | kg | Calculated | Total amount of concentrate feed programmed/granted to the animal over the period. | Calculated: Sum of programmed concentrate feeding amounts. *(Source: TVL_Dier_Voeropname_KV_Etmaal)* |
| `SumVoeRst` | Total Feed Residual | `number` | kg | Calculated | Total amount of unconsumed concentrate feed remaining in the troughs. | Calculated: Total Feed Granted minus Total Feed Intake. *(Source: TVL_Dier_Voeropname_KV_Etmaal)* |
| `Unit` | Unit / barn number | `integer` | number | nan | Location of where the cows are housed. | Direct measurement |
| `Urea (mg/100g)` | Weekly milk urea concentration | `string` | mg/dL | Measured | Weekly milk urea concentration during the AO sampling for animals in an experiment. AO = avond ochtend (eveningn morning) sample, taken on Tuesday evening and Wednesday morning. So 2 values per week. | Direct measurement |
| `Week` | Week | `integer` | number | Measured | Calender week number of data record | Direct measurement |
| `WeekDay` | Day of the week | `string` | short text | nan | Abbreviaton of weekday (Ma = Monday, Di = Tuesday, Wo = Wednesday, Do = Thursday, Vr = Friday, Za = Saturday, Zo = Sunday) | Direct measurement |
| `WeightAfternoon` | Weight afternoon | `number` | kg | Measured | Weight of the animal after milking in the afternoon | Direct measurement |
| `WeightMorning` | Weight morning | `number` | kg | Measured | Weight of the animal after milking in the morning | Direct measurement |
| `Year` | number | `string` | N/A | nan | Measured | Direct measurement |
| `AntGewA` | Weight afternoon | `number` | kg | Measured | Weight of the animal after milking in the afternoon | Direct measurement |
| `AntGewO` | Weight morning | `number` | kg | Measured | Weight of the animal after milking in the morning | Direct measurement |
| `IDNumber` | Animal Identification Number | `string` | identifier | Measured | Official national unique life identification number of the animal (LevNum / EU identification tag). | Source: t_animals |
| `DateMelkCon4Wk` | Date of 4-Weekly Milk Recording | `date` | yyyy-mm-dd | Measured | Date of the most recent official 4-weekly milk control / recording event (MPR). | Source: T_Animal_MilkSamples |
| `DatGldTot` | Valid Until Date | `datetime` | yyyy-mm-dd | Calculated | Date until which the current housing, lactation, or trial assignment status remains valid. | Calculated: End validity date of status record. *(Source: TVL_Dier_Datum_Stal)* |
| `Eiw` | Protein concentration standard | `number` | % | Calculated | Protein concentration of the monthly milk test | Calculated: Calculated by whom or what or how? *(Source: ?)* |
| `ExpecCalvingDate` | Expected Calving Date | `date` | yyyy-mm-dd | Calculated | Estimated date of the next calving, based on confirmed insemination date + gestation length (~270-280 days). | Calculated: Calculated by ExpectedCalvingDate() function from last successful insemination. *(Source: t_animal_matings / ExpectedCalvingDate)* |
| `Lac` | Lactose concentration standard | `number` | % | Calculated | Lactose of the monthly milk test | Calculated: Calculated by whom or what or how? *(Source: ?)* |
| `Milk_Yield` | Milk Yield | `number` | kg | Calculated | Milk yield | Calculated: Verschil Milk_Yield, MilkYield en MilkDay? |
| `MilkAfternoon` | Milk Yield afternoon | `number` | kg | Calculated | Milk Yield afternoon | Calculated: nan |
| `MilkDay` | Milk Yield day | `number` | kg | Calculated | Milk Yield day | Calculated: nan |
| `MilkMorming` | Morning Milk Yield | `number` | kg | Measured | Total quantity of milk produced during morning milking sessions. | Source: TVL_Dier_Melkgift_Etmaal_Melkcontrole |
| `MilkYield` | Milk Yield | `number` | kg | Calculated | Milk yield | Calculated: nan |
| `MlkCon` | Milk Recording Present | `boolean` | boolean | Calculated | Indicator flag showing whether official milk recording (MPR) data was collected on this date. | Calculated: Boolean flag indicating presence of milk laboratory sample record. *(Source: T_Animal_MilkSamples)* |
| `Stl` | Barn Section | `string` | identifier | Measured | Physical barn building or housing section identifier at Dairy Campus. | Source: TVL_Dier_Datum_Stal |
| `Ure` | Calculated day urea concentration | `string` | mg/dL | Calculated | An estimated daily milk urea concentration based on the AO sampling and the corresponding milk yield of that day. | Calculated: Calculated by whom or what or how? *(Source: ?)* |
| `Vet` | Weekly milk fat concentration | `number` | % | Measured | Weekly milk fat concentration during the AO sampling for animals in an experiment. AO = avond ochtend (eveningn morning) sample, taken on Tuesday evening and Wednesday morning. So 2 values per week. | Direct measurement |
| `SumVoeOpnm` | Total Feed Intake | `number` | kg | Calculated | Total actual concentrate feed consumed by the animal over the period. | Calculated: Sum of consumed concentrate intake amounts. *(Source: TVL_Dier_Voeropname_KV_Etmaal)* |


