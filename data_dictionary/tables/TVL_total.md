# Daily Total Cow Research Summary (TVL_total)

**Dataset Identifier:** `TVL_total`  
**Underlying Database Source:** `tvl_totaal_bedrijf / tvl_totaal_bedrijf_proef`  
**Observation Granularity:** One row per animal per calendar day  

## Description

Comprehensive daily summary per cow integrating all individual data sources: animal demographics, lactation stage, roughage intake (fractions 1-4, fresh and water-excluded), dry matter intake, concentrate intake across stations, morning/evening milk production, official milk test recording components (fat, protein, lactose, urea, SCC), body condition score (BCS), GreenFeed visits, and live body weight.

## Variables & Data Dictionary

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `AnimalServerId` | Animal server number | `integer` | number | N/A | Unique animal server identifier issued across the different systems at Dairy Campus | Direct measurement |
| `AntMlkA` | Number of milkings afternoon | `integer` | number | Measured | How often an animal was milked in the afternoon. 1 is the assumed value. 0 means a missing value/something wrong with registration. 2+ means reattachment of the milking apparatus, can be outlier values. | Direct measurement |
| `AntMlkEtm` | Number of milkings 24 hours | `integer` | number | Measured | Amount of milkings in the last 24 hours. 2 is the assumed value. 1 or 3+ means something is off during morning and/or afternoon milking. | Direct measurement |
| `AntMlkO` | Number of milkings morning | `integer` | number | Measured | How often an animal was milked in the morning. 1 is the assumed value. 0 means a missing value/something wrong with registration. 2+ means reattachment of the milking apparatus, can be outlier values. | Direct measurement |
| `bcs` | Body condition score | `integer` | number | Measured | Automatic body condition score camera | Direct measurement |
| `BegDatPrf` | Starting date experiment | `date` | yy-mm-dd | Measured | Expected start date of the experiment | Direct measurement |
| `BehCod` | Treatment code | `string` | short text | N/A | Abbreviaton of the treatname name. Set by the researcher. | Direct measurement |
| `BehNam` | Treatment name | `string` | short text | N/A | Full name of the treatment. Set by the researcher | Direct measurement |
| `Blk` | Blocking group | `integer` | number | N/A | Number of the assigned block. Set by the researcher. | Direct measurement |
| `C21-10` | Total concentrate via station 1 till 4 | `number` | kg | Calculated | Dag totaal krachtvoer caroussel | **Calculated**: ??? Sum of distributed concentrate feed at the specific day? *(Source: ?)* |
| `C21-9` | Concentrate feed milking caroussel | `number` | kg | N/A | Kilogram of concentrate feed dispatched at the milking caroussel. NOT the uptake, that cannot be registered currently. | Direct measurement |
| `CelStd` | Somatic cell count standard | `string` | x1000 cells/mL | Calculated | Somatic cell count of the monthly milk test | **Calculated**: Official somatic cell count (SCC) determined from routine 4-weekly milk recording samples (MPR), analyzed by laboratory. *(Source: T_Animal_MilkSamples (MlkCon.SCCDay))* |
| `Dat` | Date | `date` | yy-mm-dd | Measured | Date of the data record | Direct measurement |
| `DelPro-13` | Feed from the milking robot | `number` | kg | N/A | Intake feed 1 from the milkingrobot | Direct measurement |
| `DrgZetDat` | Start date dry period | `date` | yy-mm-dd | Measured | Starting date of the dry period | Direct measurement |
| `EiwStd` | Protein concentration standard | `number` | % | Calculated | Protein concentration of the monthly milk test | **Calculated**: Milk crude protein percentage determined from official routine milk recording laboratory analysis. *(Source: T_Animal_MilkSamples (MlkCon.ProteinPercentage))* |
| `EndDatPrf` | Ending date experiment | `date` | yy-mm-dd | Measured | Expected end date of the experiment | Direct measurement |
| `GewA` | Weight afternoon | `number` | kg | Measured | Weight of the animal after milking in the afternoon | Direct measurement |
| `GewO` | Weight morning | `number` | kg | Measured | Weight of the animal after milking in the morning | Direct measurement |
| `gf_visits` | GreenFeed measurements | `string` | N/A | Measured | Measurements on cow emission (summarized data) | Direct measurement |
| `gf_cupdrops` | GreenFeed cupdrops | `string` | N/A | Measured | GreenFeed portions concentrate feed. | Direct measurement |
| `Hok` | Pen / Stable number | `integer` | number | N/A | Location of where the cows are housed. | Direct measurement |
| `HokMin1` | Pen / Stable number day before | `integer` | number | N/A | Location of where the cows are housed day before | Direct measurement |
| `AtributedKVA` | Attributed Concentrate A | `number` | kg | Calculated | Total allocated/programmed amount of concentrate feed type A for the cow on the specified date. | **Calculated**: Sum of programmed concentrate A quantities across feeding stations (Hokofarm / SAC). *(Source: T_Raw_HokofarmCD / TVL_Totaal_sub_kv)* |
| `TotalIntakeKVA` | Concentrate feed station 1 | `number` | kg | Calculated | Total intake feed from SAC box 1 | **Calculated**: Total consumed quantity of concentrate feed A by the animal at the automatic feeding station on the specified date. *(Source: T_Raw_HokofarmCD (totalIntakeKVA))* |
| `AtributedKVB` | Attributed Concentrate B | `number` | kg | Calculated | Total allocated/programmed amount of concentrate feed type B for the cow on the specified date. | **Calculated**: Sum of programmed concentrate B quantities across feeding stations (Hokofarm / SAC). *(Source: T_Raw_HokofarmCD / TVL_Totaal_sub_kv)* |
| `TotalIntakeKVB` | Concentrate feed station 2 | `number` | kg | Calculated | Total intake feed from SAC box 2 | **Calculated**: Total consumed quantity of concentrate feed B by the animal at the automatic feeding station on the specified date. *(Source: T_Raw_HokofarmCD (totalIntakeKVB))* |
| `AtributedKVC` | Attributed Concentrate C | `number` | kg | Calculated | Total allocated/programmed amount of concentrate feed type C for the cow on the specified date. | **Calculated**: Sum of programmed concentrate C quantities across feeding stations (Hokofarm / SAC). *(Source: T_Raw_HokofarmCD / TVL_Totaal_sub_kv)* |
| `TotalIntakeKVC` | Concentrate feed station 3 | `number` | kg | Calculated | Total intake feed from SAC box 3 | **Calculated**: Total consumed quantity of concentrate feed C by the animal at the automatic feeding station on the specified date. *(Source: T_Raw_HokofarmCD (totalIntakeKVC))* |
| `AtributedKVD` | Attributed Concentrate D | `number` | kg | Calculated | Total allocated/programmed amount of concentrate feed type D for the cow on the specified date. | **Calculated**: Sum of programmed concentrate D quantities across feeding stations (Hokofarm / SAC). *(Source: T_Raw_HokofarmCD / TVL_Totaal_sub_kv)* |
| `TotalIntakeKVD` | Concentrate feed station 4 | `number` | kg | Calculated | Total intake feed from SAC box 4 | **Calculated**: Total consumed quantity of concentrate feed D by the animal at the automatic feeding station on the specified date. *(Source: T_Raw_HokofarmCD (totalIntakeKVD))* |
| `HrhNum` | Repeating number | `integer` | number | N/A | Number of repeat of a previously performed test | Direct measurement |
| `InsDat` | Insemination day | `date` | yy-mm-dd | Measured | Date of last insemination | Direct measurement |
| `Jar` | Year | `integer` | number | Measured | Year of the data record | Direct measurement |
| `KetStd` | Ketose concentration standard | `integer` | number | Calculated | Ketose concentration of the monthly milk test | **Calculated**: Ketosis diagnostic classification code (0: normal/negative, 1: suspected subclinical, 2: clinical ketosis). *(Source: T_Animal_MilkSamples (MlkCon.KetosisCode))* |
| `KgMlkA` | Kilogram milk afternoon | `number` | kg | Measured | Kilogram of milk registred at the afternoon milking event | Direct measurement |
| `KgMlkEtm` | Kilogram milk 24 hours | `number` | kg | Measured | Kilogram of milk in the last 24 hours | Direct measurement |
| `KgMlkO` | Kilogram milk morning | `number` | kg | Measured | Kilogram of milk registred at the morning milking event | Direct measurement |
| `KlfDat` | Calving date | `date` | yy-mm-dd | Measured | Date of last calving | Direct measurement |
| `LacDgn` | Days in lactation | `integer` | number | Calculated | Amount of days producing milk | **Calculated**: Date - calving date *(Source: ?)* |
| `LacNum` | Parity | `integer` | number | Measured | Parity (amount of calvings) of the animal | Direct measurement |
| `LacStd` | Lactose concentration standard | `number` | % | Calculated | Lactose of the monthly milk test | **Calculated**: Milk lactose percentage determined from official routine milk recording laboratory analysis. *(Source: T_Animal_MilkSamples (MlkCon.LactosePercentage))* |
| `LevNum` | Registration number | `integer` | text + number | N/A | National registration number of the animal. | Direct measurement |
| `LftDgn` | Age | `integer` | number | Measured | Age of the animal in days | Direct measurement |
| `MlkStd` | Milk standard | `number` | kg | Calculated | Kilogram of milk produced during the standard (once a month) milk composition sampling | **Calculated**: Total daily milk yield recorded during the official milk control recording day. *(Source: T_Animal_MilkSamples (MlkCon.MilkQuantityMass))* |
| `mpr_dag.Fat_Concentration` | Weekly milk fat concentration | `number` | % | Measured | Weekly milk fat concentration during the AO sampling for animals in an experiment. AO = avond ochtend (eveningn morning) sample, taken on Tuesday evening and Wednesday morning. So 2 values per week. | Direct measurement |
| `mpr_dag.Lactose_Concentration` | Weekly milk lactose concentration | `number` | % | Measured | Weekly milk lactose concentration during the AO sampling for animals in an experiment. AO = avond ochtend (eveningn morning) sample, taken on Tuesday evening and Wednesday morning. So 2 values per week. | Direct measurement |
| `mpr_dag.Protein_Concentration` | Weekly milk protein concentration | `number` | % | Measured | Weekly milk protein concentration during the AO sampling for animals in an experiment. AO = avond ochtend (eveningn morning) sample, taken on Tuesday evening and Wednesday morning. So 2 values per week. | Direct measurement |
| `mpr_dag.SCC` | Weekly somatic cell count | `string` | 1000 cells/mL | Measured | Weekly somatic cell count during the AO sampling for animals in an experiment. AO = avond ochtend (eveningn morning) sample, taken on Tuesday evening and Wednesday morning. So 2 values per week. | Direct measurement |
| `mpr_dag.Urea_Concentration` | Weekly milk urea concentration | `string` | mg/dL | Measured | Weekly milk urea concentration during the AO sampling for animals in an experiment. AO = avond ochtend (eveningn morning) sample, taken on Tuesday evening and Wednesday morning. So 2 values per week. | Direct measurement |
| `mpr_week.Fat_Concentration` | Calculated day fat concentration | `number` | % | Calculated | An estimated daily milk fat concentration based on the AO sampling and the corresponding milk yield of that day.  x | **Calculated**: ISO-calendar week yield-weighted average milk fat concentration calculated across regular CRV/MPR test recordings: sum(Fat_Concentration * MilkingYield) / sum(MilkingYield). Used to derive Fat- and Protein-Corrected Milk (FPCM). *(Source: VL_Dier_Datum_Crv)* |
| `mpr_week.Lactose_Concentration` | Calculated day lactose concentration | `number` | % | Calculated | An estimated daily milk lactose concentration based on the AO sampling and the corresponding milk yield of that day. | **Calculated**: ISO-calendar week yield-weighted average milk lactose concentration calculated across regular CRV/MPR test recordings: sum(Lactose_Concentration * MilkingYield) / sum(MilkingYield). *(Source: VL_Dier_Datum_Crv)* |
| `mpr_week.Protein_Concentration` | Calculated day protein concentration | `number` | % | Calculated | An estimated daily milk protein concentration based on the AO sampling and the corresponding milk yield of that day. | **Calculated**: ISO-calendar week yield-weighted average milk protein concentration calculated across regular CRV/MPR test recordings: sum(Protein_Concentration * MilkingYield) / sum(MilkingYield). Used to derive Fat- and Protein-Corrected Milk (FPCM). *(Source: VL_Dier_Datum_Crv)* |
| `mpr_week.SCC` | Calculated day somatic cell count | `string` | 1000 cells/mL | Calculated | An estimated daily somatic cell count based on the AO sampling and the corresponding milk yield of that day. | **Calculated**: ISO-calendar week yield-weighted average somatic cell count (1,000 cells/mL) calculated across regular CRV/MPR test recordings: sum(SCC * MilkingYield) / sum(MilkingYield). *(Source: VL_Dier_Datum_Crv)* |
| `mpr_week.Urea_Concentration` | Calculated day urea concentration | `string` | mg/dL | Calculated | An estimated daily milk urea concentration based on the AO sampling and the corresponding milk yield of that day. | **Calculated**: ISO-calendar week yield-weighted average milk urea concentration (mg/dL) calculated across regular CRV/MPR test recordings: sum(Urea_Concentration * MilkingYield) / sum(MilkingYield). *(Source: VL_Dier_Datum_Crv)* |
| `OorNum` | Ear number | `integer` | number | N/A | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. | Direct measurement |
| `OpnRvDsHans` | Intake roughage dry matter Hans | `string` | N/A | N/A | Intake of dry matter from the roughage, Hans (Will be removed from table) | Direct measurement |
| `PrdSta` | Production stage | `string` | short text | N/A | Identifying the stage of the cow, producing milk or not | Direct measurement |
| `PrfCod` | Experiment number | `integer` | number | N/A | Code assigned by Dairy Campus to identify the experiment. Can be the same as the MyProjects number, or differ. | Direct measurement |
| `RowID` | Row ID | `integer` | number | N/A | Unique number for row in a specific table. | Direct measurement |
| `rv1.ds` | Roughage 1 dry matter | `string` | N/A | N/A | Roughage 1 dry matter | Direct measurement |
| `rv1.name` | Roughage name 1 | `string` | short text | N/A | Name of the roughage treatment consumed by the animal | Direct measurement |
| `rv1.opnDs` | Roughage 1 intake dry matter | `string` | N/A | N/A | Roughage 1 intake dry matter | Direct measurement |
| `rv1.Prod` | Roughage product 1 | `number` | kg | Calculated | Total uptake in kilograms of the roughage | **Calculated**: Sum of roughage intake of all visits in a single day. The roughage bin calculates uptake as: starting weight - end weight (bins contains a scale) *(Source: ?)* |
| `rv1.ProdExclWater` | Roughage 1 intake excluding water | `number` | kg | Calculated | Total uptake in kilograms of the roughage excluding water | **Calculated**: Daily roughage intake fraction 1 excluding added water: (TotalLoaded - AddedWaterKg) / TotalLoaded * Intake. *(Source: VL_Totaal_sub_ric_opn_prod)* |
| `rv1.ricBez` | Roughage 1 RIC bin visits | `integer` | number | Measured | Amount of times the animal visited the roughage bins to consume the roughage. | Direct measurement |
| `rv1.trBatches` | Roughage 1 batches | `integer` | number | Measured | Amount of different batches distributed by the feeding robot that the animal consumed for its total roughage uptake | Direct measurement |
| `rv2.ds` | Roughage 2 dry matter | `number` | kg | N/A | Roughage 2 dry matter | Direct measurement |
| `rv2.name` | Roughage name 2 | `string` | short text | N/A | Name of the roughage treatment consumed by the animal. These are only active (2, 3 and 4) when the animal consumes roughage from a treatment she isn't assigned to. | Direct measurement |
| `rv2.opnDs` | Roughage 2 intake dry matter | `number` | kg | N/A | Roughage 2 intake dry matter | Direct measurement |
| `rv2.Prod` | Roughage product 2 | `number` | kg | Calculated | Total uptake in kilograms of the roughage. | **Calculated**: ? |
| `rv2.ProdExclWater` | Roughage 2 intake excluding water | `number` | kg | Calculated | Total uptake in kilograms of the roughage excluding water | **Calculated**: Daily roughage intake fraction 2 excluding added water: (TotalLoaded - AddedWaterKg) / TotalLoaded * Intake. *(Source: VL_Totaal_sub_ric_opn_prod)* |
| `rv2.ricBez` | Roughage 2 RIC bin visits | `integer` | number | Measured | Amount of times the animal visited the roughage bins to consume the roughage. | Direct measurement |
| `rv2.trBatches` | Roughage 2 batches | `integer` | number | Measured | Amount of different batches distributed by the feeding robot that the animal consumed for its total roughage uptake | Direct measurement |
| `rv3.ds` | Roughage 3 dry matter | `number` | kg | N/A | Roughage 3 dry matter | Direct measurement |
| `rv3.name` | Roughage name 3 | `string` | short text | N/A | Name of the roughage treatment consumed by the animal. These are only active (2, 3 and 4) when the animal consumes roughage from a treatment she isn't assigned to. | Direct measurement |
| `rv3.opnDs` | Roughage 3 intake dry matter | `number` | kg | N/A | Roughage 3 intake dry matter | Direct measurement |
| `rv3.Prod` | Roughage product 3 | `number` | kg | Calculated | Total uptake in kilograms of the roughage. | **Calculated**: Sum of roughage intake of all visits in a single day. The roughage bin calculates uptake as: starting weight - end weight (bins contains a scale) *(Source: ?)* |
| `rv3.ProdExclWater` | Roughage 3 intake excluding water | `number` | kg | Calculated | Total uptake in kilograms of the roughage excluding water | **Calculated**: Daily roughage intake fraction 3 excluding added water: (TotalLoaded - AddedWaterKg) / TotalLoaded * Intake. *(Source: VL_Totaal_sub_ric_opn_prod)* |
| `rv3.ricBez` | Roughage 3 RIC bin visits | `integer` | number | Measured | Amount of times the animal visited the roughage bins to consume the roughage. | Direct measurement |
| `rv3.trBatches` | Roughage 3 batches | `integer` | number | Measured | Amount of different batches distributed by the feeding robot that the animal consumed for its total roughage uptake | Direct measurement |
| `rv4.ds` | Roughage 4 dry matter | `number` | kg | N/A | Roughage 4 dry matter | Direct measurement |
| `rv4.name` | Roughage name 4 | `string` | short text | N/A | Name of the roughage treatment consumed by the animal. These are only active (2, 3 and 4) when the animal consumes roughage from a treatment she isn't assigned to. | Direct measurement |
| `rv4.opnDs` | Roughage 4 intake dry matter | `number` | kg | N/A | Roughage 4 intake dry matter | Direct measurement |
| `rv4.Prod` | Roughage product 4 | `number` | kg | Calculated | Total uptake in kilograms of the roughage. | **Calculated**: Sum of roughage intake of all visits in a single day. The roughage bin calculates uptake as: starting weight - end weight (bins contains a scale) *(Source: ?)* |
| `rv4.ProdExclWater` | Roughage 4 intake excluding water | `number` | kg | Calculated | Total uptake in kilograms of the roughage excluding water | **Calculated**: Daily roughage intake fraction 4 excluding added water: (TotalLoaded - AddedWaterKg) / TotalLoaded * Intake. *(Source: VL_Totaal_sub_ric_opn_prod)* |
| `rv4.ricBez` | Roughage 4 RIC bin visits | `integer` | number | Measured | Amount of times the animal visited the roughage bins to consume the roughage. | Direct measurement |
| `rv4.trBatches` | Roughage 4 batches | `integer` | number | Measured | Amount of different batches distributed by the feeding robot that the animal consumed for its total roughage uptake | Direct measurement |
| `tot.opnDs` | Total intake drymatter | `number` | kg | Calculated | Total uptake in kilograms of dry matter | **Calculated**: Total daily dry matter intake (kg DM/day). Calculated by summing the dry matter intake of all roughage fractions: (OpnMinWater * DryMatterPercentage). *(Source: VL_Totaal_sub_ric_opn_prod)* |
| `tot.Prod` | Total product | `number` | kg | N/A | Total roughage 1 t/m 4 | Direct measurement |
| `UreStd` | Urea concentration standard | `number` | mg/100 gram | Calculated | Urea concentration of the monthly milk test | **Calculated**: Milk urea nitrogen content determined from official routine milk recording laboratory analysis. *(Source: T_Animal_MilkSamples (MlkCon.Urea))* |
| `VetStd` | Fat concentration standard | `number` | % | Calculated | Fat concentration of the monthly milk test | **Calculated**: Milk fat percentage determined from official routine milk recording laboratory analysis. *(Source: T_Animal_MilkSamples (MlkCon.FatPercentage))* |
| `VlgKlfDat` | Next calving date | `date` | yy-mm-dd | Calculated | Next calving date, not predicted, but added after calving | **Calculated**: ? |
| `VrwDgn` | Expected number of days | `integer` | number | Calculated | Number of days from date to expected calving date based on insemination date | **Calculated**: Expected calving date minus current date. *(Source: TVL_Dier_Datum_Stal)* |
| `VrwKlfDat` | Expected calving date | `date` | yy-mm-dd | Calculated | Expected calving date based on insemination date | **Calculated**: Insemination date + 280 days *(Source: ?)* |
| `Wek` | Week | `integer` | number | Measured | Calender week number of data record | Direct measurement |
| `WekDag` | Day of the week | `string` | short text | N/A | Abbreviaton of weekday (Ma = Monday, Di = Tuesday, Wo = Wednesday, Do = Thursday, Vr = Friday, Za = Saturday, Zo = Sunday) | Direct measurement |
