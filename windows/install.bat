:: PATH-ADD - add a path to user env var

@echo off
:: first command line argument is always location of exe
pushd %~dp0

:: get the user path variable (not system)
for /f "delims=" %%a in ('powershell -NoProfile -Command "(Get-ItemProperty HKCU:\Environment).PATH"') do set UserPath=%%a

:: set the user path variable
setx "Path" "%~dp0bin;%UserPath%"

popd
