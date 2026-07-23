"""
Clean and validate the deliberately messy Sabia Group HRBP datasets.

Run:
    pip install -r requirements.txt
    python clean_and_validate.py

The script reads ../05_Raw_Data and writes cleaned outputs to
../07_Python/generated_clean_output so the supplied clean data remains untouched.
"""
from pathlib import Path
import re
import pandas as pd

BASE = Path(__file__).resolve().parents[1]
RAW = BASE / "05_Raw_Data"
OUT = Path(__file__).resolve().parent / "generated_clean_output"
OUT.mkdir(exist_ok=True)

def clean_money(series: pd.Series) -> pd.Series:
    return pd.to_numeric(
        series.astype(str)
        .str.replace("BDT", "", regex=False)
        .str.replace("taka", "", regex=False)
        .str.replace(",", "", regex=False)
        .str.strip()
        .replace({"": None, "nan": None}),
        errors="coerce",
    )

def clean_rate(series: pd.Series) -> pd.Series:
    text = series.astype(str).str.strip()
    pct = text.str.endswith("%")
    numeric = pd.to_numeric(text.str.replace("%", "", regex=False), errors="coerce")
    numeric.loc[pct] = numeric.loc[pct] / 100
    return numeric

# Employee master
emp = pd.read_csv(RAW / "raw_employee_master_messy.csv")
emp.columns = emp.columns.str.strip()
emp["Employee_Name"] = emp["Employee_Name"].astype(str).str.strip().str.title()
emp["Gender"] = (
    emp["Gender"].astype(str).str.strip().str.lower()
    .replace({"m":"Male","male":"Male","f":"Female","female":"Female"})
)
emp["Department"] = emp["Department"].astype(str).str.strip().str.replace("&", "and", regex=False)
emp["Join_Date"] = pd.to_datetime(emp["Join_Date"], errors="coerce", dayfirst=True)
emp["Exit_Date"] = pd.to_datetime(emp["Exit_Date"], errors="coerce", dayfirst=True)
emp["Base_Salary_BDT"] = clean_money(emp["Base_Salary_BDT"])
emp["District"] = emp["District"].replace({"": None}).fillna("Unknown")
emp["Skill_Level"] = emp["Skill_Level"].replace({"": None}).fillna("Not Assessed")
emp = emp.drop_duplicates(subset=["Employee_ID"], keep="first")
assert emp["Employee_ID"].is_unique
assert emp["Join_Date"].notna().all()
emp.to_csv(OUT / "employee_master_cleaned.csv", index=False)

# Training
training = pd.read_csv(RAW / "raw_training_records_messy.csv")
training["Completion_Status"] = training["Completion_Status"].astype(str).str.strip().str.title()
training["Training_Date"] = pd.to_datetime(training["Training_Date"], errors="coerce")
training["Assessment_Score"] = pd.to_numeric(training["Assessment_Score"], errors="coerce")
training["Training_Cost_BDT"] = clean_money(training["Training_Cost_BDT"])
training.to_csv(OUT / "training_records_cleaned.csv", index=False)

# Production
prod = pd.read_csv(RAW / "raw_production_metrics_messy.csv")
prod["Production_Line"] = prod["Production_Line"].astype(str).str.strip().str.title()
prod["Month"] = pd.to_datetime(prod["Month"], errors="coerce")
prod["Defect_Rate"] = clean_rate(prod["Defect_Rate"])
prod["First_Pass_Yield"] = clean_rate(prod["First_Pass_Yield"])
prod["First_Pass_Yield"] = prod["First_Pass_Yield"].fillna(
    1 - prod["Defect_Rate"] - pd.to_numeric(prod["Rework_Rate"], errors="coerce") * 0.25
)
prod.to_csv(OUT / "production_metrics_cleaned.csv", index=False)

# Validation report
report = pd.DataFrame([
    {"dataset":"employee","rows":len(emp),"duplicate_keys":int(emp["Employee_ID"].duplicated().sum()),"missing_primary_key":int(emp["Employee_ID"].isna().sum())},
    {"dataset":"training","rows":len(training),"duplicate_keys":int(training["Training_Record_ID"].duplicated().sum()),"missing_primary_key":int(training["Training_Record_ID"].isna().sum())},
    {"dataset":"production","rows":len(prod),"duplicate_keys":int(prod.duplicated(subset=["Month","Production_Line"]).sum()),"missing_primary_key":int(prod["Month"].isna().sum())},
])
report.to_csv(OUT / "data_quality_report.csv", index=False)
print(report.to_string(index=False))
