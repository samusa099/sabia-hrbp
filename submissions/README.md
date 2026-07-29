# 📥 Participant Submissions

Participant work must be submitted through a fork and pull request.

```text
submissions/
└── <github-username>/
    └── <submission-id>/
        ├── README.md
        ├── report.pdf
        ├── analysis.ipynb   # optional
        └── dashboard.png    # optional
```

## Workflow

```mermaid
flowchart LR
    A[Fork repository] --> B[Create submission branch]
    B --> C[Add files under own submission path]
    C --> D[Open pull request]
    D --> E[Automated scope validation]
    E --> F[Maintainer review]
    F --> G[Accepted, revision required or not eligible]
```

Direct writes to the main repository are not part of the participant workflow. Read `case-study/SUBMISSION_REQUIREMENTS.md` before preparing files.