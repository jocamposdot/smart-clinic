# Script simples para iniciar o backend
# Execute este script para iniciar o backend Spring Boot

Write-Host "Iniciando Backend Spring Boot..." -ForegroundColor Cyan
Write-Host ""

$env:SPRING_PROFILES_ACTIVE="dev"
$env:APP_JWT_SECRET="change-me-dev-secret-key-for-screenshots-2024"

Set-Location "app"

Write-Host "Variáveis configuradas:" -ForegroundColor Green
Write-Host "  SPRING_PROFILES_ACTIVE = $env:SPRING_PROFILES_ACTIVE" -ForegroundColor White
Write-Host "  APP_JWT_SECRET = configurado" -ForegroundColor White
Write-Host ""
Write-Host "Iniciando backend... Aguarde 30-60 segundos..." -ForegroundColor Yellow
Write-Host ""

mvn spring-boot:run

