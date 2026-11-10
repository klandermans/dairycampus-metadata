#!/usr/bin/env python3
"""
Generate publication-grade Data Descriptor article for Zenodo deposition:
1. Longitudinal cohort documentation: continuous multi-sensor data collection since 2016 across ~500 Holstein Friesian dairy cows.
2. Structured metadata linkage: W3C DCAT and DataCite XML modeling 19 datasets as dct:distribution entities of one central catalog.
3. Clean scientific mathematical equations in SQL layer (only official nutritional & lactation formulas; removed 2.4, 2.6, 2.8).
4. Uniform table layout with EXACT field names as they appear in the SQL database objects.
5. Interactive Table of Contents with jump links and return links.
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
    html = f"""<h2>Dairy Campus Research Data Platform: Longitudinal Precision Dairy Cattle Data Descriptor, Standardized Metadata Dictionaries, and Calculation Methodologies</h2>

<p><strong>Authors:</strong> Bert Klandermans &amp; Fedde de Jong<br>
<strong>Affiliation:</strong> Dairy Campus, Wageningen University &amp; Research, Leeuwarden, The Netherlands<br>
<strong>Temporal Coverage:</strong> 2016 &ndash; Present (Continuous longitudinal collection)<br>
<strong>License:</strong> Creative Commons Attribution 4.0 International (CC-BY 4.0)<br>
<strong>Permanent DOI:</strong> {doi_str}</p>

<p><a name="table_of_contents"></a></p>
<hr>

<h3>Table of Contents</h3>
<ul>
    <li><a href="#sec_abstract">Abstract</a></li>
    <li><a href="#sec_facility">1. Longitudinal Experimental Infrastructure (500 Dairy Cows, 2016&ndash;Present)</a></li>
    <li><a href="#sec_dcat">2. Structured Metadata Architecture: DCAT Catalog &amp; 19 Distributions</a></li>
    <li><a href="#sec_calculations">3. Mathematical Calculation Methodologies in SQL Layer</a>
        <ul>
            <li><a href="#calc_ric">3.1 Roughage Intake per Visit and per Day (Hokofarm RIC Troughs)</a></li>
            <li><a href="#calc_water">3.2 Water Exclusion Deduction (Trioliet Triomatic Feeding Robot)</a></li>
            <li><a href="#calc_dmi">3.3 Laboratory Dry Matter Content &amp; Total Daily DMI</a></li>
            <li><a href="#calc_mpr">3.4 Milk Recording (MPR) Yield-Weighted Composite Concentrations</a></li>
            <li><a href="#calc_timing">3.5 Animal Demographics &amp; Lactation Timing</a></li>
        </ul>
    </li>
    <li><a href="#sec_overview">4. Overview of 19 Research Datasets</a></li>
    <li><a href="#sec_dictionaries">5. Standardized Data Dictionaries (All 19 Tables)</a>
        <ul>
"""
    for idx, ds in enumerate(datasets, start=1):
        html += f'            <li><a href="#table_{ds}">Table {idx}: <code>{ds}</code> &mdash; {sheet_descriptions.get(ds, ds)}</a></li>\n'

    html += """        </ul>
    </li>
    <li><a href="#sec_extraction">6. Trial-Specific SQL Extraction Architecture</a></li>
    <li><a href="#sec_citation">7. How to Cite</a></li>
</ul>

<hr>

<h3><a name="sec_abstract"></a>Abstract</h3>
<p>
The Dairy Campus research facility (Wageningen University &amp; Research, Leeuwarden, The Netherlands) operates an internationally leading experimental dairy infrastructure tracking an experimental herd of approximately <strong>500 Holstein Friesian dairy cows continuously since 2016</strong>. This comprehensive data descriptor formalizes the multi-sensor, multi-lactation research database comprising <strong>19 distinct research datasets</strong> and <strong>507 scientific variables</strong>. Spanning more than a decade of automated observations, the platform contains <strong>millions of individual milking records</strong> (yields, electrical conductivity, milking duration, live cow weights), <strong>millions of electronic roughage intake visits</strong> recorded via load-cell troughs, continuous enteric greenhouse gas fluxes (CH<sub>4</sub> and CO<sub>2</sub>), high-frequency behavioral accelerometry, and routine laboratory milk component analyses. All datasets are formally modeled as standardized distributions (<code>dct:distribution</code>) of a single central catalog under W3C DCAT and DataCite metadata standards.
</p>

<hr>

<h3><a name="sec_facility"></a>1. Longitudinal Experimental Infrastructure (500 Dairy Cows, 2016&ndash;Present)</h3>
<p>
<strong>Dairy Campus</strong> in Leeuwarden is the national research and innovation center for dairy farming in the Netherlands, operated by <strong>Wageningen University &amp; Research (WUR)</strong>. Since 2016, Dairy Campus maintains an active experimental herd of approximately <strong>500 high-producing Holstein Friesian dairy cows</strong> across dedicated research compartments and cubicle housing (stallen 50&ndash;73). The herd is continuously monitored throughout complete productive lifespans, encompassing multi-lactation trajectories, transition periods, and dry periods.
</p>
<p>The longitudinal data architecture ingests and validates continuous telemetry streams from precision livestock farming (PLF) hardware:
</p>
<ul>
    <li><strong>Automated Milking Systems &amp; Rotaries (GEA):</strong> Millions of individual milking transaction records. Each milking logs gross milk yield (kg), session duration, quarter-level milk electrical conductivity, blood presence detection, and cow live body weight measured on integrated walkthrough platform scales.</li>
    <li><strong>Individual Roughage Intake Control (Hokofarm RIC Troughs):</strong> Bins mounted on high-precision electronic load cells with integrated radio-frequency transponder recognition. Records individual visit timestamps (start/end), trough mass differences (intake per visit), and consumption rates across 4 distinct roughage fractions (rv<sub>1</sub>&ndash;rv<sub>4</sub>).</li>
    <li><strong>Automated Feeding Kitchen &amp; Robot (Trioliet Triomatic):</strong> Tracks exact ingredient batch mixing, silage loading, added water mass, and discharge distributions along feed fences and individual RIC troughs.</li>
    <li><strong>Computerized Concentrate Feeding Stations (SAC &amp; Hokofarm):</strong> Programmed individual concentrate allowances (types A, B, C, D) versus actual consumed quantities, dispenser speeds, and visit counts.</li>
    <li><strong>Enteric Greenhouse Gas Monitoring Hoods (C-Lock GreenFeed):</strong> Automated bait-fed breath analysis chambers measuring individual enteric methane (CH<sub>4</sub>) and carbon dioxide (CO<sub>2</sub>) emission fluxes during voluntary cow visits.</li>
    <li><strong>Continuous Behavioral Accelerometers (Nedap Velos Smarttags):</strong> High-resolution neck-collar and leg sensors classifying 24-hour time budgets into eating, ruminating, inactivity (lying), and active standing/walking.</li>
    <li><strong>On-Site Meteorological Weather Station:</strong> Continuous climate logging of ambient temperature, relative humidity, wind speed, solar radiation, and rainfall, linked to automated barn ventilation curtains.</li>
    <li><strong>Official Milk Laboratory Recording (CRV/MPR):</strong> Routine 4-weekly and trial-specific AO (evening and morning) sampling for fat %, protein %, lactose %, somatic cell count (SCC), urea content, and ketosis diagnostic indicators.</li>
</ul>

<hr>

<h3><a name="sec_dcat"></a>2. Structured Metadata Architecture: DCAT Catalog &amp; 19 Distributions</h3>
<p>
To ensure strict adherence to the <strong>FAIR data principles</strong> (Findable, Accessible, Interoperable, Reusable), this data descriptor models the 19 research datasets explicitly as distributions (<code>dct:distribution</code> / <code>dcat:Distribution</code>) belonging to one central catalog (<code>dcat:Catalog</code> / <code>schema:DataCatalog</code>).
</p>
<pre>
  Central Catalog: Dairy Campus Research Data Platform (doi:{doi_str})
  │
  ├── dct:distribution [01] ── TVL_total (Master daily integrated cow summary, 97 vars)
  ├── dct:distribution [02] ── Hokofarm_SAC_concentrates (Concentrate feeder transactions, 42 vars)
  ├── dct:distribution [03] ── Hokofarm_RIC (Roughage intake visits, 18 vars)
  ├── dct:distribution [04] ── TVL_RIC_intake_dm (Daily roughage intake &amp; oven DM, 12 vars)
  ├── dct:distribution [05] ── Triomatic_RIC_load (Feeding robot kitchen loading, 46 vars)
  ├── dct:distribution [06] ── Triomatic_RIC_drop (Feeding robot trough discharge, 46 vars)
  ├── dct:distribution [07] ── GEA_gates (Separation and routing smart gates, 5 vars)
  ├── dct:distribution [08] ── GEA_milkings (Milking parlor &amp; robot records, 13 vars)
  ├── dct:distribution [09] ── TMR_Trioliet_cowconnect_mix (Mixer wagon recipes, 12 vars)
  ├── dct:distribution [10] ── Velos_behaviour (Cow behavioral interval transitions, 4 vars)
  ├── dct:distribution [11] ── Velos_behaviour_day (Daily behavioral time budgets, 7 vars)
  ├── dct:distribution [12] ── TMR_Trioliet_cowconnect_drop (Feed fence distribution drops, 11 vars)
  ├── dct:distribution [13] ── DC_DM_content (Laboratory oven gravimetric tests, 16 vars)
  ├── dct:distribution [14] ── Greenfeed_summarized_data (Validated CH4 and CO2 fluxes, 24 vars)
  ├── dct:distribution [15] ── Greenfeed_feed_aggregrated (Bait feed drop rewards, 13 vars)
  ├── dct:distribution [16] ── Weatherstation (Meteorological climate observations, 18 vars)
  ├── dct:distribution [17] ── Missing_data (Quality audit &amp; sensor continuity flags, 17 vars)
  ├── dct:distribution [18] ── Environment_barn_Animal_day (Barn environment &amp; cow demographics, 52 vars)
  └── dct:distribution [19] ── Environment_barn_Animal_experim (Trial cohort treatment records, 54 vars)
</pre>
<blockquote>
<p><strong>Formal Metadata Files Attached to this Record:</strong><br>
&bull; <strong><code>dairy_campus_catalog_dcat.jsonld</code></strong>: Full W3C DCAT 2.0 / schema.org JSON-LD document specifying the central catalog and all 19 <code>dct:distribution</code> entities with exact variable lists.<br>
&bull; <strong><code>dairy_campus_datacite.xml</code></strong>: DataCite Schema 4.4 XML record with temporal collection span (2016&ndash;present) and technical catalog distributions.<br>
&bull; <strong>Harvesting &amp; Interoperability:</strong> Compatible with Dataverse, OpenAIRE, and Google Dataset Search.</p>
</blockquote>

<h4>Sample Machine-Readable W3C DCAT JSON-LD Distribution Schema:</h4>
<pre>
{{
  "@context": {{
    "dcat": "http://www.w3.org/ns/dcat#",
    "dct": "http://purl.org/dc/terms/",
    "schema": "http://schema.org/"
  }},
  "@id": "https://doi.org/{doi_str}",
  "@type": ["dcat:Catalog", "schema:DataCatalog"],
  "dct:title": "Dairy Campus Research Data Platform: Central Data Catalog",
  "dcat:dataset": {{
    "@type": ["dcat:Dataset", "schema:Dataset"],
    "dct:distribution": [
      {{
        "@id": "https://doi.org/{doi_str}#distribution_TVL_total",
        "@type": ["dcat:Distribution", "schema:DataDownload"],
        "dct:identifier": "TVL_total",
        "dct:title": "Distribution 1: TVL_total",
        "dct:description": "Master Daily Integrated Cow Summary (97 variables)",
        "dct:source": "tvl_totaal",
        "dcat:mediaType": "text/csv",
        "schema:numberOfVariables": 97
      }},
      {{
        "@id": "https://doi.org/{doi_str}#distribution_Hokofarm_RIC",
        "@type": ["dcat:Distribution", "schema:DataDownload"],
        "dct:identifier": "Hokofarm_RIC",
        "dct:title": "Distribution 3: Hokofarm_RIC",
        "dct:description": "Roughage Intake Control Individual Visit Transactions (18 variables)",
        "dct:source": "t_raw_hokofarmvr",
        "dcat:mediaType": "text/csv",
        "schema:numberOfVariables": 18
      }}
      /* ... and 17 additional distributions (see dairy_campus_catalog_dcat.jsonld) ... */
    ]
  }}
}}
</pre>

<hr>

<h3><a name="sec_calculations"></a>3. Mathematical Calculation Methodologies in SQL Layer</h3>
<p>
This section formalizes the core scientific calculations implemented directly in the database views and stored procedures defining the 19 research datasets.
</p>

<h4><a name="calc_ric"></a>3.1 Roughage Intake per Visit and per Day (Hokofarm RIC Troughs)</h4>
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
&bull; <em>t</em><sub>v,start</sub>, <em>t</em><sub>v,end</sub>: Timestamps of visit entry and departure.<br>
&bull; <em>V</em><sub>f,d</sub>: Set of all completed feeding visits to troughs delivering roughage fraction <em>f</em> on day <em>d</em>.<br>
&bull; <strong>SQL Objects:</strong> <code>t_raw_hokofarmvr</code>, <code>tvl_totaal</code>.</p>
</blockquote>

<h4><a name="calc_water"></a>3.2 Water Exclusion Deduction (Trioliet Triomatic Feeding Robot)</h4>
<p>
During total mixed ration (TMR) preparation in the Trioliet Triomatic automated feeding kitchen, water is added to suppress dust and prevent ration sorting. Fresh intake recorded by Hokofarm RIC bins is adjusted by deducting the proportion of added water logged in the robot load files (view <code>VL_Totaal_sub_ric_opn_prod</code>):
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
&bull; <em>M</em><sub>loaded</sub>: Total batch mass loaded into Trioliet Triomatic mixer wagon (kg).<br>
&bull; <em>M</em><sub>water</sub>: Mass of water added to batch during mixing (kg).<br>
&bull; <em>I</em><sub>excl_water, <em>f</em>, <em>d</em></sub>: Daily roughage intake excluding added water (columns <code>rv1.ProdExclWater</code>&ndash;<code>rv4.ProdExclWater</code>).<br>
&bull; <strong>SQL View:</strong> <code>VL_Totaal_sub_ric_opn_prod</code>.</p>
</blockquote>

<h4><a name="calc_dmi"></a>3.3 Laboratory Dry Matter Content &amp; Total Daily DMI</h4>
<p>
Weekly forage and silage samples are analyzed in the drying oven laboratory (<em>droogstoof</em>, <code>VL_totaal_droogstoof</code>) to determine gravimetric dry matter percentages (function <code>WeekGemiddelde_DS</code>). Total daily Dry Matter Intake (DMI) across all roughage fractions is:
</p>
<pre>
                  4
  (6)   DMI_d = &sum; [ I_excl_water,f,d &times; (DM_%,f / 100) ]
                 f=1
</pre>
<blockquote>
<p><strong>Definitions:</strong><br>
&bull; <em>DMI</em><sub>d</sub>: Total daily dry matter intake (column <code>tot.opnDs</code>, kg DM/day).<br>
&bull; <em>DM</em><sub>%, <em>f</em></sub>: Laboratory gravimetric dry matter percentage of roughage fraction <em>f</em>.<br>
&bull; <strong>SQL Sources:</strong> <code>VL_totaal_droogstoof</code>, <code>WeekGemiddelde_DS</code>, <code>tvl_totaal</code>.</p>
</blockquote>

<h4><a name="calc_mpr"></a>3.4 Milk Recording (MPR) Yield-Weighted Composite Concentrations</h4>
<p>
Milk samples are collected during evening (A) and morning (O) milking sessions (AO sampling). Weekly composite concentrations across test sessions in ISO-calendar week <em>w</em> are calculated as yield-weighted averages in view <code>VL_Dier_Datum_Crv</code>:
</p>
<pre>
               &sum;_{j &isin; J_w} (c_j &times; Y_j)
  (7)   c̄_w = -------------------------
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

<h4><a name="calc_timing"></a>3.5 Animal Demographics &amp; Lactation Timing</h4>
<p>
Standardized chronological and reproductive timing metrics are derived in view <code>VL_totaal_bedrijf</code> and table <code>TVL_Dier_Datum_Stal</code>:
</p>
<pre>
  (8)   DIM = t_record - t_calving                  (Days in Milk, LacDgn / IMDim)
  (9)   Age_days = t_record - t_birth               (Animal Age in Days, LftDgn / AgeDays)
  (10)  t_exp_calving = t_insemination + 280 days   (Expected Calving Date, VrwKlfDat)
  (11)  Days_to_calving = t_exp_calving - t_record  (Days Remaining to Calving, VrwDgn)
</pre>
<blockquote>
<p><strong>Definitions:</strong><br>
&bull; <em>DIM</em>: Days in milk calculated from the most recent calving date.<br>
&bull; <em>Age</em><sub>days</sub>: Animal chronological age in days from official birth date.<br>
&bull; <em>t</em><sub>exp_calving</sub>: Projected calving date based on standard 280-day bovine gestation period.<br>
&bull; <strong>SQL Sources:</strong> <code>tvl_totaal</code>, <code>T_RAW_Gea_milk</code>, <code>TVL_Dier_Datum_Stal</code>.</p>
</blockquote>

<p align="right"><a href="#table_of_contents">&uarr; Back to Table of Contents</a></p>
<hr>

<h3><a name="sec_overview"></a>4. Overview of 19 Research Datasets</h3>
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

<h3><a name="sec_dictionaries"></a>5. Standardized Data Dictionaries (All 19 Tables)</h3>
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

<h3><a name="sec_extraction"></a>6. Trial-Specific SQL Extraction Architecture</h3>
<p>
In the automated Apache Airflow data pipeline (<code>report.py</code>), research deliverables for a specific scientific study are extracted using parameterized SQL queries filtering by trial code (e.g., <code>WHERE prfcod = '[prfcod]'</code>).
</p>
<p>
The core database architecture encompasses 30 production extraction queries (covering breeds, veterinary diagnoses, treatments, weighings, dry matter, barn climate, milking sessions, feeding visits, behavior summaries, and GreenFeed visits), along with 20 stored procedures, 190 views, and 26 user-defined functions that constitute the core calculation engine.
</p>

<hr>

<h3><a name="sec_citation"></a>7. How to Cite</h3>
<p>If you use these metadata specifications, dictionaries, or calculation methodologies in scientific publications or secondary data analyses, please cite:</p>
<blockquote>
<p>
Klandermans, B., &amp; de Jong, F. (2026). <em>Dairy Campus Research Data Platform: Longitudinal Precision Dairy Cattle Data Descriptor, Standardized Metadata Dictionaries, and Calculation Methodologies</em> [Data set]. Zenodo. <a href="https://doi.org/{doi_str}">https://doi.org/{doi_str}</a>
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
