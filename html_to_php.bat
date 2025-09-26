@echo off
echo  ============================================================
echo | Converting all .html files to .php and updating references |
echo  ============================================================
echo.

REM Step 1: Rename .html files to .php
for /r %%f in (*.html) do (
    echo [RENAMING] %%~nxf  ^>  %%~nf.php
    ren "%%f" "%%~nf.php"
)

echo.
REM Step 2: Replace ".html" with ".php" inside .php files
for /r %%f in (*.php) do (
    echo [UPDATING] %%~nxf
    powershell -Command "(Get-Content '%%f') -replace '\.html', '.php' | Set-Content '%%f'"
)

echo.
echo  ===================================================
echo | Conversion complete! All .html files are now .php |
echo  ===================================================
pause
