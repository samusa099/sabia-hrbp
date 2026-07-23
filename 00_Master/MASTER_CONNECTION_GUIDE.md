# Master Workbook Connection Guide

The master workbook and quarter workbooks are portable project files.

## Recommended refresh architecture
1. Keep the folder structure unchanged.
2. In Excel Power Query, choose **Data > Get Data > From File > From Folder**.
3. Select `06_Clean_Data`.
4. Filter by CSV name and load each table using the file names listed in the `Data Sources` sheet.
5. For Python, use paths relative to the script folder as shown in `07_Python`.
6. In Power BI, use the same Folder connector and apply the relationships supplied in `08_PowerBI`.

## Quarter folders
- Q1 files provide feasibility, scenarios, restructuring and risk evidence.
- Q2 files provide pilot participants, training and test-control outcomes.
- Q3 files provide scale recruitment, production and performance evidence.
- Q4 files provide enterprise maturity, technology and benefits-realization evidence.

The master workbook is already populated with a static snapshot so it opens without refresh.


## SQLite database route

The enhanced package also contains:

`../13_Database_SQL/Sabia_Group_HRBP_Analytics.sqlite`

Use it in DB Browser/DBeaver for SQL practice. For Power BI or Excel, configure an appropriate ODBC DSN and load the `vw_bi_` reporting views, or use the supplied Python loader. Detailed steps are in:

`../08_PowerBI/POWER_BI_AND_OTHER_BI_USAGE_GUIDE.md`
