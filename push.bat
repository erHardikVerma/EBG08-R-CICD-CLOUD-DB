@echo off
:: Delegate to PowerShell immediately — cmd.exe has a known conflict
:: with the OneDrive file watcher that blocks git operations.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0push.ps1"
pause
