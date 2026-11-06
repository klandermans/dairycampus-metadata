#!/usr/bin/env python3
"""
Generate a comprehensive, full-length scientific Data Descriptor article in HTML
with all 19 metadata tables fully elaborated, and update the Zenodo deposition.
"""

import os
import sys
import json
import requests
import pandas as pd
from pathlib import Path

# Load from ~/.env
env_path = Path.home() / ".env"
token = None
if env_path.exists():
    with open(env_path) as f:
        for line in f:
            line = line.strip()
            if line.startswith("ZENODO_ACCESS_TOKEN="):
                token = line.split("=", 1)[1].strip().strip("'\"")

if not token:
    print("Error: ZENODO_ACCESS_TOKEN missing", file=sys.stderr)
    sys.exit(1)

master_df = pd.read_csv("data_dictionary/csv/all_metadata_dictionary.csv")
datasets = master_df["dataset_name"].unique()

article_html = """
<h2>Dairy Campus Research Data Platform: Comprehensive Data Descriptor, Standardized Metadata Dictionaries, and Calculation Methodologies</h2>

<p><strong>Authors:</strong> Bert Klandermans &amp; Fedde de Jong<br>
<strong>Affiliation:</strong> Dairy Campus, Wageningen University &amp; Research, Leeuwarden, The Netherlands<br>
<strong>License:</strong> Creative Commons Attribution 4.0 International (CC-BY 4.0)<br>
<strong>Permanent DOI:</strong> 10.5281/zenodo.24020783</p>

<hr>

<h3>Abstract</h3>
<p>
The Dairy Campus research facility (Wageningen University &amp; Research, Leeuwarden, the Netherlands) operates a high-throughput, multi-sensor experimental dairy cattle infrastructure dedicated to precision livestock farming, sustainable dairy nutrition, animal welfare, and enteric greenhouse gas mitigation. This comprehensive data descriptor provides the complete FAIR metadata documentation, operational parameters, algorithmic calculation models, and standardized data dictionaries for the Dairy Campus Research Data Platform. It elaborates <strong>19 distinct research datasets</strong> comprising <strong>507 scientific variables</strong>, detailing observation granularities, measurement units, sensor specifications, dry matter corrections, water exclusion deductions, milk component yield weighting, Fat- and Protein-Corrected Milk (FPCM) standardizations, behavioral budgets, and automated quality control matrices.
</p>

<hr>

<h3>1. Background &amp; Experimental Facility</h3>
<p>
<strong>Dairy Campus</strong> is the preeminent national and international research, education, and innovation center for dairy farming in the Netherlands, operated by <strong>Wageningen University &amp; Research (WUR)</strong>. Dairy Campus manages an experimental herd of approximately 500 Holstein Friesian dairy cows housed in specialized compartments and cubicle pens (stallen 50–73). The facility is equipped with automated feeding kitchens, automated milking systems, computerized concentrate stations, high-frequency behavioral accelerometers, enteric methane and carbon dioxide measurement hoods, and continuous barn climate monitoring.
</p>
<p>
Scientific trials conducted at Dairy Campus investigate dairy cattle nutrition, feed efficiency, mitigation of enteric greenhouse gases (CH<sub>4</sub> and CO<sub>2</sub>), precision health diagnostics, animal welfare, locomotion, and circular manure/nitrogen cycles. To support open science and the FAIR principles (Findable, Accessible, Interoperable, Reusable), this catalog formalizes the data models and calculation pipelines used to export experimental datasets.
</p>

<hr>

<h3>2. Precision Livestock Farming (PLF) Sensor Infrastructure</h3>
<p>The Dairy Campus data platform continuously ingests data streams from commercial and experimental hardware:</p>
<ul>
    <li><strong>Hokofarm RIC (Roughage Intake Control) Troughs:</strong> Automated individual feed intake bins mounted on high-precision electronic load cells with integrated RFID cow transponder recognition. Measures start weight, end weight, duration, and eating rate per visit.</li>
    <li><strong>Trioliet Triomatic Automated Feeding Robot:</strong> Automated feeding kitchen and suspended feeding robot mixer wagon. Weighs silage, concentrates, and water during recipe loading, and logs distributed batch drops to specific barn pens and troughs.</li>
    <li><strong>SAC &amp; Hokofarm Computerized Concentrate Stations:</strong> Automated concentrate feeding boxes dispensing up to four concentrate feeds (A, B, C, D) based on individual nutritional allowance curves.</li>
    <li><strong>GEA Automated Milking Systems:</strong> Electronic milking parlors and robotic milking units capturing individual milk yields, milking durations, quarter-level milk electrical conductivity, blood detection, and cow live body weight during milking.</li>
    <li><strong>Nedap Velos Behavior Smarttags:</strong> Accelerometer sensors (neck collars and leg pedometers) transmitting behavioral activity intervals classified into eating, ruminating, inactivity (lying), and active standing/walking.</li>
    <li><strong>C-Lock GreenFeed Emission Monitoring Units:</strong> Automated head-hood emission chambers measuring enteric methane (CH<sub>4</sub>) and carbon dioxide (CO<sub>2</sub>) flux rates during voluntary bait-fed cow visits.</li>
    <li><strong>DeLaval 3D Body Condition Score (BCS) Cameras:</strong> Overhead 3D stereoscopic imaging cameras capturing structural dorsal contours and body fat mobilization scores (scale 1.00–5.00).</li>
    <li><strong>Dairy Campus Weather Station &amp; Airkoe Curtain Ventilation:</strong> On-site meteorological station recording ambient temperature, humidity, wind, and radiation, paired with automated barn curtain ventilation controllers.</li>
</ul>

<hr>

<h3>3. Data Harmonization &amp; Calculation Methodologies</h3>

<h4>3.1 Roughage Intake &amp; Water Exclusion Deduction</h4>
<p>
During total mixed ration (TMR) preparation in the Trioliet Triomatic automated feeding kitchen, water is frequently added to suppress dust and prevent ration sorting by dairy cows. To measure the true nutritional intake, the intake recorded by the Hokofarm RIC bins is adjusted by subtracting the proportion of added water logged in the mixer robot load files:
</p>
<blockquote style="background:#f8f9fa; border-left:4px solid #0366d6; padding:10px 15px; margin:10px 0;">
<strong>Water Exclusion Ratio:</strong><br>
<code>WaterRatio = (TotalLoaded - AddedWaterKg) / TotalLoaded</code><br><br>
<strong>Roughage Intake Excluding Water:</strong><br>
<code>Intake_excl_water (kg/day) = Intake_fresh &times; WaterRatio</code>
</blockquote>

<h4>3.2 Laboratory Dry Matter (DM) Content &amp; Total DMI</h4>
<p>
Weekly representative forage and silage samples are analyzed in the Dairy Campus drying oven laboratory (<em>droogstoof</em>, <code>VL_totaal_droogstoof</code>) to determine dry matter percentages (<code>WeekGemiddelde_DS</code>). Total daily Dry Matter Intake (DMI) across all four roughage fractions (rv<sub>1</sub>–rv<sub>4</sub>) is computed as:
</p>
<blockquote style="background:#f8f9fa; border-left:4px solid #0366d6; padding:10px 15px; margin:10px 0;">
<strong>Total Daily Dry Matter Intake:</strong><br>
<code>tot.opnDs (kg DM/day) = &sum; [ Intake_excl_water,i &times; (DM_percentage,i / 100) ]</code>
</blockquote>

<h4>3.3 Milk Recording (MPR) AO Yield-Weighted Composite Formula</h4>
<p>
In experimental trial sampling, milk samples are collected during evening (A) and morning (O) milking sessions (AO sampling). Because milk volume and milk solids vary significantly between morning and evening intervals, daily composite concentrations are calculated as <strong>yield-weighted averages</strong> in view <code>VL_Dier_Datum_Crv</code>:
</p>
<blockquote style="background:#f8f9fa; border-left:4px solid #0366d6; padding:10px 15px; margin:10px 0;">
<strong>Yield-Weighted Component Concentration:</strong><br>
<code>Composite_Concentration = (Concentration_evening &times; Yield_evening + Concentration_morning &times; Yield_morning) / (Yield_evening + Yield_morning)</code>
</blockquote>
<p>
This formula is applied to milk fat percentage, crude protein percentage, lactose percentage, urea concentration (mg/dL), and somatic cell count (SCC, in 1,000 cells/mL).
</p>

<h4>3.4 Fat- and Protein-Corrected Milk (FPCM / Standaardmelk)</h4>
<p>
To standardize milk production to an equivalent energetic value across cows, diets, and lactation stages, milk yield is standardized using the Dutch national reference formula (CVB / Wageningen University &amp; Research standard, implemented in view <code>bert_relifestock</code>):
</p>
<blockquote style="background:#f8f9fa; border-left:4px solid #0366d6; padding:10px 15px; margin:10px 0;">
<strong>Fat- and Protein-Corrected Milk (kg/day):</strong><br>
<code>FPCM = MilkYield &times; (0.337 + 0.116 &times; Fat% + 0.060 &times; Protein%)</code>
</blockquote>
<p>
Standard milk (FPCM) represents milk containing 4.00% fat and 3.32% protein, delivering approximately 3.14 MJ Net Energy for Lactation (NE<sub>L</sub>) per kilogram.
</p>

<h4>3.5 Feed Conversion Efficiency (FCE)</h4>
<blockquote style="background:#f8f9fa; border-left:4px solid #0366d6; padding:10px 15px; margin:10px 0;">
<strong>Feed Conversion Efficiency:</strong><br>
<code>FCE = FPCM (kg/day) / Dry Matter Intake (kg DM/day)</code>
</blockquote>

<h4>3.6 Nedap Velos 24-Hour Behavioral Budgets</h4>
<p>
Raw high-frequency intervals transmitted by Nedap Smarttags are categorized into behavioral states: 0 = other/active, 1 = inactive/lying, 2 = ruminating, and 3 = eating. Seconds duration are aggregated over each 24-hour calendar day in <code>Velos_behaviour_day</code> to produce daily behavioral time-budgets.
</p>

<h4>3.7 Enteric GHG Emissions (C-Lock GreenFeed)</h4>
<p>
GreenFeed units measure methane (CH<sub>4</sub>) and carbon dioxide (CO<sub>2</sub>) mass fluxes by drawing air past the cow's muzzle during voluntary bait-fed visits. Validated visit fluxes (g CH<sub>4</sub>/day, g CO<sub>2</sub>/day) are integrated based on airflow calibration factors (<code>AirflowCf</code>), background gas concentrations, and head proximity sensor metrics.
</p>

<h4>3.8 Automated Data Quality &amp; Missing Observation Matrix</h4>
<p>
View <code>TVL_Totaal_missende_data_proef</code> performs daily automated audit checks across all experimental cows. It flags missing milkings, missing body weights, lack of feed intake, and sensor dropouts (e.g. days where Nedap Velos logs less than 50,000 seconds of behavior).
</p>

<hr>

<h3>4. Overview of Research Datasets</h3>
<table border="1" cellpadding="6" cellspacing="0" style="border-collapse: collapse; width: 100%; font-size: 13px;">
<thead style="background-color: #0366d6; color: #ffffff;">
    <tr>
        <th>#</th>
        <th>Dataset Identifier</th>
        <th>Descriptive Title</th>
        <th>Variables</th>
        <th>Primary Granularity</th>
        <th>Source System</th>
    </tr>
</thead>
<tbody>
"""

sheet_descriptions = {
    "TVL_total": "Master Daily Integrated Cow Summary (intake, yields, milk components, body weight, BCS, emissions)",
    "Hokofarm_RIC": "Roughage Intake Control Individual Visit Transactions (entry/exit timestamps, trough weights)",
    "Hokofarm_SAC_concentrates": "Automatic Concentrate Feeder Transactions (programmed feed, intake, feeder speed, visits)",
    "TVL_RIC_intake_dm": "Roughage Daily Intake & Dry Matter Integration (fresh intake, laboratory dry oven DM%)",
    "Triomatic_RIC_load": "Trioliet Feeding Robot Mixer Loading Records (kitchen ingredient batch target and loaded weights)",
    "Triomatic_RIC_drop": "Trioliet Feeding Robot Trough Deliveries (discharged ration mass to pens and RIC bins)",
    "GEA_milkings": "GEA Milking Robot & Parlor Transactions (session yields, duration, conductivity, body weight)",
    "GEA_gates": "GEA Separation & Smart Gate Passages (cow identification, routing decisions, sorting gate ID)",
    "TMR_Trioliet_cowconnect_mix": "CowConnect Mixer Wagon Rations (planned vs actual ingredient loading weights and mixing times)",
    "TMR_Trioliet_cowconnect_drop": "CowConnect Feed Distribution Drops (ration discharge records along feed fences)",
    "Velos_behaviour": "Nedap Velos Cow Behaviour Intervals (smarttag sensor state transitions for eating, ruminating, lying)",
    "Velos_behaviour_day": "Nedap Velos Daily Cow Behaviour Summary (aggregated 24-hour durations of eating, ruminating, resting)",
    "Greenfeed_summarized_data": "GreenFeed Enteric Emission Summaries (validated CH4 and CO2 fluxes, head sensors, airflow rates)",
    "Greenfeed_feed_aggregrated": "GreenFeed Bait Feed Drops (pelleted feed mass and cup drop rewards during emission visits)",
    "DC_DM_content": "Laboratory Dry Matter Content Oven Tests (official droogstoof gravimetric oven analysis results)",
    "Weatherstation": "Dairy Campus Meteorological Weather Station (ambient temperature, humidity, wind, solar radiation, rain)",
    "Missing_data": "Data Quality & Completeness Audit Matrix (automated daily validation flags per cow per day)",
    "Environment_barn_Animal_day": "Barn Environment & Animal Daily Profile (pen housing, lactation days, parity, age, movement)",
    "Environment_barn_Animal_experim": "Experimental Cohort Animal Daily Records (trial project codes, treatment assignments, blocks)"
}

for idx, ds in enumerate(datasets, start=1):
    sub = master_df[master_df["dataset_name"] == ds]
    desc = sheet_descriptions.get(ds, ds)
    src = sub["source_table"].iloc[0]
    article_html += f"""    <tr>
        <td>{idx}</td>
        <td><strong><code>{ds}</code></strong></td>
        <td>{desc}</td>
        <td><strong>{len(sub)}</strong></td>
        <td>Daily / Visit records</td>
        <td><code>{src}</code></td>
    </tr>
"""

article_html += """</tbody>
</table>

<hr>

<h3>5. Complete Elaborated Data Dictionaries (All 19 Tables)</h3>
<p>The tables below provide the full, variable-by-variable specification for each dataset in the Dairy Campus Research Data Platform.</p>
"""

# Now generate every single table with all variables!
for idx, ds in enumerate(datasets, start=1):
    sub = master_df[master_df["dataset_name"] == ds]
    desc = sheet_descriptions.get(ds, ds)
    src = sub["source_table"].iloc[0]

    article_html += f"""
<h4 id="table_{ds}">{idx}. {ds} &mdash; {desc}</h4>
<p><strong>Database Source:</strong> <code>{src}</code> | <strong>Total Variables:</strong> {len(sub)}</p>
<table border="1" cellpadding="5" cellspacing="0" style="border-collapse: collapse; width: 100%; margin-bottom: 25px; font-size: 12px;">
<thead style="background-color: #f1f8ff; color: #0366d6;">
    <tr>
        <th style="width: 16%;">Column Name</th>
        <th style="width: 18%;">English Label</th>
        <th style="width: 8%;">Type</th>
        <th style="width: 8%;">Unit</th>
        <th style="width: 9%;">Method</th>
        <th style="width: 25%;">English Description</th>
        <th style="width: 16%;">Calculation / Source</th>
    </tr>
</thead>
<tbody>
"""
    for _, r in sub.iterrows():
        unit_str = r["unit"] if pd.notna(r["unit"]) and str(r["unit"]).strip() not in ["N/A", ""] else "&mdash;"
        m_type = r["measurement_type"] if pd.notna(r["measurement_type"]) and str(r["measurement_type"]).strip() not in ["N/A", ""] else "Measured"
        desc_str = r["description_en"] if pd.notna(r["description_en"]) else ""
        
        calc_str = ""
        if m_type == "Calculated":
            calc_str = f"<strong>Calc:</strong> {r['calculation_description']}"
            if pd.notna(r["calculation_source"]) and str(r["calculation_source"]).strip() not in ["N/A", ""]:
                calc_str += f"<br><small>Source: {r['calculation_source']}</small>"
        elif pd.notna(r["calculation_source"]) and str(r["calculation_source"]).strip() not in ["N/A", ""]:
            calc_str = f"Source: {r['calculation_source']}"
        else:
            calc_str = "Direct measurement"

        type_badge = f"<span style='color: #d73a49; font-weight: bold;'>{m_type}</span>" if m_type == "Calculated" else f"<span style='color: #22863a;'>{m_type}</span>"

        article_html += f"""    <tr>
        <td><code>{r['column_name']}</code></td>
        <td><strong>{r['name_en']}</strong></td>
        <td><code>{r['data_type']}</code></td>
        <td>{unit_str}</td>
        <td>{type_badge}</td>
        <td>{desc_str}</td>
        <td>{calc_str}</td>
    </tr>
"""
    article_html += "</tbody></table>\n"

article_html += """
<hr>

<h3>6. Trial-Specific Data Extraction Queries</h3>
<p>
In the automated Apache Airflow pipeline (<code>report.py</code>), research deliverables for a specific scientific study are extracted using parameterized SQL queries. Each query filters by the unique experiment/trial code:
<br><code>WHERE prfcod = '[prfcod]'</code>
</p>
<p>
The bundled archive <strong><code>04_Dairy_Campus_Calculations_and_Queries.zip</code></strong> contains all 30 production extraction queries (covering breeds, veterinary diagnoses, treatments, weighings, dry matter, barn climate, milking sessions, feeding visits, behavior summaries, and GreenFeed visits), along with 20 stored procedures, 197 views, and 26 user-defined functions that constitute the core calculation engine.
</p>

<hr>

<h3>7. How to Cite</h3>
<p>If you use these metadata specifications, dictionaries, or calculation methodologies in scientific publications or secondary data analyses, please cite:</p>
<blockquote style="background:#f8f9fa; border-left:4px solid #0366d6; padding:10px 15px;">
Klandermans, B., &amp; de Jong, F. (2026). <em>Dairy Campus Research Data Platform: Metadata Dictionary, Extraction Queries, and Calculation Models</em> (Version v1.0.0) [Data set]. Zenodo. <a href="https://doi.org/10.5281/zenodo.24020783">https://doi.org/10.5281/zenodo.24020783</a>
</blockquote>
"""

# Save locally
out_path = "zenodo_deposit_files/zenodo_full_article_description.html"
with open(out_path, "w", encoding="utf-8") as f:
    f.write(article_html)
print(f"Generated full article HTML ({len(article_html) / 1024:.1f} KB).")

# Update Zenodo deposition
print("Updating Zenodo deposition metadata via API...")
dep_id = "24020783"
update_url = f"https://zenodo.org/api/deposit/depositions/{dep_id}"
headers = {"Content-Type": "application/json"}
params = {"access_token": token}

payload = {
    "metadata": {
        "title": "Dairy Campus Research Data Platform: Comprehensive Data Descriptor, Standardized Metadata Dictionaries, and Calculation Methodologies",
        "upload_type": "dataset",
        "description": article_html,
        "creators": [
            {
                "name": "Klandermans, Bert",
                "affiliation": "Dairy Campus, Wageningen University & Research"
            },
            {
                "name": "de Jong, Fedde",
                "affiliation": "Dairy Campus, Wageningen University & Research"
            }
        ],
        "keywords": [
            "Dairy Campus",
            "Wageningen University & Research",
            "Dairy cattle",
            "Precision Livestock Farming",
            "Enteric methane",
            "GreenFeed",
            "Roughage Intake Control",
            "Hokofarm RIC",
            "Trioliet Triomatic",
            "Nedap Velos",
            "GEA Milking",
            "Cow behaviour",
            "FAIR data",
            "Data dictionary",
            "Metadata",
            "Data Descriptor"
        ],
        "access_right": "open",
        "license": "cc-by-4.0"
    }
}

r = requests.put(update_url, params=params, json=payload, headers=headers)
if r.status_code == 200:
    print(f"Successfully updated Zenodo deposition {dep_id} with full article!")
    print(f"View online: https://zenodo.org/deposit/{dep_id}")
else:
    print(f"Failed to update Zenodo: {r.status_code} - {r.text}", file=sys.stderr)
    sys.exit(1)
