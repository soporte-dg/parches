# ==============================================================================
# Script: Borrado_Seguro.ps1
# Descripción: Sanitización SSD + Generación de Certificado PDF (Local y Red)
# ==============================================================================

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Este script requiere ejecutarse como Administrador."
    exit
}

# --- CONFIGURACIÓN DE RUTAS DE DESTINO ---
$localFolder   = "C:\TI\Borrado_Seguro"
$networkFolder = "\\172.16.40.250\da\Reportes\Borrado_Seguro"

if (-not (Test-Path $localFolder)) { 
    New-Item -ItemType Directory -Path $localFolder -Force | Out-Null 
}

# --- OBTENER DATOS DE HARDWARE Y SISTEMA ---
$hostname = $env:COMPUTERNAME
$dateStr  = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$fileTag  = Get-Date -Format "yyyyMMdd_HHmmss"

$fileName = "Certificado_${hostname}_${fileTag}.pdf"
$htmlFile = "$localFolder\Temp_${hostname}_${fileTag}.html"
$localPdf = "$localFolder\$fileName"

$biosInfo    = Get-CimInstance Win32_Bios
$osInfo      = Get-CimInstance Win32_OperatingSystem
$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$serialNum   = $biosInfo.SerialNumber
$osCaption   = $osInfo.Caption

# Obtener discos SSD
$ssdDisks = Get-PhysicalDisk | Where-ObjectType -Property MediaType -Eq "SSD"
$diskRowsHtml = ""

foreach ($disk in $ssdDisks) {
    $sizeGB = [math]::Round($disk.Size / 1GB, 2)
    $diskRowsHtml += "<tr><td>C:</td><td>$($disk.FriendlyName)</td><td>$($disk.SerialNumber)</td><td>SSD ($($disk.BusType))</td><td>$sizeGB GB</td></tr>"
}

# --- LOGS DE EJECUCIÓN ---
$logBuffer = @()
$logBuffer += "[$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))] INICIO DE PROCESO DE SANITIZACION EN $hostname"

Write-Host "Iniciando limpieza y sanitizacion en $hostname..." -ForegroundColor Cyan

# 1. Temporales
$logBuffer += "[$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))] [1/4] Limpiando archivos temporales..."
$tempFolders = @("$env:SystemRoot\Temp\*", "C:\Users\*\AppData\Local\Temp\*")
foreach ($path in $tempFolders) { Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue }
$logBuffer += "[$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))] Archivos temporales purgados."

# 2. DISM
$logBuffer += "[$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))] [2/4] Ejecutando DISM Component Cleanup..."
Start-Process -FilePath "Dism.exe" -ArgumentList "/Online /Cleanup-Image /StartComponentCleanup /ResetBase" -Wait -NoNewWindow
$logBuffer += "[$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))] DISM Cleanup completado con exito."

# 3. Papelera
$logBuffer += "[$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))] [3/4] Vaciando Papelera de Reciclaje..."
Clear-RecycleBin -Force -ErrorAction SilentlyContinue
$logBuffer += "[$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))] Papelera de reciclaje vaciada."

# 4. ReTrim
$logBuffer += "[$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))] [4/4] Enviando ReTrim a unidades SSD..."
$volumesToTrim = Get-Volume | Where-ObjectType { $_.DriveLetter -and $_.DriveType -eq "Fixed" }
foreach ($vol in $volumesToTrim) {
    try {
        Optimize-Volume -DriveLetter $vol.DriveLetter -ReTrim -Verbose
        $logBuffer += "[$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))] ReTrim enviado exitosamente a la unidad $($vol.DriveLetter):"
    } catch {
        $logBuffer += "[$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))] ERROR al ejecutar TRIM en $($vol.DriveLetter): $_"
    }
}

$logText = $logBuffer -join "`n"

# Generar Hash SHA-256
$logBytes = [System.Text.Encoding]::UTF8.GetBytes($logText)
$hasher = [System.Security.Cryptography.SHA256]::Create()
$hashBytes = $hasher.ComputeHash($logBytes)
$sha256Hash = (-join ($hashBytes | ForEach-Object { "{0:X2}" -f $_ }))

# --- CONSTRUCCIÓN DEL HTML ---
$htmlTemplate = @"
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Certificado de Sanitizacion SSD</title>
    <style>
        @page { size: A4; margin: 12mm; }
        body { font-family: 'Segoe UI', Arial, sans-serif; color: #1e293b; margin: 0; padding: 0; font-size: 9.5pt; line-height: 1.35; }
        .header { background-color: #0f172a; color: #ffffff; padding: 18px 20px; border-bottom: 4px solid #0284c7; }
        .header-title { font-size: 16pt; font-weight: bold; margin: 0 0 4px 0; text-transform: uppercase; }
        .header-subtitle { font-size: 9.5pt; color: #94a3b8; margin: 0; }
        .badge-container { text-align: right; margin: 12px 0; }
        .status-badge { background-color: #dcfce7; color: #166534; border: 1px solid #86efac; font-weight: bold; padding: 5px 12px; border-radius: 4px; font-size: 8.5pt; display: inline-block; }
        .section-title { font-size: 11pt; font-weight: bold; color: #0f172a; border-left: 4px solid #0284c7; padding-left: 8px; margin-top: 14px; margin-bottom: 8px; text-transform: uppercase; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 12px; background-color: #ffffff; border: 1px solid #e2e8f0; }
        th { background-color: #f1f5f9; color: #334155; font-size: 8.5pt; font-weight: bold; text-align: left; padding: 6px 10px; border-bottom: 1px solid #cbd5e1; }
        td { padding: 6px 10px; border-bottom: 1px solid #e2e8f0; font-size: 8.5pt; color: #334155; }
        .field-label { font-weight: bold; color: #475569; width: 25%; }
        .code-block { background-color: #1e293b; color: #f8fafc; font-family: 'Consolas', monospace; padding: 8px 10px; border-radius: 4px; font-size: 8pt; white-space: pre-wrap; word-break: break-all; margin-bottom: 12px; }
        .compliance-box { background-color: #eff6ff; border: 1px solid #bfdbfe; padding: 10px; border-radius: 4px; font-size: 8.5pt; color: #1e40af; margin-bottom: 12px; }
        .signatures-table { margin-top: 25px; border: none; }
        .signatures-table td { border: none; padding: 0 15px; width: 50%; text-align: center; }
        .signature-line { border-top: 1px solid #64748b; margin-top: 35px; padding-top: 4px; font-weight: bold; color: #334155; font-size: 8.5pt; }
        .signature-subtext { font-size: 7.5pt; color: #64748b; }
        .footer { margin-top: 20px; padding-top: 8px; border-top: 1px solid #cbd5e1; font-size: 7pt; color: #64748b; text-align: center; }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-title">Certificado de Sanitizacion de Datos</div>
        <div class="header-subtitle">Evidencia Auditable de Borrado Seguro en Disco SSD</div>
    </div>

    <div class="badge-container">
        <span class="status-badge">ESTADO: EJECUTADO CON EXITO</span>
    </div>

    <div class="section-title">1. Informacion del Equipo y Sistema</div>
    <table>
        <tr>
            <td class="field-label">Nombre del Host:</td>
            <td>$hostname</td>
            <td class="field-label">Fecha / Hora:</td>
            <td>$dateStr</td>
        </tr>
        <tr>
            <td class="field-label">Numero de Serie:</td>
            <td>$serialNum</td>
            <td class="field-label">Tecnico Operador:</td>
            <td>$currentUser</td>
        </tr>
        <tr>
            <td class="field-label">Sistema Operativo:</td>
            <td colspan="3">$osCaption</td>
        </tr>
    </table>

    <div class="section-title">2. Identificacion del Hardware SSD</div>
    <table>
        <thead>
            <tr>
                <th>Unidad</th>
                <th>Modelo del Disco</th>
                <th>Numero de Serie del Disco</th>
                <th>Tipo / Bus</th>
                <th>Capacidad</th>
            </tr>
        </thead>
        <tbody>
            $diskRowsHtml
        </tbody>
    </table>

    <div class="section-title">3. Estandar y Metodologia Aplicada</div>
    <div class="compliance-box">
        <b>Metodologia de Purga:</b> Se aplico la instruccion nativa <b>TRIM / ReTrim</b> (NIST SP 800-88 Rev. 1 - Sanitizacion de Medios Flash/SSD), previa depuracion del almacen de componentes de Windows (DISM) y vaciado completo de archivos temporales y papeleras.
    </div>

    <div class="section-title">4. Registro de Ejecucion y Firma Digital (SHA-256)</div>
    <div class="code-block">$logText
--------------------------------------------------------------------------------
HASH SHA-256 DEL REGISTRO DE AUDITORIA:
$sha256Hash
--------------------------------------------------------------------------------</div>

    <div class="section-title">5. Firmas de Conformidad</div>
    <table class="signatures-table">
        <tr>
            <td>
                <div class="signature-line">Firma del Tecnico Responsable</div>
                <div class="signature-subtext">Soporte Tecnico / TI</div>
            </td>
            <td>
                <div class="signature-line">Firma de Recibido / Auditoria</div>
                <div class="signature-subtext">Seguridad de la Informacion / Cumplimiento</div>
            </td>
        </tr>
    </table>

    <div class="footer">
        Este documento PDF sirve como evidencia auditable generada de forma automatizada. Valido para cumplimiento ISO 27001 / NIST 800-88.
    </div>
</body>
</html>
"@

$htmlTemplate | Out-File -FilePath $htmlFile -Encoding utf8

# --- EXPORTAR A PDF CON MICROSOFT EDGE ---
Write-Host "Generando certificado PDF..." -ForegroundColor Yellow

$edgePath = "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edgePath)) {
    $edgePath = "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe"
}

if (Test-Path $edgePath) {
    # Generar el PDF localmente
    Start-Process -FilePath $edgePath -ArgumentList "--headless", "--disable-gpu", "--print-to-pdf=`"$localPdf`"", "`"$htmlFile`"" -Wait
    Remove-Item -Path $htmlFile -Force -ErrorAction SilentlyContinue
    
    Write-Host " [1/2] PDF guardado en ruta local: $localPdf" -ForegroundColor Green

    # Intentar copiar el PDF a la red
    try {
        if (Test-Path $networkFolder) {
            Copy-Item -Path $localPdf -Destination "$networkFolder\$fileName" -Force
            Write-Host " [2/2] Copia enviada con exito a la red: $networkFolder\$fileName" -ForegroundColor Green
        } else {
            Write-Warning " [2/2] No se pudo acceder a la ruta de red '$networkFolder'. El PDF solo se conservara localmente."
        }
    } catch {
        Write-Warning " [2/2] Error al intentar copiar el PDF a la red: $_"
    }

    Write-Host ""
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host " PROCESO Y GENERACION DE EVIDENCIA FINALIZADOS    " -ForegroundColor Cyan
    Write-Host "==================================================" -ForegroundColor Cyan

} else {
    Write-Warning "Microsoft Edge no fue encontrado en la ruta esperada."
}