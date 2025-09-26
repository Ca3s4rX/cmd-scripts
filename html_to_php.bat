@echo off
setlocal EnableDelayedExpansion

REM === Configuration ===
REM Set DRYRUN=1 to preview actions without making changes
set "DRYRUN=0"

echo ============================================================
echo Converting all .html files to .php and updating references
echo ============================================================
echo.

set "renamed=0"
set "updated=0"

REM ---------- Step 1: Rename .html -> .php (recursively) ----------
for /r %%f in (*.html) do (
    echo [RENAMING] "%%~nxf" -> "%%~nf.php"
    if "%DRYRUN%"=="1" (
        REM dry-run: do not actually rename
    ) else (
        ren "%%f" "%%~nf.php"
        if errorlevel 1 (
            echo    [ERROR] Failed to rename "%%f"
        ) else (
            set /a renamed+=1
        )
    )
)

echo.
REM ---------- Step 2: Replace ".html" with ".php" inside .php files ----------
for /r %%f in (*.php) do (
    echo [UPDATING] "%%~nxf"
    if "%DRYRUN%"=="1" (
        REM dry-run: do not modify files
    ) else (
        powershell -NoProfile -ExecutionPolicy Bypass -Command ^
          "(Get-Content -Raw -LiteralPath '%%f') -replace '\.html','.php' | Set-Content -LiteralPath '%%f'"
        if errorlevel 1 (
            echo    [ERROR] Failed to update "%%f"
        ) else (
            set /a updated+=1
        )
    )
)

echo.
echo ============================================================
echo Renamed files : !renamed!
echo Updated files : !updated!
echo ============================================================
if "%DRYRUN%"=="1" (
    echo NOTE: DRY RUN mode - no changes were written. Set DRYRUN=0 to apply changes.
)
pause
endlocal
