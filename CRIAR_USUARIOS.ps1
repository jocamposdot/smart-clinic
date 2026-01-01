# Script para criar usuários de teste no MySQL
# Execute APÓS o backend ter iniciado (para criar as tabelas via Flyway)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Criando Usuários de Teste" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar se MySQL está rodando
$mysqlRunning = docker ps --filter "name=smart-clinic-mysql" --format "{{.Names}}"
if ($mysqlRunning -ne "smart-clinic-mysql") {
    Write-Host "✗ MySQL não está rodando. Execute primeiro: docker-compose up -d mysql" -ForegroundColor Red
    exit
}

Write-Host "✓ MySQL está rodando" -ForegroundColor Green
Write-Host ""
Write-Host "Executando script SQL..." -ForegroundColor Cyan

# Executar o script SQL
docker exec -i smart-clinic-mysql mysql -u smartclinic -psmartclinic smart_clinic < criar-usuarios-teste.sql

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✓ Usuários criados com sucesso!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Credenciais criadas:" -ForegroundColor Cyan
    Write-Host "  Admin:  admin@smartclinic.com / senha123" -ForegroundColor White
    Write-Host "  Doctor: joao.silva@smartclinic.com / senha123" -ForegroundColor White
    Write-Host "  Patient: maria.santos@example.com / senha123" -ForegroundColor White
    Write-Host ""
    Write-Host "Agora você pode fazer login nos portais!" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "✗ Erro ao executar script SQL" -ForegroundColor Red
    Write-Host ""
    Write-Host "Tente executar manualmente:" -ForegroundColor Yellow
    Write-Host "  docker exec -it smart-clinic-mysql mysql -u smartclinic -psmartclinic smart_clinic" -ForegroundColor White
    Write-Host "  Depois cole o conteúdo de criar-usuarios-teste.sql" -ForegroundColor Gray
}

Write-Host ""

