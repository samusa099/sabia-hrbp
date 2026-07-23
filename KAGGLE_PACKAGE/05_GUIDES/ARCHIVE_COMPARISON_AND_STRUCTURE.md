# Archive Comparison and Final Structure Decision

## Archive 1 — Kaggle package

**Strengths**
- Small and focused
- Contains the main CSV datasets, notebook, database, Excel master file, and Kaggle metadata
- Easy to upload

**Weaknesses**
- All files are placed in one flat root
- Raw data, reference tables, clean data, and project files are mixed together
- Users must search through many files to find the workbook, notebook, or database

## Archive 2 — GitHub repository export

**Strengths**
- Better subject-based folder organization
- Q1–Q4 project phases are separated
- Raw data, clean data, Python, Power BI, SQL, documentation, and Wiki assets are clearly grouped

**Weaknesses**
- Contains many publishing, repository-management, preview, and developer files
- Too large and complex for a clean Kaggle download package
- Includes duplicated snapshots and repeated datasets

## Final decision

The final package follows a **hybrid structure**:

- The **GitHub archive provides the folder-organization model**.
- The **Kaggle archive provides the compact set of publishable project files**.
- Duplicate snapshots, Git scripts, workflows, Wiki files, preview images, and repository-management files are excluded.
- Existing GitHub content is not modified.

## Data comparison result

The CSV files shared by both archives have the same columns, row counts, and data values. Their file hashes differ mainly because of text encoding and line-ending differences. The published Kaggle CSV versions were retained in the final package to keep Kaggle continuity.

## Final archive structure

```text
Sabia_Group_HRBP_Analytics_Package/
├── dataset-metadata.json
├── README.md
├── 01_REFERENCE_DATA/
├── 02_RAW_DATA/
├── 03_CLEAN_DATA/
│   ├── 01_WORKFORCE/
│   ├── 02_TALENT_AND_HR_OPERATIONS/
│   ├── 03_PRODUCTION_AND_FINANCE/
│   └── 04_STRATEGY_AND_RECOVERY/
├── 04_PROJECT_FILES/
│   ├── 01_EXCEL/
│   ├── 02_DATABASE/
│   └── 03_NOTEBOOK/
└── 05_GUIDES/
```
