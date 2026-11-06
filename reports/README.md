# Research Trial Extraction Queries (`reports/`)

## Overview

The SQL queries in this directory are used by the automated data pipeline (orchestrated via **Apache Airflow**, specifically `report.py`) at Dairy Campus (Wageningen University & Research) to extract standardized research datasets for individual scientific trials.

Each experimental trial at Dairy Campus is assigned a unique trial / project code (`prfcod`, e.g., `4400003634`). When exporting data for researchers, analysts, or Zenodo deposits, the pipeline substitutes the placeholder token:

```sql
WHERE prfcod = '[prfcod]'
```

with the active experiment code. This ensures that researchers receive precisely the subset of high-resolution sensor observations, animal physiological records, and environmental conditions corresponding to the animals assigned to that specific scientific study.

---

## Catalog of Extraction Queries

| Query File | Output Research Dataset | Description & Primary Table Joined |
|:---|:---|:---|
| [`Agrovision_breeds.sql`](Agrovision_breeds.sql) | Cattle Breed Composition | Extracts breed composition and genetic percentages (`T_Animal_AnimalBreedCompositions`) for cows enrolled in the trial. |
| [`Agrovision_diagnosis.sql`](Agrovision_diagnosis.sql) | Veterinary Diagnoses | Veterinary health diagnoses, disorder descriptions, categories, and hoof/limb locations (`T_Animal_Diagnosis`). |
| [`Agrovision_treatments.sql`](Agrovision_treatments.sql) | Veterinary Treatments | Medical treatments, drug administrations, active substances, dosages, withdrawal periods (`T_Animal_TreatmentActions`). |
| [`Agrovision_weighings.sql`](Agrovision_weighings.sql) | Body Weights | Automated walkthrough scale body weight recordings (`TB_Animal_AnimalWeighings`). |
| [`DC_DM_content.sql`](DC_DM_content.sql) | Dry Matter Content | Official laboratory oven dry matter test results (`VL_totaal_droogstoof`) matched to feed batches and trial dates. |
| [`Environment_barn_Airkoe.sql`](Environment_barn_Airkoe.sql) | Barn Curtain & Climate | Ventilation curtain positions, indoor temperatures across barn compartments (stallen 50–73), and outdoor weather (`T_RAW_gordijnen`). |
| [`Environment_barn_Animal_day.sql`](Environment_barn_Animal_day.sql) | Animal Daily Profile | Daily animal profile joining housing location/pen, age, lactation days, and daily production (`TVL_Dier_Datum_Stal`). |
| [`Environment_barn_Animal_experiment.sql`](Environment_barn_Animal_experiment.sql) | Experimental Cohort Daily | Experiment-specific daily tracking joining treatments, blocks, milkings, and intake (`TVL_Dier_Datum_Proef`). |
| [`GEA_gates.sql`](GEA_gates.sql) | Smart Gate Passages | Cow routing and separation passages through GEA automated selection gates (`T_RAW_Gea_Separatie`). |
| [`GEA_milkings.sql`](GEA_milkings.sql) | Milking Transactions | Individual robot / parlor milking transactions including yields, conductivity, and durations (`T_RAW_Gea_milk`). |
| [`Greenfeed_feed.sql`](Greenfeed_feed.sql) | GreenFeed Bait Feeder | Bait feed dispensed by GreenFeed emission units during animal visits (`T_RAW_Greenfeed_Feed_data`). |
| [`Greenfeed_feed_aggregrated.sql`](Greenfeed_feed_aggregrated.sql) | Daily GreenFeed Bait | Daily aggregated bait feed drops per animal at GreenFeed stations. |
| [`Greenfeed_rfid.sql`](Greenfeed_rfid.sql) | GreenFeed RFID Transponders | RFID ear tag transponder readings at GreenFeed units (`T_RAW_Greenfeed_RFID_data`). |
| [`Greenfeed_summarized_data.sql`](Greenfeed_summarized_data.sql) | Enteric Emission Visits | Validated visit-level enteric methane (CH4) and carbon dioxide (CO2) emission flux summaries (`T_RAW_Greenfeed_Summarized_Data`). |
| [`Greenfeed_summarized_data_final.sql`](Greenfeed_summarized_data_final.sql) | Emission Summaries (Final) | Quality-filtered, validated GreenFeed visit emission metrics (`T_RAW_Greenfeed_Summarized_Data_final`). |
| [`Hokofarm_Ric.sql`](Hokofarm_Ric.sql) | RIC Roughage Feeding Visits | High-resolution visit records from Hokofarm RIC weighing feed troughs (`VL_Totaal_Bedrijf_Ric_VR`). |
| [`Hokofarm_Ric_realtime.sql`](Hokofarm_Ric_realtime.sql) | Real-time Roughage Visits | Direct raw stream of RIC trough feeding visits (`T_RAW_HokofarmVR`). |
| [`Hokofarm_SAC_concentrates.sql`](Hokofarm_SAC_concentrates.sql) | Concentrate Feeding Visits | Individual concentrate feeding visits to SAC / Hokofarm automated concentrate stations (`VL_Totaal_Bedrijf_Ric_VB`). |
| [`Hokofarm_summaries.sql`](Hokofarm_summaries.sql) | Daily RIC Summaries | Aggregated daily roughage and concentrate summaries per cow (`VL_Totaal_Bedrijf_Ric_CD`). |
| [`TMR_Trioliet_cowconnect_mix.sql`](TMR_Trioliet_cowconnect_mix.sql) | CowConnect TMR Mixes | Ration mixing records with component planned vs. loaded weights (`t_raw_cowconnect_mix`). |
| [`TVL_RIC_intake_dm.sql`](TVL_RIC_intake_dm.sql) | Roughage Intake & DM | Daily roughage intake combined with laboratory dry matter percentage (`TVL_totaal_sub_ric_opn`). |
| [`TVL_RIC_intake_dm_prod.sql`](TVL_RIC_intake_dm_prod.sql) | Roughage Intake per Product | Dry matter and fresh intake breakdown per roughage product / ingredient (`tvl_totaal_sub_ric_opn_prod`). |
| [`TVL_Total.sql`](TVL_Total.sql) | Master Daily Cow Summary | Primary master daily record per cow (`tvl_totaal_bedrijf_proef`) joining intake, yields, components, and health. |
| [`TVL_total_welfare.sql`](TVL_total_welfare.sql) | Animal Welfare Log | Animal welfare, locomotion scores, veterinary treatments, and daily milkings (`tvl_totaal_welzijnsdagboek`). |
| [`Triomatic_RIC_drop.sql`](Triomatic_RIC_drop.sql) | Trioliet Robot Deliveries | Triomatic automated feeding robot delivery (discharge) drops into barn pens and RIC troughs (`t_raw_trioliet`). |
| [`Triomatic_RIC_load.sql`](Triomatic_RIC_load.sql) | Trioliet Robot Loads | Triomatic automated feeding robot kitchen ingredient loading batches (`t_raw_trioliet`). |
| [`Velos_behaviour.sql`](Velos_behaviour.sql) | Nedap Velos Intervals | Raw behavior intervals (eating, ruminating, inactivity) from Nedap Smarttags (`T_RAW_velos_behaviour`). |
| [`Velos_behaviour_cest.sql`](Velos_behaviour_cest.sql) | Velos CEST Timezone | Behavior observations adjusted to Central European Summer Time (`VL_totaal_velos`). |
| [`Velos_behaviour_day.sql`](Velos_behaviour_day.sql) | Daily Behavior Budgets | Daily aggregated 24-hour durations of eating, ruminating, inactive, and other states. |
| [`Weatherstation.sql`](Weatherstation.sql) | On-Site Weather Data | On-site meteorological observations from the Dairy Campus weather station (`T_RAW_weerstation`). |

---

## How to Execute

In an automated Python/Airflow script or database client:

```python
with open("reports/TVL_Total.sql", "r") as f:
    sql = f.read().replace("[prfcod]", "4400003634")

# Execute against the Dairy Campus database
df = pd.read_sql(sql, connection)
```
