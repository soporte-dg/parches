title Correccion de Vulnerabilidades
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/CVE_Upgrade.markdown" -OutFile "C:\TI\CVE_Upgrade.bat"
reg delete HKEY_CLASSES_ROOT\search-ms /f
powershell -Command "Get-Package -Name "GLPI Agent 1.16" | Uninstall-Package"
winget uninstall "GLPI Agent"
powershell -Command "Get-Package -Name "GLPI Agent 1.15" | Uninstall-Package"
powershell -Command "Get-Package -Name "GLPI Agent 1.13" | Uninstall-Package"
powershell -Command "Get-Package -Name "GLPI Agent 1.7" | Uninstall-Package"
:0
echo Resumen de Versiones de Software
echo --------------------------------------------------------------------
powershell -Command Get-Package -Name "*7-Zip*"
echo - Version Requerida 7-Zip 26.00 
echo --------------------------------------------------------------------
powershell -Command Get-Package -Name "*GLPI*"
echo - GLPI Agent v1.16 Debe ser desinstalado
echo --------------------------------------------------------------------
powershell -Command Get-Package -Name "*VLC*"
echo - Version Requerida VLC 3.0.23
echo --------------------------------------------------------------------
powershell -Command Get-Package -Name "*Forticlient*"
echo - Version Requerida Forticlient VPN 7.4.3.8758
echo --------------------------------------------------------------------
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DisplayVersion
echo - Version Requerida Windows 11 25H2
echo --------------------------------------------------------------------
echo Toma nota de las versiones desactualizadas y
pause
cls
echo Selecciona el numero de vulnerabilidad a resolver
echo --------------------------------------------------------------------
echo  1 - Desactivado
echo  2 - 7-Zip
echo  3 - Desactivado
echo  4 - VLC
echo  5 - Forticlient
echo  6 - Actualizar Version de Windows
echo  7 - Descargar AV BGZ_Mon
echo  8 - Descargar AV BGZ_Sop
echo --------------------------------------------------------------------
echo Introduzca el numero a continuacion y presione enter
set /p step=
if %step% == 0 goto 0
if %step% == 1 goto 1
if %step% == 2 goto 2
if %step% == 3 goto 3
if %step% == 4 goto 4
if %step% == 5 goto 5
if %step% == 6 goto 6
if %step% == 7 goto 7
if %step% == 8 goto 8
:1
echo --------------------------------------------------------------------
echo Desactivado
echo --------------------------------------------------------------------
Desactivado
cls
goto 0
:2
echo --------------------------------------------------------------------
echo 7Zip
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://github.com/soporte-dg/parches/raw/refs/heads/main/7zip-x64.msi" -OutFile "C:\TI\7zip-x64.msi"
msiexec /i C:\TI\7zip-x64.msi /quiet
cls
goto 0
:3
echo --------------------------------------------------------------------
echo Desactivado
echo --------------------------------------------------------------------
Desactivado
cls
goto 0
:4
echo --------------------------------------------------------------------
echo VLC
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://southfront.mm.fcix.net/videolan-ftp/vlc/3.0.23/win64/vlc-3.0.23-win64.msi" -OutFile "C:\TI\vlc-win64.msi"
msiexec /i C:\TI\vlc-win64.msi /quiet
cls
goto 0
:6
echo --------------------------------------------------------------------
echo W11
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://github.com/soporte-dg/parches/raw/refs/heads/main/WPCHCS.msi" -OutFile "C:\TI\WPCHCS.msi"
msiexec /i C:\TI\WPCHCS.msi
powershell -Command Invoke-WebRequest -Uri "https://github.com/soporte-dg/parches/raw/refs/heads/main/W11IA.exe" -OutFile "C:\TI\W11IA.exe"
"C:\TI\W11IA.exe"
pause
cls
goto 0
:5
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
msiexec /i C:\TI\FortiClientVPN.msi
pause
cls
goto 0
:7
echo --------------------------------------------------------------------
echo Descargando AV BGZ_Mon
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://github.com/soporte-dg/parches/raw/refs/heads/main/BGZ_Mon_setupdownloader_%5BaHR0cHM6Ly9jbG91ZC1lY3MuZ3Jhdml0eXpvbmUuYml0ZGVmZW5kZXIuY29tL1BhY2thZ2VzL0JTVFdJTi8wL3ZMbXlUZi9pbnN0YWxsZXIueG1sP2xhbmc9ZXMtRVM=%5D.exe" -OutFile "C:\TI\AV\BGZ_Mon\setupdownloader_%5BaHR0cHM6Ly9jbG91ZC1lY3MuZ3Jhdml0eXpvbmUuYml0ZGVmZW5kZXIuY29tL1BhY2thZ2VzL0JTVFdJTi8wL3ZMbXlUZi9pbnN0YWxsZXIueG1sP2xhbmc9ZXMtRVM=%5D.exe"
explorer "C:\TI\AV\"
pause
cls
goto 0
:8
echo --------------------------------------------------------------------
echo Descargando AV BGZ_Sop
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://github.com/soporte-dg/parches/raw/refs/heads/main/BGZ_Sop_setupdownloader_%5BaHR0cHM6Ly9jbG91ZC1lY3MuZ3Jhdml0eXpvbmUuYml0ZGVmZW5kZXIuY29tL1BhY2thZ2VzL0JTVFdJTi8wL1B2dGtPZi9pbnN0YWxsZXIueG1sP2xhbmc9ZXMtRVM=%5D.exe" -OutFile "C:\TI\AV\BGZ_Sop\setupdownloader_%5BaHR0cHM6Ly9jbG91ZC1lY3MuZ3Jhdml0eXpvbmUuYml0ZGVmZW5kZXIuY29tL1BhY2thZ2VzL0JTVFdJTi8wL1B2dGtPZi9pbnN0YWxsZXIueG1sP2xhbmc9ZXMtRVM=%5D.exe"
explorer "C:\TI\AV\"
pause
cls
goto 0
