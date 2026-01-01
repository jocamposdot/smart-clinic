# Script para verificar se o backend está rodando

Write-Host "Verificando status do backend..." -ForegroundColor Cyan
Write-Host ""

try {
    $response = Invoke-WebRequest -Uri "http://localhost:8080/api/doctors" -Method GET -TimeoutSec 3 -ErrorAction Stop
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "✓✓✓ BACKEND ESTÁ RODANDO!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Status: $($response.StatusCode)" -ForegroundColor White
    Write-Host ""
    Write-Host "Agora você pode:" -ForegroundColor Cyan
    Write-Host "  1. Executar: .\ABRIR_PORTALS.ps1" -ForegroundColor White
    Write-Host "  2. OU executar: node capturar-screenshots.js" -ForegroundColor White
} catch {
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "✗ Backend NÃO está rodando" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Execute:" -ForegroundColor Yellow
    Write-Host "  .\INICIAR_TUDO.ps1" -ForegroundColor White
    Write-Host ""
    Write-Host "OU manualmente:" -ForegroundColor Yellow
    Write-Host "  cd app" -ForegroundColor White
    Write-Host "  `$env:SPRING_PROFILES_ACTIVE='dev'" -ForegroundColor White
    Write-Host "  `$env:APP_JWT_SECRET='change-me-dev-secret-key-for-screenshots-2024'" -ForegroundColor White
    Write-Host "  mvn spring-boot:run" -ForegroundColor White
}

Write-Host ""

