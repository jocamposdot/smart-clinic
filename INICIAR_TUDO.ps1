# Script completo para iniciar tudo (MySQL + Backend)
# Execute este script para iniciar tudo de uma vez

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Smart Clinic - Iniciando Tudo" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar Docker
try {
    $dockerVersion = docker --version
    Write-Host "✓ Docker encontrado" -ForegroundColor Green
} catch {
    Write-Host "✗ Docker não encontrado. Por favor, inicie o Docker Desktop primeiro." -ForegroundColor Red
    exit
}

# Passo 1: Iniciar MySQL
Write-Host "Passo 1: Iniciando MySQL..." -ForegroundColor Cyan
docker-compose up -d mysql
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ MySQL iniciado!" -ForegroundColor Green
    Write-Host "  Aguardando MySQL ficar pronto..." -ForegroundColor Yellow
    Start-Sleep -Seconds 8
} else {
    Write-Host "✗ Erro ao iniciar MySQL" -ForegroundColor Red
    exit
}

# Verificar se MySQL está rodando
$mysqlRunning = docker ps --filter "name=smart-clinic-mysql" --format "{{.Names}}"
if ($mysqlRunning -ne "smart-clinic-mysql") {
    Write-Host "✗ MySQL não está rodando" -ForegroundColor Red
    exit
}
Write-Host "✓ MySQL está rodando!" -ForegroundColor Green
Write-Host ""

# Passo 2: Configurar variáveis
Write-Host "Passo 2: Configurando variáveis de ambiente..." -ForegroundColor Cyan
$env:SPRING_PROFILES_ACTIVE="dev"
$env:APP_JWT_SECRET="change-me-dev-secret-key-for-screenshots-2024"
Write-Host "✓ Variáveis configuradas" -ForegroundColor Green
Write-Host ""

# Passo 3: Criar usuários (se as tabelas existirem)
Write-Host "Passo 3: Tentando criar usuários de teste..." -ForegroundColor Cyan
try {
    Get-Content criar-usuarios-teste.sql | docker exec -i smart-clinic-mysql mysql -u smartclinic -psmartclinic smart_clinic 2>&1 | Out-Null
    Write-Host "✓ Usuários criados (ou já existiam)" -ForegroundColor Green
} catch {
    Write-Host "⚠ Usuários não puderam ser criados (tabelas podem não existir ainda - normal se backend não rodou antes)" -ForegroundColor Yellow
}
Write-Host ""

# Passo 4: Iniciar Backend
Write-Host "Passo 4: Iniciando Backend Spring Boot..." -ForegroundColor Cyan
Write-Host "  Isso pode levar 30-60 segundos..." -ForegroundColor Yellow
Write-Host "  Uma nova janela PowerShell será aberta para o backend." -ForegroundColor Yellow
Write-Host ""

Set-Location "app"
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PWD'; `$env:SPRING_PROFILES_ACTIVE='dev'; `$env:APP_JWT_SECRET='change-me-dev-secret-key-for-screenshots-2024'; Write-Host 'Iniciando backend Spring Boot...' -ForegroundColor Cyan; Write-Host 'Aguarde até ver: Started SmartClinicApplication' -ForegroundColor Yellow; Write-Host ''; mvn spring-boot:run"
Set-Location ..

Write-Host "✓ Backend iniciando em nova janela..." -ForegroundColor Green
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "✓ Tudo iniciando!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Aguarde 30-60 segundos para o backend iniciar completamente." -ForegroundColor Yellow
Write-Host ""
Write-Host "Para verificar se está rodando, execute:" -ForegroundColor Cyan
Write-Host "  curl http://localhost:8080/api/doctors" -ForegroundColor White
Write-Host ""
Write-Host "Depois que o backend iniciar:" -ForegroundColor Cyan
Write-Host "  1. Execute: .\CRIAR_USUARIOS.ps1" -ForegroundColor White
Write-Host "  2. Execute: .\ABRIR_PORTALS.ps1" -ForegroundColor White
Write-Host "  3. OU execute: node capturar-screenshots.js" -ForegroundColor White
Write-Host ""

