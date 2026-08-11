<# Forzar la obtención de datos de hardware locales #>
$wmi = Get-CimInstance -Namespace root/cimv2/mdm/dmmap -ClassName MDM_DevDetail_Ext01 -Filter "InstanceID='Ext01' AND ParentID='./DevDetail'"
$serial = (Get-CimInstance -ClassName Win32_Bios).SerialNumber
$hash = $wmi.DeviceHardwareData

$args = $MyInvocation.BoundParameters
if ($args.ContainsKey('OutputFile')) {
    $outputFile = $args['OutputFile']
    "[SerialNumber],[MachineGUID],[HardwareHash]`r`n$serial,,$hash" | Out-File -FilePath $outputFile -Encoding ascii -Force
    Write-Host "Archivo CSV generado exitosamente en: $outputFile" -ForegroundColor Green
} else {
    Write-Host "Serial: $serial"
    Write-Host "Hash: $hash"
}
