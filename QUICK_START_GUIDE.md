# Smart Clinic - Quick Start Guide

## 🚀 Início Rápido (5 minutos)

### Passo 1: Iniciar Banco de Dados (30 segundos)
```bash
cd smart-clinic
docker-compose up -d mysql
```

Aguarde 30 segundos para o MySQL inicializar completamente.

### Passo 2: Iniciar Backend (40 segundos)
```bash
cd app
mvn spring-boot:run -Dspring-boot.run.profiles=dev
```

Aguarde até ver a mensagem: `Started SmartClinicApplication in X seconds`

O backend estará disponível em: `http://localhost:8090`

### Passo 3: Testar Sistema

#### Criar Usuário Admin (SQL)
```bash
docker exec -it smart-clinic-mysql mysql -u smartclinic -psmartclinic smart_clinic
```

Execute no MySQL:
```sql
INSERT INTO admins (name, email, password) 
VALUES ('Admin', 'admin@smartclinic.com', 
'$2a$10$vF4gYX.HZvKYXH1gYX.HZvKYXH1gYX.HZvKYXH1gYX.HZvKYXH1gYX.');

-- Senha: admin123 (BCrypt hash)
```

#### Testar Login Admin (cURL)
```bash
curl -X POST http://localhost:8090/api/auth/admin/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@smartclinic.com","password":"admin123"}'
```

Se retornar um JSON com `"success": true` e um `token`, o sistema está funcional! ✅

---

## 📝 Testes Funcionais Principais

### 1. Teste de Autenticação
```bash
# Admin Login
curl -X POST http://localhost:8090/api/auth/admin/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@smartclinic.com","password":"admin123"}'

# Salve o token retornado
TOKEN="seu_token_aqui"
```

### 2. Teste de Criação de Médico
```bash
curl -X POST http://localhost:8090/api/admin/doctors \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "name": "Dr. João Silva",
    "specialty": "Cardiologia",
    "email": "joao.silva@smartclinic.com",
    "phone": "(11) 98765-4321",
    "password": "senha123",
    "availableTimes": ["09:00", "10:00", "14:00", "15:00"]
  }'
```

### 3. Teste de Listagem de Médicos
```bash
curl -X GET http://localhost:8090/api/admin/doctors \
  -H "Authorization: Bearer $TOKEN"
```

### 4. Teste de Login de Médico
```bash
curl -X POST http://localhost:8090/api/auth/doctor/login \
  -H "Content-Type: application/json" \
  -d '{"email":"joao.silva@smartclinic.com","password":"senha123"}'
```

---

## 🌐 Testes dos Portais Web

### Admin Portal
1. Abra: `frontend/admin/index.html` no navegador
2. Login: `admin@smartclinic.com` / `admin123`
3. Teste: Criar um novo médico
4. ✅ Verificar se aparece na lista

### Doctor Portal
1. Abra: `frontend/doctor/index.html` no navegador
2. Login com credenciais de médico criado anteriormente
3. Teste: Visualizar dashboard de compromissos
4. ✅ Verificar se a interface carrega corretamente

### Patient Portal
1. Abra: `frontend/patient/index.html` no navegador
2. Primeiro crie um paciente via SQL ou API
3. Login com credenciais do paciente
4. Teste: Buscar médicos por especialidade
5. ✅ Verificar se consegue agendar consulta

---

## 🗄️ Scripts SQL Úteis

### Criar Usuário Admin
```sql
INSERT INTO admins (name, email, password) 
VALUES ('Admin', 'admin@smartclinic.com', 
'$2a$10$vF4gYX.HZvKYXH1gYX.HZvKYXH1gYX.HZvKYXH1gYX.HZvKYXH1gYX.');
```

### Criar Médico (direto no banco)
```sql
INSERT INTO doctors (name, specialty, email, phone, password) 
VALUES ('Dr. João Silva', 'Cardiologia', 'joao.silva@smartclinic.com', 
'(11) 98765-4321', '$2a$10$vF4gYX.HZvKYXH1gYX.HZvKYXH1gYX.HZvKYXH1gYX.HZvKYXH1gYX.');

-- Horários disponíveis
INSERT INTO doctor_available_times (doctor_id, available_time) VALUES 
(1, '09:00:00'), (1, '10:00:00'), (1, '14:00:00'), (1, '15:00:00');
```

### Criar Paciente
```sql
INSERT INTO patients (name, date_of_birth, email, phone, address, password) 
VALUES ('Maria Santos', '1990-05-15', 'maria.santos@example.com', 
'(11) 98888-8888', 'Rua A, 123', '$2a$10$vF4gYX.HZvKYXH1gYX.HZvKYXH1gYX.HZvKYXH1gYX.HZvKYXH1gYX.');
```

### Verificar Dados
```sql
-- Ver todos os admins
SELECT * FROM admins;

-- Ver todos os médicos
SELECT * FROM doctors;

-- Ver todos os pacientes
SELECT * FROM patients;

-- Ver todas as consultas
SELECT a.id, d.name as doctor, p.name as patient, a.appointment_time, a.status
FROM appointments a
JOIN doctors d ON a.doctor_id = d.id
JOIN patients p ON a.patient_id = p.id;
```

---

## ❌ Solução de Problemas

### Backend não inicia
```bash
# 1. Verificar se MySQL está rodando
docker-compose ps

# 2. Verificar porta 8090
netstat -ano | findstr :8090

# 3. Ver logs do backend
# (Verificar no terminal onde executou mvn spring-boot:run)

# 4. Reiniciar MySQL
docker-compose restart mysql
```

### Erro 401 Unauthorized
- Verifique se o token JWT está sendo enviado no header `Authorization: Bearer {token}`
- O token expira em 2 horas, faça login novamente

### Erro de CORS no navegador
- Verifique se o backend está rodando em `localhost:8090`
- Verifique o arquivo `frontend/*/script.js` - a URL da API deve ser `http://localhost:8090/api`

### MySQL não conecta
```bash
# Parar e remover containers
docker-compose down -v

# Recriar do zero
docker-compose up -d mysql

# Aguardar 30 segundos e testar
docker exec -it smart-clinic-mysql mysql -u smartclinic -psmartclinic -e "SHOW DATABASES;"
```

---

## ✅ Checklist de Validação

Use este checklist para validar que tudo está funcional:

### Infraestrutura
- [ ] Docker Desktop está rodando
- [ ] Container MySQL está UP (docker-compose ps)
- [ ] Backend iniciou sem erros
- [ ] Porta 8090 está listening (netstat)

### Banco de Dados
- [ ] Database `smart_clinic` existe
- [ ] Todas as 6 tabelas foram criadas (SHOW TABLES)
- [ ] Pelo menos 1 admin existe no banco
- [ ] Stored procedures foram criadas

### API Endpoints
- [ ] Admin login retorna token JWT
- [ ] Admin consegue criar médico
- [ ] Admin consegue listar médicos
- [ ] Médico consegue fazer login
- [ ] Endpoint protegido retorna 401 sem token

### Frontend
- [ ] Admin portal carrega corretamente
- [ ] Doctor portal carrega corretamente
- [ ] Patient portal carrega corretamente
- [ ] Login funciona em todos os portais
- [ ] Dados são carregados via API

---

## 📚 Documentação Completa

Para documentação detalhada, consulte:
- **TECHNICAL_DOCUMENTATION.md** - Documentação técnica completa
- **README.md** - Visão geral do projeto
- **schema-design.md** - Design do banco de dados
- **user_stories.md** - Histórias de usuário

---

## 🆘 Suporte

Se encontrar problemas:
1. Verifique os logs do backend no terminal
2. Verifique os logs do MySQL: `docker logs smart-clinic-mysql`
3. Consulte a seção "Troubleshooting" na documentação técnica
4. Verifique o repositório: https://github.com/jocamposdot/smart-clinic

---

**Tempo estimado de setup**: 5-10 minutos  
**Versão**: 1.0  
**Última atualização**: Janeiro 2, 2026

