-- Run these queries in DB Browser for SQLite, DBeaver or the sqlite3 command line.

-- 1. See raw employee rows with the highest number of cleaning flags.
SELECT *
FROM vw_employee_cleaned_from_raw
ORDER BY Cleaning_Flag_Count DESC, Employee_ID
LIMIT 50;

-- 2. Compare raw and cleaned fields side by side.
SELECT *
FROM vw_employee_cleaning_comparison
WHERE Raw_Employee_Name<>Clean_Employee_Name
   OR LOWER(TRIM(Raw_Gender))<>LOWER(TRIM(Clean_Gender))
   OR Raw_Department<>Clean_Department
   OR Raw_Join_Date<>Clean_Join_Date
   OR CAST(REPLACE(REPLACE(REPLACE(Raw_Base_Salary,'BDT',''),',',''),' ','') AS REAL)<>Clean_Base_Salary
LIMIT 100;

-- 3. Review all detected data-quality problems.
SELECT Dataset, Issue_Type, COUNT(*) AS Issue_Count
FROM vw_data_quality_issues
GROUP BY Dataset, Issue_Type
ORDER BY Dataset, Issue_Count DESC;

-- 4. Check duplicate keys before loading to a reporting model.
SELECT TRIM(Employee_ID) AS Employee_ID, COUNT(*) AS Duplicate_Count
FROM raw_employee_master_messy
GROUP BY TRIM(Employee_ID)
HAVING COUNT(*)>1;

-- 5. Inspect production rows where FPY was imputed.
SELECT *
FROM vw_production_cleaned_from_raw
WHERE FPY_Cleaning_Method='Imputed from defect and rework';

-- 6. Training records that need manual assessment review.
SELECT *
FROM vw_training_cleaned_from_raw
WHERE Assessment_Score IS NULL
   OR Training_Date IS NULL
   OR Training_Cost_BDT IS NULL;
