"""
Export any SQLite query to CSV.

Examples:
    python 07_export_query_results.py vw_bi_quarterly_business_summary quarterly_summary.csv
    python 07_export_query_results.py vw_employee_cleaned_from_raw cleaned_employee_from_sql.csv
"""
from pathlib import Path
import csv
import sqlite3
import sys

HERE=Path(__file__).resolve().parent
DB=HERE/"Sabia_Group_HRBP_Analytics.sqlite"

if len(sys.argv)<3:
    raise SystemExit("Usage: python 07_export_query_results.py <table_or_view> <output.csv>")

object_name=sys.argv[1]
output=HERE/sys.argv[2]
safe=object_name.replace('"','""')

conn=sqlite3.connect(DB)
cur=conn.execute(f'SELECT * FROM "{safe}"')
with output.open("w",encoding="utf-8-sig",newline="") as f:
    writer=csv.writer(f)
    writer.writerow([d[0] for d in cur.description])
    writer.writerows(cur.fetchall())
conn.close()
print("Exported:",output)
