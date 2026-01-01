# Script para iniciar o backend Spring Boot
# Execute este script DEPOIS que o MySQL estiver rodando

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Iniciando Backend Spring Boot" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Configurar variáveis de ambiente
$env:SPRING_PROFILES_ACTIVE="dev"
$env:APP_JWT_SECRET="change-me-dev-secret-key-for-screenshots-2024"

Write-Host "✓ Variáveis de ambiente configuradas" -ForegroundColor Green
Write-Host ""

# Verificar se MySQL está rodando
$mysqlRunning = docker ps --filter "name=smart-clinic-mysql" --format "{{.Names}}"
if ($mysqlRunning -ne "smart-clinic-mysql") {
    Write-Host "✗ MySQL não está rodando. Execute primeiro:" -ForegroundColor Red
    Write-Host "  docker-compose up -d mysql" -ForegroundColor Yellow
    exit
}

Write-Host "✓ MySQL está rodando" -ForegroundColor Green
Write-Host ""

# Navegar para pasta do app
Set-Location "app"

Write-Host "Iniciando backend Spring Boot..." -ForegroundColor Cyan
Write-Host "Aguarde... (isso pode levar 30-60 segundos)" -ForegroundColor Yellow
Write-Host ""

# Iniciar Spring Boot
mvn spring-boot:run

