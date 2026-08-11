@echo off
:10
cls
echo --------------------------------------------------------------------
echo Menu Mantenimiento
echo --------------------------------------------------------------------
echo  10a - Reporte Historial de Navegacion, Apps y Archivos No Aut.
echo  10b - Ejecutar limpieza de sistema operativo
echo  10c - Validar Funcionamiento de OneDrive
echo  10d - Actualizar Windows 11
echo  10e - Actualizaciones de Windows
echo  10f - Antivirus, revisa que este instalado y actualizado en GLPI
echo  10g - Proceso HASH BBVA
echo  10h - Reporte Inventario "\\172.16.40.250\da\Reportes\"
echo  10i - Borrado Seguro Espacio Libre
echo  0 - Regresar al menu principal
echo --------------------------------------------------------------------
echo Introduzca el numero a continuacion y presione enter
set /p step=
if %step% == 10 goto 10
if %step% == 10a goto 10a
if %step% == 10b goto 10b
if %step% == 10c goto 10c
if %step% == 10d goto 10d
if %step% == 10e goto 10e
if %step% == 10f goto 10f
if %step% == 10g goto 10g
if %step% == 10h goto 10h
if %step% == 10i goto 10i
if %step% == 0 goto 0
:10a
cls
echo --------------------------------------------------------------------
echo Generar reporte de historial de navegacion
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/BHV.zip" -OutFile "C:\TI\BHV.zip"
"C:\Program Files\7-Zip\7z.exe" x C:\TI\BHV.zip -oC:\TI\
C:\TI\BHV\BHV.exe /cfg "C:\TI\BHV\BHV.cfg" /scomma "C:\TI\%computername%_BHV.csv"
cls
echo --------------------------------------------------------------------
echo Generar Reporte de programas instalados
echo --------------------------------------------------------------------
winget list --accept-source-agreements >> C:\TI\%computername%_Apps_Instaladas.txt
cls
echo --------------------------------------------------------------------
echo Generando Reporte de Archivos No Autorizados
echo --------------------------------------------------------------------
echo Listado de archivos no autorizados >> C:\TI\%computername%_No_Auth_Files.txt
echo %date% >> C:\TI\%computername%_No_Auth_Files.txt
echo -------------------------------------------------------------------- >> C:\TI\%computername%_No_Auth_Files.txt
echo Instaladores, Portables o Ejecutables >> C:\TI\%computername%_No_Auth_Files.txt
dir "C:\Users\*.exe" /s /b /a-d | findstr /v /i "AppData" >> C:\TI\%computername%_No_Auth_Files.txt
echo -------------------------------------------------------------------- >> C:\TI\%computername%_No_Auth_Files.txt
echo Archivos Audio >> C:\TI\%computername%_No_Auth_Files.txt
dir "C:\Users\*.mp3" /s /b /a-d | findstr /v /i "AppData" >> C:\TI\%computername%_No_Auth_Files.txt
dir "C:\Users\*.m4a" /s /b /a-d | findstr /v /i "AppData" >> C:\TI\%computername%_No_Auth_Files.txt
echo -------------------------------------------------------------------- >> C:\TI\%computername%_No_Auth_Files.txt
echo Archivos Video >> C:\TI\%computername%_No_Auth_Files.txt
dir "C:\Users\*.mp4" /s /b /a-d | findstr /v /i "AppData" >> C:\TI\%computername%_No_Auth_Files.txt
dir "C:\Users\*.mkv" /s /b /a-d | findstr /v /i "AppData" >> C:\TI\%computername%_No_Auth_Files.txt
dir "C:\Users\*.avi" /s /b /a-d | findstr /v /i "AppData" >> C:\TI\%computername%_No_Auth_Files.txt
dir "C:\Users\*.mpg" /s /b /a-d | findstr /v /i "AppData" >> C:\TI\%computername%_No_Auth_Files.txt
dir "C:\Users\*.mpeg" /s /b /a-d | findstr /v /i "AppData" >> C:\TI\%computername%_No_Auth_Files.txt
echo -------------------------------------------------------------------- >> C:\TI\%computername%_No_Auth_Files.txt
cls
echo --------------------------------------------------------------------
echo El reporte se encuentra en: "C:\TI\%computername%_Apps_Instaladas.txt"
echo El reporte se encuentra en: "C:\TI\DPCP-***_No_Auth_Files.txt"
echo El reporte se encuentra en: "C:\TI\DPCP-***_BHV.csv"
echo --------------------------------------------------------------------
pause
explorer C:\TI
pause
cls
goto 10
:10b
cls
echo --------------------------------------------------------------------
echo Limpieza de sistema operativo, basica y avanzada
echo --------------------------------------------------------------------
pause
cleanmgr.exe
cls
goto 10
:10c
cls
echo --------------------------------------------------------------------
echo Validar Funcionamiento de OneDrive:
echo --------------------------------------------------------------------
echo Abrir OneDrive desde inicio y verificar que se abra la carpeta
echo del usuario y que los iconos de estado esten presentes.
echo
pause
xcopy /y /s "\\172.16.40.250\da\Software\Auto\Pics_Apoyo\MTTO_01.png" "C:\TI\Pics_Apoyo\"
cls
echo Revisa que todo los iconos de OneDrive digan "Actualizado"
C:\TI\Pics_Apoyo\MTTO_01.png
pause
cls
goto 10
:10d
echo --------------------------------------------------------------------
powershell -Command Invoke-WebRequest -Uri "https://github.com/soporte-dg/parches/raw/refs/heads/main/WPCHCS.msi" -OutFile "C:\TI\WPCHCS.msi"
msiexec /i C:\TI\WPCHCS.msi
powershell -Command Invoke-WebRequest -Uri "https://github.com/soporte-dg/parches/raw/refs/heads/main/W11IA.exe" -OutFile "C:\TI\W11IA.exe"
"C:\TI\W11IA.exe"
pause
cls
goto 10
:10e
echo Buscar actualizaciones del Sistema Operativo
pause
wuauclt.exe /updatenow
pause
echo Buscar e Instalar actualizaciones opcionales
powershell Start-Process ms-settings:windowsupdate-optionalupdates
cls
goto 10
:10f
cls
echo --------------------------------------------------------------------
echo Revisa que el antivirus este instalado y actualizado en GLPI
pause
cls
goto 10
:10g
cls
echo --------------------------------------------------------------------
echo Consulta Version de Windows y Numero de serie
echo --------------------------------------------------------------------
powershell -Command "wmic bios get serialnumber"
winver
pause
cls
echo --------------------------------------------------------------------
echo Obtener Hash del equipo
echo --------------------------------------------------------------------
powershell -Command "Set-ExecutionPolicy Unrestricted -force"
powershell -Command "Install-Script Get-WindowsAutoPilotInfo -force"
powershell -Command "Get-WindowsAutoPilotInfo.ps1 -OutputFile C:\TI\Usuario_Red.csv"
powershell -Command "Get-Content "C:\TI\Usuario_Red.csv" | Out-Printer -Name "Microsoft Print to PDF""
pause
cls
goto 10
:10h
echo --------------------------------------------------------------------
echo Reporte Inventario "\\172.16.40.250\da\Reportes\"
echo --------------------------------------------------------------------
hostname >> \\172.16.40.250\da\Reportes\Inv_Fisico.csv
powershell whoami >> \\172.16.40.250\da\Reportes\Inv_Fisico.csv
powershell Get-WmiObject win32_bios SerialNumber >> \\172.16.40.250\da\Reportes\Inv_Fisico.csv
dir C:\Users\ >> \\172.16.40.250\da\Reportes\Inv_Fisico.csv
echo -------------------------------------------------------------------- >> \\172.16.40.250\da\Reportes\Inv_Fisico.csv
cls
goto 10
:10i
cls
echo ----------------------------------------------------------------
echo Borrado Seguro de Espacio Libre
echo ----------------------------------------------------------------
echo Importante! Cierra todas las aplicaciones y archivos, antes de continuar
pause
xcopy /y /s "\\172.16.40.250\da\Borrado_Seguro.ps1" "C:\TI\"
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/soporte-dg/parches/refs/heads/main/Clean-SSD.markdown" -OutFile "C:\TI\Borrado_Seguro.ps1"
powershell -ExecutionPolicy Bypass -File "C:\TI\Borrado_Seguro.ps1"
pause
echo Importante! Si el borrado seguro se hace fuera de la oficina,
echo debes enviar el archivo C:\TI\Borrado_Seguro\Certificado_<HOSTNAME>_<FECHA>.pdf por correo
echo a soporte@deltaproyectos.com indicando que es el reporte de borrado seguro.
explorer "C:\TI\Borrado_Seguro"
pause
cls
goto 10
:0
C:\TI\DPD_STD.bat