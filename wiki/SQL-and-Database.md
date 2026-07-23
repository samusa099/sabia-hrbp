# SQL and Database Lab

## Ready database

`13_Database_SQL/Sabia_Group_HRBP_Analytics.sqlite`

Open it in:

- DB Browser for SQLite;
- DBeaver;
- SQLiteStudio;
- Python `sqlite3`;
- Power BI or Excel through an appropriately configured ODBC connection.

## Key scripts

- `00_build_database.py`
- `01_schema_and_cleaning_views.sql`
- `02_data_cleaning_queries.sql`
- `03_data_quality_audit.sql`
- `04_hrbp_analytics_queries.sql`
- `05_powerbi_reporting_views.sql`
- `06_q1_q4_business_queries.sql`

## Recommended first query

```sql
SELECT *
FROM vw_bi_quarterly_business_summary
ORDER BY Quarter;
```

## Data-cleaning practice

Use the raw staging tables and compare them with:

- `vw_employee_cleaned_from_raw`;
- `vw_training_cleaned_from_raw`;
- `vw_production_cleaned_from_raw`;
- `vw_data_quality_issues`.
