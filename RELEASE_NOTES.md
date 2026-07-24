# Release Notes

## v1.1.0 — 2026-07-24 — Power BI publication and security hardening

### 📊 Power BI project update

- Added the Power BI project file to the repository release scope.
- Confirmed the Power BI area remains part of the maintained analytics package under `08_PowerBI/`.
- Updated release documentation so users can identify the Power BI asset alongside Excel, Python, SQL, SQLite, and Kaggle resources.
- Preserved the supporting model, DAX, relationship, dashboard, and usage guidance already included in the repository.

### 🔐 Security and code protection

- Added `.github/CODEOWNERS` to protect security-sensitive configuration, analytics code, BI assets, and release documentation through explicit ownership.
- Added `.github/dependabot.yml` for weekly Python and GitHub Actions dependency updates.
- Added `.github/workflows/codeql.yml` for automated Python CodeQL analysis on pushes, pull requests, and a weekly schedule.
- Hardened `.github/workflows/validate-project.yml` with least-privilege permissions, dependency caching, concurrency control, and a job timeout.
- Expanded `SECURITY.md` with a private-reporting process, prohibited-content rules, remediation steps, and credential-history guidance.
- Reviewed open repository issues for vulnerability or security cases; no open vulnerability case was found at the time of this release.

### ✅ Vulnerability review status

The repository-level vulnerability review is closed as **completed** for this release. No confirmed open vulnerability issue was present in the accessible issue tracker. Automated checks remain active for future dependency, workflow, and Python-code findings.

### 🧹 Repository cleanup

The following obsolete publishing helper scripts were removed:

- `PUBLISH_TO_GITHUB_WITH_GH.bat`
- `PUBLISH_TO_GITHUB_WITH_GH.sh`
- `PUSH_TO_EXISTING_GITHUB_REPO.bat`
- `PUSH_TO_EXISTING_GITHUB_REPO.sh`

### 📚 Documentation improvements

- Added a concise dataset-use summary to `README.md`.
- Added `DATASET_USAGE_GUIDE.md` with use cases, calculations, and tool-specific workflows.
- Added Mermaid diagrams to repository structure, contribution guidance, and the code of conduct.
- Standardized the portfolio author name as **Musa**.

---

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
