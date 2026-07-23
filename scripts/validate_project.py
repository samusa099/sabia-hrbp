"""Validate the publish-ready Sabia Group repository."""
from pathlib import Path
import csv
import sqlite3
import sys

ROOT = Path(__file__).resolve().parents[1]
required = [
    ROOT / "README.md",
    ROOT / "00_Master" / "Sabia_Group_HRBP_Analytics_Master_2026.xlsx",
    ROOT / "06_Clean_Data" / "employee_master.csv",
    ROOT / "06_Clean_Data" / "financial_impact_monthly.csv",
    ROOT / "13_Database_SQL" / "Sabia_Group_HRBP_Analytics.sqlite",
    ROOT / "08_PowerBI" / "POWER_BI_AND_OTHER_BI_USAGE_GUIDE.md",
]

missing = [str(p.relative_to(ROOT)) for p in required if not p.exists()]
if missing:
    raise SystemExit("Missing required files: " + ", ".join(missing))

with (ROOT / "06_Clean_Data" / "employee_master.csv").open(
    encoding="utf-8-sig", newline=""
) as f:
    employees = list(csv.DictReader(f))

employee_ids = [row["Employee_ID"] for row in employees]
if len(employee_ids) != len(set(employee_ids)):
    raise SystemExit("Duplicate Employee_ID found in official clean data.")

db = ROOT / "13_Database_SQL" / "Sabia_Group_HRBP_Analytics.sqlite"
with sqlite3.connect(db) as conn:
    integrity = conn.execute("PRAGMA integrity_check").fetchone()[0]
    q4_headcount = conn.execute(
        "SELECT Active_Headcount FROM vw_bi_workforce_bridge WHERE Quarter='Q4'"
    ).fetchone()[0]
    q4_profit = conn.execute(
        "SELECT Operating_Profit_BDT_Million "
        "FROM vw_bi_quarterly_business_summary WHERE Quarter='Q4'"
    ).fetchone()[0]

if integrity != "ok":
    raise SystemExit(f"SQLite integrity check failed: {integrity}")
if q4_headcount != 114:
    raise SystemExit(f"Unexpected Q4 headcount: {q4_headcount}")
if round(float(q4_profit), 2) != 64.02:
    raise SystemExit(f"Unexpected Q4 operating profit: {q4_profit}")

print("Validation passed.")
print("Employee rows:", len(employees))
print("Q4 active headcount:", q4_headcount)
print("Q4 operating profit (BDT million):", q4_profit)
