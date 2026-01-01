# Script PowerShell para enviar projeto para o GitHub
# Execute este script após criar o repositório no GitHub

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Smart Clinic - Setup Git e GitHub" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar se Git está instalado
try {
    $gitVersion = git --version
    Write-Host "✓ Git encontrado: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Git não encontrado. Por favor, instale o Git primeiro." -ForegroundColor Red
    Write-Host "  Download: https://git-scm.com/download/win" -ForegroundColor Yellow
    exit
}

Write-Host ""
Write-Host "IMPORTANTE: Antes de continuar, você precisa:" -ForegroundColor Yellow
Write-Host "  1. Criar um repositório no GitHub (veja GUIA_GITHUB.md)" -ForegroundColor Yellow
Write-Host "  2. Ter a URL do repositório (ex: https://github.com/seu-usuario/smart-clinic.git)" -ForegroundColor Yellow
Write-Host ""

$continuar = Read-Host "Já criou o repositório no GitHub? (S/N)"
if ($continuar -ne "S" -and $continuar -ne "s") {
    Write-Host "Por favor, crie o repositório primeiro. Veja GUIA_GITHUB.md para instruções." -ForegroundColor Yellow
    exit
}

Write-Host ""
Write-Host "Passo 1: Verificando configuração do Git..." -ForegroundColor Cyan

# Verificar configuração do Git
$gitUser = git config --global user.name
$gitEmail = git config --global user.email

if (-not $gitUser -or -not $gitEmail) {
    Write-Host "Git não está configurado. Preciso de algumas informações:" -ForegroundColor Yellow
    if (-not $gitUser) {
        $nome = Read-Host "Digite seu nome completo"
        git config --global user.name $nome
    }
    if (-not $gitEmail) {
        $email = Read-Host "Digite seu email"
        git config --global user.email $email
    }
    Write-Host "✓ Git configurado!" -ForegroundColor Green
} else {
    Write-Host "✓ Git já configurado: $gitUser <$gitEmail>" -ForegroundColor Green
}

Write-Host ""
Write-Host "Passo 2: Inicializando repositório Git..." -ForegroundColor Cyan

if (Test-Path .git) {
    Write-Host "✓ Repositório Git já inicializado" -ForegroundColor Green
} else {
    git init
    Write-Host "✓ Repositório Git inicializado" -ForegroundColor Green
}

Write-Host ""
Write-Host "Passo 3: Adicionando arquivos..." -ForegroundColor Cyan
git add .
Write-Host "✓ Arquivos adicionados" -ForegroundColor Green

Write-Host ""
Write-Host "Passo 4: Fazendo commit inicial..." -ForegroundColor Cyan
$commitMessage = "Initial commit: Smart Clinic Management System"
git commit -m $commitMessage
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Commit realizado com sucesso!" -ForegroundColor Green
} else {
    Write-Host "✗ Erro ao fazer commit" -ForegroundColor Red
    exit
}

Write-Host ""
Write-Host "Passo 5: Configurando repositório remoto..." -ForegroundColor Cyan
Write-Host ""
Write-Host "Cole a URL do seu repositório GitHub:" -ForegroundColor Yellow
Write-Host "  Exemplo: https://github.com/seu-usuario/smart-clinic.git" -ForegroundColor Gray
$repoUrl = Read-Host "URL do repositório"

# Verificar se remote já existe
$remoteExists = git remote get-url origin 2>$null
if ($remoteExists) {
    Write-Host "Remote 'origin' já existe: $remoteExists" -ForegroundColor Yellow
    $atualizar = Read-Host "Deseja atualizar? (S/N)"
    if ($atualizar -eq "S" -or $atualizar -eq "s") {
        git remote remove origin
        git remote add origin $repoUrl
        Write-Host "✓ Remote atualizado" -ForegroundColor Green
    }
} else {
    git remote add origin $repoUrl
    Write-Host "✓ Remote adicionado" -ForegroundColor Green
}

Write-Host ""
Write-Host "Passo 6: Renomeando branch para 'main'..." -ForegroundColor Cyan
git branch -M main
Write-Host "✓ Branch renomeada para 'main'" -ForegroundColor Green

Write-Host ""
Write-Host "Passo 7: Enviando para o GitHub..." -ForegroundColor Cyan
Write-Host ""
Write-Host "⚠️  ATENÇÃO: Se pedir credenciais:" -ForegroundColor Yellow
Write-Host "  - Username: seu username do GitHub" -ForegroundColor Gray
Write-Host "  - Password: use um Personal Access Token (não sua senha!)" -ForegroundColor Gray
Write-Host "  - Veja GUIA_GITHUB.md para criar um token" -ForegroundColor Gray
Write-Host ""
$continuar = Read-Host "Pronto para fazer push? (S/N)"
if ($continuar -eq "S" -or $continuar -eq "s") {
    git push -u origin main
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "✓ SUCESSO! Código enviado para o GitHub!" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "Acesse seu repositório:" -ForegroundColor Cyan
        Write-Host "  $repoUrl" -ForegroundColor White
        Write-Host ""
        Write-Host "Próximo passo: Atualize os links no RESPOSTAS_ASSIGNMENT.md" -ForegroundColor Yellow
    } else {
        Write-Host ""
        Write-Host "✗ Erro ao fazer push. Verifique:" -ForegroundColor Red
        Write-Host "  1. URL do repositório está correta?" -ForegroundColor Yellow
        Write-Host "  2. Você tem permissão no repositório?" -ForegroundColor Yellow
        Write-Host "  3. Está usando um Personal Access Token?" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Veja GUIA_GITHUB.md para mais detalhes." -ForegroundColor Cyan
    }
} else {
    Write-Host "Push cancelado. Execute 'git push -u origin main' quando estiver pronto." -ForegroundColor Yellow
}

Write-Host ""

