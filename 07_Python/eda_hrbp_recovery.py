"""
Exploratory analysis for the Sabia Group HRBP recovery dataset.
"""
from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt

BASE = Path(__file__).resolve().parents[1]
DATA = BASE / "06_Clean_Data"
OUT = Path(__file__).resolve().parent / "eda_outputs"
OUT.mkdir(exist_ok=True)

score = pd.read_csv(DATA / "quarterly_scorecard.csv")
finance = pd.read_csv(DATA / "financial_impact_monthly.csv")
production = pd.read_csv(DATA / "production_monthly.csv")
employees = pd.read_csv(DATA / "employee_master.csv")

# Quarterly KPI change
score["Q1_to_Q4_Change"] = score["Q4"] - score["Q1"]
score.to_csv(OUT / "quarterly_kpi_change.csv", index=False)

# Headcount by department and status
headcount = (
    employees.groupby(["Department","Employee_Status"])
    .size().reset_index(name="Employee_Count")
)
headcount.to_csv(OUT / "headcount_by_department_status.csv", index=False)

# Financial trend chart
plt.figure(figsize=(10,5))
plt.plot(finance["Month"], finance["Operating_Profit_BDT_Million"], marker="o")
plt.axhline(0, linewidth=1)
plt.xticks(rotation=45, ha="right")
plt.title("Monthly Operating Profit — Sabia Smartwatch Recovery")
plt.ylabel("BDT million")
plt.tight_layout()
plt.savefig(OUT / "monthly_operating_profit.png", dpi=180)
plt.close()

# Quality and productivity summary
quality = (
    production.groupby("Quarter")
    .agg(
        First_Pass_Yield=("First_Pass_Yield","mean"),
        Defect_Rate=("Defect_Rate","mean"),
        Units_per_Labour_Hour=("Units_per_Labour_Hour","mean"),
        Actual_Units=("Actual_Units","sum")
    )
    .reset_index()
)
quality.to_csv(OUT / "quarterly_production_summary.csv", index=False)

print("EDA outputs created in:", OUT)
