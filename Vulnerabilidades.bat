@echo off
title Correccion de Vulnerabilidades
echo --------------------------------------------------------------------
echo Lista de Vulnerabilidades a Corregir
echo --------------------------------------------------------------------
echo - 7zip
echo - GLPI Agent
echo - VLC
echo - Forticlient
echo - Windows 11
echo --------------------------------------------------------------------
echo Ligas de Descarga
echo --------------------------------------------------------------------
echo https://7-zip.org/a/7z2501-x64.msi
echo --------------------------------------------------------------------
echo https://github.com/glpi-project/glpi-agent/releases/download/1.15/GLPI-Agent-1.15-x64.msi
echo --------------------------------------------------------------------
echo https://southfront.mm.fcix.net/videolan-ftp/vlc/3.0.23/win64/vlc-3.0.23-win64.msi
echo --------------------------------------------------------------------
echo Create a OneDrive Anyone Access Link, and replace the text following the question mark (?) with “download=1”
echo https://dpdm365bs-my.sharepoint.com/:u:/g/personal/ivan_bistrain_deltaproyectos_com/IQA8aKGABWGPSYcHwNXKOQQKAaqaVLMJzJUQvDFs1MGrxWM?download=1
echo https://dpdm365bs-my.sharepoint.com/personal/ivan_bistrain_deltaproyectos_com/Documents/Descargas/Vulnerabilidades/FortiClientVPN.msi?ga=1
echo --------------------------------------------------------------------
echo https://download.microsoft.com/download/db8267b0-3e86-4254-82c7-a127878a9378/Windows11InstallationAssistant.exe
echo --------------------------------------------------------------------
pause
cls
echo --------------------------------------------------------------------
echo Comenzando Descarga y Actualizacion
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://7-zip.org/a/7z2501-x64.msi" -OutFile "C:\TI\7zip-x64.msi"
msiexec /i C:\TI\7zip-x64.msi /quiet
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://github.com/glpi-project/glpi-agent/releases/download/1.15/GLPI-Agent-1.15-x64.msi" -OutFile "C:\TI\GLPI-Agent.msi"
msiexec /i C:\TI\GLPI-Agent.msi /quiet SERVER="https://glpi.deltaproyectos.mx/front/inventory.php"
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://southfront.mm.fcix.net/videolan-ftp/vlc/3.0.23/win64/vlc-3.0.23-win64.msi" -OutFile "C:\TI\vlc-win64.msi"
msiexec /i C:\TI\vlc-win64.msi /quiet
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://dpdm365bs-my.sharepoint.com/personal/ivan_bistrain_deltaproyectos_com/Documents/Descargas/Vulnerabilidades/FortiClientVPN.msi" -OutFile "C:\TI\FortiClientVPN.msi"
msiexec /i C:\TI\FortiClientVPN.msi /quiet
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://download.microsoft.com/download/db8267b0-3e86-4254-82c7-a127878a9378/Windows11InstallationAssistant.exe" -OutFile "C:\TI\Windows11InstallationAssistant.exe"
C:\TI\Windows11InstallationAssistant.exe
echo --------------------------------------------------------------------



