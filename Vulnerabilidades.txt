@echo off
title Corrección de Vulnerabilidades
echo --------------------------------------------------------------------
echo Lista de Correcciones para aplicar
echo --------------------------------------------------------------------
echo - GLPI Server URL,7zip, GLPI Agent, VLC, FCVPN y W11
echo --------------------------------------------------------------------
pause
cls
echo --------------------------------------------------------------------
echo Comenzando Descarga y Actualizacion
echo --------------------------------------------------------------------
echo GLPI Server URL
powershell -Command Invoke-WebRequest -Uri "https://github.com/soporte-dg/parches/raw/refs/heads/main/GLPI_SVR_Link.reg" -OutFile "C:\TI\Regedit\GLPI_SVR_Link.reg"
reg import C:\TI\Regedit\GLPI_SVR_Link.reg
echo --------------------------------------------------------------------
echo
echo Si solo vas a actualizar la URL del GLPI, puedes cerrar el bat aquí.
echo
echo Si vas a corregir las vulnerabilidades
pause
cls
echo --------------------------------------------------------------------
echo 7Zip
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://github.com/soporte-dg/parches/raw/refs/heads/main/7zip-x64.msi" -OutFile "C:\TI\7zip-x64.msi"
msiexec /i C:\TI\7zip-x64.msi /quiet
echo --------------------------------------------------------------------
echo GLPI
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://github.com/soporte-dg/parches/raw/refs/heads/main/GLPI-Agent.msi" -OutFile "C:\TI\GLPI-Agent.msi"
msiexec /i C:\TI\GLPI-Agent.msi /quiet SERVER="https://glpi.sisadem.com/front/inventory.php"
echo --------------------------------------------------------------------
echo VLC
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://southfront.mm.fcix.net/videolan-ftp/vlc/3.0.23/win64/vlc-3.0.23-win64.msi" -OutFile "C:\TI\vlc-win64.msi"
msiexec /i C:\TI\vlc-win64.msi /quiet
echo --------------------------------------------------------------------
echo W11
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://github.com/soporte-dg/parches/raw/refs/heads/main/WPCHCS.msi" -OutFile "C:\TI\WPCHCS.msi"
msiexec /i C:\TI\WPCHCS.msi
powershell -Command Invoke-WebRequest -Uri "https://github.com/soporte-dg/parches/raw/refs/heads/main/W11IA.exe" -OutFile "C:\TI\W11IA.exe"
"C:\TI\W11IA.exe"
pause
cls
echo --------------------------------------------------------------------
echo FCVPN Parte 01 de 17
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/FCVPN.7z.001" -OutFile "C:\TI\FCVPN.7z.001"
cls
echo --------------------------------------------------------------------
echo FCVPN Parte 02 de 17
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/FCVPN.7z.002" -OutFile "C:\TI\FCVPN.7z.002"
cls
echo --------------------------------------------------------------------
echo FCVPN Parte 03 de 17
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/FCVPN.7z.003" -OutFile "C:\TI\FCVPN.7z.003"
cls
echo --------------------------------------------------------------------
echo FCVPN Parte 04 de 17
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/FCVPN.7z.004" -OutFile "C:\TI\FCVPN.7z.004"
cls
echo --------------------------------------------------------------------
echo FCVPN Parte 05 de 17
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/FCVPN.7z.005" -OutFile "C:\TI\FCVPN.7z.005"
cls
echo --------------------------------------------------------------------
echo FCVPN Parte 06 de 17
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/FCVPN.7z.006" -OutFile "C:\TI\FCVPN.7z.006"
cls
echo --------------------------------------------------------------------
echo FCVPN Parte 07 de 17
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/FCVPN.7z.007" -OutFile "C:\TI\FCVPN.7z.007"
cls
echo --------------------------------------------------------------------
echo FCVPN Parte 08 de 17
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/FCVPN.7z.008" -OutFile "C:\TI\FCVPN.7z.008"
cls
echo --------------------------------------------------------------------
echo FCVPN Parte 09 de 17
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/FCVPN.7z.009" -OutFile "C:\TI\FCVPN.7z.009"
cls
echo --------------------------------------------------------------------
echo FCVPN Parte 10 de 17
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/FCVPN.7z.010" -OutFile "C:\TI\FCVPN.7z.010"
cls
echo --------------------------------------------------------------------
echo FCVPN Parte 11 de 17
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/FCVPN.7z.011" -OutFile "C:\TI\FCVPN.7z.011"
cls
echo --------------------------------------------------------------------
echo FCVPN Parte 12 de 17
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/FCVPN.7z.012" -OutFile "C:\TI\FCVPN.7z.012"
cls
echo --------------------------------------------------------------------
echo FCVPN Parte 13 de 17
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/FCVPN.7z.013" -OutFile "C:\TI\FCVPN.7z.013"
cls
echo --------------------------------------------------------------------
echo FCVPN Parte 14 de 17
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/FCVPN.7z.014" -OutFile "C:\TI\FCVPN.7z.014"
cls
echo --------------------------------------------------------------------
echo FCVPN Parte 15 de 17
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/FCVPN.7z.015" -OutFile "C:\TI\FCVPN.7z.015"
cls
echo --------------------------------------------------------------------
echo FCVPN Parte 16 de 17
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/FCVPN.7z.016" -OutFile "C:\TI\FCVPN.7z.016"
cls
echo --------------------------------------------------------------------
echo FCVPN Parte 17 de 17
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/FCVPN.7z.017" -OutFile "C:\TI\FCVPN.7z.017"
cls
echo --------------------------------------------------------------------
echo FCVPN - Extrayendo Ejecutable
echo --------------------------------------------------------------------
"C:\Program Files\7-Zip\7z.exe" x C:\TI\FCVPN.7z.001 -oC:\TI
del C:\TI\FCVPN.7z.001
del C:\TI\FCVPN.7z.002
del C:\TI\FCVPN.7z.003
del C:\TI\FCVPN.7z.004
del C:\TI\FCVPN.7z.005
del C:\TI\FCVPN.7z.006
del C:\TI\FCVPN.7z.007
del C:\TI\FCVPN.7z.008
del C:\TI\FCVPN.7z.009
del C:\TI\FCVPN.7z.010
del C:\TI\FCVPN.7z.011
del C:\TI\FCVPN.7z.012
del C:\TI\FCVPN.7z.013
del C:\TI\FCVPN.7z.014
del C:\TI\FCVPN.7z.015
del C:\TI\FCVPN.7z.016
del C:\TI\FCVPN.7z.017
msiexec /i C:\TI\FortiClientVPN.msi /quiet
pause
exit