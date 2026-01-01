# Script para abrir os portais no navegador
# Execute este script DEPOIS que o backend estiver rodando

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Abrindo Portais Frontend" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$basePath = $PSScriptRoot
if (-not $basePath) {
    $basePath = Get-Location
}

$adminPath = Join-Path $basePath "frontend\admin\index.html"
$doctorPath = Join-Path $basePath "frontend\doctor\index.html"
$patientPath = Join-Path $basePath "frontend\patient\index.html"

Write-Host "Abrindo portais..." -ForegroundColor Cyan
Write-Host ""

if (Test-Path $adminPath) {
    Start-Process $adminPath
    Write-Host "✓ Portal Admin aberto" -ForegroundColor Green
} else {
    Write-Host "✗ Portal Admin não encontrado: $adminPath" -ForegroundColor Red
}

Start-Sleep -Seconds 1

if (Test-Path $doctorPath) {
    Start-Process $doctorPath
    Write-Host "✓ Portal Doctor aberto" -ForegroundColor Green
} else {
    Write-Host "✗ Portal Doctor não encontrado: $doctorPath" -ForegroundColor Red
}

Start-Sleep -Seconds 1

if (Test-Path $patientPath) {
    Start-Process $patientPath
    Write-Host "✓ Portal Patient aberto" -ForegroundColor Green
} else {
    Write-Host "✗ Portal Patient não encontrado: $patientPath" -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "✓ Portais abertos no navegador!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Credenciais de teste:" -ForegroundColor Cyan
Write-Host "  Admin:  admin@smartclinic.com / senha123" -ForegroundColor White
Write-Host "  Doctor: joao.silva@smartclinic.com / senha123" -ForegroundColor White
Write-Host "  Patient: maria.santos@example.com / senha123" -ForegroundColor White
Write-Host ""

