#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

REMOTE_URL="${1:-}"
if [ -z "$REMOTE_URL" ]; then
  read -r -p "Paste the empty GitHub repository URL: " REMOTE_URL
fi

[ -n "$REMOTE_URL" ] || { echo "A remote URL is required."; exit 1; }

[ -d .git ] || git init
git add .
if ! git diff --cached --quiet; then
  git commit -m "Initial release: Sabia Group HRBP analytics project"
fi
git branch -M main

if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$REMOTE_URL"
else
  git remote add origin "$REMOTE_URL"
fi

git push -u origin main
