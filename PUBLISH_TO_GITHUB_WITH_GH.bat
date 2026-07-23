@echo off
setlocal
cd /d "%~dp0"

where git >nul 2>nul || (
  echo Git is not installed or not in PATH.
  pause
  exit /b 1
)

where gh >nul 2>nul || (
  echo GitHub CLI ^(gh^) is not installed or not in PATH.
  echo Install it from https://cli.github.com/
  pause
  exit /b 1
)

set /p REPO_NAME=GitHub repository name [sabia-hrbp]:
if "%REPO_NAME%"=="" set REPO_NAME=sabia-hrbp

gh auth status >nul 2>nul || gh auth login

if not exist ".git" git init
git add .
git diff --cached --quiet || git commit -m "Initial release: Sabia Group HRBP analytics project"
git branch -M main

gh repo create "%REPO_NAME%" --public --source=. --remote=origin --push
if errorlevel 1 (
  echo.
  echo Publish failed. The repository may already exist or authentication may be incomplete.
  pause
  exit /b 1
)

echo.
echo GitHub publishing completed.
pause
