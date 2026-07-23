# Sabia Group Database and SQL Practice Lab

এই folder-টি project-কে spreadsheet-only project থেকে একটি **queryable HR analytics database project**-এ রূপান্তর করেছে।

## Ready database
`Sabia_Group_HRBP_Analytics.sqlite`

এটি সরাসরি নিচের software-এ খুলতে পারবেন:

- DB Browser for SQLite
- DBeaver
- SQLiteStudio
- `sqlite3` command line
- Python `sqlite3`
- Power BI through an appropriately configured ODBC data source
- Excel Power Query through ODBC

## Database layers

| Layer | Object |
|---|---|
| Raw staging | `raw_employee_master_messy`, `raw_training_records_messy`, `raw_production_metrics_messy` |
| Official clean data | Tables loaded from `06_Clean_Data` |
| SQL-cleaned practice views | `vw_employee_cleaned_from_raw`, `vw_training_cleaned_from_raw`, `vw_production_cleaned_from_raw` |
| Data quality | `vw_data_quality_issues`, `data_quality_audit` |
| BI-ready reporting | All views beginning with `vw_bi_` |
| Date model | `dim_date` |

## Recommended first queries

```sql
SELECT * FROM vw_data_quality_issues;

SELECT *
FROM vw_employee_cleaning_comparison
WHERE Cleaning_Flag_Count > 0;

SELECT *
FROM vw_bi_quarterly_business_summary
ORDER BY Quarter;

SELECT *
FROM vw_bi_production_finance_monthly
ORDER BY Month;
```

## Rebuild the database

```bash
python 00_build_database.py
```

Python-এর standard `sqlite3` module ব্যবহার করা হয়েছে; database build করার জন্য আলাদা DB package দরকার নেই।

## Script order

1. `00_build_database.py`
2. `01_schema_and_cleaning_views.sql`
3. `02_data_cleaning_queries.sql`
4. `03_data_quality_audit.sql`
5. `04_hrbp_analytics_queries.sql`
6. `05_powerbi_reporting_views.sql`
7. `06_q1_q4_business_queries.sql`
8. `07_export_query_results.py`

## Important

- SQLite cleaning views practice-এর জন্য।
- `employee_master` এবং অন্যান্য `06_Clean_Data` tables project-এর official analysis-ready snapshot।
- Real employee termination or layoff decisions-এর জন্য synthetic score ব্যবহার করবেন না।
