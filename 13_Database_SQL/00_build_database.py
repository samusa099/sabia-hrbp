"""
Build the ready-to-query SQLite database for the Sabia Group HRBP project.

No external database package is required: Python's standard sqlite3 module is used.

Run from this folder:
    python 00_build_database.py

The script:
1. Loads all clean CSVs as typed SQLite tables.
2. Loads messy raw CSVs as TEXT staging tables.
3. Creates date dimension, cleaning views, quality audit views and BI reporting views.
4. Exports a small set of sample query results.
"""
from pathlib import Path
import csv
import sqlite3
import re
from datetime import date, timedelta

BASE = Path(__file__).resolve().parents[1]
CLEAN = BASE / "06_Clean_Data"
RAW = BASE / "05_Raw_Data"
HERE = Path(__file__).resolve().parent
DB = HERE / "Sabia_Group_HRBP_Analytics.sqlite"
SAMPLE = HERE / "sample_query_results"
SAMPLE.mkdir(exist_ok=True)

TEXT_HINTS = {"Month","Quarter","Department_Code","Employee_ID","Entity_ID","Facility_ID"}

def q(name):
    return '"' + name.replace('"','""') + '"'

def table_name(path):
    return re.sub(r"[^a-zA-Z0-9_]+","_",path.stem).strip("_").lower()

def infer_type(header, values, force_text=False):
    if force_text or header in TEXT_HINTS or header.endswith("_ID") or header.endswith("_Code"):
        return "TEXT"
    if header.endswith("_Date") or header in {"Month","Join_Date","Exit_Date"}:
        return "TEXT"
    values=[v.strip() for v in values if v and v.strip()]
    if values and all(re.fullmatch(r"[-+]?\d+",v) for v in values):
        return "INTEGER"
    if values:
        try:
            for v in values: float(v)
            return "REAL"
        except ValueError:
            pass
    return "TEXT"

def convert(v, typ):
    if v is None or not v.strip(): return None
    if typ=="INTEGER": return int(v)
    if typ=="REAL": return float(v)
    return v.strip()

def load_csv(conn, path, force_text=False):
    with path.open(encoding="utf-8-sig",newline="") as f:
        reader=csv.DictReader(f)
        rows=list(reader)
        headers=reader.fieldnames or []
    types={h:infer_type(h,[r.get(h,"") for r in rows],force_text) for h in headers}
    name=table_name(path)
    conn.execute(f"DROP TABLE IF EXISTS {q(name)}")
    conn.execute(f"CREATE TABLE {q(name)} ({', '.join(q(h)+' '+types[h] for h in headers)})")
    sql=f"INSERT INTO {q(name)} ({', '.join(q(h) for h in headers)}) VALUES ({', '.join('?' for _ in headers)})"
    conn.executemany(sql,[[convert(r.get(h,""),types[h]) for h in headers] for r in rows])
    return name,len(rows)

def export_query(conn, filename, sql):
    cur=conn.execute(sql)
    with (SAMPLE/filename).open("w",encoding="utf-8-sig",newline="") as f:
        writer=csv.writer(f)
        writer.writerow([d[0] for d in cur.description])
        writer.writerows(cur.fetchall())

if DB.exists():
    DB.unlink()

conn=sqlite3.connect(DB)
conn.execute("PRAGMA foreign_keys=ON")
conn.execute("PRAGMA journal_mode=WAL")

catalog=[]
for path in sorted(CLEAN.glob("*.csv")):
    name,count=load_csv(conn,path)
    catalog.append((name,"clean",count,str(path.relative_to(BASE))))
for path in sorted(RAW.glob("*.csv")):
    name,count=load_csv(conn,path,force_text=True)
    catalog.append((name,"raw",count,str(path.relative_to(BASE))))

conn.execute("DROP TABLE IF EXISTS dim_date")
conn.execute("""CREATE TABLE dim_date(
    Date TEXT PRIMARY KEY, Year INTEGER, Month_Number INTEGER, Month_Name TEXT,
    Month_Start TEXT, Quarter TEXT, Year_Quarter TEXT
)""")
d=date(2026,1,1)
rows=[]
while d<=date(2026,12,31):
    qtr=f"Q{((d.month-1)//3)+1}"
    rows.append((d.isoformat(),d.year,d.month,d.strftime("%B"),d.replace(day=1).isoformat(),qtr,f"{d.year}-{qtr}"))
    d+=timedelta(days=1)
conn.executemany("INSERT INTO dim_date VALUES (?,?,?,?,?,?,?)",rows)

conn.executescript((HERE/"01_schema_and_cleaning_views.sql").read_text(encoding="utf-8"))
conn.executescript((HERE/"05_powerbi_reporting_views.sql").read_text(encoding="utf-8"))

index_commands=[
    "CREATE INDEX IF NOT EXISTS idx_employee_id ON employee_master(Employee_ID)",
    "CREATE INDEX IF NOT EXISTS idx_employee_department ON employee_master(Department)",
    "CREATE INDEX IF NOT EXISTS idx_employee_join_exit ON employee_master(Join_Date,Exit_Date)",
    "CREATE INDEX IF NOT EXISTS idx_training_employee ON training_records(Employee_ID)",
    "CREATE INDEX IF NOT EXISTS idx_training_quarter ON training_records(Quarter)",
    "CREATE INDEX IF NOT EXISTS idx_performance_employee_quarter ON performance_quarterly(Employee_ID,Quarter)",
    "CREATE INDEX IF NOT EXISTS idx_recruitment_quarter ON recruitment_funnel(Quarter)",
    "CREATE INDEX IF NOT EXISTS idx_production_month ON production_monthly(Month)",
    "CREATE INDEX IF NOT EXISTS idx_financial_month ON financial_impact_monthly(Month)",
]
for sql in index_commands:
    conn.execute(sql)

conn.execute("DROP TABLE IF EXISTS database_table_catalog")
conn.execute("""CREATE TABLE database_table_catalog(
    Object_Name TEXT, Object_Type TEXT, Source_Layer TEXT, Row_Count INTEGER, Source_File TEXT
)""")
for name,layer,count,source in catalog:
    conn.execute("INSERT INTO database_table_catalog VALUES (?,?,?,?,?)",(name,"table",layer,count,source))
for name,obj_type in conn.execute("SELECT name,type FROM sqlite_master WHERE type='view' ORDER BY name"):
    conn.execute("INSERT INTO database_table_catalog VALUES (?,?,?,?,?)",(name,obj_type,"sql_view",None,None))

conn.execute("DROP TABLE IF EXISTS data_quality_audit")
conn.execute("""CREATE TABLE data_quality_audit AS
SELECT Dataset, Issue_Type, COUNT(*) AS Issue_Count
FROM vw_data_quality_issues
GROUP BY Dataset, Issue_Type""")

export_query(conn,"01_data_quality_issue_summary.csv",
             "SELECT * FROM data_quality_audit ORDER BY Dataset, Issue_Count DESC")
export_query(conn,"02_employee_cleaning_examples.csv",
             "SELECT * FROM vw_employee_cleaning_comparison WHERE Cleaning_Flag_Count>0 LIMIT 100")
export_query(conn,"03_quarterly_business_summary.csv",
             "SELECT * FROM vw_bi_quarterly_business_summary ORDER BY Quarter")
export_query(conn,"04_workforce_bridge.csv",
             "SELECT * FROM vw_bi_workforce_bridge ORDER BY Quarter")
export_query(conn,"05_recruitment_summary.csv",
             "SELECT * FROM vw_bi_recruitment_quarterly ORDER BY Quarter")
export_query(conn,"06_training_summary.csv",
             "SELECT * FROM vw_bi_training_quarterly ORDER BY Quarter")
export_query(conn,"07_department_people_summary.csv",
             "SELECT * FROM vw_bi_department_people_summary ORDER BY Active_Headcount DESC")
export_query(conn,"08_powerbi_production_finance_monthly.csv",
             "SELECT * FROM vw_bi_production_finance_monthly ORDER BY Month")

conn.commit()
print("Database built:",DB)
print("Tables:",conn.execute("SELECT COUNT(*) FROM sqlite_master WHERE type='table'").fetchone()[0])
print("Views:",conn.execute("SELECT COUNT(*) FROM sqlite_master WHERE type='view'").fetchone()[0])
print("Quality issues:",conn.execute("SELECT COALESCE(SUM(Issue_Count),0) FROM data_quality_audit").fetchone()[0])
conn.close()
