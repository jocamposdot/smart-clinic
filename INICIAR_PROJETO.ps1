# Script PowerShell para iniciar o projeto Smart Clinic
# Execute este script para iniciar MySQL e o backend

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Smart Clinic - Inicialização do Projeto" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar se Docker está rodando
try {
    $dockerVersion = docker --version
    Write-Host "✓ Docker encontrado: $dockerVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Docker não encontrado. Por favor, instale o Docker Desktop primeiro." -ForegroundColor Red
    Write-Host "  Download: https://www.docker.com/products/docker-desktop" -ForegroundColor Yellow
    exit
}

Write-Host ""
Write-Host "Passo 1: Iniciando MySQL..." -ForegroundColor Cyan
docker-compose up -d mysql

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ MySQL iniciado!" -ForegroundColor Green
    Write-Host "  Aguardando MySQL ficar pronto..." -ForegroundColor Yellow
    Start-Sleep -Seconds 5
} else {
    Write-Host "✗ Erro ao iniciar MySQL" -ForegroundColor Red
    exit
}

Write-Host ""
Write-Host "Passo 2: Verificando se MySQL está rodando..." -ForegroundColor Cyan
$mysqlRunning = docker ps --filter "name=smart-clinic-mysql" --format "{{.Names}}"
if ($mysqlRunning -eq "smart-clinic-mysql") {
    Write-Host "✓ MySQL está rodando!" -ForegroundColor Green
} else {
    Write-Host "✗ MySQL não está rodando. Verifique: docker ps" -ForegroundColor Red
    exit
}

Write-Host ""
Write-Host "Passo 3: Configurando variáveis de ambiente..." -ForegroundColor Cyan
$env:SPRING_PROFILES_ACTIVE="dev"
$env:APP_JWT_SECRET="change-me-dev-secret-key-for-screenshots-2024"
Write-Host "✓ Variáveis configuradas!" -ForegroundColor Green
Write-Host "  SPRING_PROFILES_ACTIVE = dev" -ForegroundColor Gray
Write-Host "  APP_JWT_SECRET = configurado" -ForegroundColor Gray

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "✓ Preparação concluída!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Próximos passos:" -ForegroundColor Cyan
Write-Host "  1. Em um NOVO terminal, execute:" -ForegroundColor Yellow
Write-Host "     cd app" -ForegroundColor White
Write-Host "     mvn spring-boot:run" -ForegroundColor White
Write-Host ""
Write-Host "  2. Aguarde o backend iniciar (você verá 'Started SmartClinicApplication')" -ForegroundColor Yellow
Write-Host ""
Write-Host "  3. Crie os usuários de teste:" -ForegroundColor Yellow
Write-Host "     docker exec -it smart-clinic-mysql mysql -u smartclinic -psmartclinic smart_clinic < criar-usuarios-teste.sql" -ForegroundColor White
Write-Host "     OU conecte ao MySQL e execute o SQL manualmente" -ForegroundColor Gray
Write-Host ""
Write-Host "  4. Abra os portais frontend:" -ForegroundColor Yellow
Write-Host "     - frontend/admin/index.html" -ForegroundColor White
Write-Host "     - frontend/doctor/index.html" -ForegroundColor White
Write-Host "     - frontend/patient/index.html" -ForegroundColor White
Write-Host ""
Write-Host "Credenciais de teste:" -ForegroundColor Cyan
Write-Host "  Admin:  admin@smartclinic.com / senha123" -ForegroundColor White
Write-Host "  Doctor: joao.silva@smartclinic.com / senha123" -ForegroundColor White
Write-Host "  Patient: maria.santos@example.com / senha123" -ForegroundColor White
Write-Host ""

