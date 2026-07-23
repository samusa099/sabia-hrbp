from __future__ import annotations

import csv
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA_DIR = ROOT / "06_Clean_Data"
OUTPUT = ROOT / "10_Kaggle" / "dataset-metadata.json"

EXACT = {
    "Employee_ID": "Unique synthetic identifier assigned to each employee.",
    "Employee_Name": "Synthetic full name of the employee.",
    "Gender": "Reported gender category used in the synthetic workforce profile.",
    "Department": "Organizational department where the employee is assigned.",
    "Department_ID": "Unique identifier assigned to the department.",
    "Department_Code": "Short code used to identify the department.",
    "Designation": "Employee job title or organizational designation.",
    "Role": "Employee role or project responsibility.",
    "Join_Date": "Employee joining date in YYYY-MM-DD format.",
    "Exit_Date": "Employee exit date in YYYY-MM-DD format, where applicable.",
    "Employee_Status": "Current simulated employment status of the employee.",
    "Employment_Type": "Employment arrangement, such as permanent, contractual, or temporary.",
    "Total_Monthly_Cost_BDT": "Total estimated monthly employee cost expressed in Bangladeshi taka.",
    "Critical_Skill": "Indicates whether the employee holds a business-critical skill.",
    "Quarter": "Business quarter represented as Q1, Q2, Q3, or Q4.",
    "Month": "Reporting month, generally stored in YYYY-MM or date format.",
    "Metric": "Name of the KPI or analytical measure.",
    "Value": "Recorded value of the corresponding metric.",
    "Unit": "Unit of measurement used for the metric.",
    "Status": "Current status of the record, action, case, or metric.",
    "Description": "Narrative description of the record or analytical item.",
    "Planned_Units": "Number of production units planned for the reporting period.",
    "Actual_Units": "Number of production units actually completed.",
    "First_Pass_Yield": "Share of units passing quality inspection without rework.",
    "Defect_Rate": "Share of produced units identified as defective.",
    "Rework_Rate": "Share of produced units requiring rework.",
    "Units_per_Labour_Hour": "Production output per labour hour.",
    "Downtime_Hours": "Total production downtime recorded in hours.",
    "Revenue_BDT_Million": "Revenue expressed in millions of Bangladeshi taka.",
    "Operating_Profit_BDT_Million": "Operating profit expressed in millions of Bangladeshi taka.",
    "Cumulative_Profit_BDT_Million": "Cumulative operating profit expressed in millions of Bangladeshi taka.",
    "Active_Headcount": "Number of active employees in the reporting period.",
    "Training_Hours": "Number of training hours completed.",
    "Assessment_Score": "Training or competency assessment score.",
    "Completion_Status": "Training completion status.",
    "Certified": "Indicates whether certification was achieved.",
    "Training_Cost_BDT": "Training cost expressed in Bangladeshi taka.",
    "Absence_Rate": "Employee absence rate for the reporting period.",
    "Average_Overtime_Hours_per_Employee": "Average overtime hours recorded per employee.",
    "Late_Incidents": "Number of recorded lateness incidents.",
    "Safety_Incidents": "Number of recorded workplace safety incidents.",
    "Applications": "Number of job applications received.",
    "Offers_Accepted": "Number of employment offers accepted.",
    "Hires_Joined": "Number of selected candidates who joined.",
    "Time_to_Fill_Days": "Average number of days required to fill a position.",
    "Recruitment_Cost_BDT": "Recruitment cost expressed in Bangladeshi taka.",
    "90_Day_Retention_Rate": "Share of new hires retained for at least 90 days.",
}


def humanize(name: str) -> str:
    return re.sub(r"\s+", " ", name.replace("_", " ")).strip()


def describe(name: str) -> str:
    if name in EXACT:
        return EXACT[name]
    label = humanize(name)
    low = name.lower()
    if low.endswith("_id") or low == "id":
        return f"Unique identifier for the {humanize(name[:-3] if low.endswith('_id') else name).lower()} record."
    if "date" in low:
        return f"{label} recorded as a calendar date; use the source file format shown in the data."
    if "rate" in low or "percent" in low or low.endswith("_pct"):
        return f"{label} expressed as a rate or percentage."
    if any(x in low for x in ("cost", "salary", "revenue", "profit", "budget", "bdt")):
        return f"{label} recorded as a financial value; currency is BDT unless otherwise stated."
    if "hour" in low:
        return f"{label} measured in hours."
    if any(x in low for x in ("count", "headcount", "units", "applications", "hires", "incidents")):
        return f"{label} recorded as a numeric count."
    if any(x in low for x in ("status", "type", "category", "level", "group", "stage", "priority")):
        return f"{label} categorical value used to classify the record."
    if any(x in low for x in ("name", "title", "designation", "department", "location", "district", "facility")):
        return f"{label} text label associated with the record."
    if any(x in low for x in ("score", "index", "rating")):
        return f"{label} numeric analytical score or rating."
    return f"{label} field used in the Sabia Group HRBP synthetic analytics project."


def infer_type(name: str, samples: list[str]) -> str:
    low = name.lower()
    if low.endswith("_id") or low == "id":
        return "id"
    if "date" in low or low in {"month", "year_month"}:
        return "datetime"
    values = [v.strip() for v in samples if v and v.strip()]
    if values:
        try:
            ints = [int(v) for v in values]
            if len(ints) == len(values):
                return "integer"
        except ValueError:
            pass
        try:
            nums = [float(v.replace(",", "")) for v in values]
            if len(nums) == len(values):
                return "numeric"
        except ValueError:
            pass
    return "string"


def read_columns(path: Path) -> tuple[list[str], list[list[str]]]:
    with path.open("r", encoding="utf-8-sig", newline="") as handle:
        reader = csv.reader(handle)
        header = next(reader)
        rows = []
        for index, row in enumerate(reader):
            rows.append(row)
            if index >= 24:
                break
    return header, rows


def build_resource(path: Path) -> dict:
    header, rows = read_columns(path)
    fields = []
    for idx, column in enumerate(header):
        samples = [row[idx] for row in rows if idx < len(row)]
        fields.append({
            "name": column,
            "description": describe(column),
            "type": infer_type(column, samples),
        })
    return {
        "path": path.name,
        "description": (
            f"Synthetic practice table for {humanize(path.stem).lower()} analysis "
            "in the Sabia Group HRBP recovery portfolio."
        ),
        "schema": {"fields": fields},
    }


def main() -> None:
    csv_files = sorted(DATA_DIR.glob("*.csv"))
    if not csv_files:
        raise FileNotFoundError(f"No CSV files found in {DATA_DIR}")

    metadata = {
        "id": "samusahr/sabia-hrbp-analytics",
        "title": "Sabia Group HRBP Recovery Practice Dataset",
        "subtitle": "Synthetic HRBP data for workforce, manufacturing, and business recovery analytics",
        "description": (
            "A Bangladesh-focused synthetic HR Business Partner and manufacturing recovery dataset "
            "created by Musa for Excel, Power BI, Python, SQL, SQLite, data-cleaning, and portfolio practice."
        ),
        "licenses": [{"name": "CC-BY-4.0"}],
        "resources": [build_resource(path) for path in csv_files],
    }

    OUTPUT.write_text(json.dumps(metadata, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    total_fields = sum(len(item["schema"]["fields"]) for item in metadata["resources"])
    print(f"Generated {OUTPUT}")
    print(f"Documented {len(csv_files)} CSV files and {total_fields} columns")


if __name__ == "__main__":
    main()
