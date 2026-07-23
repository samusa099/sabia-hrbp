# Paste this into Power BI Desktop > Get Data > Python script.
# Change DB_PATH to the extracted project location on your computer.

import sqlite3
import pandas as pd

DB_PATH = r"C:\YourFolder\Sabia_Group_HRBP_Smartwatch_Recovery_2026_DB_Enhanced\13_Database_SQL\Sabia_Group_HRBP_Analytics.sqlite"

with sqlite3.connect(DB_PATH) as conn:
    dataset = pd.read_sql_query(
        "SELECT * FROM vw_bi_production_finance_monthly ORDER BY Month",
        conn
    )
