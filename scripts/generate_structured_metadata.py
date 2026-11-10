#!/usr/bin/env python3
"""
Generate structured metadata for the Dairy Campus Research Data Platform:
- W3C DCAT 2.0 / schema.org JSON-LD (dcat:Catalog with 19 dct:distribution items)
- DataCite 4.4 XML schema
"""

import json
import xml.etree.ElementTree as ET
from xml.dom import minidom
from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parent.parent
DICT_CSV = ROOT / "zenodo_deposit_files" / "01_Dairy_Campus_Master_Data_Dictionary.csv"

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


def build_dcat_jsonld(doi_str="10.5281/zenodo.24092291"):
    df = pd.read_csv(DICT_CSV)
    distributions = []
    for idx, (ds, g) in enumerate(df.groupby("dataset_name", sort=False), 1):
        src = str(g["source_table"].iloc[0])
        desc = sheet_descriptions.get(ds, ds)
        dist = {
            "@id": f"https://doi.org/{doi_str}#distribution_{ds}",
            "@type": ["dcat:Distribution", "schema:DataDownload"],
            "dct:identifier": ds,
            "dct:title": f"Distribution {idx}: {ds}",
            "dct:description": desc,
            "dct:source": src if src != "?" else "Internal experimental database view",
            "dct:format": "application/x-sql",
            "dcat:mediaType": "text/csv",
            "dcat:accessURL": f"https://zenodo.org/records/{doi_str.split('.')[-1]}#table_{ds}",
            "schema:numberOfVariables": int(len(g)),
            "schema:variableMeasured": g["column_name"].tolist()
        }
        distributions.append(dist)

    catalog = {
        "@context": {
            "dcat": "http://www.w3.org/ns/dcat#",
            "dct": "http://purl.org/dc/terms/",
            "schema": "http://schema.org/",
            "foaf": "http://xmlns.com/foaf/0.1/",
            "xsd": "http://www.w3.org/2001/XMLSchema#"
        },
        "@id": f"https://doi.org/{doi_str}",
        "@type": ["dcat:Catalog", "schema:DataCatalog"],
        "dct:identifier": f"doi:{doi_str}",
        "dct:title": "Dairy Campus Research Data Platform: Central Data Catalog & Standardized Metadata Dictionaries",
        "dct:description": (
            "Central research data catalog for the Dairy Campus experimental dairy cattle research infrastructure "
            "(Wageningen University & Research, Leeuwarden, The Netherlands). Continuously recorded since 2016 across an "
            "experimental herd of approximately 500 Holstein Friesian dairy cows. Encompasses millions of longitudinal "
            "milking parlor/robot transactions, individual load-cell roughage feed visits, computer-controlled concentrate "
            "feed allocations, high-frequency behavioral sensor states, GreenFeed enteric methane/CO2 fluxes, and milk composition records."
        ),
        "dct:publisher": {
            "@type": "foaf:Organization",
            "foaf:name": "Dairy Campus, Wageningen University & Research",
            "foaf:homepage": "https://www.dairycampus.nl/"
        },
        "dct:creator": [
            {
                "@type": "foaf:Person",
                "foaf:name": "Bert Klandermans",
                "schema:affiliation": "Dairy Campus, Wageningen University & Research"
            },
            {
                "@type": "foaf:Person",
                "foaf:name": "Fedde de Jong",
                "schema:affiliation": "Dairy Campus, Wageningen University & Research"
            }
        ],
        "dct:license": "https://creativecommons.org/licenses/by/4.0/",
        "dct:issued": "2016-01-01",
        "dct:modified": "2026-11-10",
        "dct:temporal": {
            "@type": "dct:PeriodOfTime",
            "schema:startDate": "2016-01-01",
            "schema:endDate": "2026-11-10"
        },
        "dct:spatial": {
            "@type": "dct:Location",
            "schema:name": "Dairy Campus, Leeuwarden, Friesland, The Netherlands"
        },
        "dcat:dataset": {
            "@id": f"https://doi.org/{doi_str}#dataset",
            "@type": ["dcat:Dataset", "schema:Dataset"],
            "dct:title": "Dairy Campus Research Data Platform: 19 Precision Dairy Cattle Datasets",
            "dct:description": "Collection of 19 multi-sensor precision livestock farming datasets encompassing 507 scientific variables.",
            "dct:distribution": distributions
        }
    }
    return catalog


def build_datacite_xml(doi_str="10.5281/zenodo.24092291"):
    df = pd.read_csv(DICT_CSV)
    
    root = ET.Element("resource", {
        "xmlns": "http://datacite.org/schema/kernel-4",
        "xmlns:xsi": "http://www.w3.org/2001/XMLSchema-instance",
        "xsi:schemaLocation": "http://datacite.org/schema/kernel-4 http://schema.datacite.org/meta/kernel-4.4/metadata.xsd"
    })

    ET.SubElement(root, "identifier", {"identifierType": "DOI"}).text = doi_str

    creators = ET.SubElement(root, "creators")
    c1 = ET.SubElement(creators, "creator")
    ET.SubElement(c1, "creatorName", {"nameType": "Personal"}).text = "Klandermans, Bert"
    ET.SubElement(c1, "givenName").text = "Bert"
    ET.SubElement(c1, "familyName").text = "Klandermans"
    ET.SubElement(c1, "affiliation").text = "Dairy Campus, Wageningen University & Research"

    c2 = ET.SubElement(creators, "creator")
    ET.SubElement(c2, "creatorName", {"nameType": "Personal"}).text = "de Jong, Fedde"
    ET.SubElement(c2, "givenName").text = "Fedde"
    ET.SubElement(c2, "familyName").text = "de Jong"
    ET.SubElement(c2, "affiliation").text = "Dairy Campus, Wageningen University & Research"

    titles = ET.SubElement(root, "titles")
    ET.SubElement(titles, "title").text = "Dairy Campus Research Data Platform: Comprehensive Data Descriptor, Standardized Metadata Dictionaries, and Calculation Methodologies"

    ET.SubElement(root, "publisher").text = "Dairy Campus, Wageningen University & Research"
    ET.SubElement(root, "publicationYear").text = "2026"
    ET.SubElement(root, "resourceType", {"resourceTypeGeneral": "Dataset"}).text = "DataCatalog"

    subjects = ET.SubElement(root, "subjects")
    for s in ["Dairy Campus", "Wageningen University & Research", "Precision Livestock Farming", "Dairy Cattle", "Enteric Methane", "Roughage Intake Control", "GreenFeed", "Milking Records", "Data Catalog", "DCAT Distribution"]:
        ET.SubElement(subjects, "subject").text = s

    dates = ET.SubElement(root, "dates")
    ET.SubElement(dates, "date", {"dateType": "Collected"}).text = "2016-01-01/2026-11-10"
    ET.SubElement(dates, "date", {"dateType": "Updated"}).text = "2026-11-10"

    formats = ET.SubElement(root, "formats")
    ET.SubElement(formats, "format").text = "application/ld+json"
    ET.SubElement(formats, "format").text = "application/x-sql"
    ET.SubElement(formats, "format").text = "text/csv"

    descriptions = ET.SubElement(root, "descriptions")
    d_abs = ET.SubElement(descriptions, "description", {"descriptionType": "Abstract"})
    d_abs.text = (
        "The Dairy Campus research data platform (Wageningen University & Research, Leeuwarden, The Netherlands) "
        "encompasses longitudinal high-frequency multi-sensor records collected continuously since 2016 from an experimental "
        "herd of approximately 500 Holstein Friesian dairy cows. This catalog structures 19 distinct research datasets "
        "(507 variables) defining automated milking records, individual feed intake visits, concentrate allocations, "
        "accelerometer behavioral states, enteric greenhouse gas fluxes (CH4, CO2), barn climate, and official milk testing records."
    )

    d_tech = ET.SubElement(descriptions, "description", {"descriptionType": "TechnicalInfo"})
    d_tech.text = "Central Catalog Distributions:\n" + "\n".join(
        [f"- {ds} ({len(g)} vars, Source: {g['source_table'].iloc[0]}): {sheet_descriptions.get(ds, ds)}"
         for ds, g in df.groupby("dataset_name", sort=False)]
    )

    rough = ET.tostring(root, encoding="utf-8")
    parsed = minidom.parseString(rough)
    return parsed.toprettyxml(indent="  ")


def main():
    doi = "10.5281/zenodo.24092291"
    jsonld_obj = build_dcat_jsonld(doi)
    jsonld_str = json.dumps(jsonld_obj, indent=2, ensure_ascii=False)
    
    xml_str = build_datacite_xml(doi)

    out_jsonld = ROOT / "zenodo_deposit_files" / "dairy_campus_catalog_dcat.jsonld"
    out_xml = ROOT / "zenodo_deposit_files" / "dairy_campus_datacite.xml"

    out_jsonld.write_text(jsonld_str, encoding="utf-8")
    out_xml.write_text(xml_str, encoding="utf-8")

    print(f"[+] Wrote {out_jsonld} ({len(jsonld_str) / 1024:.1f} KB)")
    print(f"[+] Wrote {out_xml} ({len(xml_str) / 1024:.1f} KB)")


if __name__ == "__main__":
    main()
