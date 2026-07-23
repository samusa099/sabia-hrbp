# Power BI, Excel, Looker Studio and Other BI Software Usage Guide

এই project ব্যবহার করার চারটি practical route আছে।

---

## Route A — Power BI Folder Connector: সবচেয়ে সহজ এবং driver-free

1. ZIP extract করুন।
2. Power BI Desktop খুলুন।
3. **Get Data → Folder** নির্বাচন করুন।
4. `06_Clean_Data` folder নির্বাচন করুন।
5. **Transform Data** ব্যবহার করে প্রয়োজনীয় CSV filter করুন।
6. `08_PowerBI/model_relationships.csv` অনুযায়ী model তৈরি করুন।
7. `DAX_Measures_and_Report_Pages.md` থেকে measures ব্যবহার করুন।

Recommended core tables:

- `employee_master.csv`
- `training_records.csv`
- `performance_quarterly.csv`
- `recruitment_funnel.csv`
- `attendance_monthly.csv`
- `production_monthly.csv`
- `financial_impact_monthly.csv`
- `technology_adoption.csv`

Microsoft documents the Folder connector as a way to connect, combine and transform files from a selected folder:

https://learn.microsoft.com/en-us/power-query/connectors/folder

---

## Route B — SQLite database through ODBC

Ready database:

`13_Database_SQL/Sabia_Group_HRBP_Analytics.sqlite`

### Steps

1. একটি trusted SQLite ODBC driver install এবং Windows ODBC Data Source Administrator-এ DSN configure করুন।
2. Power BI Desktop → **Get Data → ODBC**।
3. আপনার SQLite DSN select করুন।
4. Tables-এর পরিবর্তে প্রয়োজন হলে নিচের reporting views load করুন:

- `vw_bi_quarterly_business_summary`
- `vw_bi_production_finance_monthly`
- `vw_bi_workforce_bridge`
- `vw_bi_kpi_scorecard_long`
- `vw_bi_pillar_maturity_long`
- `vw_bi_recruitment_quarterly`
- `vw_bi_training_quarterly`
- `vw_bi_department_people_summary`
- `vw_bi_pilot_vs_control`

Power Query's ODBC connector supports import and can accept a SQL statement in its advanced options:

https://learn.microsoft.com/en-us/power-query/connectors/odbc

### Example SQL

```sql
SELECT *
FROM vw_bi_production_finance_monthly
ORDER BY Month;
```

### Example Power Query M

```powerquery
let
    Source = Odbc.Query(
        "dsn=Sabia_SQLite",
        "SELECT * FROM vw_bi_quarterly_business_summary ORDER BY Quarter"
    )
in
    Source
```

> SQLite ODBC driverটি Microsoft-এর supplied project file নয়। Driver architecture Power BI Desktop-এর architecture-এর সঙ্গে match করতে হবে।

---

## Route C — Power BI Python data source

এই folder-এর file ব্যবহার করুন:

`08_PowerBI/powerbi_python_sqlite_loader.py`

Power BI Desktop Python scripts চালিয়ে resulting dataset model-এ import করতে পারে:

https://learn.microsoft.com/en-us/power-bi/connect-data/desktop-python-scripts

Basic pattern:

```python
import sqlite3
import pandas as pd

with sqlite3.connect(DB_PATH) as conn:
    dataset = pd.read_sql_query(
        "SELECT * FROM vw_bi_production_finance_monthly",
        conn
    )
```

---

## Recommended Power BI model

### Option 1: Fast portfolio model
শুধু `vw_bi_` views load করুন। এগুলো chart-ready এবং flattened।

### Option 2: Proper star schema
Dimensions:

- `dim_date`
- `employee_master`
- `departments`
- `company_entities`
- `facilities`
- `hr_pillars`

Facts:

- `training_records`
- `performance_quarterly`
- `recruitment_funnel`
- `attendance_monthly`
- `production_monthly`
- `financial_impact_monthly`
- `hr_service_tickets`
- `employee_relations_cases`
- `technology_adoption`

Use single-direction relationships wherever practical।

---

## Suggested report pages

1. Executive Business Recovery
2. Q1 Feasibility and Workforce Reset
3. Q2 Pilot versus Control
4. Q3 Critical Hiring and Scale
5. Q4 Enterprise Rollout
6. People, Quality and Productivity
7. Financial Benefits Realization
8. Data Quality and SQL Cleaning

---

## Excel Power Query

Excel-এও একই দুটি পথ ব্যবহার করা যাবে:

- **Data → Get Data → From File → From Folder**
- **Data → Get Data → From Other Sources → From ODBC**

SQL query result CSV export করতে:

```bash
python 13_Database_SQL/07_export_query_results.py vw_bi_quarterly_business_summary quarterly_summary.csv
```

---

## Looker Studio

Local SQLite file সরাসরি browser-based dashboard-এর primary route হিসেবে না নিয়ে নিচের route ব্যবহার করুন:

### Simple route
1. `sample_query_results` অথবা `06_Clean_Data` CSV Google Sheets-এ upload করুন।
2. Looker Studio-তে Google Sheets data source যোগ করুন।
3. `Quarter`, `Month`, `Department` field type যাচাই করুন।
4. Rate fields-কে Percent এবং financial fields-কে Number/Currency করুন।

### Database route
SQLite reporting views PostgreSQL/MySQL-এ migrate করলে Looker Studio-এর database connector ব্যবহার করতে পারবেন। SQLite-specific date logic adapt করার জন্য `13_Database_SQL/09_SQL_PORTABILITY_NOTES.md` দেখুন।

Looker Studio is designed for self-service visualization and supports many data sources; its current documentation is maintained under Google Cloud:

https://cloud.google.com/looker/docs/studio

---

## Tableau, DBeaver, Jupyter and other software

### DBeaver / DB Browser for SQLite
`Sabia_Group_HRBP_Analytics.sqlite` খুলুন এবং `.sql` scripts execute করুন।

### Python / Jupyter
`07_Python/query_sqlite_database.py` চালান।

### Tableau
CSV route অথবা configured ODBC connection ব্যবহার করুন।

### Google Sheets
`sample_query_results/*.csv` import করে lightweight dashboard বা Looker Studio staging layer তৈরি করুন।

---

## Refresh workflow

1. Raw CSV update
2. `python 07_Python/clean_and_validate.py`
3. Clean CSV review
4. `python 13_Database_SQL/00_build_database.py`
5. Power BI / Excel refresh
6. Data-quality page check
7. Publish only after row-count and KPI reconciliation

---

## Final validation checklist

- Employee_ID duplicate নেই
- Join_Date valid
- Rates 0–1 range-এর মধ্যে
- Month and Quarter relationship correct
- Power BI percentages correctly formatted
- Q1–Q4 headcount: 52, 70, 99, 114
- Q4 endpoint scorecard FPY: 97.1%
- Weighted Q4 production-average FPY: approximately 95.5%
- Q4 endpoint defect rate: 2.4%
- Q4 operating profit: BDT 64.02 million
