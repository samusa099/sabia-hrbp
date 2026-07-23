# Data Architecture and Dictionary

## Data layers

1. `05_Raw_Data` — deliberately messy CSVs for cleaning practice.
2. `06_Clean_Data` — analysis-ready HR, production, quality, and finance tables.
3. `13_Database_SQL` — SQLite database, staging tables, cleaning views, quality audit, and BI views.
4. `00_Master` — master Excel analytics workbook and consolidated data snapshot.

## Main dimensions

- employee;
- department;
- legal entity;
- facility;
- date;
- HR pillar.

## Main facts

- recruitment;
- training;
- performance;
- attendance;
- production;
- financial impact;
- HR-service tickets;
- employee-relations cases;
- technology adoption;
- exits and restructuring.

## Recommended model

Use a star schema for full Power BI practice. Use the flattened `vw_bi_` database views for a faster portfolio dashboard.

The detailed field-level catalogue is available in:

- `06_Clean_Data/data_dictionary.csv`
- `00_Master/Sabia_Group_HRBP_Analytics_Master_2026.xlsx`
