@echo off
title Actualizacion de Parche de Vulnerabilidades
echo --------------------------------------------------------------------
echo Actualizando parches de Vulnerabilidades:
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/Vulnerabilidades.markdown" -OutFile "C:\TI\Vulnerabilidades.bat"
pause
cls
C:\TI\Vulnerabilidades.bat