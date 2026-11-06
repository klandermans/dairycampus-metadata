#!/usr/bin/env python3
"""
Generate comprehensive English metadata documentation, data dictionaries,
CSVs, and Frictionless Data Package from Metadata-2.xlsx and SQL definitions.
"""

import os
import re
import csv
import json
import openpyxl

EXCEL_FILE = "Metadata-2.xlsx"
OUTPUT_CSV_DIR = "data_dictionary/csv"
OUTPUT_TABLES_DIR = "data_dictionary/tables"
DATAPACKAGE_PATH = "data_dictionary/datapackage.json"
README_DICT_PATH = "data_dictionary/README.md"

# Enrichment mapping for known placeholders or missing values
COLUMN_ENRICHMENTS = {
    # TVL_total
    ("tvl_totaal", "AtributedKVA"): {
        "Name.EN": "Attributed Concentrate A",
        "Name.Description": "Total allocated/programmed amount of concentrate feed type A for the cow on the specified date.",
        "Unit": "kg",
        "Measured.Calculated": "Calculated",
        "Data.calculated.description": "Sum of programmed concentrate A quantities across feeding stations (Hokofarm / SAC).",
        "Source.table": "T_Raw_HokofarmCD / TVL_Totaal_sub_kv"
    },
    ("tvl_totaal", "AtributedKVB"): {
        "Name.EN": "Attributed Concentrate B",
        "Name.Description": "Total allocated/programmed amount of concentrate feed type B for the cow on the specified date.",
        "Unit": "kg",
        "Measured.Calculated": "Calculated",
        "Data.calculated.description": "Sum of programmed concentrate B quantities across feeding stations (Hokofarm / SAC).",
        "Source.table": "T_Raw_HokofarmCD / TVL_Totaal_sub_kv"
    },
    ("tvl_totaal", "AtributedKVC"): {
        "Name.EN": "Attributed Concentrate C",
        "Name.Description": "Total allocated/programmed amount of concentrate feed type C for the cow on the specified date.",
        "Unit": "kg",
        "Measured.Calculated": "Calculated",
        "Data.calculated.description": "Sum of programmed concentrate C quantities across feeding stations (Hokofarm / SAC).",
        "Source.table": "T_Raw_HokofarmCD / TVL_Totaal_sub_kv"
    },
    ("tvl_totaal", "AtributedKVD"): {
        "Name.EN": "Attributed Concentrate D",
        "Name.Description": "Total allocated/programmed amount of concentrate feed type D for the cow on the specified date.",
        "Unit": "kg",
        "Measured.Calculated": "Calculated",
        "Data.calculated.description": "Sum of programmed concentrate D quantities across feeding stations (Hokofarm / SAC).",
        "Source.table": "T_Raw_HokofarmCD / TVL_Totaal_sub_kv"
    },
    ("tvl_totaal", "CelStd"): {
        "Data.calculated.description": "Official somatic cell count (SCC) determined from routine 4-weekly milk recording samples (MPR), analyzed by laboratory.",
        "Source.table": "T_Animal_MilkSamples (MlkCon.SCCDay)"
    },
    ("tvl_totaal", "EiwStd"): {
        "Data.calculated.description": "Milk crude protein percentage determined from official routine milk recording laboratory analysis.",
        "Source.table": "T_Animal_MilkSamples (MlkCon.ProteinPercentage)"
    },
    ("tvl_totaal", "VetStd"): {
        "Data.calculated.description": "Milk fat percentage determined from official routine milk recording laboratory analysis.",
        "Source.table": "T_Animal_MilkSamples (MlkCon.FatPercentage)"
    },
    ("tvl_totaal", "LacStd"): {
        "Data.calculated.description": "Milk lactose percentage determined from official routine milk recording laboratory analysis.",
        "Source.table": "T_Animal_MilkSamples (MlkCon.LactosePercentage)"
    },
    ("tvl_totaal", "UreStd"): {
        "Data.calculated.description": "Milk urea nitrogen content determined from official routine milk recording laboratory analysis.",
        "Source.table": "T_Animal_MilkSamples (MlkCon.Urea)"
    },
    ("tvl_totaal", "KetStd"): {
        "Data.calculated.description": "Ketosis diagnostic classification code (0: normal/negative, 1: suspected subclinical, 2: clinical ketosis).",
        "Source.table": "T_Animal_MilkSamples (MlkCon.KetosisCode)"
    },
    ("tvl_totaal", "MlkStd"): {
        "Data.calculated.description": "Total daily milk yield recorded during the official milk control recording day.",
        "Source.table": "T_Animal_MilkSamples (MlkCon.MilkQuantityMass)"
    },
    ("tvl_totaal", "TotalIntakeKVA"): {
        "Data.calculated.description": "Total consumed quantity of concentrate feed A by the animal at the automatic feeding station on the specified date.",
        "Source.table": "T_Raw_HokofarmCD (totalIntakeKVA)"
    },
    ("tvl_totaal", "TotalIntakeKVB"): {
        "Data.calculated.description": "Total consumed quantity of concentrate feed B by the animal at the automatic feeding station on the specified date.",
        "Source.table": "T_Raw_HokofarmCD (totalIntakeKVB)"
    },
    ("tvl_totaal", "TotalIntakeKVC"): {
        "Data.calculated.description": "Total consumed quantity of concentrate feed C by the animal at the automatic feeding station on the specified date.",
        "Source.table": "T_Raw_HokofarmCD (totalIntakeKVC)"
    },
    ("tvl_totaal", "TotalIntakeKVD"): {
        "Data.calculated.description": "Total consumed quantity of concentrate feed D by the animal at the automatic feeding station on the specified date.",
        "Source.table": "T_Raw_HokofarmCD (totalIntakeKVD)"
    },
    ("tvl_totaal", "mpr_week.Fat_Concentration"): {
        "Data.calculated.description": "ISO-calendar week average milk fat concentration calculated across regular CRV test recordings.",
        "Source.table": "VL_Dier_Datum_Crv"
    },
    ("tvl_totaal", "mpr_week.Protein_Concentration"): {
        "Data.calculated.description": "ISO-calendar week average milk protein concentration calculated across regular CRV test recordings.",
        "Source.table": "VL_Dier_Datum_Crv"
    },
    ("tvl_totaal", "mpr_week.Lactose_Concentration"): {
        "Data.calculated.description": "ISO-calendar week average milk lactose concentration calculated across regular CRV test recordings.",
        "Source.table": "VL_Dier_Datum_Crv"
    },
    ("tvl_totaal", "mpr_week.SCC"): {
        "Data.calculated.description": "ISO-calendar week average milk somatic cell count calculated across regular CRV test recordings.",
        "Source.table": "VL_Dier_Datum_Crv"
    },
    ("tvl_totaal", "mpr_week.Urea_Concentration"): {
        "Data.calculated.description": "ISO-calendar week average milk urea concentration calculated across regular CRV test recordings.",
        "Source.table": "VL_Dier_Datum_Crv"
    },
    ("tvl_totaal", "mpr_week.Urea_Concentration "): {
        "Data.calculated.description": "ISO-calendar week average milk urea concentration calculated across regular CRV test recordings.",
        "Source.table": "VL_Dier_Datum_Crv"
    },
    ("tvl_totaal", "tot.opnDs"): {
        "Data.calculated.description": "Total daily dry matter intake (kg DM/day). Calculated by summing the dry matter intake of all roughage fractions: (OpnMinWater * DryMatterPercentage).",
        "Source.table": "VL_Totaal_sub_ric_opn_prod"
    },
    ("tvl_totaal", "rv1.ProdExclWater"): {
        "Data.calculated.description": "Daily roughage intake fraction 1 excluding added water: (TotalLoaded - AddedWaterKg) / TotalLoaded * Intake.",
        "Source.table": "VL_Totaal_sub_ric_opn_prod"
    },
    ("tvl_totaal", "rv2.ProdExclWater"): {
        "Data.calculated.description": "Daily roughage intake fraction 2 excluding added water: (TotalLoaded - AddedWaterKg) / TotalLoaded * Intake.",
        "Source.table": "VL_Totaal_sub_ric_opn_prod"
    },
    ("tvl_totaal", "rv3.ProdExclWater"): {
        "Data.calculated.description": "Daily roughage intake fraction 3 excluding added water: (TotalLoaded - AddedWaterKg) / TotalLoaded * Intake.",
        "Source.table": "VL_Totaal_sub_ric_opn_prod"
    },
    ("tvl_totaal", "rv4.ProdExclWater"): {
        "Data.calculated.description": "Daily roughage intake fraction 4 excluding added water: (TotalLoaded - AddedWaterKg) / TotalLoaded * Intake.",
        "Source.table": "VL_Totaal_sub_ric_opn_prod"
    },
    # GEA_milkings
    ("T_RAW_Gea_milk", "IMWt"): {
        "Name.NL": "Koe gewicht bij melking",
        "Name.EN": "Cow Weight at Milking",
        "Name.Description": "Live animal body weight measured by the integrated scale inside the GEA milking stall or exit platform.",
        "Unit": "kg",
        "Measured.Calculated": "Measured",
        "Data.calculated.description": "Directly recorded by GEA milking scale sensor.",
        "Source.table": "T_RAW_Gea_milk"
    },
    ("T_RAW_Gea_milk", "IMFlg"): {
        "Name.NL": "Melk status vlag",
        "Name.EN": "Milking Status Flag",
        "Name.Description": "Status/diagnostic flag from GEA milking robot/parlor indicating normal completion, kick-off, or incomplete milking.",
        "Unit": "code",
        "Measured.Calculated": "Measured",
        "Data.calculated.description": "Status code recorded by GEA system.",
        "Source.table": "T_RAW_Gea_milk"
    },
    ("T_RAW_Gea_milk", "IMDim"): {
        "Name.NL": "Dagen in lactatie",
        "Name.EN": "Days in Milk",
        "Name.Description": "Days in Milk (DIM) recorded in GEA at the time of the milking event.",
        "Unit": "days",
        "Measured.Calculated": "Calculated",
        "Data.calculated.description": "Milking date minus most recent calving date.",
        "Source.table": "T_RAW_Gea_milk"
    },
    # Environment_barn_Animal_day & Environment_barn_Animal_experim
    ("?", "AgeDays"): {
        "Name.NL": "Leeftijd in dagen",
        "Name.EN": "Age in Days",
        "Name.Description": "Age of the animal in days calculated as recording date minus birth date.",
        "Unit": "days",
        "Measured.Calculated": "Calculated",
        "Data.calculated.description": "Recording date - Birth date.",
        "Source.table": "TVL_Dier_Datum_Stal"
    },
    ("?", "GewTot"): {
        "Name.NL": "Totaal gewicht",
        "Name.EN": "Total Weight",
        "Name.Description": "Total live animal body weight (average or latest measurement for the date).",
        "Unit": "kg",
        "Measured.Calculated": "Measured",
        "Data.calculated.description": "Recorded by automated walkthrough weighing scale.",
        "Source.table": "TVL_Dier_Gewicht_Etmaal"
    },
    ("?", "Ket"): {
        "Name.NL": "Ketose score",
        "Name.EN": "Ketosis Indicator",
        "Name.Description": "Ketosis classification indicator (0: healthy/negative, 1: suspected subclinical ketosis, 2: clinical ketosis).",
        "Unit": "code",
        "Measured.Calculated": "Calculated",
        "Data.calculated.description": "Laboratory diagnostic score from milk recording analysis.",
        "Source.table": "T_Animal_MilkSamples"
    },
    ("?", "NumbOfDates"): {
        "Name.NL": "Aantal datums",
        "Name.EN": "Number of Dates",
        "Name.Description": "Count of observation days recorded for the animal within the experimental reporting period.",
        "Unit": "count",
        "Measured.Calculated": "Calculated",
        "Data.calculated.description": "Count of distinct active recording dates.",
        "Source.table": "TVL_Dier_Datum_Proef"
    },
    ("?", "Projectcode"): {
        "Name.NL": "Project code",
        "Name.EN": "Project Code",
        "Name.Description": "Unique research experiment / trial code (e.g. 4400003634). Same as prfcod.",
        "Unit": "identifier",
        "Measured.Calculated": "Measured",
        "Data.calculated.description": "Official trial identifier registered in t_proef.",
        "Source.table": "t_proef"
    },
    ("?", "ProjectName"): {
        "Name.NL": "Project naam",
        "Name.EN": "Project Name",
        "Name.Description": "Official descriptive name of the research project or trial. Same as prfnam.",
        "Unit": "text",
        "Measured.Calculated": "Measured",
        "Data.calculated.description": "Official trial title registered in t_proef.",
        "Source.table": "t_proef"
    },
    ("?", "SumVoeGft"): {
        "Name.NL": "Som voergift",
        "Name.EN": "Total Feed Granted",
        "Name.Description": "Total amount of concentrate feed programmed/granted to the animal over the period.",
        "Unit": "kg",
        "Measured.Calculated": "Calculated",
        "Data.calculated.description": "Sum of programmed concentrate feeding amounts.",
        "Source.table": "TVL_Dier_Voeropname_KV_Etmaal"
    },
    ("?", "SumVoeOpnm"): {
        "Name.NL": "Som voeropname",
        "Name.EN": "Total Feed Intake",
        "Name.Description": "Total actual concentrate feed consumed by the animal over the period.",
        "Unit": "kg",
        "Measured.Calculated": "Calculated",
        "Data.calculated.description": "Sum of consumed concentrate intake amounts.",
        "Source.table": "TVL_Dier_Voeropname_KV_Etmaal"
    },
    ("?", "SumVoeRst"): {
        "Name.NL": "Som voerrest",
        "Name.EN": "Total Feed Residual",
        "Name.Description": "Total amount of unconsumed concentrate feed remaining in the troughs.",
        "Unit": "kg",
        "Measured.Calculated": "Calculated",
        "Data.calculated.description": "Total Feed Granted minus Total Feed Intake.",
        "Source.table": "TVL_Dier_Voeropname_KV_Etmaal"
    },
    ("?", "IDNumber"): {
        "Name.NL": "Levensnummer",
        "Name.EN": "Animal Identification Number",
        "Name.Description": "Official national unique life identification number of the animal (LevNum / EU identification tag).",
        "Unit": "identifier",
        "Measured.Calculated": "Measured",
        "Data.calculated.description": "Official national cattle ear tag number.",
        "Source.table": "t_animals"
    },
    ("?", "DateMelkCon4Wk"): {
        "Name.NL": "Datum 4-wekelijkse melkcontrole",
        "Name.EN": "Date of 4-Weekly Milk Recording",
        "Name.Description": "Date of the most recent official 4-weekly milk control / recording event (MPR).",
        "Unit": "yyyy-mm-dd",
        "Measured.Calculated": "Measured",
        "Data.calculated.description": "Date of official test day sampling.",
        "Source.table": "T_Animal_MilkSamples"
    },
    ("?", "DatGldTot"): {
        "Name.NL": "Datum geldig tot",
        "Name.EN": "Valid Until Date",
        "Name.Description": "Date until which the current housing, lactation, or trial assignment status remains valid.",
        "Unit": "yyyy-mm-dd",
        "Measured.Calculated": "Calculated",
        "Data.calculated.description": "End validity date of status record.",
        "Source.table": "TVL_Dier_Datum_Stal"
    },
    ("?", "ExpecCalvingDate"): {
        "Name.NL": "Verwachte kalfdatum",
        "Name.EN": "Expected Calving Date",
        "Name.Description": "Estimated date of the next calving, based on confirmed insemination date + gestation length (~270-280 days).",
        "Unit": "yyyy-mm-dd",
        "Measured.Calculated": "Calculated",
        "Data.calculated.description": "Calculated by ExpectedCalvingDate() function from last successful insemination.",
        "Source.table": "t_animal_matings / ExpectedCalvingDate"
    },
    ("?", "MilkMorming"): {
        "Name.NL": "Melkgift ochtend",
        "Name.EN": "Morning Milk Yield",
        "Name.Description": "Total quantity of milk produced during morning milking sessions.",
        "Unit": "kg",
        "Measured.Calculated": "Measured",
        "Data.calculated.description": "Sum of morning milking yields.",
        "Source.table": "TVL_Dier_Melkgift_Etmaal_Melkcontrole"
    },
    ("?", "MlkCon"): {
        "Name.NL": "Melkcontrole aanwezig",
        "Name.EN": "Milk Recording Present",
        "Name.Description": "Indicator flag showing whether official milk recording (MPR) data was collected on this date.",
        "Unit": "boolean",
        "Measured.Calculated": "Calculated",
        "Data.calculated.description": "Boolean flag indicating presence of milk laboratory sample record.",
        "Source.table": "T_Animal_MilkSamples"
    },
    ("?", "Stl"): {
        "Name.NL": "Stal",
        "Name.EN": "Barn Section",
        "Name.Description": "Physical barn building or housing section identifier at Dairy Campus.",
        "Unit": "identifier",
        "Measured.Calculated": "Measured",
        "Data.calculated.description": "Stable / Barn number recorded in management system.",
        "Source.table": "TVL_Dier_Datum_Stal"
    },
    ("?", "VrwDgn"): {
        "Name.NL": "Verwachte aantal dagen",
        "Name.EN": "Expected Days",
        "Name.Description": "Expected remaining gestation days or planned days dry prior to the anticipated calving date.",
        "Unit": "days",
        "Measured.Calculated": "Calculated",
        "Data.calculated.description": "Expected calving date minus current date.",
        "Source.table": "TVL_Dier_Datum_Stal"
    }
}

# English descriptions of the 19 datasets/sheets
SHEET_DESCRIPTIONS = {
    "TVL_total": {
        "title": "Daily Total Cow Research Summary (TVL_total)",
        "description": "Comprehensive daily summary per cow integrating all individual data sources: animal demographics, lactation stage, roughage intake (fractions 1-4, fresh and water-excluded), dry matter intake, concentrate intake across stations, morning/evening milk production, official milk test recording components (fat, protein, lactose, urea, SCC), body condition score (BCS), GreenFeed visits, and live body weight.",
        "source_table": "tvl_totaal_bedrijf / tvl_totaal_bedrijf_proef",
        "granularity": "One row per animal per calendar day"
    },
    "Hokofarm_SAC_concentrates": {
        "title": "Automatic Concentrate Feeder Intake (Hokofarm_SAC_concentrates)",
        "description": "Visit-level concentrate feeding transactions recorded by SAC / Hokofarm automated concentrate feeders. Captures programmed feed allowance, actual consumed amount, feeding speed, dry matter, crude ash, protein, fat, fiber, and visit timestamps.",
        "source_table": "t_raw_hokofarmvb",
        "granularity": "One row per concentrate feeding station visit"
    },
    "Hokofarm_RIC": {
        "title": "Roughage Intake Control Individual Visits (Hokofarm_RIC)",
        "description": "High-resolution individual visit transactions recorded by Hokofarm RIC (Roughage Intake Control) weighing feed bins. Measures cow ear tag number, bin number, start and end timestamps, initial weight, ending weight, consumed fresh feed quantity, and nutritional composition.",
        "source_table": "t_raw_hokofarmvr",
        "granularity": "One row per roughage trough feeding visit"
    },
    "TVL_RIC_intake_dm": {
        "title": "Roughage Daily Intake and Dry Matter (TVL_RIC_intake_dm)",
        "description": "Daily aggregated roughage intake per cow per feed group/ration, combining fresh intake, laboratory dry matter determination, and ration dry matter intake.",
        "source_table": "TVL_totaal_sub_ric_opn",
        "granularity": "One row per cow per feed group per calendar day"
    },
    "Triomatic_RIC_load": {
        "title": "Trioliet Feeding Robot Mixer Loading Records (Triomatic_RIC_load)",
        "description": "Batch loading records from the Trioliet Triomatic automated feeding kitchen and mixer robot. Records target and actual weights for each ration component (silage, hay, concentrates, minerals, added water) loaded into the mixer robot.",
        "source_table": "t_raw_trioliet (subgroupnr = 0)",
        "granularity": "One row per ingredient loaded per mixing batch"
    },
    "Triomatic_RIC_drop": {
        "title": "Trioliet Feeding Robot Trough Delivery Records (Triomatic_RIC_drop)",
        "description": "Batch delivery (discharge) records from the Trioliet Triomatic feeding robot to individual barn pens, groups, and RIC feeding bins. Captures distributed weight, delivery time, and destination pen.",
        "source_table": "t_raw_trioliet (subgroupnr <> 0)",
        "granularity": "One row per feeding delivery drop event"
    },
    "GEA_gates": {
        "title": "GEA Separation and Smart Gate Passages (GEA_gates)",
        "description": "Passage records through GEA automated selection, separation, and smart routing gates. Logs animal identification, gate ID, direction, and routing decisions.",
        "source_table": "T_RAW_Gea_Separatie",
        "granularity": "One row per smart gate passage event"
    },
    "GEA_milkings": {
        "title": "GEA Milking Robot and Parlor Transactions (GEA_milkings)",
        "description": "Individual milking session transactions from GEA milking systems (automatic milking rotary/robots). Records milk yield per quarter/session, milking duration, milk conductivity, blood detection, animal body weight at milking, and status flags.",
        "source_table": "T_RAW_Gea_milk",
        "granularity": "One row per milking event"
    },
    "TMR_Trioliet_cowconnect_mix": {
        "title": "CowConnect Mixer Wagon Rations (TMR_Trioliet_cowconnect_mix)",
        "description": "TMR (Total Mixed Ration) mixing records collected via the CowConnect digital weighing system on mobile mixer wagons. Records loaded quantities, planned vs actual weights, and mixing times per ingredient.",
        "source_table": "t_raw_cowconnect_mix",
        "granularity": "One row per ingredient batch per mix event"
    },
    "Velos_behaviour": {
        "title": "Nedap Velos Cow Behaviour Intervals (Velos_behaviour)",
        "description": "Sensor-based behavioral observation intervals captured by Nedap Velos collar/leg tags (Smarttags). Classifies duration of behaviors (0: other/standing, 1: inactive/lying, 2: ruminating, 3: eating).",
        "source_table": "T_RAW_velos_behaviour",
        "granularity": "One row per behavior state transition / interval"
    },
    "Velos_behaviour_day": {
        "title": "Nedap Velos Daily Cow Behaviour Summary (Velos_behaviour_day)",
        "description": "Daily aggregated behavioral budgets per cow, summing durations of eating, ruminating, inactivity (lying), and other active behaviors per 24-hour day.",
        "source_table": "T_RAW_velos_behaviour (aggregated daily)",
        "granularity": "One row per cow per calendar day"
    },
    "TMR_Trioliet_cowconnect_drop": {
        "title": "CowConnect Feed Distribution Drops (TMR_Trioliet_cowconnect_drop)",
        "description": "Discharge and delivery logs of mixed rations to feed fences and groups recorded via the CowConnect system.",
        "source_table": "t_raw_cowconnect_drop",
        "granularity": "One row per feed fence discharge drop"
    },
    "DC_DM_content": {
        "title": "Laboratory Dry Matter Content Oven Tests (DC_DM_content)",
        "description": "Official laboratory oven-drying dry matter test results (droogstoof) for feed batches, silage cuts, and mixed rations sampled at Dairy Campus.",
        "source_table": "VL_totaal_droogstoof",
        "granularity": "One row per feed sample test"
    },
    "Greenfeed_summarized_data": {
        "title": "GreenFeed Enteric Emission Summaries (Greenfeed_summarized_data)",
        "description": "Validated visit-level enteric methane (CH4) and carbon dioxide (CO2) emission measurements from C-Lock GreenFeed automated emission monitoring systems, including emission fluxes, head proximity detection, airflow rates, and sensor calibrations.",
        "source_table": "T_RAW_Greenfeed_Summarized_Data",
        "granularity": "One row per validated GreenFeed visit"
    },
    "Greenfeed_feed_aggregrated": {
        "title": "GreenFeed Bait Feed Aggregations (Greenfeed_feed_aggregrated)",
        "description": "Aggregated pelleted bait feed dispensed by GreenFeed units to incentivize cow visits, including cup drops, feed mass, and visit timestamps.",
        "source_table": "T_RAW_Greenfeed_Feed_data",
        "granularity": "One row per cow per GreenFeed station day"
    },
    "Weatherstation": {
        "title": "Dairy Campus Meteorological Weather Station (Weatherstation)",
        "description": "On-site local meteorological data recorded at Dairy Campus in Leeuwarden. Parameters include ambient temperature, relative humidity, atmospheric pressure, wind speed, wind direction, dew point, solar radiation, and precipitation.",
        "source_table": "T_RAW_weerstation",
        "granularity": "Hourly / ten-minute meteorological records"
    },
    "Missing_data": {
        "title": "Data Quality and Missing Data Flags (Missing_data)",
        "description": "Automated data validation and completeness flags per cow per day, tracking whether milk yields, body weights, feed intake, Nedap Velos tracking, or BCS camera observations are missing or suspect.",
        "source_table": "tvl_totaal_missende_data_proef",
        "granularity": "One row per animal per calendar day"
    },
    "Environment_barn_Animal_day": {
        "title": "Barn Environment & Animal Daily Profile (Environment_barn_Animal_day)",
        "description": "Integrated animal-level daily profile linking barn compartment/pen locations, lactation days, age, group movements, and daily intake/yield metrics.",
        "source_table": "TVL_Dier_Datum_Stal",
        "granularity": "One row per animal per housing location per calendar day"
    },
    "Environment_barn_Animal_experim": {
        "title": "Experimental Cohort Animal Daily Records (Environment_barn_Animal_experim)",
        "description": "Experiment-specific animal daily tracking table joining trial assignment, treatment codes, block numbers, and longitudinal performance parameters.",
        "source_table": "TVL_Dier_Datum_Proef",
        "granularity": "One row per experimental animal per calendar day"
    }
}


def clean_val(v):
    if v is None:
        return ""
    s = str(v).strip()
    if s in ["#N/A", "N.v.t", "None"]:
        return "N/A"
    return s


def infer_datatype(unit, colname, desc):
    u = (unit or "").lower()
    c = colname.lower()
    d = (desc or "").lower()

    if any(k in c for k in ["date", "datum", "dat", "begdat", "enddat", "klfdat", "insdat", "gebdat", "timestamp"]):
        if "time" in c or "dt" in c or "hh-mm-ss" in u:
            return "datetime"
        return "date"
    if any(k in u for k in ["kg", "°c", "mm", "m/s", "g/day", "g/kg", "%", "bar", "pct", "float", "gram"]):
        return "number"
    if any(k in u for k in ["count", "number", "days", "dgn", "sec", "seconds", "min"]):
        return "integer"
    if any(k in c for k in ["id", "code", "cod", "num", "nr", "station", "rfid", "earnumber"]):
        return "string"
    if "ja/nee" in u or "boolean" in u:
        return "boolean"
    return "string"


def main():
    wb = openpyxl.load_workbook(EXCEL_FILE)
    master_records = []
    tables_summary = []

    datapackage = {
        "name": "dairy-campus-research-metadata",
        "title": "Dairy Campus Research Data Platform: Standardized Data Dictionaries",
        "description": "Comprehensive FAIR metadata dictionaries, variables, and schema descriptions for dairy cattle sensor and experimental data collected at Dairy Campus (Wageningen University & Research).",
        "version": "1.0.0",
        "homepage": "https://www.dairycampus.nl/",
        "license": "CC-BY-4.0",
        "resources": []
    }

    for sheetname in wb.sheetnames:
        ws = wb[sheetname]
        raw_rows = list(ws.iter_rows(values_only=True))
        if not raw_rows:
            continue
        headers = [clean_val(h) for h in raw_rows[0]]
        data = raw_rows[1:]

        cleaned_sheet_records = []
        sheet_meta = SHEET_DESCRIPTIONS.get(sheetname, {
            "title": sheetname,
            "description": f"Research dataset for {sheetname}.",
            "source_table": "Dairy Campus database",
            "granularity": "Per record"
        })

        for row in data:
            if not row or not any(row):
                continue
            rec = {
                "dataset_name": sheetname,
                "source_table": clean_val(row[0]) if len(row) > 0 else "",
                "column_name": clean_val(row[1]) if len(row) > 1 else "",
                "name_nl": clean_val(row[2]) if len(row) > 2 else "",
                "name_en": clean_val(row[3]) if len(row) > 3 else "",
                "description_en": clean_val(row[4]) if len(row) > 4 else "",
                "unit": clean_val(row[5]) if len(row) > 5 else "",
                "measurement_type": clean_val(row[6]) if len(row) > 6 else "",
                "calculation_description": clean_val(row[7]) if len(row) > 7 else "",
                "calculation_source": clean_val(row[8]) if len(row) > 8 else ""
            }

            # Apply enrichment if available
            enrich_key = (rec["source_table"], rec["column_name"])
            if enrich_key in COLUMN_ENRICHMENTS:
                enr = COLUMN_ENRICHMENTS[enrich_key]
                if "Name.EN" in enr and (not rec["name_en"] or rec["name_en"] in ["N/A", "?", ""]):
                    rec["name_en"] = enr["Name.EN"]
                if "Name.Description" in enr and (not rec["description_en"] or rec["description_en"] in ["N/A", "?", ""]):
                    rec["description_en"] = enr["Name.Description"]
                if "Name.NL" in enr and (not rec["name_nl"] or rec["name_nl"] in ["N/A", "?", ""]):
                    rec["name_nl"] = enr["Name.NL"]
                if "Unit" in enr and (not rec["unit"] or rec["unit"] in ["N/A", "?", ""]):
                    rec["unit"] = enr["Unit"]
                if "Measured.Calculated" in enr:
                    rec["measurement_type"] = enr["Measured.Calculated"]
                if "Data.calculated.description" in enr:
                    rec["calculation_description"] = enr["Data.calculated.description"]
                if "Source.table" in enr:
                    rec["calculation_source"] = enr["Source.table"]

            # Fallback for generic '?' table key in Environment sheets
            fallback_key = ("?", rec["column_name"])
            if fallback_key in COLUMN_ENRICHMENTS:
                enr = COLUMN_ENRICHMENTS[fallback_key]
                if "Name.EN" in enr and (not rec["name_en"] or rec["name_en"] in ["N/A", "?", ""]):
                    rec["name_en"] = enr["Name.EN"]
                if "Name.Description" in enr and (not rec["description_en"] or rec["description_en"] in ["N/A", "?", ""]):
                    rec["description_en"] = enr["Name.Description"]
                if "Name.NL" in enr and (not rec["name_nl"] or rec["name_nl"] in ["N/A", "?", ""]):
                    rec["name_nl"] = enr["Name.NL"]
                if "Unit" in enr and (not rec["unit"] or rec["unit"] in ["N/A", "?", ""]):
                    rec["unit"] = enr["Unit"]
                if "Measured.Calculated" in enr:
                    rec["measurement_type"] = enr["Measured.Calculated"]
                if "Data.calculated.description" in enr:
                    rec["calculation_description"] = enr["Data.calculated.description"]
                if "Source.table" in enr:
                    rec["calculation_source"] = enr["Source.table"]

            if not rec["name_en"] or rec["name_en"] == "N/A":
                rec["name_en"] = rec["column_name"]
            if not rec["description_en"] or rec["description_en"] == "N/A":
                rec["description_en"] = f"Field {rec['column_name']} recorded in {sheetname}."

            rec["data_type"] = infer_datatype(rec["unit"], rec["column_name"], rec["description_en"])

            cleaned_sheet_records.append(rec)
            master_records.append(rec)

        # 1. Write sheet-specific CSV
        sheet_csv_path = os.path.join(OUTPUT_CSV_DIR, f"{sheetname}.csv")
        csv_fields = [
            "dataset_name", "source_table", "column_name", "name_en", "name_nl",
            "data_type", "unit", "measurement_type", "description_en",
            "calculation_description", "calculation_source"
        ]
        with open(sheet_csv_path, "w", newline="", encoding="utf-8") as f:
            writer = csv.DictWriter(f, fieldnames=csv_fields)
            writer.writeheader()
            for r in cleaned_sheet_records:
                writer.writerow(r)

        # 2. Write sheet-specific Markdown
        sheet_md_path = os.path.join(OUTPUT_TABLES_DIR, f"{sheetname}.md")
        with open(sheet_md_path, "w", encoding="utf-8") as f:
            f.write(f"# {sheet_meta['title']}\n\n")
            f.write(f"**Dataset Identifier:** `{sheetname}`  \n")
            f.write(f"**Underlying Database Source:** `{sheet_meta['source_table']}`  \n")
            f.write(f"**Observation Granularity:** {sheet_meta['granularity']}  \n\n")
            f.write(f"## Description\n\n{sheet_meta['description']}\n\n")
            f.write(f"## Variables & Data Dictionary\n\n")
            f.write("| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |\n")
            f.write("|:---|:---|:---|:---|:---|:---|:---|\n")
            for r in cleaned_sheet_records:
                calc_info = ""
                if r["measurement_type"] == "Calculated":
                    calc_info = f"**Calculated**: {r['calculation_description']}"
                    if r["calculation_source"] and r["calculation_source"] != "N/A":
                        calc_info += f" *(Source: {r['calculation_source']})*"
                elif r["calculation_source"] and r["calculation_source"] != "N/A":
                    calc_info = f"Source: {r['calculation_source']}"
                else:
                    calc_info = "Direct measurement"

                desc_clean = r["description_en"].replace("|", "\\|").replace("\n", " ")
                calc_clean = calc_info.replace("|", "\\|").replace("\n", " ")
                f.write(f"| `{r['column_name']}` | {r['name_en']} | `{r['data_type']}` | {r['unit'] or 'N/A'} | {r['measurement_type'] or 'Measured'} | {desc_clean} | {calc_clean} |\n")

        # 3. Add to Frictionless datapackage resource
        dp_resource = {
            "name": sheetname.lower(),
            "path": f"csv/{sheetname}.csv",
            "format": "csv",
            "mediatype": "text/csv",
            "description": sheet_meta["description"],
            "schema": {
                "fields": [
                    {
                        "name": r["column_name"],
                        "type": "number" if r["data_type"] == "number" else ("integer" if r["data_type"] == "integer" else ("date" if r["data_type"] == "date" else ("datetime" if r["data_type"] == "datetime" else ("boolean" if r["data_type"] == "boolean" else "string")))),
                        "title": r["name_en"],
                        "description": r["description_en"],
                        "unit": r["unit"]
                    } for r in cleaned_sheet_records
                ]
            }
        }
        datapackage["resources"].append(dp_resource)

        tables_summary.append({
            "name": sheetname,
            "title": sheet_meta["title"],
            "variables_count": len(cleaned_sheet_records),
            "source": sheet_meta["source_table"],
            "granularity": sheet_meta["granularity"]
        })

    # Write Master CSV
    master_csv_path = os.path.join(OUTPUT_CSV_DIR, "all_metadata_dictionary.csv")
    with open(master_csv_path, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=csv_fields)
        writer.writeheader()
        for r in master_records:
            writer.writerow(r)

    # Write datapackage.json
    with open(DATAPACKAGE_PATH, "w", encoding="utf-8") as f:
        json.dump(datapackage, f, indent=2)

    # Write data_dictionary/README.md
    with open(README_DICT_PATH, "w", encoding="utf-8") as f:
        f.write("# Dairy Campus Data Dictionary\n\n")
        f.write("This directory contains the machine-readable and human-readable data dictionaries for all 19 standardized research datasets provided by the Dairy Campus Research Data Platform (Wageningen University & Research).\n\n")
        f.write("## Overview of Datasets\n\n")
        f.write("| Dataset Code | Dataset Title | Variables | Primary Granularity | Source Table / System |\n")
        f.write("|:---|:---|:---|:---|:---|\n")
        for t in tables_summary:
            f.write(f"| [{t['name']}](tables/{t['name']}.md) | {t['title']} | {t['variables_count']} | {t['granularity']} | `{t['source']}` |\n")

        f.write("\n## Directory Structure\n\n")
        f.write("- **`tables/`**: Individual Markdown documentation pages for each table, including variable names, English labels, data types, physical measurement units, calculation formulas, and sensor descriptions.\n")
        f.write("- **`csv/`**: Clean, UTF-8 encoded machine-readable CSV dictionaries for automated ingestion into R, Python, and data catalog tools.\n")
        f.write("  - `all_metadata_dictionary.csv`: Master data dictionary containing every variable across all 19 datasets in a unified schema.\n")
        f.write("- **`datapackage.json`**: Standardized [Frictionless Data Package](https://specs.frictionlessdata.io/data-package/) specification describing each dataset resource and field schema.\n\n")
        f.write("## Variable Standards\n\n")
        f.write("- **Identifier Fields**:\n")
        f.write("  - `AnimalServerId` / `dienum`: Central internal integer animal identifier issued across Dairy Campus systems.\n")
        f.write("  - `cow` / `oornum` / `AnimalNo`: Practical ear tag management number (typically 3 to 4 digits).\n")
        f.write("  - `LevNum`: Full European official animal registration / life number.\n")
        f.write("  - `prfcod`: Research experiment / trial code (e.g., `4400003634`).\n")
        f.write("- **Measurement vs. Calculated**:\n")
        f.write("  - `Measured`: Directly recorded by hardware sensors, RFID transponders, scales, meters, or laboratory analyzers.\n")
        f.write("  - `Calculated`: Derived via mathematical transformation, temporal aggregation, dry matter correction, or subtraction of mixer wagon added water (defined in `calculations/`).\n")

    print(f"Successfully generated documentation for {len(tables_summary)} tables and {len(master_records)} total variables.")


if __name__ == "__main__":
    main()
