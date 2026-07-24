# 📘 Sabia HRBP Dataset Usage Guide

<p align="center">
  <strong>Why, how and where to use the Sabia Group HRBP Analytics dataset</strong><br>
  A practical guide for HR analytics, workforce planning, manufacturing recovery and portfolio learning.
</p>

---

## 🎯 Why this dataset exists

This project was created to show how HR data can be connected with operational and financial outcomes. It allows learners, HR professionals, analysts and students to practise turning workforce information into measurable business insight.

You can use the dataset to:

- 👥 understand workforce size, structure and capability;
- 🎯 evaluate recruitment, training and performance;
- 🧭 compare workforce-reset and business-recovery scenarios;
- 🏭 connect people metrics with production, defects and productivity;
- 💰 calculate workforce cost, operating cost, revenue and profit;
- 📊 build dashboards, scorecards and executive reports;
- 🧹 practise raw-data cleaning and validation;
- 🗄️ learn SQL, SQLite and relational data modelling;
- 🐍 perform exploratory analysis in Python;
- 📈 create portfolio projects in Excel, Power BI, Kaggle and GitHub.

> All records are synthetic. The dataset is for learning, practice and portfolio demonstration only.

---

## 🧩 Where the data can be used

| Use area | Example questions | Recommended files |
|---|---|---|
| 👥 Workforce analytics | How did headcount change? Which skills are critical? | `employee_master.csv`, `attendance_monthly.csv`, `workforce_scenarios.csv` |
| 🎯 Recruitment analytics | Which source produced the best hires? What is the time-to-fill? | `recruitment_funnel.csv` |
| 🎓 Learning and development | Did training improve skill, certification or productivity? | `training_records.csv`, `pilot_participants.csv`, `pilot_results.csv` |
| ⭐ Performance analytics | Which departments improved most across quarters? | `performance_quarterly.csv`, `hr_pillar_scores.csv` |
| 🏭 Production analytics | How did output, FPY, defects and downtime change? | `production_monthly.csv` |
| 💰 Financial analytics | Did recovery actions improve profit? What costs changed? | `financial_impact_monthly.csv` |
| 🧭 Strategy and scenario planning | Which workforce scenario is most sustainable? | `workforce_scenarios.csv`, `feasibility_findings.csv`, `risk_register.csv` |
| 🛠️ HR service analytics | Were HR tickets resolved within SLA? | `hr_service_tickets.csv` |
| 💻 HR technology analytics | Did HRIS adoption reduce paper transactions and service cost? | `technology_adoption.csv` |
| 🧹 Data-cleaning practice | Can messy data be standardized and validated? | `05_Raw_Data/`, `07_Python/clean_and_validate.py` |

---

## 🧮 What you can calculate

### 👥 Workforce calculations

#### Active headcount

```text
Active Headcount = Employees with Employee_Status = "Active"
```

#### Workforce growth rate

```text
Workforce Growth % = ((Ending Headcount - Starting Headcount) / Starting Headcount) × 100
```

Example:

```text
((114 - 100) / 100) × 100 = 14%
```

#### Attrition rate

```text
Attrition Rate % = Employee Exits / Average Headcount × 100
```

#### Average monthly employee cost

```text
Average Monthly Cost = Total Monthly Workforce Cost / Active Headcount
```

#### Critical-skill coverage

```text
Critical Skill Coverage % = Employees with Critical Skills / Active Headcount × 100
```

---

### 🎯 Recruitment calculations

#### Application-to-hire conversion

```text
Hire Conversion % = Hires Joined / Applications × 100
```

#### Offer acceptance rate

```text
Offer Acceptance % = Offers Accepted / Offers Made × 100
```

#### Joining rate

```text
Joining Rate % = Hires Joined / Offers Accepted × 100
```

#### Cost per hire

```text
Cost per Hire = Recruitment Cost / Hires Joined
```

#### Average time-to-fill

```text
Average Time-to-Fill = Sum of Time-to-Fill Days / Number of Requisitions
```

#### 90-day retention rate

```text
90-Day Retention % = New Hires Retained for 90 Days / Hires Joined × 100
```

---

### 🎓 Training calculations

#### Training completion rate

```text
Completion Rate % = Completed Training Records / Total Training Records × 100
```

#### Certification rate

```text
Certification Rate % = Certified Participants / Completed Participants × 100
```

#### Average assessment score

```text
Average Assessment Score = Total Assessment Scores / Number of Assessments
```

#### Training cost per employee

```text
Training Cost per Employee = Total Training Cost / Unique Trained Employees
```

#### Skill improvement

```text
Skill Improvement = Post-Skill Score - Pre-Skill Score
```

#### Productivity improvement

```text
Productivity Improvement % = ((Post Index - Pre Index) / Pre Index) × 100
```

---

### 🏭 Production calculations

#### Production achievement

```text
Production Achievement % = Actual Units / Planned Units × 100
```

#### First-pass yield

```text
FPY % = Good Units Without Rework / Total Units Produced × 100
```

#### Defect rate

```text
Defect Rate % = Defective Units / Total Units Produced × 100
```

#### Rework rate

```text
Rework Rate % = Reworked Units / Total Units Produced × 100
```

#### Labour productivity

```text
Units per Labour Hour = Actual Units / Total Labour Hours
```

#### Downtime per production unit

```text
Downtime per Unit = Downtime Hours / Actual Units
```

---

### 💰 Financial calculations

#### Total operating cost

```text
Total Operating Cost = Material Cost + Workforce Cost + Overhead + Scrap Cost + Warranty Cost + HR Transformation Cost + Other Operating Cost
```

#### Operating profit

```text
Operating Profit = Revenue - Total Operating Cost
```

#### Operating margin

```text
Operating Margin % = Operating Profit / Revenue × 100
```

#### Cumulative profit

```text
Cumulative Profit = Previous Cumulative Profit + Current Month Operating Profit
```

#### Revenue per employee

```text
Revenue per Employee = Revenue / Active Headcount
```

#### Profit per employee

```text
Profit per Employee = Operating Profit / Active Headcount
```

#### Scrap-cost reduction

```text
Scrap Cost Reduction % = ((Baseline Scrap Cost - Current Scrap Cost) / Baseline Scrap Cost) × 100
```

---

### 🛠️ HR service and technology calculations

#### SLA compliance rate

```text
SLA Compliance % = Tickets Resolved Within SLA / Total Tickets × 100
```

#### Average resolution time

```text
Average Resolution Hours = Total Resolution Hours / Total Tickets
```

#### HRIS adoption rate

```text
HRIS Adoption % = Monthly Active Users / Active Headcount × 100
```

#### Self-service ratio

```text
Self-Service Ratio % = Self-Service Transactions / Total HR Transactions × 100
```

#### Paper reduction rate

```text
Paper Reduction % = ((Baseline Paper Transactions - Current Paper Transactions) / Baseline Paper Transactions) × 100
```

---

## 🧪 Example analysis workflows

### 📊 Excel workflow

1. Open the master workbook in `00_Master/`.
2. Load clean CSV files with Power Query.
3. Create relationships using employee, department, quarter and date keys.
4. Build PivotTables for headcount, training, recruitment and production.
5. Add KPI cards for FPY, defects, headcount and profit.
6. Create quarter-over-quarter trend charts.

### 🟨 Power BI workflow

1. Import tables from `06_Clean_Data/` or connect to the SQLite database.
2. Build a star schema with employee, date, department and metric dimensions.
3. Create DAX measures for headcount, attrition, training completion, FPY and profit.
4. Design separate pages for Workforce, Talent, Operations and Finance.
5. Add slicers for Quarter, Department, Facility and Production Line.
6. Publish an executive summary page.

### 🐍 Python workflow

```bash
python -m pip install -r 07_Python/requirements.txt
python 07_Python/clean_and_validate.py
python 07_Python/eda_hrbp_recovery.py
```

Suggested tasks:

- clean inconsistent dates and categories;
- test missing values and duplicate IDs;
- compare Q1 and Q4 metrics;
- calculate correlation between training, productivity and quality;
- visualize headcount, defects, profit and HRIS adoption;
- export cleaned tables and charts.

### 🗄️ SQL and SQLite workflow

```bash
python 13_Database_SQL/00_build_database.py
```

Example query:

```sql
SELECT
    Quarter,
    AVG(First_Pass_Yield) AS Avg_FPY,
    AVG(Defect_Rate) AS Avg_Defect_Rate
FROM production_monthly
GROUP BY Quarter
ORDER BY Quarter;
```

Use SQL to:

- join employee, attendance and performance data;
- rank departments by overtime or absence;
- compare pilot and control outcomes;
- calculate recruitment conversion rates;
- create BI-ready views;
- audit missing values and duplicate keys.

---

## 📍 Where this project is useful

### 🎓 Learning and academic practice

- HR analytics assignments
- Business analytics coursework
- SQL and database labs
- Python EDA projects
- Power BI and Excel dashboard exercises
- Research-methodology demonstrations

### 💼 Career and portfolio use

- GitHub portfolio
- Kaggle dataset and notebook
- HRBP interview presentation
- HR analytics case study
- Power BI portfolio dashboard
- Excel and SQL skills demonstration
- Data-cleaning project evidence

### 🏢 Business simulation

- Workforce planning workshops
- Recruitment-funnel reviews
- Training ROI discussions
- Production-quality recovery simulation
- HRIS adoption analysis
- Scenario planning and risk review
- Executive scorecard design

---

## 🧭 Recommended learning path

```mermaid
flowchart LR
    A[📚 Read reference data] --> B[🧹 Clean raw files]
    B --> C[🔗 Build relationships]
    C --> D[🧮 Calculate KPIs]
    D --> E[📊 Create dashboards]
    E --> F[🧠 Interpret business impact]
    F --> G[💼 Publish portfolio]
```

---

## ⚠️ Responsible-use rules

- 🔒 Do not combine this project with real confidential employee records.
- ⚖️ Do not use the dataset to make real employment decisions.
- 🚫 Do not use protected characteristics for unfair selection or scoring.
- 📌 Treat every result as simulated, not causal proof.
- 🧾 Validate formulas, assumptions and business definitions before reuse.
- 👥 Keep human review, labour-law review and privacy review in real projects.

---

## 🔗 Related project resources

- [Main README](README.md)
- [SQL and Database Guide](13_Database_SQL/README_DATABASE_SQL.md)
- [Power BI Guide](08_PowerBI/POWER_BI_AND_OTHER_BI_USAGE_GUIDE.md)
- [Project Documentation](11_Documentation/)
- [Live Kaggle Dataset](https://www.kaggle.com/datasets/samusahr/sabia-hrbp-analytics)

---

<div align="center">

### 👤 Musa

**HRBP | HR & Data Analytics Practitioner | Bangladesh**

*Practice data. Real analytical thinking. Business-focused HRBP learning.*

</div>
