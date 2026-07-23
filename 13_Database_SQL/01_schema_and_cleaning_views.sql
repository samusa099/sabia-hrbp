-- Sabia Group: SQL cleaning views built from deliberately messy raw CSV tables.
-- Dialect: SQLite 3.25+ (window functions required).

DROP VIEW IF EXISTS vw_employee_cleaned_from_raw;
CREATE VIEW vw_employee_cleaned_from_raw AS
WITH normalized AS (
    SELECT
        rowid AS Source_Row_Number,
        TRIM(Employee_ID) AS Employee_ID,
        UPPER(SUBSTR(TRIM(Employee_Name),1,1)) || SUBSTR(TRIM(Employee_Name),2) AS Employee_Name,
        CASE LOWER(TRIM(Gender))
            WHEN 'm' THEN 'Male' WHEN 'male' THEN 'Male'
            WHEN 'f' THEN 'Female' WHEN 'female' THEN 'Female'
            ELSE NULL
        END AS Gender,
        CAST(NULLIF(TRIM(Age),'') AS INTEGER) AS Age,
        COALESCE(NULLIF(TRIM(District),''),'Unknown') AS District,
        TRIM(Entity_ID) AS Entity_ID,
        TRIM(Legal_Entity) AS Legal_Entity,
        TRIM(Facility_ID) AS Facility_ID,
        TRIM(Department_Code) AS Department_Code,
        REPLACE(TRIM(Department),'&','and') AS Department,
        TRIM(Position) AS Position,
        TRIM(Grade) AS Grade,
        TRIM(Employment_Type) AS Employment_Type,
        TRIM(Shift) AS Shift,
        CASE
            WHEN LENGTH(TRIM(Join_Date)) = 10 AND SUBSTR(TRIM(Join_Date),5,1)='-' THEN TRIM(Join_Date)
            WHEN LENGTH(TRIM(Join_Date)) = 10 AND SUBSTR(TRIM(Join_Date),3,1)='/' THEN
                SUBSTR(TRIM(Join_Date),7,4)||'-'||SUBSTR(TRIM(Join_Date),4,2)||'-'||SUBSTR(TRIM(Join_Date),1,2)
            ELSE NULL
        END AS Join_Date,
        CASE
            WHEN NULLIF(TRIM(Exit_Date),'') IS NULL THEN NULL
            WHEN LENGTH(TRIM(Exit_Date)) = 10 AND SUBSTR(TRIM(Exit_Date),5,1)='-' THEN TRIM(Exit_Date)
            WHEN LENGTH(TRIM(Exit_Date)) = 10 AND SUBSTR(TRIM(Exit_Date),3,1)='/' THEN
                SUBSTR(TRIM(Exit_Date),7,4)||'-'||SUBSTR(TRIM(Exit_Date),4,2)||'-'||SUBSTR(TRIM(Exit_Date),1,2)
            WHEN LENGTH(TRIM(Exit_Date)) = 11 AND SUBSTR(TRIM(Exit_Date),3,1)='-' THEN
                SUBSTR(TRIM(Exit_Date),8,4)||'-'||
                CASE LOWER(SUBSTR(TRIM(Exit_Date),4,3))
                    WHEN 'jan' THEN '01' WHEN 'feb' THEN '02' WHEN 'mar' THEN '03'
                    WHEN 'apr' THEN '04' WHEN 'may' THEN '05' WHEN 'jun' THEN '06'
                    WHEN 'jul' THEN '07' WHEN 'aug' THEN '08' WHEN 'sep' THEN '09'
                    WHEN 'oct' THEN '10' WHEN 'nov' THEN '11' WHEN 'dec' THEN '12'
                END||'-'||SUBSTR(TRIM(Exit_Date),1,2)
            ELSE NULL
        END AS Exit_Date,
        TRIM(Employee_Status) AS Employee_Status,
        TRIM(Critical_Skill) AS Critical_Skill,
        TRIM(Skill_Category) AS Skill_Category,
        COALESCE(NULLIF(TRIM(Skill_Level),''),'Not Assessed') AS Skill_Level,
        CAST(REPLACE(REPLACE(REPLACE(TRIM(Base_Salary_BDT),'BDT',''),',',''),' ','') AS REAL) AS Base_Salary_BDT,
        CAST(NULLIF(TRIM(Allowance_BDT),'') AS REAL) AS Allowance_BDT,
        CAST(NULLIF(TRIM(Total_Monthly_Cost_BDT),'') AS REAL) AS Total_Monthly_Cost_BDT,
        TRIM(Hire_Cohort) AS Hire_Cohort,
        TRIM(Synthetic_Data_Flag) AS Synthetic_Data_Flag
    FROM raw_employee_master_messy
),
ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Employee_ID ORDER BY Source_Row_Number) AS Duplicate_Rank
    FROM normalized
)
SELECT
    Employee_ID, Employee_Name, Gender, Age, District, Entity_ID, Legal_Entity,
    Facility_ID, Department_Code, Department, Position, Grade, Employment_Type,
    Shift, Join_Date, Exit_Date, Employee_Status, Critical_Skill, Skill_Category,
    Skill_Level, Base_Salary_BDT, Allowance_BDT, Total_Monthly_Cost_BDT,
    Hire_Cohort, Synthetic_Data_Flag, Source_Row_Number,
    (CASE WHEN Gender IS NULL THEN 1 ELSE 0 END
     + CASE WHEN Join_Date IS NULL THEN 1 ELSE 0 END
     + CASE WHEN District='Unknown' THEN 1 ELSE 0 END
     + CASE WHEN Skill_Level='Not Assessed' THEN 1 ELSE 0 END
     + CASE WHEN Base_Salary_BDT IS NULL OR Base_Salary_BDT<=0 THEN 1 ELSE 0 END) AS Cleaning_Flag_Count
FROM ranked
WHERE Duplicate_Rank=1;

DROP VIEW IF EXISTS vw_training_cleaned_from_raw;
CREATE VIEW vw_training_cleaned_from_raw AS
SELECT
    TRIM(Training_Record_ID) AS Training_Record_ID,
    TRIM(Employee_ID) AS Employee_ID,
    UPPER(TRIM(Quarter)) AS Quarter,
    REPLACE(TRIM(Department),'&','and') AS Department,
    TRIM(Course_Name) AS Course_Name,
    TRIM(Training_Category) AS Training_Category,
    CASE
        WHEN LENGTH(TRIM(Training_Date))=10 AND SUBSTR(TRIM(Training_Date),5,1)='-' THEN TRIM(Training_Date)
        WHEN LENGTH(TRIM(Training_Date))=10 AND SUBSTR(TRIM(Training_Date),3,1)='/' THEN
            SUBSTR(TRIM(Training_Date),7,4)||'-'||SUBSTR(TRIM(Training_Date),1,2)||'-'||SUBSTR(TRIM(Training_Date),4,2)
        ELSE NULL
    END AS Training_Date,
    CAST(NULLIF(TRIM(Training_Hours),'') AS REAL) AS Training_Hours,
    CAST(NULLIF(TRIM(Assessment_Score),'') AS REAL) AS Assessment_Score,
    CASE LOWER(TRIM(Completion_Status))
        WHEN 'completed' THEN 'Completed'
        WHEN 'failed' THEN 'Failed'
        WHEN 'in progress' THEN 'In Progress'
        ELSE COALESCE(NULLIF(TRIM(Completion_Status),''),'Unknown')
    END AS Completion_Status,
    TRIM(Certified) AS Certified,
    CAST(REPLACE(REPLACE(LOWER(TRIM(Training_Cost_BDT)),'taka',''),' ','') AS REAL) AS Training_Cost_BDT,
    TRIM(Provider) AS Provider
FROM raw_training_records_messy;

DROP VIEW IF EXISTS vw_production_cleaned_from_raw;
CREATE VIEW vw_production_cleaned_from_raw AS
WITH normalized AS (
    SELECT
        CASE
            WHEN LENGTH(TRIM(Month))=10 AND SUBSTR(TRIM(Month),5,1)='-' THEN TRIM(Month)
            WHEN LENGTH(TRIM(Month))=8 AND SUBSTR(TRIM(Month),4,1)='-' THEN
                SUBSTR(TRIM(Month),5,4)||'-'||
                CASE LOWER(SUBSTR(TRIM(Month),1,3))
                    WHEN 'jan' THEN '01' WHEN 'feb' THEN '02' WHEN 'mar' THEN '03'
                    WHEN 'apr' THEN '04' WHEN 'may' THEN '05' WHEN 'jun' THEN '06'
                    WHEN 'jul' THEN '07' WHEN 'aug' THEN '08' WHEN 'sep' THEN '09'
                    WHEN 'oct' THEN '10' WHEN 'nov' THEN '11' WHEN 'dec' THEN '12'
                END||'-01'
            ELSE NULL
        END AS Month,
        UPPER(TRIM(Quarter)) AS Quarter,
        UPPER(SUBSTR(TRIM(Production_Line),1,1))||SUBSTR(TRIM(Production_Line),2) AS Production_Line,
        CAST(NULLIF(TRIM(Planned_Units),'') AS INTEGER) AS Planned_Units,
        CAST(NULLIF(TRIM(Actual_Units),'') AS INTEGER) AS Actual_Units,
        CASE
            WHEN NULLIF(TRIM(First_Pass_Yield),'') IS NULL THEN NULL
            WHEN INSTR(TRIM(First_Pass_Yield),'%')>0
                THEN CAST(REPLACE(TRIM(First_Pass_Yield),'%','') AS REAL)/100.0
            ELSE CAST(TRIM(First_Pass_Yield) AS REAL)
        END AS First_Pass_Yield_Raw,
        CASE
            WHEN INSTR(TRIM(Defect_Rate),'%')>0
                THEN CAST(REPLACE(TRIM(Defect_Rate),'%','') AS REAL)/100.0
            ELSE CAST(NULLIF(TRIM(Defect_Rate),'') AS REAL)
        END AS Defect_Rate,
        CAST(NULLIF(TRIM(Rework_Rate),'') AS REAL) AS Rework_Rate,
        CAST(NULLIF(TRIM(Scrap_Units),'') AS INTEGER) AS Scrap_Units,
        CAST(NULLIF(TRIM(Customer_Return_Rate),'') AS REAL) AS Customer_Return_Rate,
        CAST(NULLIF(TRIM(Units_per_Labour_Hour),'') AS REAL) AS Units_per_Labour_Hour,
        CAST(NULLIF(TRIM(Production_Headcount),'') AS INTEGER) AS Production_Headcount,
        CAST(NULLIF(TRIM(Downtime_Hours),'') AS REAL) AS Downtime_Hours,
        TRIM(Primary_Constraint) AS Primary_Constraint
    FROM raw_production_metrics_messy
)
SELECT
    Month, Quarter, Production_Line, Planned_Units, Actual_Units,
    COALESCE(First_Pass_Yield_Raw, 1.0-Defect_Rate-(Rework_Rate*0.25)) AS First_Pass_Yield,
    Defect_Rate, Rework_Rate, Scrap_Units, Customer_Return_Rate,
    Units_per_Labour_Hour, Production_Headcount, Downtime_Hours,
    Primary_Constraint,
    CASE WHEN First_Pass_Yield_Raw IS NULL THEN 'Imputed from defect and rework' ELSE 'Source value' END AS FPY_Cleaning_Method
FROM normalized;

DROP VIEW IF EXISTS vw_employee_cleaning_comparison;
CREATE VIEW vw_employee_cleaning_comparison AS
SELECT
    r.rowid AS Raw_Row_Number,
    r.Employee_ID,
    r.Employee_Name AS Raw_Employee_Name,
    c.Employee_Name AS Clean_Employee_Name,
    r.Gender AS Raw_Gender,
    c.Gender AS Clean_Gender,
    r.Department AS Raw_Department,
    c.Department AS Clean_Department,
    r.Join_Date AS Raw_Join_Date,
    c.Join_Date AS Clean_Join_Date,
    r.Base_Salary_BDT AS Raw_Base_Salary,
    c.Base_Salary_BDT AS Clean_Base_Salary,
    c.Cleaning_Flag_Count
FROM raw_employee_master_messy r
LEFT JOIN vw_employee_cleaned_from_raw c
  ON TRIM(r.Employee_ID)=c.Employee_ID;

DROP VIEW IF EXISTS vw_data_quality_issues;
CREATE VIEW vw_data_quality_issues AS
SELECT 'Employee' AS Dataset, Employee_ID AS Record_Key, 'DUPLICATE_KEY' AS Issue_Type,
       'Duplicate Employee_ID found in raw source' AS Issue_Description
FROM raw_employee_master_messy
GROUP BY TRIM(Employee_ID)
HAVING COUNT(*)>1
UNION ALL
SELECT 'Employee', TRIM(Employee_ID), 'MISSING_DISTRICT', 'District is blank'
FROM raw_employee_master_messy WHERE NULLIF(TRIM(District),'') IS NULL
UNION ALL
SELECT 'Employee', TRIM(Employee_ID), 'INVALID_GENDER', 'Gender requires standardization'
FROM raw_employee_master_messy
WHERE LOWER(TRIM(Gender)) NOT IN ('m','male','f','female')
UNION ALL
SELECT 'Employee', Employee_ID, 'INVALID_JOIN_DATE', 'Join date could not be normalized'
FROM vw_employee_cleaned_from_raw WHERE Join_Date IS NULL
UNION ALL
SELECT 'Employee', Employee_ID, 'MISSING_SKILL_LEVEL', 'Skill level was blank and mapped to Not Assessed'
FROM vw_employee_cleaned_from_raw WHERE Skill_Level='Not Assessed'
UNION ALL
SELECT 'Training', Training_Record_ID, 'MISSING_ASSESSMENT', 'Assessment score is blank'
FROM vw_training_cleaned_from_raw WHERE Assessment_Score IS NULL
UNION ALL
SELECT 'Training', Training_Record_ID, 'INVALID_TRAINING_DATE', 'Training date could not be normalized'
FROM vw_training_cleaned_from_raw WHERE Training_Date IS NULL
UNION ALL
SELECT 'Production', Quarter||'-'||Production_Line, 'INVALID_MONTH', 'Month could not be normalized'
FROM vw_production_cleaned_from_raw WHERE Month IS NULL
UNION ALL
SELECT 'Production', Month||'-'||Production_Line, 'RATE_OUT_OF_RANGE', 'A quality rate falls outside 0 to 1'
FROM vw_production_cleaned_from_raw
WHERE First_Pass_Yield NOT BETWEEN 0 AND 1
   OR Defect_Rate NOT BETWEEN 0 AND 1
   OR Rework_Rate NOT BETWEEN 0 AND 1;
