#!/usr/bin/env python3
"""
Generate standardized, machine-readable XML data dictionary schemas for each of the 19 Dairy Campus tables.
Conforms to DDI-Codebook / DataCite schema conventions:
- Dataset metadata (name, source object, central catalog DOI, temporal coverage, granularity)
- Full variable specifications (exact SQL field name, data type, unit, measurement type, description, SQL derivation/source)
"""

import os
import zipfile
import xml.etree.ElementTree as ET
from xml.dom import minidom
from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parent.parent
DICT_CSV = ROOT / "zenodo_deposit_files" / "01_Dairy_Campus_Master_Data_Dictionary.csv"
OUT_DIR = ROOT / "zenodo_deposit_files" / "xml_tables"
OUT_ZIP = ROOT / "zenodo_deposit_files" / "dairy_campus_19_tables_xml.zip"

DOI = "10.5281/zenodo.24092291"

sheet_descriptions = {
    "TVL_total": "Master Daily Integrated Cow Summary (intake, yields, milk components, body weight, BCS, emissions)",
    "Hokofarm_SAC_concentrates": "Automatic Concentrate Feeder Transactions (programmed feed, intake, feeder speed, visits)",
    "Hokofarm_RIC": "Roughage Intake Control Individual Visit Transactions (entry/exit timestamps, trough weights)",
    "TVL_RIC_intake_dm": "Roughage Daily Intake & Dry Matter Integration (fresh intake, laboratory dry oven DM%)",
    "Triomatic_RIC_load": "Trioliet Feeding Robot Mixer Loading Records (kitchen ingredient batch target and loaded weights)",
    "Triomatic_RIC_drop": "Trioliet Feeding Robot Trough Deliveries (discharged ration mass to pens and RIC bins)",
    "GEA_gates": "GEA Separation & Smart Gate Passages (cow identification, routing decisions, sorting gate ID)",
    "GEA_milkings": "GEA Milking Robot & Parlor Transactions (session yields, duration, conductivity, body weight)",
    "TMR_Trioliet_cowconnect_mix": "CowConnect Mixer Wagon Rations (planned vs actual ingredient loading weights and mixing times)",
    "Velos_behaviour": "Nedap Velos Cow Behaviour Intervals (smarttag sensor state transitions for eating, ruminating, lying)",
    "Velos_behaviour_day": "Nedap Velos Daily Cow Behaviour Summary (aggregated 24-hour durations of eating, ruminating, resting)",
    "TMR_Trioliet_cowconnect_drop": "CowConnect Feed Distribution Drops (ration discharge records along feed fences)",
    "DC_DM_content": "Laboratory Dry Matter Content Oven Tests (official droogstoof gravimetric oven analysis results)",
    "Greenfeed_summarized_data": "GreenFeed Enteric Emission Summaries (validated CH4 and CO2 fluxes, head sensors, airflow rates)",
    "Greenfeed_feed_aggregrated": "GreenFeed Bait Feed Drops (pelleted feed mass and cup drop rewards during emission visits)",
    "Weatherstation": "Dairy Campus Meteorological Weather Station (ambient temperature, humidity, wind, solar radiation, rain)",
    "Missing_data": "Data Quality & Completeness Audit Matrix (automated daily validation flags per cow per day)",
    "Environment_barn_Animal_day": "Barn Environment & Animal Daily Profile (pen housing, lactation days, parity, age, movement)",
    "Environment_barn_Animal_experim": "Experimental Cohort Animal Daily Records (trial project codes, treatment assignments, blocks)"
}


def generate_table_xml(ds_name: str, group: pd.DataFrame, idx: int) -> str:
    root = ET.Element("tableSchema", {
        "xmlns": "http://dairycampus.nl/schema/metadata/v1",
        "xmlns:dct": "http://purl.org/dc/terms/",
        "xmlns:dcat": "http://www.w3.org/ns/dcat#",
        "id": ds_name,
        "tableNumber": str(idx)
    })

    # Header / Identification
    header = ET.SubElement(root, "header")
    ET.SubElement(header, "tableName").text = ds_name
    ET.SubElement(header, "description").text = sheet_descriptions.get(ds_name, ds_name)
    ET.SubElement(header, "sourceObject").text = str(group["source_table"].iloc[0])
    ET.SubElement(header, "centralCatalogDoi").text = DOI
    ET.SubElement(header, "catalogUrl").text = f"https://doi.org/{DOI}"
    ET.SubElement(header, "distributionId").text = f"https://doi.org/{DOI}#distribution_{ds_name}"
    ET.SubElement(header, "temporalSpan").text = "2016-present"
    ET.SubElement(header, "facility").text = "Dairy Campus, Wageningen University & Research, Leeuwarden, The Netherlands"
    ET.SubElement(header, "targetPopulation").text = "500 Holstein Friesian dairy cows"
    ET.SubElement(header, "variableCount").text = str(len(group))
    ET.SubElement(header, "license").text = "https://creativecommons.org/licenses/by/4.0/"

    # Variables
    vars_elem = ET.SubElement(root, "fields")
    for pos, (_, r) in enumerate(group.iterrows(), start=1):
        field_elem = ET.SubElement(vars_elem, "field", {"position": str(pos)})
        
        col_name = str(r["column_name"]).strip()
        ET.SubElement(field_elem, "fieldName").text = col_name

        dtype = str(r["data_type"]).strip() if pd.notna(r["data_type"]) else "string"
        ET.SubElement(field_elem, "dataType").text = dtype

        unit = str(r["unit"]).strip() if pd.notna(r["unit"]) else ""
        if unit.lower() not in ["n/a", "none", "nan", ""]:
            ET.SubElement(field_elem, "unit").text = unit

        mtype = str(r["measurement_type"]).strip() if pd.notna(r["measurement_type"]) else "Measured"
        ET.SubElement(field_elem, "origin").text = mtype

        desc_en = str(r["description_en"]).strip() if pd.notna(r["description_en"]) else ""
        if desc_en.lower() not in ["nan", "none", "n/a", ""]:
            ET.SubElement(field_elem, "description").text = desc_en

        calc_desc = str(r["calculation_description"]).strip() if pd.notna(r["calculation_description"]) else ""
        if calc_desc and calc_desc.lower() not in ["nan", "none", "n/a", ""] and "?" not in calc_desc:
            ET.SubElement(field_elem, "derivation").text = calc_desc

        calc_src = str(r["calculation_source"]).strip() if pd.notna(r["calculation_source"]) else ""
        if calc_src and calc_src.lower() not in ["nan", "none", "n/a", "", "?"]:
            ET.SubElement(field_elem, "sourceObject").text = calc_src

    # Pretty-print
    rough_str = ET.tostring(root, encoding="utf-8")
    parsed = minidom.parseString(rough_str)
    return parsed.toprettyxml(indent="  ")


def main():
    df = pd.read_csv(DICT_CSV)
    OUT_DIR.mkdir(parents=True, exist_ok=True)

    generated_files = []
    print(f"Generating XML metadata schemas for all 19 tables in {OUT_DIR}...")
    for idx, (ds_name, group) in enumerate(df.groupby("dataset_name", sort=False), start=1):
        xml_content = generate_table_xml(ds_name, group, idx)
        out_file = OUT_DIR / f"{idx:02d}_{ds_name}.xml"
        out_file.write_text(xml_content, encoding="utf-8")
        generated_files.append(out_file)
        print(f"  [{idx:2d}/19] Wrote {out_file.name} ({len(group)} fields)")

    # Create ZIP archive
    with zipfile.ZipFile(OUT_ZIP, "w", zipfile.ZIP_DEFLATED) as zf:
        for f in generated_files:
            zf.write(f, arcname=f.name)
    print(f"\n[+] Bundled all 19 table XMLs into: {OUT_ZIP} ({os.path.getsize(OUT_ZIP) / 1024:.1f} KB)")


if __name__ == "__main__":
    main()
