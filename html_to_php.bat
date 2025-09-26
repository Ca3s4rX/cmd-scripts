@echo off

REM ==================================================
REM This script converts all .html files in the project
REM 1. Renames .html files to .php
REM 2. Replaces .html references inside files with .php
REM ==================================================

REM Step 1: Rename all .html files to .php (recursively)
for /r %%f in (*.html) do ren "%%f" "%%~nf.php"

REM Step 2: Replace ".html" with ".php" inside all .php files (recursively)
for /r %%f in (*.php) do powershell -Command ^
    "(Get-Content '%%f') -replace '\.html', '.php' | Set-Content '%%f'"

echo Done! All .html files converted to .php and references updated.
pause
