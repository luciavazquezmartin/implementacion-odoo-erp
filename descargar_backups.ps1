# Variables
$remotePath = "odoo:versiones_odoo"  # Ruta en Drive
$localDownloadDir = "C:\backups\versiones-odoo"
$fileName = (.\rclone lsf "$remotePath" --format "p" --time-format "max" | Sort-Object | Select-Object -Last 1)  # Obtiene el archivo más reciente

# Ruta local completa donde se descargará el archivo
$localFilePath = Join-Path $localDownloadDir $fileName

Write-Output "Descargando archivo más reciente: $fileName desde Google Drive..."

# 1. Crear carpeta local si no existe
if (!(Test-Path $localDownloadDir)) {
    New-Item -Path $localDownloadDir -ItemType Directory -Force
}

# 2. Ejecutar el comando rclone para copiar el archivo desde Drive a la carpeta local
#    Ajusta la ruta a rclone.exe si está en otro directorio
& "C:\backups\rclone-v1.69.1-windows-amd64\rclone.exe" copy `
    "$remotePath/$fileName" `
    "$localDownloadDir"

# 3. Verificar que el archivo se haya descargado correctamente
if (Test-Path $localFilePath) {
    Write-Output "Archivo descargado con exito: $localFilePath"
} else {
    Write-Output "ERROR: No se pudo descargar el archivo."
    exit 1
}

Write-Output "Proceso completado correctamente."
