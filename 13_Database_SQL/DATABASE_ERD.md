# Database Relationship Map

```mermaid
erDiagram
    COMPANY_ENTITIES ||--o{ FACILITIES : contains
    FACILITIES ||--o{ EMPLOYEE_MASTER : employs
    DEPARTMENTS ||--o{ EMPLOYEE_MASTER : groups
    EMPLOYEE_MASTER ||--o{ TRAINING_RECORDS : attends
    EMPLOYEE_MASTER ||--o{ PERFORMANCE_QUARTERLY : receives
    EMPLOYEE_MASTER ||--o{ LAYOFF_AND_RESTRUCTURING : affected_by
    EMPLOYEE_MASTER ||--o{ OTHER_EMPLOYEE_EXITS : exits
    DEPARTMENTS ||--o{ ATTENDANCE_MONTHLY : reports
    RECRUITMENT_FUNNEL }o--|| DEPARTMENTS : hires_for
    PRODUCTION_MONTHLY }o--|| DIM_DATE : occurs_on
    FINANCIAL_IMPACT_MONTHLY }o--|| DIM_DATE : occurs_on
    TECHNOLOGY_ADOPTION }o--|| DIM_DATE : occurs_on
    HR_SERVICE_TICKETS }o--|| DIM_DATE : occurs_on
```

## Reporting layer

`vw_bi_` views reduce modelling effort for portfolio dashboards:

- `vw_bi_quarterly_business_summary`
- `vw_bi_production_finance_monthly`
- `vw_bi_workforce_bridge`
- `vw_bi_kpi_scorecard_long`
- `vw_bi_pillar_maturity_long`
- `vw_bi_recruitment_quarterly`
- `vw_bi_training_quarterly`
- `vw_bi_department_people_summary`
- `vw_bi_pilot_vs_control`

For a proper star schema, use `dim_date`, employee/department/entity dimensions and the original fact tables instead of only the flattened views.
