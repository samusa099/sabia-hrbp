# Using the dataset in Power BI, Excel, Looker Studio and SQL

## Power BI

The simplest route is **Get Data → Folder** and select the extracted dataset
folder. Filter the files you need in Power Query.

Recommended core files:

- employee_master.csv
- recruitment_funnel.csv
- training_records.csv
- performance_quarterly.csv
- attendance_monthly.csv
- production_monthly.csv
- financial_impact_monthly.csv
- technology_adoption.csv

The included SQLite database also contains flattened `vw_bi_` reporting views.
Use a configured SQLite ODBC connection or Python's `sqlite3` + pandas route.

## Excel

Use **Data → Get Data → From File → From Folder**, or import the ready master
workbook directly.

## Looker Studio

Upload the relevant CSV files to Google Sheets, then use Google Sheets as the
Looker Studio data source. For a database connector workflow, migrate the
SQLite reporting views to PostgreSQL or MySQL.

## SQL

Open `Sabia_Group_HRBP_Analytics.sqlite` with DB Browser for SQLite, DBeaver,
SQLiteStudio, or Python. The database already contains cleaning, data-quality,
and Power BI reporting views.
