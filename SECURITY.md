# Security and Privacy

This repository contains synthetic portfolio data only. No real employee, medical, payroll, credential, or confidential organizational information should be committed.

## Supported version

Security fixes are applied to the latest state of the `main` branch.

## Report a vulnerability

Report suspected credential exposure, unsafe workflow behavior, dependency risk, personal-data exposure, or other security concerns privately to the repository owner. Do not publish secrets, exploit details, or personal data in a public issue.

Include:

- affected file or workflow;
- clear reproduction steps;
- expected and observed behavior;
- potential impact;
- recommended remediation, when known.

## Prohibited content

Do not commit:

- Kaggle API tokens or `kaggle.json` credentials;
- GitHub tokens, cloud keys, passwords, or connection strings;
- `.env` files or local credential stores;
- real employee or applicant records;
- confidential organizational data;
- personal identifiers, medical information, or unrestricted payroll data;
- untrusted executable files or macros presented as safe project assets.

## Repository protections

The repository uses:

- least-privilege GitHub Actions permissions;
- automated validation on pushes and pull requests;
- CodeQL analysis for Python;
- Dependabot updates for Python and GitHub Actions;
- CODEOWNERS coverage for security-sensitive files and analytics code.

## Response process

1. Confirm and classify the report.
2. Remove exposed credentials or personal data immediately.
3. Rotate affected credentials outside GitHub.
4. Patch vulnerable code, configuration, or dependencies.
5. Validate the repository and relevant workflows.
6. Document the remediation without exposing sensitive details.
7. Close the report only after verification.

Historical secrets must be removed from Git history before further distribution. A normal file deletion does not remove secrets from earlier commits.
