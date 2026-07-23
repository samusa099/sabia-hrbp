-- Data quality audit and reconciliation queries.

-- Overall issue count
SELECT COUNT(*) AS Total_Data_Quality_Issues
FROM vw_data_quality_issues;

-- Issues by source and type
SELECT Dataset, Issue_Type, COUNT(*) AS Issue_Count
FROM vw_data_quality_issues
GROUP BY Dataset, Issue_Type
ORDER BY Dataset, Issue_Count DESC;

-- Reconcile raw unique employee keys with the clean official employee master.
SELECT
    (SELECT COUNT(*) FROM raw_employee_master_messy) AS Raw_Rows,
    (SELECT COUNT(DISTINCT TRIM(Employee_ID)) FROM raw_employee_master_messy) AS Raw_Unique_Employee_IDs,
    (SELECT COUNT(*) FROM vw_employee_cleaned_from_raw) AS SQL_Cleaned_Rows,
    (SELECT COUNT(*) FROM employee_master) AS Official_Clean_Rows;

-- Orphan training records
SELECT t.Employee_ID, COUNT(*) AS Training_Rows
FROM training_records t
LEFT JOIN employee_master e ON t.Employee_ID=e.Employee_ID
WHERE e.Employee_ID IS NULL
GROUP BY t.Employee_ID;

-- Range checks for operational metrics
SELECT *
FROM production_monthly
WHERE First_Pass_Yield NOT BETWEEN 0 AND 1
   OR Defect_Rate NOT BETWEEN 0 AND 1
   OR Rework_Rate NOT BETWEEN 0 AND 1
   OR Customer_Return_Rate NOT BETWEEN 0 AND 1;

-- Employee date logic
SELECT Employee_ID, Join_Date, Exit_Date
FROM employee_master
WHERE Exit_Date IS NOT NULL AND Exit_Date<>'' AND Exit_Date<Join_Date;
