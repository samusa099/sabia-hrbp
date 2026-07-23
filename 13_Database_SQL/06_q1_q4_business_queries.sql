-- Q1 to Q4 business recovery queries.

-- Q1: scenario comparison
SELECT *
FROM workforce_scenarios
ORDER BY Annual_Operating_Profit_BDT_M DESC;

-- Q2: pilot versus control
SELECT *
FROM vw_bi_pilot_vs_control
ORDER BY Metric;

-- Q3: scale recruitment and production
SELECT r.*, q.Actual_Units, q.First_Pass_Yield, q.Defect_Rate, q.Units_per_Labour_Hour
FROM vw_bi_recruitment_quarterly r
LEFT JOIN vw_bi_quarterly_business_summary q USING(Quarter)
WHERE r.Quarter='Q3';

-- Q4: full enterprise results
SELECT *
FROM vw_bi_quarterly_business_summary
WHERE Quarter='Q4';

-- Complete recovery story
SELECT *
FROM vw_bi_quarterly_business_summary
ORDER BY Quarter;

-- Month in which operating profit first became positive
SELECT Month, Operating_Profit_BDT_Million
FROM financial_impact_monthly
WHERE Operating_Profit_BDT_Million>0
ORDER BY Month
LIMIT 1;

-- HR pillar progression
SELECT *
FROM vw_bi_pillar_maturity_long
ORDER BY Pillar, Quarter;
