@echo off
echo =========================================
echo 🚀 Pushing Code to GitHub...
echo =========================================

git init
git remote remove origin 2>nul
git remote add origin https://github.com/erHardikVerma/EBG08-R-CICD-CLOUD-DB.git
git add .
git commit -m "Auto-commit: Saved project memory and backend logic"
git branch -M main
git pull --rebase origin main
git push -u origin main

echo =========================================
echo ✅ Push Complete!
echo =========================================
