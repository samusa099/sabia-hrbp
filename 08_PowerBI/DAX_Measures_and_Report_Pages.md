# Recommended Power BI DAX Measures

```DAX
Active Headcount =
VAR AsOfDate = MAX('Date'[Date])
RETURN
CALCULATE(
    DISTINCTCOUNT(Employee_Master[Employee_ID]),
    Employee_Master[Join_Date] <= AsOfDate,
    OR(
        ISBLANK(Employee_Master[Exit_Date]),
        Employee_Master[Exit_Date] > AsOfDate
    )
)

Layoff Count =
CALCULATE(
    COUNTROWS(Layoff_and_Restructuring),
    Layoff_and_Restructuring[Ethical_Review_Status] = "Reviewed"
)

Annualized Cost Saving =
SUM(Layoff_and_Restructuring[Estimated_Annual_Cost_Saving_BDT])

Offer Acceptance Rate =
DIVIDE(
    SUM(Recruitment_Funnel[Offers_Accepted]),
    SUM(Recruitment_Funnel[Offers_Made])
)

Average Time to Fill =
AVERAGE(Recruitment_Funnel[Time_to_Fill_Days])

Training Completion Rate =
DIVIDE(
    CALCULATE(COUNTROWS(Training_Records), Training_Records[Completion_Status] = "Completed"),
    COUNTROWS(Training_Records)
)

Certification Rate =
DIVIDE(
    CALCULATE(COUNTROWS(Training_Records), Training_Records[Certified] = "Yes"),
    COUNTROWS(Training_Records)
)

Performance Review Completion =
DIVIDE(
    CALCULATE(COUNTROWS(Performance_Quarterly), Performance_Quarterly[Manager_Checkin_Completed] = "Yes"),
    COUNTROWS(Performance_Quarterly)
)

First Pass Yield =
DIVIDE(
    SUMX(Production_Monthly, Production_Monthly[Actual_Units] * Production_Monthly[First_Pass_Yield]),
    SUM(Production_Monthly[Actual_Units])
)

Defect Rate =
DIVIDE(
    SUMX(Production_Monthly, Production_Monthly[Actual_Units] * Production_Monthly[Defect_Rate]),
    SUM(Production_Monthly[Actual_Units])
)

Operating Profit =
SUM(Financial_Impact_Monthly[Operating_Profit_BDT_Million])

Cumulative Operating Profit =
CALCULATE(
    [Operating Profit],
    FILTER(ALLSELECTED('Date'[Date]), 'Date'[Date] <= MAX('Date'[Date]))
)

HRIS Adoption =
AVERAGE(Technology_Adoption[HRIS_Adoption_Rate])

HR Service SLA =
DIVIDE(
    CALCULATE(COUNTROWS(HR_Service_Tickets), HR_Service_Tickets[SLA_Met] = "Yes"),
    COUNTROWS(HR_Service_Tickets)
)
```

## Suggested report pages
1. Executive Recovery Story
2. Workforce Reset and Risk
3. Talent Acquisition and Critical Skills
4. Learning, Performance and Recognition
5. Employee Services, ER and HR Technology
6. Production Quality and Productivity
7. Financial Benefits Realization
8. Data Quality and Methodology
