# Power BI and Other BI Tools

## Power BI folder route

1. Get Data → Folder.
2. Select `06_Clean_Data`.
3. Filter the required CSV files.
4. Apply transformations in Power Query.
5. Create relationships using `08_PowerBI/model_relationships.csv`.
6. Add DAX from `08_PowerBI/DAX_Measures_and_Report_Pages.md`.

## Database route

Load the SQLite `vw_bi_` views through ODBC or the supplied Python loader.

## Recommended report pages

1. Executive recovery story
2. Q1 feasibility and workforce reset
3. Q2 pilot versus control
4. Q3 hiring and scale
5. Q4 enterprise rollout
6. Production and financial linkage
7. Data quality and methodology

## Other tools

- Excel Power Query: use the Folder connector or ODBC.
- Looker Studio: stage CSV outputs in Google Sheets.
- Tableau: use CSV or configured ODBC.
