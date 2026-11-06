# Zenodo Direct Upload Package

This folder contains the publication-ready files for depositing the **Dairy Campus Research Data Platform** metadata directly onto **[Zenodo.org](https://zenodo.org/)**.

## Files to Upload to Zenodo

When you create a new upload on Zenodo ([https://zenodo.org/deposit/new](https://zenodo.org/deposit/new)), drag and drop the following files into the **Files** section:

1. **`01_Dairy_Campus_Master_Data_Dictionary.csv`**
   - **Why this is key:** Zenodo provides an **interactive in-browser preview table** for CSV files. Visitors to your Zenodo page can search, sort, and filter all 507 scientific variables directly in their browser without downloading anything!
2. **`02_Dairy_Campus_Metadata_Dictionary_EN.xlsx`**
   - Clean, professional multi-tab Excel workbook with an Overview Index sheet and dedicated sheets for all 19 research tables.
3. **`03_Dairy_Campus_Complete_Data_Catalog.html`** & **`03_Dairy_Campus_Complete_Data_Catalog.md`**
   - Complete standalone data catalogs displaying every single table and parameter description in full.
4. **`04_Dairy_Campus_Calculations_and_Queries.zip`**
   - Supplemental archive containing the SQL calculation models, procedures, views, and trial extraction queries.
5. *(Optional)* **`tables_csv/*.csv`**
   - If you wish to display individual tables as separate previewable files on Zenodo, drag the individual CSV files from `tables_csv/`.

---

## Form Fields for Zenodo Deposit

- **Resource Type:** `Dataset` (or `Publication` -> `Technical note`)
- **Title:** `Dairy Campus Research Data Platform: Metadata Dictionary, Extraction Queries, and Calculation Models`
- **Authors:**
  - `Klandermans, Bert` (Affiliation: `Dairy Campus, Wageningen University & Research`)
  - `de Jong, Fedde` (Affiliation: `Dairy Campus, Wageningen University & Research`)
- **Description:**
  - Open `zenodo_description_ready_to_paste.html`, copy all the text, and paste it directly into Zenodo's Description box (or use the rich-text editor). It will format the dataset overview tables, formulas, and summaries automatically.
- **License:** `Creative Commons Attribution 4.0 International` (CC-BY-4.0).
- **Keywords:** `Dairy Campus`, `Wageningen University & Research`, `Precision Livestock Farming`, `Dairy Cattle`, `Enteric Methane`, `Roughage Intake Control`, `Nedap Velos`, `FAIR Data`.
