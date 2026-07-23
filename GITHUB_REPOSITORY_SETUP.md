# Direct GitHub Publishing Guide

## Fastest route: GitHub CLI

Open a terminal inside this extracted repository and run:

```bash
gh auth login
git init
git add .
git commit -m "Initial release: Sabia Group HRBP analytics project"
git branch -M main
gh repo create sabia-hrbp --public --source=. --remote=origin --push
```

Alternatively, run one of the supplied scripts:

- Windows: `PUBLISH_TO_GITHUB_WITH_GH.bat`
- Linux/macOS: `./PUBLISH_TO_GITHUB_WITH_GH.sh`

## Existing empty GitHub repository

```bash
git init
git add .
git commit -m "Initial release"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
git push -u origin main
```

The repository intentionally excludes credentials, temporary SQLite files,
Python caches, and locally generated archives through `.gitignore`.
