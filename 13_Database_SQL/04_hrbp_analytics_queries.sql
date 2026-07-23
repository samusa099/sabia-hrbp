-- HRBP analytics query library.

-- 1. Workforce bridge
SELECT * FROM vw_bi_workforce_bridge;

-- 2. Department people and workload risk
SELECT *
FROM vw_bi_department_people_summary
ORDER BY Average_Overtime_Hours DESC, Average_Absence_Rate DESC;

-- 3. Critical-skill headcount by department
SELECT Department, Skill_Category, Skill_Level, COUNT(*) AS Active_Employees
FROM employee_master
WHERE Employee_Status='Active' AND Critical_Skill='Yes'
GROUP BY Department, Skill_Category, Skill_Level
ORDER BY Department, Active_Employees DESC;

-- 4. Recruitment funnel by quarter
SELECT * FROM vw_bi_recruitment_quarterly ORDER BY Quarter;

-- 5. Training and certification by quarter
SELECT * FROM vw_bi_training_quarterly ORDER BY Quarter;

-- 6. Performance distribution
SELECT Quarter, Performance_Rating, COUNT(*) AS Employee_Reviews,
       AVG(Overall_Score) AS Average_Score
FROM performance_quarterly
GROUP BY Quarter, Performance_Rating
ORDER BY Quarter, Average_Score DESC;

-- 7. HR service SLA
SELECT Quarter,
       COUNT(*) AS Tickets,
       SUM(CASE WHEN SLA_Met='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) AS SLA_Rate,
       AVG(Resolution_Hours) AS Average_Resolution_Hours,
       AVG(Employee_Satisfaction) AS Employee_Satisfaction
FROM hr_service_tickets
GROUP BY Quarter
ORDER BY Quarter;

-- 8. Employee-relations closure
SELECT Quarter,
       COUNT(*) AS Cases,
       AVG(Closure_Days) AS Average_Closure_Days,
       SUM(CASE WHEN Closed_Within_SLA='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) AS Closed_Within_SLA_Rate
FROM employee_relations_cases
GROUP BY Quarter
ORDER BY Quarter;

-- 9. Layoff savings versus knowledge risk
SELECT Department,
       COUNT(*) AS Roles_Reset,
       SUM(Estimated_Annual_Cost_Saving_BDT) AS Annualized_Saving_BDT,
       SUM(Separation_Benefit_BDT) AS Separation_Benefit_BDT,
       SUM(CASE WHEN Critical_Knowledge_Risk='High' THEN 1 ELSE 0 END) AS High_Knowledge_Risk_Roles
FROM layoff_and_restructuring
GROUP BY Department
ORDER BY Annualized_Saving_BDT DESC;
