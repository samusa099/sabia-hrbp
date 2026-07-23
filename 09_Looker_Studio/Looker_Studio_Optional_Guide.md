# Optional Looker Studio Setup

The project is Power BI-first, but the clean CSV files are also Looker Studio-ready.

Recommended sources:
- quarterly_scorecard.csv
- financial_impact_monthly.csv
- production_monthly.csv
- attendance_monthly.csv
- technology_adoption.csv

Recommended calculated fields:
- Profit Margin = Operating_Profit_BDT_Million / Revenue_BDT_Million
- HRIS Adoption % = HRIS_Adoption_Rate
- Quality Loss % = Defect_Rate + Rework_Rate
- Output per Head = Actual_Units / Production_Headcount
- SLA % = SUM(CASE WHEN SLA_Met = "Yes" THEN 1 ELSE 0 END) / COUNT(Ticket_ID)

Use Google Sheets as an optional staging layer if direct CSV refresh is inconvenient.
