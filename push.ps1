Set-Location $PSScriptRoot

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "  EBG08 - GitHub Auto Deploy" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""

# Show current changes
Write-Host " Checking for changes..." -ForegroundColor Yellow
git status -s
Write-Host ""

# Stage everything
Write-Host " Staging changes..." -ForegroundColor Yellow
git add -A
if ($LASTEXITCODE -ne 0) {
    Write-Host " [ERROR] git add failed!" -ForegroundColor Red
    exit 1
}

# Commit (skip if nothing to commit)
git diff --cached --quiet
if ($LASTEXITCODE -ne 0) {
    git commit -m "update"
    if ($LASTEXITCODE -ne 0) {
        Write-Host " [ERROR] git commit failed!" -ForegroundColor Red
        exit 1
    }
    Write-Host " [OK] Changes committed." -ForegroundColor Green
}
else {
    Write-Host " [SKIP] No new changes to commit." -ForegroundColor DarkGray
}

# Pull latest (handles heartbeat commits from GitHub Actions)
Write-Host ""
Write-Host " Pulling latest changes (rebase)..." -ForegroundColor Yellow
git pull --rebase origin main

# Push
Write-Host " Pushing to GitHub..." -ForegroundColor Yellow
git push origin main
if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host " [ERROR] git push failed!" -ForegroundColor Red
    Write-Host "  Possible causes:" -ForegroundColor DarkGray
    Write-Host "    - No internet connection" -ForegroundColor DarkGray
    Write-Host "    - GitHub credentials expired" -ForegroundColor DarkGray
    Write-Host "    - Remote has newer changes" -ForegroundColor DarkGray
    exit 1
}

Write-Host ""
Write-Host "==================================================" -ForegroundColor Green
Write-Host " [SUCCESS] CODE PUSHED TO GITHUB!" -ForegroundColor Green
Write-Host " Repo: https://github.com/erHardikVerma/EBG08-R-CICD-CLOUD-DB" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Green

#try1