@echo off
setlocal
cd /d "%~dp0"

set /p REMOTE_URL=Paste the empty GitHub repository URL:
if "%REMOTE_URL%"=="" (
  echo A remote URL is required.
  pause
  exit /b 1
)

if not exist ".git" git init
git add .
git diff --cached --quiet || git commit -m "Initial release: Sabia Group HRBP analytics project"
git branch -M main

git remote get-url origin >nul 2>nul
if errorlevel 1 (
  git remote add origin "%REMOTE_URL%"
) else (
  git remote set-url origin "%REMOTE_URL%"
)

git push -u origin main
pause
