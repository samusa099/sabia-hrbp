# Sabia Group HRBP Smartwatch Recovery 2026

[![Validate project](https://github.com/samusa099/sabia-hrbp/actions/workflows/validate-project.yml/badge.svg)](https://github.com/samusa099/sabia-hrbp/actions/workflows/validate-project.yml)


![Sabia HRBP Recovery cover](assets/sabia-hrbp-cover.svg)

> **Publish-ready repository:** extract this folder, open a terminal here, and run
> `PUBLISH_TO_GITHUB_WITH_GH.bat` on Windows or
> `./PUBLISH_TO_GITHUB_WITH_GH.sh` on Linux/macOS.

The repository contains synthetic HR, production, SQL, Python, Excel, Power BI,
Looker Studio, and Kaggle assets for a Bangladesh-focused smartwatch
manufacturing recovery case.


## Project Wiki

The repository includes GitHub Wiki-compatible Markdown pages under [`wiki/`](wiki/):

- [Home](wiki/Home.md)
- [Project Overview](wiki/Project-Overview.md)
- [Q1–Q4 Transformation Story](wiki/Transformation-Journey.md)
- [Data Architecture and Dictionary](wiki/Data-Architecture.md)
- [SQL and Database Lab](wiki/SQL-and-Database.md)
- [Power BI and BI Tools](wiki/Power-BI-and-BI-Tools.md)
- [Python Data Cleaning](wiki/Python-Data-Cleaning.md)
- [Kaggle Publishing](wiki/Kaggle-Publishing.md)
- [Ethics and Limitations](wiki/Ethics-and-Limitations.md)

These files can be copied directly into the repository’s GitHub Wiki later, while remaining readable inside the main repository.

## Executive case
Sabia Group invested heavily in a **Made-in-Bangladesh smartwatch** operation but moved directly into production without validating an MVP or prototype. The result was high defect, rework, overtime, weak skill fit and sustained operating losses. The shareholders began considering a sale of the business.

A newly appointed **Lead HR Business Partner**, simultaneously acting as **Head of HR / Acting CHRO**, was asked to diagnose the business with data and build a recovery path.

## Transformation story
- **Starting workforce:** 100 employees
- **Q1 workforce reset:** 48 roles removed after documented role, skill and legal review
- **Q2 controlled pilot:** 25 employees on Line A with HR, QA, Engineering and IT support
- **Q3 scale:** Lines A and B, critical hiring and manager dashboards
- **Q4 rollout:** Group-wide HR operating model and final approval
- **End-of-year active workforce:** 114 employees
- **Final product quality:** 97.1% first-pass yield and 2.4% defect rate
- **Business outcome:** moved from critical sale risk toward a profitable operating model

## HR architecture
The project applies:
1. People Strategy
2. Workforce Strategy
3. Organization Design
4. HR Services
5. HR Technology
6. Talent Acquisition and Recruitment
7. Talent Management
8. Legal, Regulatory and Compliance
9. Performance Management
10. Rewards and Recognition
11. Career Development
12. Employee Relations
13. Employee Exits

## What you can practise
- Excel formulas, tables, charts, KPI scorecards and dashboarding
- Power BI star schema, DAX and executive storytelling
- Python data cleaning, validation and exploratory analysis
- Workforce planning, restructuring scenarios and HRBP decision support
- Recruitment, training, performance, ER, HR services and HR technology analytics
- Production, quality and financial linkage
- Optional Looker Studio modelling
- Kaggle dataset and notebook publishing

## Folder map
- `00_Master` – master Excel analytics workbook
- `01_Q1...` to `04_Q4...` – quarter-specific evidence and analysis
- `05_Raw_Data` – deliberately messy data for cleaning practice
- `06_Clean_Data` – analysis-ready tables
- `07_Python` – cleaning and EDA scripts
- `08_PowerBI` – model, DAX and dashboard guide
- `09_Looker_Studio` – optional connector and calculated-field guide
- `10_Kaggle` – dataset metadata, notebook and publishing text
- `11_Documentation` – business case, methodology and ethics
- `12_Reference` – source design reference
- `13_Database_SQL` – ready SQLite database, SQL cleaning views, quality audit, query library and BI reporting views

> All people, entities and events are synthetic demonstration data. This is not a record of a real company.


## Database and SQL extension

The enhanced package includes a ready-to-open SQLite database:

`13_Database_SQL/Sabia_Group_HRBP_Analytics.sqlite`

It contains raw staging tables, clean tables, SQL-based cleaning views, data-quality audit objects and `vw_bi_` reporting views. Open it in DB Browser for SQLite, DBeaver or SQLiteStudio, or connect from Power BI/Excel through ODBC. Rebuild it with:

```bash
python 13_Database_SQL/00_build_database.py
```

See:

- `13_Database_SQL/README_DATABASE_SQL.md`
- `08_PowerBI/POWER_BI_AND_OTHER_BI_USAGE_GUIDE.md`
