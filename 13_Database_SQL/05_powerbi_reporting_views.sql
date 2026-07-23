-- Reporting views intended for Power BI, Excel Power Query, Python, Tableau or export to Looker Studio.

DROP VIEW IF EXISTS vw_bi_employee_master;
CREATE VIEW vw_bi_employee_master AS
SELECT
    e.*,
    ROUND((JULIANDAY(COALESCE(NULLIF(e.Exit_Date,''),'2026-12-31'))-JULIANDAY(e.Join_Date))/30.44,0) AS Tenure_Months,
    e.Total_Monthly_Cost_BDT*12 AS Annual_Employment_Cost_BDT
FROM employee_master e;

DROP VIEW IF EXISTS vw_bi_workforce_bridge;
CREATE VIEW vw_bi_workforce_bridge AS
SELECT 'Q1' AS Quarter, '2026-03-31' AS As_Of_Date,
       SUM(CASE WHEN Join_Date<='2026-03-31' AND (Exit_Date IS NULL OR Exit_Date='' OR Exit_Date>'2026-03-31') THEN 1 ELSE 0 END) AS Active_Headcount
FROM employee_master
UNION ALL
SELECT 'Q2','2026-06-30',
       SUM(CASE WHEN Join_Date<='2026-06-30' AND (Exit_Date IS NULL OR Exit_Date='' OR Exit_Date>'2026-06-30') THEN 1 ELSE 0 END)
FROM employee_master
UNION ALL
SELECT 'Q3','2026-09-30',
       SUM(CASE WHEN Join_Date<='2026-09-30' AND (Exit_Date IS NULL OR Exit_Date='' OR Exit_Date>'2026-09-30') THEN 1 ELSE 0 END)
FROM employee_master
UNION ALL
SELECT 'Q4','2026-12-31',
       SUM(CASE WHEN Join_Date<='2026-12-31' AND (Exit_Date IS NULL OR Exit_Date='' OR Exit_Date>'2026-12-31') THEN 1 ELSE 0 END)
FROM employee_master;

DROP VIEW IF EXISTS vw_bi_kpi_scorecard_long;
CREATE VIEW vw_bi_kpi_scorecard_long AS
SELECT Metric, Unit, 'Q1' AS Quarter, Q1 AS KPI_Value, Annual_Target, Q4_Status FROM quarterly_scorecard
UNION ALL SELECT Metric, Unit, 'Q2', Q2, Annual_Target, Q4_Status FROM quarterly_scorecard
UNION ALL SELECT Metric, Unit, 'Q3', Q3, Annual_Target, Q4_Status FROM quarterly_scorecard
UNION ALL SELECT Metric, Unit, 'Q4', Q4, Annual_Target, Q4_Status FROM quarterly_scorecard;

DROP VIEW IF EXISTS vw_bi_pillar_maturity_long;
CREATE VIEW vw_bi_pillar_maturity_long AS
SELECT Pillar, 'Q1' AS Quarter, Q1 AS Maturity_Score FROM hr_pillar_scores
UNION ALL SELECT Pillar, 'Q2', Q2 FROM hr_pillar_scores
UNION ALL SELECT Pillar, 'Q3', Q3 FROM hr_pillar_scores
UNION ALL SELECT Pillar, 'Q4', Q4 FROM hr_pillar_scores;

DROP VIEW IF EXISTS vw_bi_quarterly_business_summary;
CREATE VIEW vw_bi_quarterly_business_summary AS
WITH fin AS (
    SELECT Quarter,
           SUM(Revenue_BDT_Million) AS Revenue_BDT_Million,
           SUM(Operating_Profit_BDT_Million) AS Operating_Profit_BDT_Million,
           AVG(Active_Headcount) AS Average_Headcount,
           SUM(Workforce_Cost_BDT_Million) AS Workforce_Cost_BDT_Million,
           SUM(Scrap_Cost_BDT_Million) AS Scrap_Cost_BDT_Million,
           SUM(Warranty_Cost_BDT_Million) AS Warranty_Cost_BDT_Million
    FROM financial_impact_monthly
    GROUP BY Quarter
),
prod AS (
    SELECT Quarter,
           SUM(Actual_Units) AS Actual_Units,
           SUM(Actual_Units*First_Pass_Yield)/NULLIF(SUM(Actual_Units),0) AS First_Pass_Yield,
           SUM(Actual_Units*Defect_Rate)/NULLIF(SUM(Actual_Units),0) AS Defect_Rate,
           AVG(Units_per_Labour_Hour) AS Units_per_Labour_Hour
    FROM production_monthly
    GROUP BY Quarter
),
att AS (
    SELECT Quarter,
           AVG(Absence_Rate) AS Absence_Rate,
           AVG(Average_Overtime_Hours_per_Employee) AS Average_Overtime_Hours
    FROM attendance_monthly
    GROUP BY Quarter
)
SELECT f.Quarter, f.Revenue_BDT_Million, f.Operating_Profit_BDT_Million,
       f.Average_Headcount, f.Workforce_Cost_BDT_Million,
       f.Scrap_Cost_BDT_Million, f.Warranty_Cost_BDT_Million,
       p.Actual_Units, p.First_Pass_Yield, p.Defect_Rate,
       p.Units_per_Labour_Hour, a.Absence_Rate, a.Average_Overtime_Hours
FROM fin f
LEFT JOIN prod p USING(Quarter)
LEFT JOIN att a USING(Quarter);

DROP VIEW IF EXISTS vw_bi_production_finance_monthly;
CREATE VIEW vw_bi_production_finance_monthly AS
WITH prod AS (
    SELECT Month, Quarter,
           SUM(Planned_Units) AS Planned_Units,
           SUM(Actual_Units) AS Actual_Units,
           SUM(Actual_Units*First_Pass_Yield)/NULLIF(SUM(Actual_Units),0) AS First_Pass_Yield,
           SUM(Actual_Units*Defect_Rate)/NULLIF(SUM(Actual_Units),0) AS Defect_Rate,
           SUM(Scrap_Units) AS Scrap_Units,
           AVG(Units_per_Labour_Hour) AS Units_per_Labour_Hour,
           SUM(Downtime_Hours) AS Downtime_Hours
    FROM production_monthly
    GROUP BY Month, Quarter
)
SELECT
    f.Month, f.Quarter, f.Active_Headcount, f.Units_Sold,
    p.Planned_Units, p.Actual_Units, p.First_Pass_Yield, p.Defect_Rate,
    p.Scrap_Units, p.Units_per_Labour_Hour, p.Downtime_Hours,
    f.Revenue_BDT_Million, f.Workforce_Cost_BDT_Million,
    f.Scrap_Cost_BDT_Million, f.Warranty_Cost_BDT_Million,
    f.Operating_Profit_BDT_Million, f.Cumulative_Profit_BDT_Million,
    t.HRIS_Adoption_Rate, t.Data_Completeness_Rate
FROM financial_impact_monthly f
LEFT JOIN prod p ON f.Month=p.Month
LEFT JOIN technology_adoption t ON f.Month=t.Month;

DROP VIEW IF EXISTS vw_bi_recruitment_quarterly;
CREATE VIEW vw_bi_recruitment_quarterly AS
SELECT Quarter,
       SUM(Approved_Headcount) AS Approved_Headcount,
       SUM(Applications) AS Applications,
       SUM(Interviewed) AS Interviewed,
       SUM(Offers_Made) AS Offers_Made,
       SUM(Offers_Accepted) AS Offers_Accepted,
       SUM(Hires_Joined) AS Hires_Joined,
       SUM(Offers_Accepted)*1.0/NULLIF(SUM(Offers_Made),0) AS Offer_Acceptance_Rate,
       AVG(Time_to_Fill_Days) AS Average_Time_to_Fill_Days,
       SUM(Recruitment_Cost_BDT) AS Recruitment_Cost_BDT,
       AVG(Hiring_Manager_Satisfaction) AS Hiring_Manager_Satisfaction
FROM recruitment_funnel
GROUP BY Quarter;

DROP VIEW IF EXISTS vw_bi_training_quarterly;
CREATE VIEW vw_bi_training_quarterly AS
SELECT Quarter,
       COUNT(*) AS Training_Events,
       COUNT(DISTINCT Employee_ID) AS Employees_Trained,
       SUM(Training_Hours) AS Training_Hours,
       SUM(CASE WHEN Completion_Status='Completed' THEN 1 ELSE 0 END)*1.0/COUNT(*) AS Completion_Rate,
       SUM(CASE WHEN Certified='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) AS Certification_Rate,
       AVG(Assessment_Score) AS Average_Assessment_Score,
       SUM(Training_Cost_BDT) AS Training_Cost_BDT
FROM training_records
GROUP BY Quarter;

DROP VIEW IF EXISTS vw_bi_department_people_summary;
CREATE VIEW vw_bi_department_people_summary AS
WITH hc AS (
    SELECT Department,
           COUNT(*) AS Total_Employee_Records,
           SUM(CASE WHEN Employee_Status='Active' THEN 1 ELSE 0 END) AS Active_Headcount,
           SUM(CASE WHEN Critical_Skill='Yes' AND Employee_Status='Active' THEN 1 ELSE 0 END) AS Active_Critical_Skill_Headcount,
           AVG(Total_Monthly_Cost_BDT) AS Average_Monthly_Cost_BDT
    FROM employee_master
    GROUP BY Department
),
perf AS (
    SELECT Department, AVG(Overall_Score) AS Average_Performance_Score,
           SUM(CASE WHEN Manager_Checkin_Completed='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) AS Checkin_Completion_Rate
    FROM performance_quarterly
    GROUP BY Department
),
train AS (
    SELECT Department, SUM(Training_Hours) AS Training_Hours,
           AVG(Assessment_Score) AS Average_Training_Score
    FROM training_records
    GROUP BY Department
),
att AS (
    SELECT Department, AVG(Absence_Rate) AS Average_Absence_Rate,
           AVG(Average_Overtime_Hours_per_Employee) AS Average_Overtime_Hours
    FROM attendance_monthly
    GROUP BY Department
)
SELECT hc.*, perf.Average_Performance_Score, perf.Checkin_Completion_Rate,
       train.Training_Hours, train.Average_Training_Score,
       att.Average_Absence_Rate, att.Average_Overtime_Hours
FROM hc
LEFT JOIN perf USING(Department)
LEFT JOIN train USING(Department)
LEFT JOIN att USING(Department);

DROP VIEW IF EXISTS vw_bi_pilot_vs_control;
CREATE VIEW vw_bi_pilot_vs_control AS
SELECT Metric, Unit, Baseline_Q1, Pilot_Target, Pilot_Result, Control_Result,
       Pilot_Result-Control_Result AS Pilot_Control_Gap,
       Decision
FROM pilot_results;
