# SQL Portability Notes

The ready database uses SQLite because it is portable and requires no server.

## PostgreSQL
- Replace SQLite `JULIANDAY()` tenure logic with date arithmetic.
- CSV can be loaded with `COPY`.
- Keep the reporting-view design and table names.
- Convert `INTEGER PRIMARY KEY` behaviour only when adding surrogate keys.

## MySQL
- Replace `JULIANDAY()` with `TIMESTAMPDIFF`.
- Load CSV through Workbench or `LOAD DATA`.
- Window functions require a modern MySQL version.

## SQL Server
- Replace `JULIANDAY()` with `DATEDIFF`.
- Import flat files through SSMS or Azure Data Studio.
- Use views with the same `vw_bi_` names to preserve the BI layer.

## DuckDB
- The clean CSV folder can be queried directly with `read_csv_auto`.
- The SQLite file remains the supplied ready-to-open database.

The scripts `02`, `03`, `04` and `06` use mostly portable SELECT syntax. The cleaning and reporting-view scripts contain SQLite-specific date expressions.
