# Definir variables 
$backupDir = "C:\backups"
$database = "sandbox2"
$date = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$backupFile = "/var/lib/postgresql/data/backup_$database_$date.sql"
$localBackupFile = "$backupDir\backup_$database_$date.sql"
$driveFolder = "3CARRERA/2cuatri/practs/practs_SISINF2/versiones_odoo"  # Nueva ruta simplificada

Write-Output "Iniciando backup de la base de datos $database..."

# Crear carpeta de backups si no existe
if (!(Test-Path -Path $backupDir)) {
    New-Item -Path $backupDir -ItemType Directory -Force
}

# Ejecutar el backup dentro del contenedor de PostgreSQL
docker exec -t irene-db-1 pg_dump -U odoo -F c -b -v -f $backupFile $database

# Copiar el backup desde Docker a Windows
docker cp irene-db-1:$backupFile $localBackupFile

# Verificar que el archivo se haya copiado correctamente
if (Test-Path $localBackupFile) {
    Write-Output "Backup realizado con exito: $localBackupFile"
} else {
    Write-Output "ERROR: No se pudo generar el backup."
    exit 1
}

# --- Subida a Google Drive ---
Write-Output "Subiendo backup a Google Drive..."
& "C:\backups\rclone-v1.69.1-windows-amd64\rclone.exe" copy "$localBackupFile" "odoo:$driveFolder"  # Ruta sin espacios ni caracteres especiales

if ($?) {
    Write-Output "Backup subido correctamente a: $driveFolder"
} else {
    Write-Output "ERROR al subir a Google Drive"
    exit 1
}

# Detención de rclone si sigue en ejecución
Start-Sleep -Seconds 5
Get-Process rclone -ErrorAction SilentlyContinue | Stop-Process -Force

Write-Output "Proceso rclone detenido con exito."

exit 0