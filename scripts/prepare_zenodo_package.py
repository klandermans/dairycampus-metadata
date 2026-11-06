#!/usr/bin/env python3
"""
Prepare Zenodo Direct Deposit Package:
Generates publication-ready CSVs, formatted Excel, HTML data catalog,
and bundled calculation scripts specifically designed to be uploaded and
previewed as interactive tables on Zenodo.org.
"""

import os
import shutil
import zipfile
import pandas as pd
import openpyxl
from openpyxl.styles import Font, PatternFill, Alignment, Border, Side
from openpyxl.utils import get_column_letter

OUT_DIR = "zenodo_deposit_files"
CSV_SRC_DIR = "data_dictionary/csv"
TABLES_MD_DIR = "data_dictionary/tables"

def build_excel_workbook(master_df):
    wb = openpyxl.Workbook()
    # Sheet 1: Index & Overview
    ws_index = wb.active
    ws_index.title = "Overview & Datasets"
    ws_index.views.sheetView[0].showGridLines = True

    header_fill = PatternFill(start_color="1F497D", end_color="1F497D", fill_type="solid")
    header_font = Font(name="Calibri", size=11, bold=True, color="FFFFFF")
    title_font = Font(name="Calibri", size=16, bold=True, color="1F497D")
    sub_font = Font(name="Calibri", size=11, italic=True)

    ws_index["A1"] = "Dairy Campus Research Data Platform - Data Dictionary"
    ws_index["A1"].font = title_font
    ws_index["A2"] = "Authors: Bert Klandermans & Fedde de Jong | Dairy Campus, Wageningen University & Research"
    ws_index["A2"].font = sub_font
    ws_index["A3"] = "License: Creative Commons Attribution 4.0 International (CC-BY 4.0)"
    ws_index["A3"].font = sub_font

    index_headers = ["#", "Dataset Name", "Title", "Variables", "Source Table", "Granularity"]
    for col_idx, h in enumerate(index_headers, start=1):
        cell = ws_index.cell(row=5, column=col_idx, value=h)
        cell.fill = header_fill
        cell.font = header_font
        cell.alignment = Alignment(horizontal="center", vertical="center")

    datasets = master_df["dataset_name"].unique()
    for row_idx, ds in enumerate(datasets, start=6):
        sub = master_df[master_df["dataset_name"] == ds]
        src_table = sub["source_table"].iloc[0]
        ws_index.cell(row=row_idx, column=1, value=row_idx - 5).alignment = Alignment(horizontal="center")
        ws_index.cell(row=row_idx, column=2, value=ds)
        ws_index.cell(row=row_idx, column=3, value=ds.replace("_", " "))
        ws_index.cell(row=row_idx, column=4, value=len(sub)).alignment = Alignment(horizontal="center")
        ws_index.cell(row=row_idx, column=5, value=src_table)
        ws_index.cell(row=row_idx, column=6, value="Daily / Visit records")

    for col in ws_index.columns:
        max_len = max(len(str(cell.value or '')) for cell in col)
        col_letter = get_column_letter(col[0].column)
        ws_index.column_dimensions[col_letter].width = max(max_len + 3, 12)

    # Sheets for each dataset
    thin_border = Border(
        left=Side(style='thin', color='D9D9D9'),
        right=Side(style='thin', color='D9D9D9'),
        top=Side(style='thin', color='D9D9D9'),
        bottom=Side(style='thin', color='D9D9D9')
    )

    for ds in datasets:
        sub = master_df[master_df["dataset_name"] == ds]
        # Excel sheet names max 31 chars
        sheet_title = ds[:31]
        ws = wb.create_sheet(title=sheet_title)
        ws.views.sheetView[0].showGridLines = True

        cols_to_export = [
            ("column_name", "Column Name"),
            ("name_en", "English Label"),
            ("data_type", "Data Type"),
            ("unit", "Unit"),
            ("measurement_type", "Measurement Type"),
            ("description_en", "English Description"),
            ("calculation_description", "Calculation / Formula Details"),
            ("calculation_source", "Source Table")
        ]

        # Write Header
        for c_idx, (col_id, col_label) in enumerate(cols_to_export, start=1):
            cell = ws.cell(row=1, column=c_idx, value=col_label)
            cell.fill = header_fill
            cell.font = header_font
            cell.alignment = Alignment(horizontal="left", vertical="center", wrap_text=True)

        ws.row_dimensions[1].height = 28
        ws.freeze_panes = "A2"

        for r_idx, (_, row) in enumerate(sub.iterrows(), start=2):
            for c_idx, (col_id, _) in enumerate(cols_to_export, start=1):
                val = row[col_id]
                cell = ws.cell(row=r_idx, column=c_idx, value=val if pd.notna(val) else "")
                cell.border = thin_border
                cell.alignment = Alignment(vertical="top", wrap_text=True if col_id in ["description_en", "calculation_description"] else False)

        for col in ws.columns:
            col_letter = get_column_letter(col[0].column)
            col_name = cols_to_export[col[0].column - 1][0]
            if col_name in ["description_en", "calculation_description"]:
                ws.column_dimensions[col_letter].width = 45
            elif col_name in ["name_en", "calculation_source"]:
                ws.column_dimensions[col_letter].width = 25
            else:
                ws.column_dimensions[col_letter].width = 18

    out_xlsx = os.path.join(OUT_DIR, "02_Dairy_Campus_Metadata_Dictionary_EN.xlsx")
    wb.save(out_xlsx)
    print(f"Saved: {out_xlsx}")


def build_full_html_catalog(master_df):
    html = """<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Dairy Campus Research Data Platform - Complete Data Catalog</title>
<style>
    body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; color: #24292e; line-height: 1.5; padding: 30px; max-width: 1400px; margin: 0 auto; background: #fafbfc; }
    h1 { color: #0366d6; border-bottom: 2px solid #e1e4e8; padding-bottom: 10px; margin-top: 0; }
    h2 { color: #24292e; border-bottom: 1px solid #e1e4e8; padding-bottom: 8px; margin-top: 40px; }
    .meta-box { background: #eef5ff; border: 1px solid #c8e1ff; border-radius: 6px; padding: 16px; margin-bottom: 30px; }
    .meta-box p { margin: 4px 0; }
    table { width: 100%; border-collapse: collapse; margin: 16px 0 32px 0; background: #fff; box-shadow: 0 1px 3px rgba(0,0,0,0.08); border-radius: 6px; overflow: hidden; }
    th { background: #0366d6; color: #fff; text-align: left; padding: 10px 12px; font-size: 13px; font-weight: 600; }
    td { padding: 9px 12px; border-bottom: 1px solid #eaecef; font-size: 13px; vertical-align: top; }
    tr:nth-child(even) { background-color: #f6f8fa; }
    tr:hover { background-color: #f1f8ff; }
    code { font-family: SFMono-Regular, Consolas, "Liberation Mono", Menlo, monospace; background: rgba(27,31,35,0.05); padding: 2px 5px; border-radius: 3px; font-size: 12px; color: #d73a49; }
    .tag { display: inline-block; padding: 2px 6px; border-radius: 10px; font-size: 11px; font-weight: 500; }
    .tag-calc { background: #ffeef0; color: #d73a49; border: 1px solid #fdaeb7; }
    .tag-meas { background: #dcffe4; color: #22863a; border: 1px solid #bef5cb; }
    .toc { background: #fff; border: 1px solid #e1e4e8; border-radius: 6px; padding: 16px 24px; margin-bottom: 30px; }
    .toc ul { column-count: 3; margin: 0; padding-left: 20px; }
    .toc li { margin-bottom: 6px; font-size: 13px; }
    a { color: #0366d6; text-decoration: none; }
    a:hover { text-decoration: underline; }
</style>
</head>
<body>

<h1>Dairy Campus Research Data Platform: Complete Metadata Catalog</h1>

<div class="meta-box">
    <p><strong>Authors:</strong> Bert Klandermans &amp; Fedde de Jong (Dairy Campus, Wageningen University &amp; Research)</p>
    <p><strong>Affiliation:</strong> Wageningen University &amp; Research, Leeuwarden, the Netherlands</p>
    <p><strong>License:</strong> Creative Commons Attribution 4.0 International (CC-BY 4.0)</p>
    <p><strong>Total Research Datasets:</strong> 19 datasets | <strong>Total Documented Variables:</strong> 507 parameters</p>
</div>

<div class="toc">
    <h3>Table of Contents</h3>
    <ul>
"""
    datasets = master_df["dataset_name"].unique()
    for ds in datasets:
        sub = master_df[master_df["dataset_name"] == ds]
        html += f'        <li><a href="#{ds}">{ds} ({len(sub)} vars)</a></li>\n'
    html += """    </ul>
</div>
"""

    for ds in datasets:
        sub = master_df[master_df["dataset_name"] == ds]
        src_table = sub["source_table"].iloc[0]
        html += f'<h2 id="{ds}">{ds}</h2>\n'
        html += f'<p><strong>Primary Source Table:</strong> <code>{src_table}</code> | <strong>Variables:</strong> {len(sub)}</p>\n'
        html += """<table>
<thead>
<tr>
    <th style="width: 15%;">Column Name</th>
    <th style="width: 18%;">English Label</th>
    <th style="width: 8%;">Type</th>
    <th style="width: 8%;">Unit</th>
    <th style="width: 10%;">Method</th>
    <th style="width: 25%;">English Description</th>
    <th style="width: 16%;">Calculation / Source</th>
</tr>
</thead>
<tbody>
"""
        for _, row in sub.iterrows():
            meas_tag = '<span class="tag tag-calc">Calculated</span>' if row["measurement_type"] == "Calculated" else '<span class="tag tag-meas">Measured</span>'
            calc_text = row["calculation_description"] if pd.notna(row["calculation_description"]) and row["calculation_description"] != "N/A" else "Direct measurement"
            if pd.notna(row["calculation_source"]) and row["calculation_source"] not in ["N/A", ""]:
                calc_text += f"<br><small style='color:#586069;'>Source: {row['calculation_source']}</small>"

            html += f"""<tr>
    <td><code>{row['column_name']}</code></td>
    <td><strong>{row['name_en']}</strong></td>
    <td><code>{row['data_type']}</code></td>
    <td>{row['unit'] if pd.notna(row['unit']) else 'N/A'}</td>
    <td>{meas_tag}</td>
    <td>{row['description_en']}</td>
    <td>{calc_text}</td>
</tr>
"""
        html += "</tbody></table>\n"

    html += "</body></html>"
    out_html = os.path.join(OUT_DIR, "03_Dairy_Campus_Complete_Data_Catalog.html")
    with open(out_html, "w", encoding="utf-8") as f:
        f.write(html)
    print(f"Saved: {out_html}")


def build_unified_markdown_catalog(master_df):
    out_md = os.path.join(OUT_DIR, "03_Dairy_Campus_Complete_Data_Catalog.md")
    with open(out_md, "w", encoding="utf-8") as f:
        f.write("# Dairy Campus Research Data Platform: Complete Metadata Catalog\n\n")
        f.write("**Authors:** Bert Klandermans & Fedde de Jong  \n")
        f.write("**Affiliation:** Dairy Campus, Wageningen University & Research  \n")
        f.write("**License:** Creative Commons Attribution 4.0 International (CC-BY 4.0)  \n\n")
        f.write("---\n\n")
        f.write("## Table of Contents\n\n")
        datasets = master_df["dataset_name"].unique()
        for ds in datasets:
            sub = master_df[master_df["dataset_name"] == ds]
            f.write(f"- [{ds}](#{ds.lower()}) ({len(sub)} variables)\n")
        f.write("\n---\n\n")

        for ds in datasets:
            sub = master_df[master_df["dataset_name"] == ds]
            src = sub["source_table"].iloc[0]
            f.write(f"## {ds}\n\n")
            f.write(f"- **Underlying Source Table:** `{src}`\n")
            f.write(f"- **Total Variables:** {len(sub)}\n\n")
            f.write("| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |\n")
            f.write("|:---|:---|:---|:---|:---|:---|:---|\n")
            for _, r in sub.iterrows():
                calc_info = ""
                if r["measurement_type"] == "Calculated":
                    calc_info = f"Calculated: {r['calculation_description']}"
                    if pd.notna(r["calculation_source"]) and r["calculation_source"] != "N/A":
                        calc_info += f" *(Source: {r['calculation_source']})*"
                elif pd.notna(r["calculation_source"]) and r["calculation_source"] != "N/A":
                    calc_info = f"Source: {r['calculation_source']}"
                else:
                    calc_info = "Direct measurement"

                desc_clean = str(r["description_en"]).replace("|", "\\|").replace("\n", " ")
                calc_clean = str(calc_info).replace("|", "\\|").replace("\n", " ")
                f.write(f"| `{r['column_name']}` | {r['name_en']} | `{r['data_type']}` | {r['unit'] if pd.notna(r['unit']) else 'N/A'} | {r['measurement_type']} | {desc_clean} | {calc_clean} |\n")
            f.write("\n\n")

    print(f"Saved: {out_md}")


def build_zenodo_description_html():
    out_desc = os.path.join(OUT_DIR, "zenodo_description_ready_to_paste.html")
    with open(out_desc, "w", encoding="utf-8") as f:
        f.write("""<p><strong>Dairy Campus Research Data Platform: Standardized Metadata Dictionaries, Extraction Queries, and Calculation Models</strong></p>
<p><strong>Authors:</strong> Bert Klandermans &amp; Fedde de Jong<br>
<strong>Institution:</strong> Dairy Campus, Wageningen University &amp; Research (Leeuwarden, the Netherlands)</p>

<h3>1. Overview</h3>
<p>This deposit provides the authoritative FAIR metadata dictionaries, data definitions, and calculation algorithms for high-throughput dairy cattle research data collected at the <strong>Dairy Campus</strong> research facility. It documents <strong>19 core research tables</strong> comprising <strong>507 scientific variables</strong> across cattle nutrition, emissions, milk production, and animal behavior.</p>

<h3>2. Interactive Metadata Tables (Included Files)</h3>
<p>To inspect and search the data dictionaries directly in your browser, click <strong>Preview</strong> on the uploaded files:</p>
<ul>
    <li><strong><code>01_Dairy_Campus_Master_Data_Dictionary.csv</code></strong>: Complete searchable catalog of all 507 parameters with English labels, data types, physical measurement units, and calculation logic. Zenodo displays this as an interactive web table.</li>
    <li><strong><code>02_Dairy_Campus_Metadata_Dictionary_EN.xlsx</code></strong>: Formatted multi-tab spreadsheet with an index sheet and dedicated sheets for each of the 19 research datasets.</li>
    <li><strong><code>03_Dairy_Campus_Complete_Data_Catalog.html</code> &amp; <code>.md</code></strong>: Complete standalone human-readable reference catalogs.</li>
    <li><strong><code>04_Dairy_Campus_Calculations_and_Queries.zip</code></strong>: SQL calculation procedures, view definitions, and trial extraction queries.</li>
</ul>

<h3>3. Summary of Documented Research Datasets</h3>
<table border="1" cellpadding="5" cellspacing="0" style="border-collapse: collapse; width: 100%;">
<thead style="background-color: #f2f2f2;">
    <tr>
        <th>Dataset Name</th>
        <th>Scientific Domain</th>
        <th>Variables</th>
        <th>Source System</th>
    </tr>
</thead>
<tbody>
    <tr><td><code>TVL_total</code></td><td>Master Daily Integrated Cow Summary</td><td>97</td><td>Dairy Campus central research table</td></tr>
    <tr><td><code>Hokofarm_RIC</code></td><td>Roughage Intake Control (visit records)</td><td>18</td><td>Hokofarm RIC weighing troughs</td></tr>
    <tr><td><code>Hokofarm_SAC_concentrates</code></td><td>Concentrate Feeder Visits</td><td>42</td><td>SAC / Hokofarm concentrate stations</td></tr>
    <tr><td><code>TVL_RIC_intake_dm</code></td><td>Daily Roughage &amp; Dry Matter Intake</td><td>12</td><td>RIC troughs + dry oven lab tests</td></tr>
    <tr><td><code>Triomatic_RIC_load</code></td><td>Feeding Robot Loading Batches</td><td>46</td><td>Trioliet Triomatic feeding kitchen</td></tr>
    <tr><td><code>Triomatic_RIC_drop</code></td><td>Feeding Robot Deliveries to Troughs</td><td>46</td><td>Trioliet Triomatic feeding robot</td></tr>
    <tr><td><code>GEA_milkings</code></td><td>Milking Transactions &amp; Yields</td><td>13</td><td>GEA automated milking systems</td></tr>
    <tr><td><code>GEA_gates</code></td><td>Smart Selection Gate Passages</td><td>5</td><td>GEA automated sorting gates</td></tr>
    <tr><td><code>TMR_Trioliet_cowconnect_mix</code></td><td>Mixer Wagon Rations (CowConnect)</td><td>12</td><td>CowConnect weighing system</td></tr>
    <tr><td><code>TMR_Trioliet_cowconnect_drop</code></td><td>Mixer Wagon Distributions</td><td>11</td><td>CowConnect weighing system</td></tr>
    <tr><td><code>Velos_behaviour</code></td><td>Behavior Observation Intervals</td><td>4</td><td>Nedap Velos Smarttags (neck/leg)</td></tr>
    <tr><td><code>Velos_behaviour_day</code></td><td>Daily Behavior Budgets (Eating, Ruminating)</td><td>7</td><td>Nedap Velos daily aggregations</td></tr>
    <tr><td><code>Greenfeed_summarized_data</code></td><td>Enteric Methane &amp; CO2 Emissions</td><td>24</td><td>C-Lock GreenFeed emission hoods</td></tr>
    <tr><td><code>Greenfeed_feed_aggregrated</code></td><td>GreenFeed Bait Feed Drops</td><td>13</td><td>C-Lock GreenFeed dispenser</td></tr>
    <tr><td><code>DC_DM_content</code></td><td>Dry Matter Content Determinations</td><td>16</td><td>Laboratory drying oven (droogstoof)</td></tr>
    <tr><td><code>Weatherstation</code></td><td>Meteorological Observations</td><td>18</td><td>On-site automated weather station</td></tr>
    <tr><td><code>Missing_data</code></td><td>Data Quality &amp; Completeness Matrix</td><td>17</td><td>Automated quality audit view</td></tr>
    <tr><td><code>Environment_barn_Animal_day</code></td><td>Barn Section &amp; Animal Profile</td><td>52</td><td>Management database</td></tr>
    <tr><td><code>Environment_barn_Animal_experim</code></td><td>Experimental Cohort Daily Records</td><td>54</td><td>Trial assignment database</td></tr>
</tbody>
</table>

<h3>4. Key Calculation Models &amp; MPR Formulas</h3>
<ul>
    <li><strong>Dry Matter Intake (DMI)</strong>: Calculated by subtracting mixer wagon added water from roughage intake and multiplying by weekly laboratory oven dry matter percentage:
    <br><code>tot.opnDs = sum(Intake * ((TotalLoaded - AddedWaterKg) / TotalLoaded) * (DM_pct / 100))</code></li>
    <li><strong>Milk Recording (MPR) AO Yield-Weighted Formula</strong>:
    <br><code>Component_daily = (Evening_Concentration * Evening_Yield + Morning_Concentration * Morning_Yield) / (Evening_Yield + Morning_Yield)</code></li>
    <li><strong>Fat- and Protein-Corrected Milk (FPCM / Standaardmelk)</strong>:
    <br><code>FPCM = MilkYield * (0.337 + 0.116 * Fat% + 0.060 * Protein%)</code></li>
    <li><strong>Feed Conversion Efficiency</strong>:
    <br><code>FCE = FPCM (kg/day) / Dry Matter Intake (kg DM/day)</code></li>
</ul>

<p><strong>License:</strong> Metadata and documentation are licensed under Creative Commons Attribution 4.0 International (CC-BY 4.0). Code and SQL scripts are licensed under MIT.</p>
""")
    print(f"Saved: {out_desc}")


def bundle_calculations_zip():
    zip_path = os.path.join(OUT_DIR, "04_Dairy_Campus_Calculations_and_Queries.zip")
    with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as z:
        for root, dirs, files in os.walk("calculations"):
            for f in files:
                full_p = os.path.join(root, f)
                z.write(full_p, full_p)
        for root, dirs, files in os.walk("reports"):
            for f in files:
                full_p = os.path.join(root, f)
                z.write(full_p, full_p)
    print(f"Saved: {zip_path}")


def copy_individual_csvs(master_df):
    dest_sub = os.path.join(OUT_DIR, "tables_csv")
    for f in os.listdir(CSV_SRC_DIR):
        if f.endswith(".csv") and f != "all_metadata_dictionary.csv":
            shutil.copy(os.path.join(CSV_SRC_DIR, f), os.path.join(dest_sub, f))
    # Copy master
    shutil.copy(
        os.path.join(CSV_SRC_DIR, "all_metadata_dictionary.csv"),
        os.path.join(OUT_DIR, "01_Dairy_Campus_Master_Data_Dictionary.csv")
    )
    print("Copied CSVs to export folder.")


def main():
    master_df = pd.read_csv(os.path.join(CSV_SRC_DIR, "all_metadata_dictionary.csv"))
    copy_individual_csvs(master_df)
    build_excel_workbook(master_df)
    build_full_html_catalog(master_df)
    build_unified_markdown_catalog(master_df)
    build_zenodo_description_html()
    bundle_calculations_zip()
    print("All Zenodo deposit files generated successfully.")


if __name__ == "__main__":
    main()
