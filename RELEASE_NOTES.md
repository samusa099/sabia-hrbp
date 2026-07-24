# Release Notes

## 2026-07-24 — Repository cleanup and documentation upgrade

### Removed

The following obsolete publishing helper scripts were removed from the repository root:

- `PUBLISH_TO_GITHUB_WITH_GH.bat`
- `PUBLISH_TO_GITHUB_WITH_GH.sh`
- `PUSH_TO_EXISTING_GITHUB_REPO.bat`
- `PUSH_TO_EXISTING_GITHUB_REPO.sh`

These files were no longer required because the repository is already published and maintained through the normal GitHub workflow.

### Documentation improvements

- Added a concise dataset-use summary to `README.md`.
- Added the detailed `DATASET_USAGE_GUIDE.md` with practical use cases, calculation examples, tool-specific workflows, and responsible-use guidance.
- Added Mermaid diagrams to the repository structure, contribution workflow, and code of conduct.
- Standardized the portfolio author name as **Musa**.

### Project structure

- Preserved the existing analytics, dataset, workbook, notebook, SQL, Power BI, and documentation folders.
- No analytical data, business logic, project workbook, database, or notebook content was removed in this cleanup.

### Current publishing approach

Use standard Git commands for repository updates:

```bash
git add .
git commit -m "Describe the update"
git push origin main
```

For Kaggle publishing, use the maintained metadata and notebook assets under `10_Kaggle/` or the structured `KAGGLE_PACKAGE/` directory.
