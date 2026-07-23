# সাবিয়া গ্রুপ HRBP Smartwatch Recovery Project — বাংলা গাইড

## প্রজেক্টের মূল গল্প
সাবিয়া গ্রুপ MVP বা prototype যাচাই না করেই Made-in-Bangladesh smartwatch-এর full production শুরু করেছিল। ফলে defect, rework, overtime, skill mismatch এবং operating loss বেড়ে যায়। ব্যবসাটি বিক্রি করার ঝুঁকি তৈরি হলে একজন strategic HRBP নিয়োগ দেওয়া হয়, যিনি একই সঙ্গে Head of HR / Acting CHRO ভূমিকা পালন করেন।

## Headcount story
- Baseline: 100 জন
- Q1 role-based workforce reset: 48 জন
- Q1 শেষে: 52 জন
- Q2 pilot ও critical hiring শেষে: 70 জন
- Q3 scale শেষে: 99 জন
- Q4 enterprise rollout শেষে: 114 জন

## Quarter workflow
### Q1
Feasibility study, KPI design, four scenarios, risk review, ethical restructuring এবং 25-person pilot approval।

### Q2
Line A-তে test-versus-control pilot, technical certification, quality-at-source, supervisor check-in, HR service SLA এবং HRIS self-service।

### Q3
Line A ও B-তে scale, critical-skill hiring, manager dashboard, recognition এবং weekly HR-business review।

### Q4
Group-wide rollout, integrated HR-production-finance analytics, benefits realization এবং final board approval।

## Excel থেকে কী করবেন
1. `00_Master/Sabia_Group_HRBP_Analytics_Master_2026.xlsx` খুলুন।
2. Executive Dashboard থেকে story বুঝুন।
3. KPI Scorecard ও Pillar Maturity sheet-এ Q1–Q4 progression দেখুন।
4. Employee Master, Recruitment, Training, Performance, Production ও Financial Impact sheet ব্যবহার করে PivotTable, Power Query এবং charts অনুশীলন করুন।
5. Formula columns edit করে scenario modelling করুন।

## Python থেকে কী করবেন
1. `07_Python/requirements.txt` install করুন।
2. `clean_and_validate.py` চালিয়ে deliberately messy raw data clean করুন।
3. `eda_hrbp_recovery.py` চালিয়ে summary tables ও chart তৈরি করুন।
4. Generated output-এর সাথে `06_Clean_Data` compare করুন।

## Power BI থেকে কী করবেন
1. `06_Clean_Data` folder-কে Folder connector দিয়ে load করুন।
2. `08_PowerBI/model_relationships.csv` অনুযায়ী relationship তৈরি করুন।
3. `DAX_Measures_and_Report_Pages.md` থেকে measures ব্যবহার করুন।
4. Executive, Workforce, Talent, Operations এবং Financial pages তৈরি করুন।

## গুরুত্বপূর্ণ
সব তথ্য synthetic demo data। বাস্তব employee decision নেওয়ার জন্য ব্যবহার করা যাবে না।


## Database ও SQL থেকে কী করবেন
1. `13_Database_SQL/Sabia_Group_HRBP_Analytics.sqlite` DB Browser for SQLite, DBeaver বা SQLiteStudio-তে খুলুন।
2. `02_data_cleaning_queries.sql` চালিয়ে raw-versus-clean records দেখুন।
3. `03_data_quality_audit.sql` দিয়ে duplicate, missing এবং invalid values audit করুন।
4. `04_hrbp_analytics_queries.sql` দিয়ে HRBP business queries চালান।
5. `vw_bi_` views Power BI, Excel Power Query অথবা CSV export-এর জন্য ব্যবহার করুন।
6. Database rebuild করতে `python 13_Database_SQL/00_build_database.py` চালান।
