# ⚠️ Instruções Finais - O que fazer agora

## ✅ O que já foi feito automaticamente:

1. ✅ Docker verificado (está instalado)
2. ✅ Maven verificado (versão 3.9.6 instalada)
3. ✅ Java verificado (versão 21 instalada)
4. ✅ Scripts criados para facilitar
5. ✅ SQL de usuários de teste criado

## ⚠️ O que você precisa fazer manualmente:

### PASSO 1: Iniciar Docker Desktop

**IMPORTANTE:** O Docker Desktop precisa estar rodando!

1. Procure por "Docker Desktop" no menu Iniciar
2. Abra o Docker Desktop
3. Aguarde ele iniciar completamente (ícone na bandeja do sistema ficará verde)
4. Verifique se está rodando (deve aparecer um ícone de baleia na bandeja)

### PASSO 2: Iniciar MySQL

Depois que o Docker Desktop estiver rodando, execute:

```powershell
cd "C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic"
docker-compose up -d mysql
```

Aguarde alguns segundos e verifique:

```powershell
docker ps
```

Você deve ver o container `smart-clinic-mysql` rodando.

### PASSO 3: Criar Usuários de Teste

Execute:

```powershell
cd "C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic"
docker exec -i smart-clinic-mysql mysql -u smartclinic -psmartclinic smart_clinic < criar-usuarios-teste.sql
```

### PASSO 4: Iniciar o Backend

Abra um **NOVO terminal** e execute:

```powershell
cd "C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic"
$env:SPRING_PROFILES_ACTIVE="dev"
$env:APP_JWT_SECRET="change-me-dev-secret-key-for-screenshots-2024"
cd app
mvn spring-boot:run
```

**OU use o script:**
```powershell
.\INICIAR_BACKEND.ps1
```

Aguarde aparecer: `Started SmartClinicApplication in X.XXX seconds`

### PASSO 5: Abrir Portais e Capturar Screenshots

1. **Portal Admin:** Abra `frontend/admin/index.html` no navegador
   - Login: `admin@smartclinic.com` / `senha123`
   - Screenshot Q13: Tela de login
   - Screenshot Q16: Adicionar médico (preencha o formulário e capture)

2. **Portal Doctor:** Abra `frontend/doctor/index.html` no navegador
   - Login: `joao.silva@smartclinic.com` / `senha123`
   - Screenshot Q14: Tela de login
   - Screenshot Q18: Lista de consultas

3. **Portal Patient:** Abra `frontend/patient/index.html` no navegador
   - Login: `maria.santos@example.com` / `senha123`
   - Screenshot Q15: Tela de login
   - Screenshot Q17: Buscar médico (digite "João" e capture)

## 📋 Resumo dos Screenshots:

- **Q13:** Admin login screen
- **Q14:** Doctor login screen  
- **Q15:** Patient login screen
- **Q16:** Admin adicionando médico (formulário preenchido ou após sucesso)
- **Q17:** Patient buscando médico (resultados da busca)
- **Q18:** Doctor vendo lista de consultas

## 🔧 Troubleshooting:

### Docker Desktop não inicia:
- Reinicie o computador
- Verifique se a virtualização está habilitada no BIOS
- Reinstale o Docker Desktop se necessário

### Erro ao criar usuários:
- Certifique-se de que o backend já iniciou pelo menos uma vez (para criar as tabelas)
- Tente conectar manualmente ao MySQL e executar o SQL

### Backend não inicia:
- Verifique se o MySQL está rodando: `docker ps`
- Verifique os logs: veja o terminal onde executou `mvn spring-boot:run`
- Certifique-se de que a porta 8080 não está em uso

## 📝 Credenciais de Teste:

- **Admin:** admin@smartclinic.com / senha123
- **Doctor:** joao.silva@smartclinic.com / senha123
- **Patient:** maria.santos@example.com / senha123

---

**Boa sorte! 🚀**

