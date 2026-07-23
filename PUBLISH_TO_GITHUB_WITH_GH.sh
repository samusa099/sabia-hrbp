#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

command -v git >/dev/null || { echo "Git is required."; exit 1; }
command -v gh >/dev/null || { echo "GitHub CLI is required: https://cli.github.com/"; exit 1; }

REPO_NAME="${1:-sabia-hrbp}"

gh auth status >/dev/null 2>&1 || gh auth login

if [ ! -d .git ]; then
  git init
fi

git add .
if ! git diff --cached --quiet; then
  git commit -m "Initial release: Sabia Group HRBP analytics project"
fi
git branch -M main

gh repo create "$REPO_NAME" --public --source=. --remote=origin --push
echo "GitHub publishing completed."
