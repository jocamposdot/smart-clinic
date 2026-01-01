# Status do Projeto - Smart Clinic

## ✅ O que já foi feito:

1. ✅ Repositório Git inicializado
2. ✅ Código enviado para GitHub: https://github.com/jocamposdot/smart-clinic
3. ✅ MySQL iniciado via Docker
4. ✅ Usuários de teste criados no banco

## 🔄 Próximos passos:

### Para capturar screenshots (Q13-Q18):

1. **Iniciar o backend Spring Boot:**
   ```powershell
   cd "C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic"
   .\INICIAR_BACKEND.ps1
   ```
   
   OU manualmente:
   ```powershell
   cd app
   $env:SPRING_PROFILES_ACTIVE="dev"
   $env:APP_JWT_SECRET="change-me-dev-secret-key-for-screenshots-2024"
   mvn spring-boot:run
   ```

2. **Aguardar o backend iniciar** (você verá: `Started SmartClinicApplication`)

3. **Abrir os portais no navegador:**
   - `frontend/admin/index.html`
   - `frontend/doctor/index.html`
   - `frontend/patient/index.html`

4. **Fazer login e capturar screenshots:**
   - **Admin:** `admin@smartclinic.com` / `senha123`
   - **Doctor:** `joao.silva@smartclinic.com` / `senha123`
   - **Patient:** `maria.santos@example.com` / `senha123`

## 📋 Credenciais de Teste:

- **Admin:** admin@smartclinic.com / senha123
- **Doctor:** joao.silva@smartclinic.com / senha123
- **Patient:** maria.santos@example.com / senha123

## 🐳 Comandos Úteis:

```powershell
# Ver status do MySQL
docker ps

# Parar MySQL
docker-compose down

# Reiniciar MySQL
docker-compose restart mysql

# Ver logs do MySQL
docker logs smart-clinic-mysql

# Conectar ao MySQL
docker exec -it smart-clinic-mysql mysql -u smartclinic -psmartclinic smart_clinic
```

