@echo off
chcp 65001 >nul
echo ==================================================
echo   EBG08 - GitHub Auto Deploy
echo ==================================================
echo.

:: Stage all changes
git add .

:: Commit (skip if nothing changed)
git diff --cached --quiet
if %errorlevel% neq 0 (
    git commit -m "update"
    echo [OK] Changes committed.
) else (
    echo [SKIP] No new changes to commit.
)

:: Pull latest (handles heartbeat commits from GitHub Actions)
echo.
echo Pulling latest changes...
git pull --rebase origin main

:: Push
echo Pushing to GitHub...
git push origin main

echo.
echo ==================================================
echo  [SUCCESS] CODE PUSHED TO GITHUB!
echo ==================================================
echo.
