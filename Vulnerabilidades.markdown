title Correccion de Vulnerabilidades
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/CVE_Upgrade.markdown" -OutFile "C:\TI\CVE_Upgrade.bat"
reg delete HKEY_CLASSES_ROOT\search-ms /f
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/Mantenimiento.markdown" -OutFile "C:\TI\Mantenimiento.bat"
cls
:0
echo --------------------------------------------------------------------
echo Revision de SecureBoot
echo --------------------------------------------------------------------
powershell -Command Confirm-SecureBootUEFI
echo Si el resultado es True, esta activado, si es false, hay que activarlo
echo --------------------------------------------------------------------
pause
@echo off
chcp 65001 >nul
echo Resumen de Versiones de Software
echo --------------------------------------------------------------------

powershell -NoProfile -ExecutionPolicy Bypass -Command "^
$apps = @('7-Zip', 'GLPI', 'VLC', 'FortiClient'); ^
foreach ($app in $apps) { ^
    $pkg = Get-Package -Name \"*$app*\" -ErrorAction SilentlyContinue; ^
    if ($pkg) { ^
        Write-Host \"[INSTALADO] $($pkg.Name) - Versión: $($pkg.Version)\"; ^
    } else { ^
        Write-Host \"[NO PRESENTES] No se encontró $app instalado\"; ^
    } ^
}"

echo - Notas de versión:
echo   * 7-Zip requerida: 26.02
echo   * VLC requerida: 3.0.23
echo   * GLPI / FortiClient: Desinstalar cualquier versión
echo --------------------------------------------------------------------
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DisplayVersion
echo - Versión Requerida: Windows 11 25H2
echo --------------------------------------------------------------------
pause
echo --------------------------------------------------------------------
echo Toma nota de las versiones desactualizadas y
pause
cls
echo Selecciona el numero de vulnerabilidad a resolver
echo --------------------------------------------------------------------
echo  1 - Desinstalar GLPI
echo  2 - 7-Zip
echo  3 - VLC
echo  4 - Forticlient
echo  5 - Actualizar Version de Windows
echo  6 - Realizar Mantenimiento
echo  7 - HP Click
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
:1
echo --------------------------------------------------------------------
echo Desinstala GLPI desde Panel de Control
echo --------------------------------------------------------------------
appwiz.cpl
pause
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
echo VLC
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://southfront.mm.fcix.net/videolan-ftp/vlc/3.0.23/win64/vlc-3.0.23-win64.msi" -OutFile "C:\TI\vlc-win64.msi"
msiexec /i C:\TI\vlc-win64.msi /quiet
cls
goto 0
:4
echo --------------------------------------------------------------------
echo Cerrar Forticlient Automaticamente
echo --------------------------------------------------------------------
taskkill /im FortiTray.exe -f
taskkill /im FortiClient.exe -f
pause
echo --------------------------------------------------------------------
echo Desinstalar Forticlient Automaticamente
echo --------------------------------------------------------------------
powershell -Command winget uninstall "FortiClient VPN"
echo --------------------------------------------------------------------
echo Verifica que este desinstalado o hazlo manualmente.
echo --------------------------------------------------------------------
appwiz.cpl
pause
cls
goto 0
:5
echo --------------------------------------------------------------------
echo Actualizar Version de Windows
echo --------------------------------------------------------------------
powershell -ExecutionPolicy Bypass -Command "Install-Module PSWindowsUpdate -Force; Get-WindowsUpdate -MicrosoftUpdate -AcceptAll -Install -AutoReboot"
echo ====================================================
echo  Proceso finalizado.
echo ====================================================
pause
cls
goto 0
:7
:6
echo --------------------------------------------------------------------
echo Realizar Mantenimiento
echo --------------------------------------------------------------------
C:\TI\Mantenimiento.bat
cls
goto 0
:7
echo --------------------------------------------------------------------
echo Instalar Portal de empresa
echo --------------------------------------------------------------------
powershell Start-Process ms-windows-store://pdp/?productid=9WZDNCRFJ3PZ
cls
goto 0
:8
echo --------------------------------------------------------------------
echo Lenovo System Update
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://download.lenovo.com/pccbbs/thinkvantage_en/system_update_5.08.03.59.exe" -OutFile "C:\TI\Lenovo_S_U.exe"
cls
goto 0

