<p align="center">
  <img src="assets/mokhles-hr-analytics-cover.png" alt="Mokhles Group HR Analytics Demo 2025" width="100%">
</p>

<h1 align="center">Mokhles Group HR Analytics Demo 2025</h1>

<p align="center">
  A realistic synthetic HR analytics and cross-platform Business Intelligence portfolio designed around a Bangladesh business environment.
</p>

<p align="center">
  <img alt="Data Type" src="https://img.shields.io/badge/data-synthetic%20%7C%20tabular-625BEB">
  <img alt="Country" src="https://img.shields.io/badge/context-Bangladesh-1E8E5A">
  <img alt="Period" src="https://img.shields.io/badge/coverage-FY2025-F36B21">
  <img alt="Python" src="https://img.shields.io/badge/Python-3.11%2B-3776AB">
  <img alt="Power BI" src="https://img.shields.io/badge/Power%20BI-ready-F2C811">
  <img alt="Excel" src="https://img.shields.io/badge/Excel-Power%20Query%20%7C%20Power%20Pivot-217346">
  <img alt="Looker Studio" src="https://img.shields.io/badge/Looker%20Studio-ready-4285F4">
  <img alt="License" src="https://img.shields.io/badge/data%20license-CC%20BY%204.0-lightgrey">
</p>

<p align="center">
  <a href="https://github.com/samusa099/mokhles-group-hr-analytics-bd-fy2025">GitHub Repository</a>
  ·
  <a href="https://www.kaggle.com/datasets/samusahr/mokhles-group-hr-analytics-portfolio-bd-fy2025">Kaggle Dataset</a>
</p>

---

## Release v2.3.0

Release **v2.3.0** adds a complete structured analytics workspace for:

- Power BI Desktop
- Excel Power Query, Power Pivot, PivotTables and PivotCharts
- Looker Studio
- Tableau
- Qlik Sense
- Metabase
- Python and Jupyter

It also introduces employee-level and department-level consolidated analytical datasets, data-quality profiling, Power Query M scripts, DAX measures, an Excel analytics starter workbook, platform-specific implementation guides and a separate Kaggle publishing transport.

---

## Overview

This repository contains a complete HR analytics portfolio for **Mokhles Group**, a fictional Bangladesh-based organisation.

The records are fully synthetic, but the structure, terminology, employee profiles, locations, compensation values and HR transactions were designed to resemble realistic organisational data.

The project combines:

- 13 authoritative analysis-ready CSV tables
- 1 consolidated Excel master workbook
- 12 specialised Excel HR reports
- 15 BI-ready dimension and fact tables
- 2 consolidated analysis-ready datasets
- Data-quality profiling and validation outputs
- A Jupyter Notebook
- Power BI semantic-model assets
- Excel analytics templates
- Looker Studio upload-ready datasets
- Tableau, Qlik Sense and Metabase implementation guides
- Complete file-level metadata
- Complete CSV column descriptions
- Automated validation and GitHub workflows

> **Privacy and ethics:** No real employee, applicant, salary, performance, health or confidential organisational data is included.

---

## Project highlights

| Area | Volume |
|---|---:|
| Employees represented during FY2025 | 516 |
| Year-end headcount | 456 |
| Hires | 96 |
| Employee separations | 60 |
| Leave transactions | 1,043 |
| Training participation records | 1,011 |
| Recruitment requisitions | 110 |
| Performance evaluation records | 456 |
| Health and safety records | 120 |
| Original analytical CSV tables | 13 |
| BI-ready CSV tables | 15 |
| Analysis-ready consolidated tables | 2 |
| Excel workbooks | 14 |
| Looker Studio-ready CSV files | 17 |
| Structured metadata resources | 138 |
| Documented CSV fields | 803 |

---

## Analytics coverage

- Headcount and workforce structure
- Monthly and annual HR KPIs
- Recruitment funnel and time-to-fill
- Employee turnover and retention
- Leave and absence
- Diversity and inclusion
- Learning and development
- Compensation and total reward
- Performance and talent readiness
- Health, safety and corrective actions
- Employee 360 analysis
- Department 360 analysis
- Data-quality profiling
- Executive and board-level HR reporting
- Cross-platform dashboard preparation

---

## Repository structure

```text
mokhles-group-hr-analytics-bd-fy2025/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   └── workflows/
├── assets/
├── bi_assets/
│   ├── power_bi/
│   └── semantic_model/
├── data/
│   ├── csv/
│   ├── bi_ready_csv/
│   ├── analysis_ready/
│   ├── data_quality/
│   └── excel/
│       ├── master/
│       └── reports/
├── docs/
│   ├── bi/
│   └── platforms/
│       ├── power_bi_assets/
│       ├── excel_analytics/
│       ├── looker_studio/
│       ├── tableau/
│       ├── qlik/
│       └── metabase/
├── examples/
├── metadata/
├── notebooks/
├── scripts/
├── src/
│   └── mokhles_hr_analytics/
├── wiki/
├── CITATION.cff
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── LICENSE
├── LICENSE-CODE
├── README.md
└── requirements.txt
```

---

## Structured Kaggle analytics workspace

The downloadable structured workspace is organised as:

```text
Mokhles_Group_HR_Analytics_FINAL_Kaggle_Upload_v2_3_0/
├── 00_START_HERE/
├── 01_SOURCE_DATA/
│   ├── csv_original/
│   ├── excel_master/
│   └── excel_reports/
├── 02_CLEAN_DATA/
│   ├── bi_ready_csv/
│   ├── analysis_ready/
│   └── data_quality/
├── 03_POWER_BI/
│   ├── theme/
│   ├── semantic_model/
│   ├── power_query_m/
│   └── dax/
├── 04_EXCEL_ANALYTICS/
├── 05_LOOKER_STUDIO/
├── 06_TABLEAU/
├── 07_QLIK/
├── 08_METABASE/
├── 09_NOTEBOOKS/
├── 10_DOCUMENTATION/
├── 11_KAGGLE_METADATA/
└── 12_SCRIPTS/
```

The structured workspace is intended for data cleaning, analysis, modeling and dashboard development.

The separate Kaggle publish package is used only for Kaggle CLI transport and metadata publishing.

---

## Analysis-ready CSV tables

| No. | Table |
|---:|---|
| 01 | Employee Master |
| 02 | Monthly HR KPI |
| 03 | Department Annual Summary |
| 04 | Quarterly Board KPI |
| 05 | Recruitment Master |
| 06 | Employee Separations |
| 07 | Leave Transactions |
| 08 | Diversity and Inclusion Master |
| 09 | Training and Development Master |
| 10 | Compensation and Benefits Master |
| 11 | Performance Evaluation Master |
| 12 | Health and Safety Master |
| 13 | Data Dictionary |

---

## BI-ready analytical layer

The Python generator creates the following tables:

```text
data/bi_ready_csv/
├── 00_dim_date.csv
├── 00_dim_department.csv
├── 00_dim_location.csv
├── 01_dim_employee_fy2025.csv
├── 02_fact_monthly_hr_kpi_fy2025.csv
├── 03_fact_department_annual_summary_fy2025.csv
├── 04_fact_quarterly_board_kpi_fy2025.csv
├── 05_fact_recruitment_fy2025.csv
├── 06_fact_employee_separations_fy2025.csv
├── 07_fact_leave_transactions_fy2025.csv
├── 08_dim_diversity_inclusion_fy2025.csv
├── 09_fact_training_development_fy2025.csv
├── 10_fact_compensation_benefits_fy2025.csv
├── 11_fact_performance_evaluation_fy2025.csv
└── 12_fact_health_safety_fy2025.csv
```

Generate or refresh the layer with:

```powershell
py scripts\build_bi_ready_layer.py
```

Expected result:

```text
BI-ready layer created: 15 CSV files
```

---

## Consolidated analysis-ready tables

### Employee 360

```text
data/analysis_ready/employee_360_fy2025.csv
```

One row per employee, combining:

- Workforce profile
- Diversity attributes
- Compensation
- Performance
- Leave
- Training
- Separation information

### Department 360

```text
data/analysis_ready/department_360_summary_fy2025.csv
```

One row per department, combining:

- Opening and closing headcount
- Hires and exits
- Turnover
- Female representation
- Compensation
- Performance
- Training
- Leave
- Promotion readiness

---

## Data-quality layer

```text
data/data_quality/
├── table_quality_summary.csv
├── column_profile.csv
└── validation_rules.csv
```

The quality layer covers:

- Row and column counts
- Blank-cell rates
- Duplicate-row checks
- Primary-key and composite-key checks
- UTF-8 readability
- Column data-type inference
- Distinct-value counts
- Minimum and maximum values
- Sample values
- Recommended remediation actions

---

## Power BI

Power BI assets include:

- JSON theme
- Relationship map
- Field-name mapping
- KPI catalogue
- Dashboard blueprint
- 15 Power Query M scripts
- DAX starter-measure library
- ProjectRoot parameter guide

Recommended workflow:

1. Run the BI-ready layer generator.
2. Open Power BI Desktop.
3. Create the `ProjectRoot` text parameter.
4. Load the M queries.
5. Verify data types.
6. Create relationships from the relationship map.
7. Mark `00_dim_date[date]` as the date table.
8. Import the Power BI theme.
9. Add DAX measures.
10. Build report pages from the dashboard blueprint.

Key assets:

```text
docs/platforms/power_bi_assets/
├── power_query_m/
├── dax/
├── semantic_model/
└── theme/
```

---

## Excel analytics

The Excel analytics starter workbook is:

```text
docs/platforms/excel_analytics/Mokhles_Group_Excel_Analytics_Starter_v2_3_0.xlsx
```

It includes:

- Start Here
- Platform Matrix
- Table Inventory
- Data Quality Summary
- Column Profile
- Cleaning Checklist
- Relationship Map
- KPI Catalog
- Pivot Blueprint
- ProjectRoot parameter

Recommended Excel workflow:

1. Select **Data → Get Data → From File → From Folder**.
2. Point Power Query to one specific data folder.
3. Select **Transform Data**.
4. Filter by folder path and extension.
5. Combine only files with the same schema.
6. Load cleaned tables to the Data Model.
7. Create relationships.
8. Build PivotTables and PivotCharts.
9. Refresh when source files change.

---

## Looker Studio

Looker Studio assets include:

```text
docs/platforms/looker_studio/
├── upload_ready_csv/
├── data_source_map.csv
├── calculated_fields.md
└── README_LOOKER_STUDIO.md
```

Recommended starting files:

```text
employee_360_fy2025.csv
department_360_summary_fy2025.csv
02_fact_monthly_hr_kpi_fy2025.csv
```

Different schemas should be uploaded as separate Looker Studio data sources.

---

## Tableau

Tableau assets include:

- Relationship-based modeling guide
- Shared relationship map
- Dimension and fact-table recommendations
- Grain-preservation guidance

Recommended source:

```text
data/bi_ready_csv/
```

Use logical relationships rather than flattening all fact tables into one physical join.

---

## Qlik Sense

Qlik assets include:

```text
docs/platforms/qlik/
├── README_QLIK.md
└── Mokhles_HR_Load_Script.qvs
```

The load script imports the BI-ready tables through a folder connection.

Review shared field names before loading to avoid unintended synthetic keys.

---

## Metabase

Metabase assets include:

- CSV upload guidance
- Recommended starting tables
- Data-type review guidance
- Maintained database workflow recommendations

Recommended starting files:

```text
employee_360_fy2025.csv
department_360_summary_fy2025.csv
02_fact_monthly_hr_kpi_fy2025.csv
```

---

## Quick start

### 1. Clone the repository

```bash
git clone https://github.com/samusa099/mokhles-group-hr-analytics-bd-fy2025.git
cd mokhles-group-hr-analytics-bd-fy2025
```

### 2. Create a virtual environment

#### Windows PowerShell

```powershell
py -m venv .venv
.\.venv\Scripts\Activate.ps1
py -m pip install -r requirements.txt
py -m pip install -e .
```

#### macOS or Linux

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
python -m pip install -e .
```

### 3. Run repository validation

```bash
python scripts/validate_repository.py
```

### 4. Generate the BI-ready layer

```bash
python scripts/build_bi_ready_layer.py
```

### 5. Build analysis-ready tables

```bash
python scripts/build_analysis_ready.py
```

### 6. Profile the data

```bash
python scripts/profile_data.py
```

### 7. Launch the notebook

```bash
jupyter lab notebooks/Mokhles_HR_Analytics_EDA.ipynb
```

---

## Python example

```python
from mokhles_hr_analytics import load_csv_table

employees = load_csv_table("01_Employee_Master_FY2025.csv")

print(employees.head())
print(employees["Department"].value_counts())
```

---

## Excel portfolio

The `data/excel/` directory includes:

- One consolidated master workbook
- Twelve specialised HR analytics reports
- Executive dashboards
- Filterable Excel tables
- KPI definitions
- Bangladesh-based BDT compensation values

The structured analytics workspace also adds a dedicated Excel analytics starter workbook.

---

## Kaggle dataset

The published dataset is available on Kaggle:

**Mokhles Group HR Analytics Portfolio BD FY2025**

https://www.kaggle.com/datasets/samusahr/mokhles-group-hr-analytics-portfolio-bd-fy2025

Kaggle-specific metadata includes:

- Dataset title and subtitle
- Full dataset description
- File-level descriptions
- CSV schemas
- Column descriptions
- Tags
- Cover image
- Source statement
- Licence
- Update frequency
- Structured workspace download

---

## Data dictionary

The complete field-level data dictionary is available at:

```text
data/csv/13_Data_Dictionary_FY2025.csv
```

Every published CSV field also has a native description in:

```text
metadata/kaggle-dataset-metadata.json
```

The structured workspace contains a human-readable backup at:

```text
10_DOCUMENTATION/COLUMN_DESCRIPTIONS_COMPLETE.md
```

---

## Validation and quality controls

The repository includes validation scripts and GitHub Actions workflows that check:

- Required files and directories
- CSV header uniqueness
- CSV row and column counts
- Kaggle schema-to-CSV column alignment
- Non-empty file descriptions
- Non-empty field descriptions
- Tags and source statement
- Cover image configuration
- JSON and notebook validity
- Excel workbook ZIP integrity
- Duplicate resource paths
- Power BI layer completeness
- Structured-workspace integrity

---

## Suggested research and portfolio extensions

- Employee-turnover prediction
- Recruitment-source optimisation
- Compensation-band modelling
- Workforce forecasting
- Talent segmentation
- Department risk scoring
- Executive Power BI dashboard
- SQL-based HR data mart
- Diversity representation analysis
- Performance and promotion-readiness modeling
- Training ROI analysis
- Absence-risk analysis
- HR data warehouse design
- Automated BI refresh pipeline

---

## Author

**Siam Ahmad Musa**  
Human Resources professional and people analytics practitioner from Bangladesh.

---

## Citation

Please cite this project using the metadata in `CITATION.cff`.

Suggested citation:

> Musa, S. A. (2026). *Mokhles Group HR Analytics Demo 2025: A Realistic Synthetic HR Dataset and Cross-Platform Analytics Portfolio from Bangladesh* (Version 2.3.0).

---

## Licences

- **Dataset and documentation:** CC BY 4.0 — see `LICENSE`
- **Python code and notebook utilities:** MIT — see `LICENSE-CODE`

---

## Disclaimer

Mokhles Group is used as a fictional company name.

All records are synthetic and must not be presented as real organisational or employee information.
