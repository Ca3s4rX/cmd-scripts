REM This code used for renaming all files in your project, from .html to .php
for /r %f in (*.html) do ren "%f" "%~nf.php"

REM This code used for replacing any .html to .php in the content of a file, Amazing when u download an html template and wants to convert it to php
for /r %f in (*.php) do powershell -Command "(Get-Content '%f') -replace '\.html', '.php' | Set-Content '%f'"
