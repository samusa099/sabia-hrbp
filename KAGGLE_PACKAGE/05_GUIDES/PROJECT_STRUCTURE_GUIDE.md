# Project Structure Guide

## Reference data

Use `01_REFERENCE_DATA/` first to understand the company entities, departments, facilities, HR pillars, and table definitions.

## Raw data

Use `02_RAW_DATA/` for cleaning exercises. These files intentionally contain formatting, date, duplicate, or text-quality issues.

## Clean data

The clean datasets are grouped by analytical purpose:

- `01_WORKFORCE/`
- `02_TALENT_AND_HR_OPERATIONS/`
- `03_PRODUCTION_AND_FINANCE/`
- `04_STRATEGY_AND_RECOVERY/`

## Project files

- `01_EXCEL/` — master workbook and Q1–Q4 workbooks
- `02_DATABASE/` — ready-to-open SQLite database
- `03_NOTEBOOK/` — Jupyter notebook and Kaggle kernel metadata

## Kaggle metadata

`dataset-metadata.json` remains at the package root because Kaggle CLI expects the metadata file in the upload directory. Its resource paths match the folder structure in this archive.
