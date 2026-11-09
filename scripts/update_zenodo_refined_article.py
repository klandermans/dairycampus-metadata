#!/usr/bin/env python3
"""
Generate publication-grade Data Descriptor article for Zenodo deposition:
1. Strict alignment with the 19 SQL metadata tables (no ad-hoc views).
2. Professional scientific mathematical notation (survives Zenodo HTML sanitizer).
3. Uniform table layout with EXACT field names as they appear in the SQL tables.
4. No file attachments (metadata-only record).
5. Table of Contents navigation with clickable anchor links and return links.
"""

import os
import sys
import json
import requests
import pandas as pd
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DICT_CSV = ROOT / "zenodo_deposit_files" / "01_Dairy_Campus_Master_Data_Dictionary.csv"
OUT_HTML = ROOT / "zenodo_deposit_files" / "zenodo_full_article_description.html"

# Load Zenodo token
token = None
env_path = Path.home() / ".env"
if env_path.exists():
    with open(env_path) as f:
        for line in f:
            if line.startswith("ZENODO_ACCESS_TOKEN="):
                token = line.split("=", 1)[1].strip().strip("'\"")

master_df = pd.read_csv(DICT_CSV)
datasets = list(dict.fromkeys(master_df["dataset_name"]))

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


def generate_article_html(doi_str="10.5281/zenodo.24092291"):
    html = f"""<h2>Dairy Campus Research Data Platform: Comprehensive Data Descriptor, Standardized Metadata Dictionaries, and Calculation Methodologies</h2>

<p><strong>Authors:</strong> Bert Klandermans &amp; Fedde de Jong<br>
<strong>Affiliation:</strong> Dairy Campus, Wageningen University &amp; Research, Leeuwarden, The Netherlands<br>
<strong>License:</strong> Creative Commons Attribution 4.0 International (CC-BY 4.0)<br>
<strong>Permanent DOI:</strong> {doi_str}</p>

<p><a name="table_of_contents"></a></p>
<hr>

<h3>Table of Contents</h3>
<ul>
    <li><a href="#sec_abstract">Abstract</a></li>
    <li><a href="#sec_facility">1. Background &amp; Precision Livestock Farming Infrastructure</a></li>
    <li><a href="#sec_calculations">2. Mathematical Calculation Methodologies in SQL Layer</a>
        <ul>
            <li><a href="#calc_ric">2.1 Roughage Intake per Visit and per Day (RIC Troughs)</a></li>
            <li><a href="#calc_water">2.2 Water Exclusion Deduction (Trioliet Triomatic Feeding Robot)</a></li>
            <li><a href="#calc_dmi">2.3 Laboratory Dry Matter Content &amp; Total DMI</a></li>
            <li><a href="#calc_conc">2.4 Concentrate Allowance vs. Consumed Intake Balances</a></li>
            <li><a href="#calc_mpr">2.5 Milk Recording (MPR) Yield-Weighted Composite Concentrations</a></li>
            <li><a href="#calc_velos">2.6 Nedap Velos 24-Hour Behavioral Budgets</a></li>
            <li><a href="#calc_timing">2.7 Animal Demographics &amp; Lactation Timing</a></li>
            <li><a href="#calc_quality">2.8 Automated Data Quality &amp; Completeness Matrix</a></li>
        </ul>
    </li>
    <li><a href="#sec_overview">3. Overview of 19 Research Datasets</a></li>
    <li><a href="#sec_dictionaries">4. Standardized Data Dictionaries (All 19 Tables)</a>
        <ul>
"""
    for idx, ds in enumerate(datasets, start=1):
        html += f'            <li><a href="#table_{ds}">Table {idx}: <code>{ds}</code> &mdash; {sheet_descriptions.get(ds, ds)}</a></li>\n'

    html += """        </ul>
    </li>
    <li><a href="#sec_extraction">5. Trial-Specific Data Extraction Queries</a></li>
    <li><a href="#sec_citation">6. How to Cite</a></li>
</ul>

<hr>

<h3><a name="sec_abstract"></a>Abstract</h3>
<p>
The Dairy Campus research facility (Wageningen University &amp; Research, Leeuwarden, the Netherlands) operates a high-throughput, multi-sensor experimental dairy cattle infrastructure dedicated to precision livestock farming, sustainable dairy cattle nutrition, animal welfare, and enteric greenhouse gas mitigation. This comprehensive data descriptor provides the complete FAIR metadata documentation, operational parameters, algorithmic calculation models, and standardized data dictionaries for the Dairy Campus Research Data Platform. It elaborates <strong>19 distinct research datasets</strong> comprising <strong>507 scientific variables</strong>, detailing observation granularities, measurement units, sensor specifications, dry matter corrections, water exclusion deductions, milk component yield weighting, behavioral budgets, and automated quality control matrices.
</p>

<hr>

<h3><a name="sec_facility"></a>1. Background &amp; Precision Livestock Farming Infrastructure</h3>
<p>
<strong>Dairy Campus</strong> is the preeminent national and international research, education, and innovation center for dairy farming in the Netherlands, operated by <strong>Wageningen University &amp; Research (WUR)</strong>. Dairy Campus manages an experimental herd of approximately 500 Holstein Friesian dairy cows housed in specialized compartments and cubicle pens (stallen 50&ndash;73). The facility is equipped with automated feeding kitchens, automated milking systems, computerized concentrate stations, high-frequency behavioral accelerometers, enteric methane and carbon dioxide measurement hoods, and continuous barn climate monitoring.
</p>
<ul>
    <li><strong>Hokofarm RIC (Roughage Intake Control) Troughs:</strong> Automated individual feed intake bins mounted on high-precision electronic load cells with integrated RFID cow transponder recognition. Measures start weight, end weight, duration, and eating rate per visit.</li>
    <li><strong>Trioliet Triomatic Automated Feeding Robot:</strong> Automated feeding kitchen and suspended feeding robot mixer wagon. Weighs silage, concentrates, and water during recipe loading, and logs distributed batch drops to specific barn pens and troughs.</li>
    <li><strong>SAC &amp; Hokofarm Computerized Concentrate Stations:</strong> Automated concentrate feeding boxes dispensing up to four concentrate feeds (A, B, C, D) based on individual nutritional allowance curves.</li>
    <li><strong>GEA Automated Milking Systems:</strong> Electronic milking parlors and robotic milking units capturing individual milk yields, milking durations, quarter-level milk electrical conductivity, blood detection, and cow live body weight during milking.</li>
    <li><strong>Nedap Velos Behavior Smarttags:</strong> Accelerometer sensors (neck collars and leg pedometers) transmitting behavioral activity intervals classified into eating, ruminating, inactivity (lying), and active standing/walking.</li>
    <li><strong>C-Lock GreenFeed Emission Monitoring Units:</strong> Automated head-hood emission chambers measuring enteric methane (CH<sub>4</sub>) and carbon dioxide (CO<sub>2</sub>) flux rates during voluntary bait-fed cow visits.</li>
    <li><strong>Weather Station:</strong> On-site meteorological station recording ambient temperature, humidity, wind speed, solar radiation, and precipitation.</li>
</ul>

<hr>

<h3><a name="sec_calculations"></a>2. Mathematical Calculation Methodologies in SQL Layer</h3>
<p>
This section formalizes the mathematical equations implemented in the SQL views, stored procedures, and database tables defining the 19 metadata datasets. Only calculations documented in the platform's metadata dictionary are included.
</p>

<h4><a name="calc_ric"></a>2.1 Roughage Intake per Visit and per Day (Hokofarm RIC Troughs)</h4>
<p>
Hokofarm RIC troughs are mounted on load cells. The fresh roughage intake <em>I</em><sub>v</sub> and visit duration &Delta;<em>t</em><sub>v</sub> of individual visit <em>v</em>, and total daily fresh intake <em>I</em><sub>fresh, <em>f</em>, <em>d</em></sub> for fraction <em>f</em> &isin; {1, 2, 3, 4} (columns <code>rv1.Prod</code>&ndash;<code>rv4.Prod</code> in view <code>tvl_totaal</code>) are computed as:
</p>
<pre>
  (1)   I_v = M_v,start - M_v,end
  (2)   &Delta;t_v = t_v,end - t_v,start
  (3)   I_fresh,f,d = &sum;_{v &isin; V_f,d} I_v
</pre>
<blockquote>
<p><strong>Definitions:</strong><br>
&bull; <em>M</em><sub>v,start</sub>, <em>M</em><sub>v,end</sub>: Trough mass before cow entry and after exit (kg).<br>
&bull; <em>t</em><sub>v,start</sub>, <em>t</em><sub>v,end</sub>: Timestamps of visit start and finish.<br>
&bull; <em>V</em><sub>f,d</sub>: Set of all completed visits to troughs delivering roughage fraction <em>f</em> on day <em>d</em>.<br>
&bull; <strong>SQL Tables:</strong> <code>t_raw_hokofarmvr</code>, <code>tvl_totaal</code>.</p>
</blockquote>

<h4><a name="calc_water"></a>2.2 Water Exclusion Deduction (Trioliet Triomatic Feeding Robot)</h4>
<p>
During total mixed ration (TMR) preparation in the Trioliet Triomatic kitchen, water is added to suppress dust and prevent ration sorting. Fresh intake recorded by Hokofarm RIC bins is corrected by deducting the proportion of added water logged in the mixer robot load files (view <code>VL_Totaal_sub_ric_opn_prod</code>):
</p>
<pre>
                &sum; M_loaded - &sum; M_water
  (4)   R_water = -----------------------
                      &sum; M_loaded

  (5)   I_excl_water,f,d = I_fresh,f,d &times; R_water
</pre>
<blockquote>
<p><strong>Definitions:</strong><br>
&bull; <em>R</em><sub>water</sub>: Net dry-feed fraction ratio after deducting added water.<br>
&bull; <em>M</em><sub>loaded</sub>: Total batch mass loaded into Trioliet Triomatic robot mixer (kg).<br>
&bull; <em>M</em><sub>water</sub>: Mass of water added to batch during mixing (kg).<br>
&bull; <em>I</em><sub>excl_water, <em>f</em>, <em>d</em></sub>: Daily roughage intake excluding added water (columns <code>rv1.ProdExclWater</code>&ndash;<code>rv4.ProdExclWater</code>).<br>
&bull; <strong>SQL View:</strong> <code>VL_Totaal_sub_ric_opn_prod</code>.</p>
</blockquote>

<h4><a name="calc_dmi"></a>2.3 Laboratory Dry Matter Content &amp; Total DMI</h4>
<p>
Weekly forage and silage samples are analyzed in the drying oven laboratory (<em>droogstoof</em>, <code>VL_totaal_droogstoof</code>) to determine dry matter percentages (function <code>WeekGemiddelde_DS</code>). Total daily Dry Matter Intake (DMI) across all roughage fractions is:
</p>
<pre>
                  4
  (6)   DMI_d = &sum; [ I_excl_water,f,d &times; (DM_%,f / 100) ]
                 f=1
</pre>
<blockquote>
<p><strong>Definitions:</strong><br>
&bull; <em>DMI</em><sub>d</sub>: Total daily dry matter intake (column <code>tot.opnDs</code>, kg DM/day).<br>
&bull; <em>DM</em><sub>%, <em>f</em></sub>: Laboratory gravimetric dry matter percentage of fraction <em>f</em>.<br>
&bull; <strong>SQL Sources:</strong> <code>VL_totaal_droogstoof</code>, <code>WeekGemiddelde_DS</code>, <code>tvl_totaal</code>.</p>
</blockquote>

<h4><a name="calc_conc"></a>2.4 Concentrate Allowance vs. Consumed Intake Balances</h4>
<p>
For SAC and Hokofarm computerized concentrate feeders, residual unconsumed feed mass (<code>SumVoeRst</code>) is calculated from programmed allowance (<code>SumVoeGft</code>) and consumed intake (<code>SumVoeOpnm</code>):
</p>
<pre>
  (7)   C_rest,d = C_granted,d - C_intake,d
</pre>
<blockquote>
<p><strong>Definitions:</strong><br>
&bull; <em>C</em><sub>granted, <em>d</em></sub>: Programmed concentrate allowance across stations (kg/day).<br>
&bull; <em>C</em><sub>intake, <em>d</em></sub>: Total concentrate mass consumed by cow across visits (kg/day).<br>
&bull; <em>C</em><sub>rest, <em>d</em></sub>: Residual unconsumed concentrate allocation remaining (kg/day).<br>
&bull; <strong>SQL Views:</strong> <code>TVL_Dier_Voeropname_KV_Etmaal</code>, <code>TVL_Totaal_sub_kv</code>.</p>
</blockquote>

<h4><a name="calc_mpr"></a>2.5 Milk Recording (MPR) Yield-Weighted Composite Concentrations</h4>
<p>
Milk samples are collected during evening (A) and morning (O) milking sessions (AO sampling). Weekly composite concentrations across test sessions in ISO-calendar week <em>w</em> are calculated as yield-weighted averages in view <code>VL_Dier_Datum_Crv</code>:
</p>
<pre>
               &sum;_{j &isin; J_w} (c_j &times; Y_j)
  (8)   c̄_w = -------------------------
                  &sum;_{j &isin; J_w} Y_j
</pre>
<blockquote>
<p><strong>Definitions:</strong><br>
&bull; <em>c̄</em><sub>w</sub>: Weekly yield-weighted mean concentration of component <em>c</em> &isin; {Fat%, Protein%, Lactose%, Urea, SCC}.<br>
&bull; <em>c</em><sub>j</sub>: Concentration measured in milking session <em>j</em>.<br>
&bull; <em>Y</em><sub>j</sub>: Milk yield recorded for session <em>j</em> (kg).<br>
&bull; <em>J</em><sub>w</sub>: Set of official test milkings recorded during calendar week <em>w</em>.<br>
&bull; <strong>SQL View:</strong> <code>VL_Dier_Datum_Crv</code> (columns <code>mpr_week.*</code> in <code>tvl_totaal</code>).</p>
</blockquote>

<h4><a name="calc_velos"></a>2.6 Nedap Velos 24-Hour Behavioral Budgets</h4>
<p>
Raw intervals from Nedap Velos smarttags record behavioral states: 0 = other active, 1 = inactive (lying), 2 = ruminating, and 3 = eating. Durations &Delta;<em>t</em><sub>k</sub> are aggregated over each 24-hour day in <code>Velos_behaviour_day</code>:
</p>
<pre>
  (9)   T_state,d = &sum;_{k &isin; K_d} &Delta;t_k &times; 1[s_k = state]
  (10)  T_total,d = T_eating + T_ruminating + T_inactive + T_other
</pre>
<blockquote>
<p><strong>Definitions:</strong><br>
&bull; <em>T</em><sub>state, <em>d</em></sub>: Total daily duration in seconds for state &isin; {eating, ruminating, inactive, other}.<br>
&bull; <em>T</em><sub>total, <em>d</em></sub>: Total monitored observation duration over the 24-hour period (hh-mm-ss).<br>
&bull; <strong>SQL Table:</strong> <code>T_RAW_velos_behaviour</code>, <code>Velos_behaviour_day</code>.</p>
</blockquote>

<h4><a name="calc_timing"></a>2.7 Animal Demographics &amp; Lactation Timing</h4>
<p>
Standardized chronological and reproductive timing metrics are derived in view <code>VL_totaal_bedrijf</code> and table <code>TVL_Dier_Datum_Stal</code>:
</p>
<pre>
  (11)  DIM = t_record - t_calving                  (Days in Milk, LacDgn / IMDim)
  (12)  Age_days = t_record - t_birth               (Animal Age in Days, LftDgn / AgeDays)
  (13)  t_exp_calving = t_insemination + 280 days   (Expected Calving Date, VrwKlfDat)
  (14)  Days_to_calving = t_exp_calving - t_record  (Days Remaining to Calving, VrwDgn)
</pre>
<blockquote>
<p><strong>Definitions:</strong><br>
&bull; <em>DIM</em>: Days in milk calculated from the most recent calving date.<br>
&bull; <em>Age</em><sub>days</sub>: Animal chronological age in days from official birth date.<br>
&bull; <em>t</em><sub>exp_calving</sub>: Projected calving date based on standard 280-day bovine gestation period.<br>
&bull; <strong>SQL Sources:</strong> <code>tvl_totaal</code>, <code>T_RAW_Gea_milk</code>, <code>TVL_Dier_Datum_Stal</code>.</p>
</blockquote>

<h4><a name="calc_quality"></a>2.8 Automated Data Quality &amp; Completeness Matrix</h4>
<p>
Table <code>Missing_data</code> (source view <code>tvl_totaal_missende_data_proef</code>) executes daily automated audit checks across all experimental cows. It evaluates sensor continuity by flagging missing morning/afternoon milkings, missing body weights, zero roughage/concentrate intake, and days where Nedap Velos logs less than 50,000 seconds of behavior.
</p>

<p align="right"><a href="#table_of_contents">&uarr; Back to Table of Contents</a></p>
<hr>

<h3><a name="sec_overview"></a>3. Overview of 19 Research Datasets</h3>
<p>Click on any dataset identifier to jump directly to its complete data dictionary:</p>

<table class="ui celled striped table">
  <thead>
    <tr>
      <th>#</th>
      <th>Dataset Identifier</th>
      <th>Scientific Domain &amp; Description</th>
      <th>Variables</th>
      <th>Source Database Object</th>
    </tr>
  </thead>
  <tbody>
"""
    for idx, ds in enumerate(datasets, start=1):
        sub = master_df[master_df["dataset_name"] == ds]
        desc = sheet_descriptions.get(ds, ds)
        src = sub["source_table"].iloc[0]
        html += f"""    <tr>
      <td align="center">{idx}</td>
      <td><a href="#table_{ds}"><strong><code>{ds}</code></strong></a></td>
      <td>{desc}</td>
      <td align="center"><strong>{len(sub)}</strong></td>
      <td><code>{src}</code></td>
    </tr>
"""

    html += """  </tbody>
</table>

<p align="right"><a href="#table_of_contents">&uarr; Back to Table of Contents</a></p>
<hr>

<h3><a name="sec_dictionaries"></a>4. Standardized Data Dictionaries (All 19 Tables)</h3>
<p>
The field names in each table correspond strictly and identically to the column names in the underlying SQL database objects. Each table provides:
<code>Field Name</code> (exact SQL column name), <code>Data Type</code>, <code>Unit</code>, <code>Type</code> (Measured vs. Derived), <code>Description</code>, and <code>SQL Source / Derivation</code>.
</p>
"""

    for idx, ds in enumerate(datasets, start=1):
        sub = master_df[master_df["dataset_name"] == ds]
        desc = sheet_descriptions.get(ds, ds)
        src = sub["source_table"].iloc[0]

        html += f"""
<hr>
<h4><a name="table_{ds}"></a>Table {idx}: <code>{ds}</code> &mdash; {desc}</h4>
<p><strong>Database Object:</strong> <code>{src}</code> &nbsp;|&nbsp; <strong>Variables:</strong> {len(sub)} &nbsp;|&nbsp; <strong>Granularity:</strong> Daily / Visit record</p>

<table class="ui celled striped table">
  <thead>
    <tr>
      <th>Field Name</th>
      <th>Data Type</th>
      <th>Unit</th>
      <th>Type</th>
      <th>Description</th>
      <th>SQL Source / Derivation</th>
    </tr>
  </thead>
  <tbody>
"""
        for _, r in sub.iterrows():
            col_name = str(r["column_name"]).strip()
            dtype = str(r["data_type"]).strip() if pd.notna(r["data_type"]) else "string"

            unit = str(r["unit"]).strip() if pd.notna(r["unit"]) else ""
            if unit.lower() in ["n/a", "none", "nan", ""]:
                unit_str = "&mdash;"
            else:
                unit_str = unit

            mtype = str(r["measurement_type"]).strip() if pd.notna(r["measurement_type"]) else "Measured"
            if mtype.lower() in ["calculated", "derived"]:
                origin_badge = "<strong>Derived</strong>"
            else:
                origin_badge = "Measured"

            desc_en = str(r["description_en"]).strip() if pd.notna(r["description_en"]) else ""
            if desc_en.lower() in ["nan", "none", "n/a"]:
                desc_en = "&mdash;"

            calc_desc = str(r["calculation_description"]).strip() if pd.notna(r["calculation_description"]) else ""
            calc_src = str(r["calculation_source"]).strip() if pd.notna(r["calculation_source"]) else ""
            if "?" in calc_desc:
                calc_desc = ""

            calc_parts = []
            if calc_desc and calc_desc.lower() not in ["nan", "none", "n/a", ""]:
                calc_parts.append(calc_desc)
            if calc_src and calc_src.lower() not in ["nan", "none", "n/a", "", "?"]:
                calc_parts.append(f"<code>{calc_src}</code>")

            if calc_parts:
                deriv_str = "<br>".join(calc_parts)
            else:
                deriv_str = "Direct measurement" if origin_badge == "Measured" else "&mdash;"

            html += f"""    <tr>
      <td><strong><code>{col_name}</code></strong></td>
      <td align="center"><code>{dtype}</code></td>
      <td align="center">{unit_str}</td>
      <td align="center">{origin_badge}</td>
      <td>{desc_en}</td>
      <td>{deriv_str}</td>
    </tr>
"""
        html += f"""  </tbody>
</table>
<p align="right"><a href="#table_of_contents">&uarr; Back to Table of Contents</a></p>
"""

    html += f"""
<hr>

<h3><a name="sec_extraction"></a>5. Trial-Specific Data Extraction Queries</h3>
<p>
In the automated Apache Airflow data pipeline (<code>report.py</code>), research deliverables for a specific scientific study are extracted using parameterized SQL queries filtering by trial code (e.g., <code>WHERE prfcod = '[prfcod]'</code>).
</p>
<p>
The core database architecture encompasses 30 production extraction queries (covering breeds, veterinary diagnoses, treatments, weighings, dry matter, barn climate, milking sessions, feeding visits, behavior summaries, and GreenFeed visits), along with 20 stored procedures, 190 views, and 26 user-defined functions that constitute the core calculation engine.
</p>

<hr>

<h3><a name="sec_citation"></a>6. How to Cite</h3>
<p>If you use these metadata specifications, dictionaries, or calculation methodologies in scientific publications or secondary data analyses, please cite:</p>
<blockquote>
<p>
Klandermans, B., &amp; de Jong, F. (2026). <em>Dairy Campus Research Data Platform: Comprehensive Data Descriptor, Standardized Metadata Dictionaries, and Calculation Methodologies</em> [Data set]. Zenodo. <a href="https://doi.org/{doi_str}">https://doi.org/{doi_str}</a>
</p>
</blockquote>
"""
    return html


def main():
    print("Generating refined Zenodo article HTML...")
    html_content = generate_article_html()
    OUT_HTML.write_text(html_content, encoding="utf-8")
    print(f"[+] Wrote {OUT_HTML} ({len(html_content) / 1024:.1f} KB)")


if __name__ == "__main__":
    main()
