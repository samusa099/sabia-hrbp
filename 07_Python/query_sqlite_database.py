"""
Query the ready SQLite database from Python.
Requires pandas, which is already listed in 07_Python/requirements.txt.
"""
from pathlib import Path
import sqlite3
import pandas as pd

BASE=Path(__file__).resolve().parents[1]
DB=BASE/"13_Database_SQL"/"Sabia_Group_HRBP_Analytics.sqlite"

with sqlite3.connect(DB) as conn:
    quarterly=pd.read_sql_query(
        "SELECT * FROM vw_bi_quarterly_business_summary ORDER BY Quarter", conn
    )
    cleaning_issues=pd.read_sql_query(
        "SELECT * FROM vw_data_quality_issues ORDER BY Dataset, Issue_Type", conn
    )
    critical_skills=pd.read_sql_query(
        """
        SELECT Department, Skill_Category, Skill_Level, COUNT(*) AS Active_Employees
        FROM employee_master
        WHERE Employee_Status='Active' AND Critical_Skill='Yes'
        GROUP BY Department, Skill_Category, Skill_Level
        ORDER BY Department, Active_Employees DESC
        """, conn
    )

print(quarterly)
print("\nData-quality issues:",len(cleaning_issues))
