#!/usr/bin/env python3
"""
Generate publication-quality Data Descriptor for Zenodo:
1. Strict alignment with the 19 metadata SQL tables (no ad-hoc views like bert_relifestock).
2. Perfectly consistent table widths (100% width, table-layout: fixed, identical colgroup).
3. Scientific mathematical notation for all calculation formulas.
4. Updates the Zenodo deposition via REST API.
"""

import os
import sys
import json
import requests
import pandas as pd
from pathlib import Path

# Load token from ~/.env
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

# Mathematical equations in HTML with scientific notation
EQ_WATER = """<div style="background-color: #f8f9fa; border: 1px solid #d0d7de; border-left: 4px solid #0969da; border-radius: 4px; padding: 12px 18px; margin: 12px 0; font-family: 'Times New Roman', Times, serif;">
    <div style="font-size: 15px; margin-bottom: 6px;">
        <em>R</em><sub>water</sub> = 
        <span style="display: inline-block; vertical-align: middle; text-align: center;">
            <span style="display: block; border-bottom: 1px solid #000; padding: 0 4px;">&sum; <em>M</em><sub>loaded</sub> &minus; &sum; <em>M</em><sub>water</sub></span>
            <span style="display: block; padding: 0 4px;">&sum; <em>M</em><sub>loaded</sub></span>
        </span>
    </div>
    <div style="font-size: 15px;">
        <em>I</em><sub>excl_water, <em>i</em></sub> = <em>I</em><sub>fresh, <em>i</em></sub> &times; <em>R</em><sub>water</sub>
    </div>
    <div style="font-size: 12px; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; color: #57606a; margin-top: 8px;">
        Where <em>I</em><sub>fresh, <em>i</em></sub> is the fresh roughage intake of fraction <em>i</em> &isin; {rv<sub>1</sub>, rv<sub>2</sub>, rv<sub>3</sub>, rv<sub>4</sub>} from Hokofarm RIC bins, <em>M</em><sub>loaded</sub> is the total ingredient batch mass loaded into the Trioliet Triomatic feeding robot, and <em>M</em><sub>water</sub> is the mass of water added in the mixer wagon.
    </div>
</div>"""

EQ_DMI = """<div style="background-color: #f8f9fa; border: 1px solid #d0d7de; border-left: 4px solid #0969da; border-radius: 4px; padding: 12px 18px; margin: 12px 0; font-family: 'Times New Roman', Times, serif;">
    <div style="font-size: 15px;">
        <em>DMI</em><sub>total</sub> = &sum;<sub><em>i</em>=1</sub><sup>4</sup> 
        <span style="font-size: 17px;">[</span> 
        <em>I</em><sub>excl_water, <em>i</em></sub> &times; 
        <span style="display: inline-block; vertical-align: middle; text-align: center;">
            <span style="display: block; border-bottom: 1px solid #000; padding: 0 4px;"><em>DM</em><sub>%, <em>i</em></sub></span>
            <span style="display: block; padding: 0 4px;">100</span>
        </span>
        <span style="font-size: 17px;">]</span>
    </div>
    <div style="font-size: 12px; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; color: #57606a; margin-top: 8px;">
        Where <em>DMI</em><sub>total</sub> is the total daily dry matter intake (<code>tot.opnDs</code>, kg DM/day), and <em>DM</em><sub>%, <em>i</em></sub> is the dry matter percentage determined weekly by drying oven gravimetric analysis (<code>VL_totaal_droogstoof</code> via <code>WeekGemiddelde_DS</code>).
    </div>
</div>"""

EQ_MPR = """<div style="background-color: #f8f9fa; border: 1px solid #d0d7de; border-left: 4px solid #0969da; border-radius: 4px; padding: 12px 18px; margin: 12px 0; font-family: 'Times New Roman', Times, serif;">
    <div style="font-size: 15px;">
        <em>C&#772;</em><sub>component</sub> = 
        <span style="display: inline-block; vertical-align: middle; text-align: center;">
            <span style="display: block; border-bottom: 1px solid #000; padding: 0 4px;">&sum;<sub><em>j</em> &isin; {A, O}</sub> (<em>C</em><sub><em>j</em></sub> &times; <em>Y</em><sub><em>j</em></sub>)</span>
            <span style="display: block; padding: 0 4px;">&sum;<sub><em>j</em> &isin; {A, O}</sub> <em>Y</em><sub><em>j</em></sub></span>
        </span>
    </div>
    <div style="font-size: 12px; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; color: #57606a; margin-top: 8px;">
        Where <em>C&#772;</em> is the 24-hour yield-weighted concentration of component <em>C</em> &isin; {Fat%, Protein%, Lactose%, SCC, Urea}, <em>C</em><sub><em>j</em></sub> is the concentration measured in milking session <em>j</em> (Evening [A] or Morning [O]), and <em>Y</em><sub><em>j</em></sub> is the corresponding milking yield in kg (view <code>VL_Dier_Datum_Crv</code>).
    </div>
</div>"""

EQ_BEH = """<div style="background-color: #f8f9fa; border: 1px solid #d0d7de; border-left: 4px solid #0969da; border-radius: 4px; padding: 12px 18px; margin: 12px 0; font-family: 'Times New Roman', Times, serif;">
    <div style="font-size: 15px;">
        <em>T</em><sub>state</sub> = &sum;<sub><em>k</em> &isin; <em>S</em><sub>state</sub></sub> &Delta;<em>t</em><sub><em>k</em></sub>
    </div>
    <div style="font-size: 12px; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; color: #57606a; margin-top: 8px;">
        Where <em>T</em><sub>state</sub> is the aggregated daily duration for behavioral state <em>state</em> &isin; {Eating (type 3), Ruminating (type 2), Inactive (type 1), Other active (type 0)}, and &Delta;<em>t</em><sub><em>k</em></sub> is the duration of individual observation intervals in seconds recorded by Nedap Velos Smarttags over a 24-hour cycle.
    </div>
</div>"""

EQ_TIMING = """<div style="background-color: #f8f9fa; border: 1px solid #d0d7de; border-left: 4px solid #0969da; border-radius: 4px; padding: 12px 18px; margin: 12px 0; font-family: 'Times New Roman', Times, serif;">
    <div style="font-size: 15px; margin-bottom: 4px;">
        <em>DIM</em> = <em>t</em><sub>observation</sub> &minus; <em>t</em><sub>calving</sub> &emsp;&emsp; (Days in Milk, <code>LacDgn</code>)
    </div>
    <div style="font-size: 15px; margin-bottom: 4px;">
        <em>Age</em><sub>days</sub> = <em>t</em><sub>observation</sub> &minus; <em>t</em><sub>birth</sub> &emsp;&emsp; (Animal Age in Days, <code>LftDgn</code>)
    </div>
    <div style="font-size: 15px;">
        <em>Date</em><sub>exp_calving</sub> = <em>t</em><sub>insemination</sub> + 280 &emsp;&emsp; (Projected Calving Date, <code>VrwKlfDat</code>)
    </div>
</div>"""

article_html = f"""
<h2>Dairy Campus Research Data Platform: Comprehensive Data Descriptor, Standardized Metadata Dictionaries, and Calculation Methodologies</h2>

<p><strong>Authors:</strong> Bert Klandermans &amp; Fedde de Jong<br>
<strong>Affiliation:</strong> Dairy Campus, Wageningen University &amp; Research, Leeuwarden, The Netherlands<br>
<strong>License:</strong> Creative Commons Attribution 4.0 International (CC-BY 4.0)<br>
<strong>Permanent DOI:</strong> 10.5281/zenodo.24020864</p>

<hr>

<h3>Abstract</h3>
<p>
The Dairy Campus research facility (Wageningen University &amp; Research, Leeuwarden, the Netherlands) operates a high-throughput, multi-sensor experimental dairy cattle infrastructure dedicated to precision livestock farming, sustainable dairy cattle nutrition, animal welfare, and enteric greenhouse gas mitigation. This comprehensive data descriptor provides the complete FAIR metadata documentation, operational parameters, algorithmic calculation models, and standardized data dictionaries for the Dairy Campus Research Data Platform. It elaborates <strong>19 distinct research datasets</strong> comprising <strong>507 scientific variables</strong>, detailing observation granularities, measurement units, sensor specifications, dry matter corrections, water exclusion deductions, milk component yield weighting, behavioral budgets, and automated quality control matrices.
</p>

<hr>

<h3>1. Background &amp; Experimental Facility</h3>
<p>
<strong>Dairy Campus</strong> is the preeminent national and international research, education, and innovation center for dairy farming in the Netherlands, operated by <strong>Wageningen University &amp; Research (WUR)</strong>. Dairy Campus manages an experimental herd of approximately 500 Holstein Friesian dairy cows housed in specialized compartments and cubicle pens (stallen 50&ndash;73). The facility is equipped with automated feeding kitchens, automated milking systems, computerized concentrate stations, high-frequency behavioral accelerometers, enteric methane and carbon dioxide measurement hoods, and continuous barn climate monitoring.
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
    <li><strong>DeLaval 3D Body Condition Score (BCS) Cameras:</strong> Overhead 3D stereoscopic imaging cameras capturing structural dorsal contours and body fat mobilization scores (scale 1.00&ndash;5.00).</li>
    <li><strong>Dairy Campus Weather Station &amp; Airkoe Curtain Ventilation:</strong> On-site meteorological station recording ambient temperature, humidity, wind, and radiation, paired with automated barn curtain ventilation controllers.</li>
</ul>

<hr>

<h3>3. Data Processing &amp; Calculation Methodologies in SQL Tables</h3>
<p>This section details the mathematical calculations implemented directly in the database views and stored procedures defining the 19 metadata tables.</p>

<h4>3.1 Roughage Intake &amp; Water Exclusion Deduction</h4>
<p>
During total mixed ration (TMR) preparation in the Trioliet Triomatic automated feeding kitchen, water is added to suppress dust and prevent ration sorting. To measure true roughage intake, the intake recorded by the Hokofarm RIC bins is adjusted by subtracting the proportion of added water logged in the mixer robot load files (view <code>VL_Totaal_sub_ric_opn_prod</code>):
</p>
{EQ_WATER}

<h4>3.2 Laboratory Dry Matter (DM) Content &amp; Total DMI</h4>
<p>
Weekly forage and silage samples are analyzed in the drying oven laboratory (<em>droogstoof</em>, <code>VL_totaal_droogstoof</code>) to determine dry matter percentages (function <code>WeekGemiddelde_DS</code>). Total daily Dry Matter Intake (DMI) across all four roughage fractions (rv<sub>1</sub>&ndash;rv<sub>4</sub>) is computed as:
</p>
{EQ_DMI}

<h4>3.3 Concentrate Allowance vs. Consumed Intake</h4>
<p>
For SAC / Hokofarm computerized feeding boxes, programmed daily allowances (<code>AtributedKVA</code>&ndash;<code>AtributedKVD</code>) and actual consumed amounts (<code>TotalIntakeKVA</code>&ndash;<code>TotalIntakeKVD</code>) are summed across stations (view <code>VL_Totaal_Sub_HokofarmBrok</code>). For GEA in-parlor feeding, intake is recorded in grams (<code>KvMlk1</code>, <code>KvMlk2</code>) and converted to kg (<code>C21-9</code>, <code>C21-10</code>), while DeLaval dispensers compute:
</p>
<div style="background-color: #f8f9fa; border: 1px solid #d0d7de; border-left: 4px solid #0969da; border-radius: 4px; padding: 12px 18px; margin: 12px 0; font-family: 'Times New Roman', Times, serif;">
    <div style="font-size: 15px;">
        <em>I</em><sub>DelPro-13</sub> = <em>Q</em><sub>programmed</sub> &minus; <em>Q</em><sub>remain</sub>
    </div>
    <div style="font-size: 12px; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; color: #57606a; margin-top: 8px;">
        Where <em>Q</em><sub>programmed</sub> is the feed mass programmed and <em>Q</em><sub>remain</sub> is the residual unconsumed feed mass remaining in the feeder (view <code>VL_Totaal_sub_kv</code>).
    </div>
</div>

<h4>3.4 Milk Recording (MPR) AO Yield-Weighted Composite Formula</h4>
<p>
In experimental trial sampling, milk samples are collected during evening (A) and morning (O) milking sessions (AO sampling). Because milk volume and milk solids vary between morning and evening intervals, daily composite concentrations are calculated as <strong>yield-weighted averages</strong> in view <code>VL_Dier_Datum_Crv</code>:
</p>
{EQ_MPR}
<p>
Official monthly test-day records (<code>T_Animal_MilkSamples</code>) are stored as <code>MlkStd</code> (milk yield, kg), <code>VetStd</code> (fat %), <code>EiwStd</code> (protein %), <code>LacStd</code> (lactose %), <code>UreStd</code> (urea, mg/dL), <code>CelStd</code> (somatic cell count, 1,000 cells/mL), and <code>KetStd</code> (diagnostic ketosis classification code: 0 = healthy, 1 = suspect, 2 = clinical).
</p>

<h4>3.5 Nedap Velos 24-Hour Behavioral Budgets</h4>
<p>
Raw high-frequency intervals transmitted by Nedap Smarttags are categorized into behavioral states: 0 = other/active, 1 = inactive/lying, 2 = ruminating, and 3 = eating. Seconds duration are aggregated over each 24-hour calendar day in <code>Velos_behaviour_day</code>:
</p>
{EQ_BEH}

<h4>3.6 Animal Demographics &amp; Lactation Timing</h4>
<p>
Standardized chronological and reproductive timing metrics are computed in view <code>VL_totaal_bedrijf</code>:
</p>
{EQ_TIMING}

<h4>3.7 Automated Data Quality &amp; Missing Observation Matrix</h4>
<p>
View <code>TVL_Totaal_missende_data_proef</code> performs daily automated audit checks across all experimental cows. It flags missing milkings, missing body weights, lack of feed intake, and sensor dropouts (e.g. days where Nedap Velos logs less than 50,000 seconds of behavior).
</p>

<hr>

<h3>4. Overview of Research Datasets</h3>
<table style="width: 100%; table-layout: fixed; border-collapse: collapse; font-size: 13px; border: 1px solid #d0d7de; margin-bottom: 30px;">
<colgroup>
    <col style="width: 5%;">
    <col style="width: 28%;">
    <col style="width: 37%;">
    <col style="width: 10%;">
    <col style="width: 20%;">
</colgroup>
<thead style="background-color: #0366d6; color: #ffffff;">
    <tr>
        <th style="padding: 10px 8px; text-align: center; border: 1px solid #d0d7de;">#</th>
        <th style="padding: 10px 8px; text-align: left; border: 1px solid #d0d7de;">Dataset Identifier</th>
        <th style="padding: 10px 8px; text-align: left; border: 1px solid #d0d7de;">Scientific Domain &amp; Description</th>
        <th style="padding: 10px 8px; text-align: center; border: 1px solid #d0d7de;">Variables</th>
        <th style="padding: 10px 8px; text-align: left; border: 1px solid #d0d7de;">Source Table</th>
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
    bg = "#f6f8fa" if idx % 2 == 0 else "#ffffff"
    article_html += f"""    <tr style="background-color: {bg};">
        <td style="padding: 8px; text-align: center; border: 1px solid #d0d7de;">{idx}</td>
        <td style="padding: 8px; border: 1px solid #d0d7de;"><strong><code>{ds}</code></strong></td>
        <td style="padding: 8px; border: 1px solid #d0d7de;">{desc}</td>
        <td style="padding: 8px; text-align: center; border: 1px solid #d0d7de;"><strong>{len(sub)}</strong></td>
        <td style="padding: 8px; border: 1px solid #d0d7de;"><code>{src}</code></td>
    </tr>
"""

article_html += """</tbody>
</table>

<hr>

<h3>5. Complete Elaborated Data Dictionaries (All 19 Tables)</h3>
<p>Each table below has a standardized layout with consistent column widths. Variable names, English labels, data types, physical measurement units, calculation formulas, and source tables are fully elaborated.</p>
"""

# Standardized column width definition applied to ALL 19 tables!
STANDARD_COLGROUP = """<colgroup>
    <col style="width: 17%;">
    <col style="width: 18%;">
    <col style="width: 8%;">
    <col style="width: 8%;">
    <col style="width: 9%;">
    <col style="width: 23%;">
    <col style="width: 17%;">
</colgroup>"""

for idx, ds in enumerate(datasets, start=1):
    sub = master_df[master_df["dataset_name"] == ds]
    desc = sheet_descriptions.get(ds, ds)
    src = sub["source_table"].iloc[0]

    article_html += f"""
<h4 id="table_{ds}" style="color: #0969da; margin-top: 35px; margin-bottom: 8px;">{idx}. {ds} &mdash; {desc}</h4>
<p style="margin-top: 0; margin-bottom: 12px; font-size: 13px; color: #57606a;"><strong>Database Source:</strong> <code>{src}</code> | <strong>Variables:</strong> {len(sub)} | <strong>Granularity:</strong> Daily / Visit record</p>

<table style="width: 100%; table-layout: fixed; border-collapse: collapse; margin-bottom: 30px; font-size: 12px; border: 1px solid #d0d7de;">
{STANDARD_COLGROUP}
<thead style="background-color: #f6f8fa; color: #24292f;">
    <tr>
        <th style="padding: 8px 10px; text-align: left; border: 1px solid #d0d7de; overflow-wrap: break-word;">Column Name</th>
        <th style="padding: 8px 10px; text-align: left; border: 1px solid #d0d7de; overflow-wrap: break-word;">English Label</th>
        <th style="padding: 8px 6px; text-align: center; border: 1px solid #d0d7de;">Type</th>
        <th style="padding: 8px 6px; text-align: center; border: 1px solid #d0d7de;">Unit</th>
        <th style="padding: 8px 6px; text-align: center; border: 1px solid #d0d7de;">Method</th>
        <th style="padding: 8px 10px; text-align: left; border: 1px solid #d0d7de; overflow-wrap: break-word;">English Description</th>
        <th style="padding: 8px 10px; text-align: left; border: 1px solid #d0d7de; overflow-wrap: break-word;">Calculation / Source</th>
    </tr>
</thead>
<tbody>
"""
    for r_idx, (_, r) in enumerate(sub.iterrows()):
        unit_str = r["unit"] if pd.notna(r["unit"]) and str(r["unit"]).strip() not in ["N/A", ""] else "&mdash;"
        m_type = r["measurement_type"] if pd.notna(r["measurement_type"]) and str(r["measurement_type"]).strip() not in ["N/A", ""] else "Measured"
        desc_str = r["description_en"] if pd.notna(r["description_en"]) else ""
        
        calc_str = ""
        if m_type == "Calculated":
            calc_str = f"<strong>Calc:</strong> {r['calculation_description']}"
            if pd.notna(r["calculation_source"]) and str(r["calculation_source"]).strip() not in ["N/A", ""]:
                calc_str += f"<br><small style='color: #57606a;'>Source: {r['calculation_source']}</small>"
        elif pd.notna(r["calculation_source"]) and str(r["calculation_source"]).strip() not in ["N/A", ""]:
            calc_str = f"Source: {r['calculation_source']}"
        else:
            calc_str = "Direct measurement"

        type_badge = f"<span style='color: #cf222e; font-weight: 600;'>{m_type}</span>" if m_type == "Calculated" else f"<span style='color: #1a7f37;'>{m_type}</span>"
        row_bg = "#ffffff" if r_idx % 2 == 0 else "#fbfcfd"

        article_html += f"""    <tr style="background-color: {row_bg};">
        <td style="padding: 7px 10px; border: 1px solid #d0d7de; overflow-wrap: break-word; font-family: monospace; font-size: 11px;">{r['column_name']}</td>
        <td style="padding: 7px 10px; border: 1px solid #d0d7de; overflow-wrap: break-word;"><strong>{r['name_en']}</strong></td>
        <td style="padding: 7px 6px; text-align: center; border: 1px solid #d0d7de; font-family: monospace; font-size: 11px;">{r['data_type']}</td>
        <td style="padding: 7px 6px; text-align: center; border: 1px solid #d0d7de;">{unit_str}</td>
        <td style="padding: 7px 6px; text-align: center; border: 1px solid #d0d7de;">{type_badge}</td>
        <td style="padding: 7px 10px; border: 1px solid #d0d7de; overflow-wrap: break-word;">{desc_str}</td>
        <td style="padding: 7px 10px; border: 1px solid #d0d7de; overflow-wrap: break-word;">{calc_str}</td>
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
The bundled archive <strong><code>04_Dairy_Campus_Calculations_and_Queries.zip</code></strong> contains all 30 production extraction queries (covering breeds, veterinary diagnoses, treatments, weighings, dry matter, barn climate, milking sessions, feeding visits, behavior summaries, and GreenFeed visits), along with 20 stored procedures, 190 views, and 26 user-defined functions that constitute the core calculation engine.
</p>

<hr>

<h3>7. How to Cite</h3>
<p>If you use these metadata specifications, dictionaries, or calculation methodologies in scientific publications or secondary data analyses, please cite:</p>
<blockquote style="background:#f8f9fa; border-left:4px solid #0969da; padding:10px 15px;">
Klandermans, B., &amp; de Jong, F. (2026). <em>Dairy Campus Research Data Platform: Comprehensive Data Descriptor, Standardized Metadata Dictionaries, and Calculation Methodologies</em> (Version v1.0.0) [Data set]. Zenodo. <a href="https://doi.org/10.5281/zenodo.24020864">https://doi.org/10.5281/zenodo.24020864</a>
</blockquote>
"""

out_path = "zenodo_deposit_files/zenodo_full_article_description.html"
with open(out_path, "w", encoding="utf-8") as f:
    f.write(article_html)
print(f"Generated refined article HTML ({len(article_html) / 1024:.1f} KB).")

# Update Zenodo deposition
print("Updating Zenodo deposition metadata via API...")
dep_id = "24020864"
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
    print(f"Successfully updated Zenodo deposition {dep_id} metadata!")
else:
    print(f"Failed to update Zenodo: {r.status_code} - {r.text}", file=sys.stderr)
    sys.exit(1)

# Now publish the updated version
print("Publishing updated deposition on Zenodo...")
pub_url = f"https://zenodo.org/api/deposit/depositions/{dep_id}/actions/publish"
pub_r = requests.post(pub_url, params=params)
if pub_r.status_code == 202:
    print(f"Successfully published updated record on Zenodo!")
    print(f"Live record URL: https://zenodo.org/records/{dep_id}")
else:
    print(f"Publish status: {pub_r.status_code} - {pub_r.text}")
