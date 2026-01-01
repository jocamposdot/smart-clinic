# Respostas para o Assignment - Smart Clinic Management System

Este documento contém todas as respostas organizadas para as 26 questões do assignment.

---

## **QUESTÕES 1-12: LINKS DO GITHUB**

> **IMPORTANTE**: Os links abaixo já estão configurados para o repositório: `https://github.com/jocamposdot/smart-clinic`

### **Questão 1 - User Stories (9 pontos)**
**Link:**
```
https://github.com/jocamposdot/smart-clinic/blob/main/user_stories.md
```

**Critérios atendidos:**
- ✅ User stories escritas usando formato baseado em roles
- ✅ Cobre todas as funcionalidades principais da aplicação (Doctor, Patient, Admin)

---

### **Questão 2 - Schema Design (5 pontos)**
**Link:**
```
https://github.com/jocamposdot/smart-clinic/blob/main/schema-design.md
```

**Critérios atendidos:**
- ✅ MySQL schema design inclui pelo menos 4 tabelas bem definidas
- ✅ Nomes de campos apropriados, tipos de dados e relacionamentos com foreign keys

---

### **Questão 3 - Doctor.java (8 pontos)**
**Link:**
```
https://github.com/jocamposdot/smart-clinic/blob/main/app/src/main/java/com/project/back_end/models/Doctor.java
```

**Critérios atendidos:**
- ✅ Define entidade JPA com anotações de chave primária adequadas (5 pontos)
- ✅ Define campo `availableTimes` com tipo e anotação corretos (3 pontos)
  - Tipo: `List<LocalTime>`
  - Anotação: `@ElementCollection` com `@CollectionTable`

---

### **Questão 4 - Appointment.java (6 pontos)**
**Link:**
```
https://github.com/jocamposdot/smart-clinic/blob/main/app/src/main/java/com/project/back_end/models/Appointment.java
```

**Critérios atendidos:**
- ✅ Define relacionamentos `@ManyToOne` apropriados com Doctor e Patient (3 pontos)
- ✅ Campo `appointmentTime` do tipo `LocalDateTime` com anotações de validação (3 pontos)
  - Anotação: `@NotNull`, `@Future`

---

### **Questão 5 - DoctorController.java (6 pontos)**
**Link:**
```
https://github.com/jocamposdot/smart-clinic/blob/main/app/src/main/java/com/project/back_end/controllers/DoctorController.java
```

**Critérios atendidos:**
- ✅ Expõe endpoint GET para disponibilidade do médico usando parâmetros dinâmicos (3 pontos)
  - Endpoint: `GET /api/doctors/{doctorId}/availability?date={date}`
- ✅ Valida token e retorna resposta estruturada usando ResponseEntity (3 pontos)

---

### **Questão 6 - AppointmentService.java (6 pontos)**
**Link:**
```
https://github.com/jocamposdot/smart-clinic/blob/main/app/src/main/java/com/project/back_end/services/AppointmentService.java
```

**Critérios atendidos:**
- ✅ Implementa método de booking que salva um appointment (3 pontos)
  - Método: `bookAppointment(Long doctorId, Long patientId, LocalDateTime appointmentTime)`
- ✅ Define método para recuperar appointments de um médico em uma data específica (3 pontos)
  - Método: `getAppointmentsForDoctorOnDate(Long doctorId, LocalDate date)`

---

### **Questão 7 - PrescriptionController.java (6 pontos)**
**Link:**
```
https://github.com/jocamposdot/smart-clinic/blob/main/app/src/main/java/com/project/back_end/controllers/PrescriptionController.java
```

**Critérios atendidos:**
- ✅ Endpoint POST salva prescrição com validação de token e request body (3 pontos)
  - Endpoint: `POST /api/prescriptions`
  - Validação: `@Valid @RequestBody` + token via `AuthService`
- ✅ Retorna mensagens estruturadas de sucesso ou erro usando ResponseEntity (3 pontos)

---

### **Questão 8 - PatientRepository.java (4 pontos)**
**Link:**
```
https://github.com/jocamposdot/smart-clinic/blob/main/app/src/main/java/com/project/back_end/repo/PatientRepository.java
```

**Critérios atendidos:**
- ✅ Método recupera paciente por email usando query derivada ou customizada (2 pontos)
  - Método: `Optional<Patient> findByEmail(String email)`
- ✅ Método recupera paciente usando email ou telefone (2 pontos)
  - Método: `Optional<Patient> findByEmailOrPhone(String email, String phone)`

---

### **Questão 9 - TokenService.java (5 pontos)**
**Link:**
```
https://github.com/jocamposdot/smart-clinic/blob/main/app/src/main/java/com/project/back_end/services/TokenService.java
```

**Critérios atendidos:**
- ✅ Define método para gerar token JWT usando o email do usuário (3 pontos)
  - Método: `generateToken(String email)`
- ✅ Implementa método para retornar a signing key usando o secret configurado (2 pontos)
  - Método: `getSigningKey()`

---

### **Questão 10 - DoctorService.java (5 pontos)**
**Link:**
```
https://github.com/jocamposdot/smart-clinic/blob/main/app/src/main/java/com/project/back_end/services/DoctorService.java
```

**Critérios atendidos:**
- ✅ Método retorna time slots disponíveis para médico em uma data (3 pontos)
  - Método: `getAvailableTimeSlots(Long doctorId, LocalDate date)`
- ✅ Método valida credenciais de login e retorna resposta estruturada (2 pontos)
  - Método: `login(LoginRequest request)` retorna `ApiResponse<LoginResponse>`

---

### **Questão 11 - Dockerfile (5 pontos)**
**Link:**
```
https://github.com/jocamposdot/smart-clinic/blob/main/Dockerfile
```

**Critérios atendidos:**
- ✅ Usa multi-stage build para compilar aplicação Spring Boot (3 pontos)
  - Stage 1: `maven:3.9.9-eclipse-temurin-17` para build
  - Stage 2: `eclipse-temurin:17-jre` para runtime
- ✅ Define configuração de runtime incluindo entrypoint e porta exposta (2 pontos)
  - `EXPOSE 8080`
  - `ENTRYPOINT ["java", "-jar", "/app/app.jar"]`

---

### **Questão 12 - GitHub Actions Workflow (5 pontos)**
**Link:**
```
https://github.com/jocamposdot/smart-clinic/blob/main/.github/workflows/compile-backend.yml
```

**Critérios atendidos:**
- ✅ Configura job para configurar Java e compilar usando Maven (3 pontos)
  - Usa `actions/setup-java@v4` com JDK 17
  - Executa `mvn clean compile`
- ✅ Automaticamente acionado em eventos push ou pull request (2 pontos)
  - `on: push: branches: [main, master]`
  - `on: pull_request: branches: [main, master]`

---

## **QUESTÕES 13-18: SCREENSHOTS**

Para estas questões, você precisará:
1. Iniciar o backend Spring Boot
2. Abrir os portais frontend no navegador
3. Fazer login e navegar pelas funcionalidades
4. Capturar screenshots

### **Configuração para Screenshots:**

1. **Iniciar o backend:**
   ```bash
   cd smart-clinic/app
   mvn spring-boot:run
   ```

2. **Abrir os portais:**
   - Admin: Abra `frontend/admin/index.html` no navegador
   - Doctor: Abra `frontend/doctor/index.html` no navegador
   - Patient: Abra `frontend/patient/index.html` no navegador

3. **Credenciais de teste:**
   - Você precisará criar usuários no banco de dados primeiro (via API ou diretamente no MySQL)

### **Questão 13 - Admin Portal Login (1 ponto)**
**Instruções:**
1. Abra `frontend/admin/index.html` no navegador
2. Você verá a tela de login do portal admin
3. Capture um screenshot da tela de login

**O que mostrar:**
- Tela de login do portal admin
- Campos de email e senha
- Botão "Entrar"

---

### **Questão 14 - Doctor Portal Login (1 ponto)**
**Instruções:**
1. Abra `frontend/doctor/index.html` no navegador
2. Você verá a tela de login do portal médico
3. Capture um screenshot da tela de login

**O que mostrar:**
- Tela de login do portal médico
- Campos de email e senha
- Botão "Entrar"

---

### **Questão 15 - Patient Portal Login (1 ponto)**
**Instruções:**
1. Abra `frontend/patient/index.html` no navegador
2. Você verá a tela de login do portal paciente
3. Capture um screenshot da tela de login

**O que mostrar:**
- Tela de login do portal paciente
- Campos de email e senha
- Botão "Entrar"

---

### **Questão 16 - Admin Adding Doctor (1 ponto)**
**Instruções:**
1. Faça login no portal admin
2. Preencha o formulário "Adicionar Novo Médico" com dados de exemplo:
   - Nome: Dr. João Silva
   - Email: joao.silva@clinic.com
   - Telefone: (11) 98765-4321
   - Especialidade: Cardiologia
   - Senha: senha123
   - Horários Disponíveis: 09:00,10:00,14:00,15:00
3. Capture um screenshot mostrando o formulário preenchido (ou após adicionar com sucesso)

**O que mostrar:**
- Portal admin logado
- Formulário de adicionar médico (preenchido ou após sucesso)
- Mensagem de sucesso (se aplicável)

---

### **Questão 17 - Patient Searching Doctor (1 ponto)**
**Instruções:**
1. Faça login no portal paciente
2. No campo de busca, digite parte do nome de um médico (ex: "João" ou "Silva")
3. Clique em "Buscar"
4. Capture um screenshot mostrando os resultados da busca

**O que mostrar:**
- Portal paciente logado
- Campo de busca com nome digitado
- Resultados da busca mostrando médico(s) encontrado(s)

---

### **Questão 18 - Doctor Viewing Appointments (1 ponto)**
**Instruções:**
1. Faça login no portal médico
2. A página deve mostrar automaticamente a lista de consultas do dia
3. Se não houver consultas, você verá a mensagem "Nenhuma consulta agendada para hoje"
4. Capture um screenshot mostrando a lista de consultas (ou a mensagem vazia)

**O que mostrar:**
- Portal médico logado
- Seção "Minhas Consultas"
- Lista de consultas (ou mensagem indicando que não há consultas)

---

## **QUESTÕES 19-23: SQL OUTPUTS**

Para estas questões, você precisará:
1. Conectar ao banco de dados MySQL
2. Executar os comandos SQL
3. Copiar o output exato

### **Questão 19 - Show Tables (3 pontos)**
**Comando SQL:**
```sql
SHOW TABLES;
```

**Output esperado (exemplo):**
```
+----------------------------------+
| Tables_in_smart_clinic           |
+----------------------------------+
| admins                           |
| appointments                     |
| doctor_available_times           |
| doctors                          |
| patients                         |
| prescriptions                    |
+----------------------------------+
6 rows in set (0.00 sec)
```

**Instruções:**
1. Conecte ao MySQL: `mysql -u root -p`
2. Use o banco: `USE smart_clinic;` (ou o nome do seu banco)
3. Execute: `SHOW TABLES;`
4. Copie o output completo e cole na resposta

---

### **Questão 20 - Select 5 Patients (3 pontos)**
**Comando SQL:**
```sql
SELECT * FROM patients LIMIT 5;
```

**Output esperado (exemplo):**
```
+------------+------------------+--------------------------+------------------+---------------------+---------------------+
| patient_id | name             | email                    | phone            | password_hash       | created_at          |
+------------+------------------+--------------------------+------------------+---------------------+---------------------+
|          1 | Maria Santos     | maria@example.com        | (11) 98765-4321  | $2a$10$...          | 2024-01-15 10:00:00 |
|          2 | João Oliveira    | joao@example.com         | (11) 98765-4322  | $2a$10$...          | 2024-01-15 10:05:00 |
|          3 | Ana Costa        | ana@example.com          | (11) 98765-4323  | $2a$10$...          | 2024-01-15 10:10:00 |
|          4 | Pedro Alves      | pedro@example.com        | (11) 98765-4324  | $2a$10$...          | 2024-01-15 10:15:00 |
|          5 | Julia Ferreira   | julia@example.com        | (11) 98765-4325  | $2a$10$...          | 2024-01-15 10:20:00 |
+------------+------------------+--------------------------+------------------+---------------------+---------------------+
5 rows in set (0.00 sec)
```

**Instruções:**
1. Execute: `SELECT * FROM patients LIMIT 5;`
2. Copie o output completo (incluindo headers e rodapé)

---

### **Questão 21 - GetDailyAppointmentReportByDoctor (3 pontos)**
**Comando SQL:**
```sql
CALL GetDailyAppointmentReportByDoctor(1, '2024-01-20');
```

**Nota:** Substitua `1` pelo ID de um médico existente e `'2024-01-20'` por uma data que tenha appointments.

**Output esperado (exemplo):**
```
+----------------+---------------------+----------+------------+--------------+-------------------+
| appointment_id | appointment_time    | status   | patient_id | patient_name | patient_email     |
+----------------+---------------------+----------+------------+--------------+-------------------+
|              1 | 2024-01-20 09:00:00 | BOOKED   |          1 | Maria Santos | maria@example.com |
|              2 | 2024-01-20 10:00:00 | BOOKED   |          2 | João Oliveira| joao@example.com  |
+----------------+---------------------+----------+------------+--------------+-------------------+
2 rows in set (0.00 sec)
```

**Instruções:**
1. Identifique o ID de um médico que tenha appointments: `SELECT doctor_id FROM appointments LIMIT 1;`
2. Identifique uma data com appointments: `SELECT DATE(appointment_time) as date FROM appointments LIMIT 1;`
3. Execute: `CALL GetDailyAppointmentReportByDoctor(<doctor_id>, '<date>');`
4. Copie o output completo

---

### **Questão 22 - GetDoctorWithMostPatientsByMonth (3 pontos)**
**Comando SQL:**
```sql
CALL GetDoctorWithMostPatientsByMonth(2024, 1);
```

**Nota:** Ajuste o ano e mês conforme seus dados.

**Output esperado (exemplo):**
```
+-----------+--------------+-------------+---------------------------+
| doctor_id | name         | specialty   | total_distinct_patients   |
+-----------+--------------+-------------+---------------------------+
|         1 | Dr. João Silva| Cardiologia|                         5 |
+-----------+--------------+-------------+---------------------------+
1 row in set (0.00 sec)
```

**Instruções:**
1. Execute: `CALL GetDoctorWithMostPatientsByMonth(2024, 1);` (ajuste ano/mês)
2. Se não houver resultados, tente outro mês/ano ou crie dados de teste
3. Copie o output completo

---

### **Questão 23 - GetDoctorWithMostPatientsByYear (3 pontos)**
**Comando SQL:**
```sql
CALL GetDoctorWithMostPatientsByYear(2024);
```

**Output esperado (exemplo):**
```
+-----------+--------------+-------------+---------------------------+
| doctor_id | name         | specialty   | total_distinct_patients   |
+-----------+--------------+-------------+---------------------------+
|         1 | Dr. João Silva| Cardiologia|                        10 |
+-----------+--------------+-------------+---------------------------+
1 row in set (0.00 sec)
```

**Instruções:**
1. Execute: `CALL GetDoctorWithMostPatientsByYear(2024);` (ajuste o ano)
2. Copie o output completo

---

## **QUESTÕES 24-26: CURL OUTPUTS**

Para estas questões, você precisará:
1. Ter o backend rodando em `http://localhost:8080`
2. Ter dados no banco (doctors, appointments, etc.)
3. Executar os comandos curl e copiar o output

### **Questão 24 - GET All Doctors (3 pontos)**
**Comando curl:**
```bash
curl -X GET http://localhost:8080/api/doctors
```

**Output esperado (exemplo):**
```json
{
  "success": true,
  "message": "OK",
  "data": [
    {
      "id": 1,
      "name": "Dr. João Silva",
      "email": "joao.silva@clinic.com",
      "phone": "(11) 98765-4321",
      "specialty": "Cardiologia",
      "availableTimes": ["09:00", "10:00", "14:00", "15:00"],
      "createdAt": "2024-01-15T10:00:00"
    },
    {
      "id": 2,
      "name": "Dr. Maria Santos",
      "email": "maria.santos@clinic.com",
      "phone": "(11) 98765-4322",
      "specialty": "Pediatria",
      "availableTimes": ["08:00", "09:00", "13:00"],
      "createdAt": "2024-01-15T10:05:00"
    }
  ]
}
```

**Instruções:**
1. Certifique-se de que o backend está rodando
2. Execute o comando curl no terminal
3. Copie o output JSON completo

---

### **Questão 25 - GET Patient Appointments (3 pontos)**
**Comando curl (com credenciais de login):**

**Passo 1: Fazer login e obter token**
```bash
TOKEN=$(curl -X POST http://localhost:8080/api/auth/patient/login \
  -H "Content-Type: application/json" \
  -d '{"email":"maria@example.com","password":"senha123"}' \
  | jq -r '.data.token')
```

**Passo 2: Buscar appointments do paciente**
```bash
curl -X GET http://localhost:8080/api/patients/me/appointments \
  -H "Authorization: Bearer $TOKEN"
```

**Output esperado (exemplo):**
```json
{
  "success": true,
  "message": "OK",
  "data": [
    {
      "id": 1,
      "doctor": {
        "id": 1,
        "name": "Dr. João Silva",
        "specialty": "Cardiologia"
      },
      "appointmentTime": "2024-01-20T09:00:00",
      "status": "BOOKED",
      "createdAt": "2024-01-15T10:00:00"
    },
    {
      "id": 2,
      "doctor": {
        "id": 2,
        "name": "Dr. Maria Santos",
        "specialty": "Pediatria"
      },
      "appointmentTime": "2024-01-21T14:00:00",
      "status": "BOOKED",
      "createdAt": "2024-01-16T11:00:00"
    }
  ]
}
```

**Instruções:**
1. Substitua `maria@example.com` e `senha123` por credenciais reais de um paciente
2. Execute os comandos (ou combine em um único curl se preferir)
3. O endpoint usado é `/api/patients/me/appointments` (definido no `PatientController`)
4. Copie o output JSON completo

---

### **Questão 26 - GET Doctors by Specialty and Time (3 pontos)**
**Comando curl:**
```bash
curl -X GET "http://localhost:8080/api/doctors/filter?specialty=Cardiologia&time=09:00"
```

**Output esperado (exemplo):**
```json
{
  "success": true,
  "message": "OK",
  "data": [
    {
      "id": 1,
      "name": "Dr. João Silva",
      "email": "joao.silva@clinic.com",
      "phone": "(11) 98765-4321",
      "specialty": "Cardiologia",
      "availableTimes": ["09:00", "10:00", "14:00", "15:00"],
      "createdAt": "2024-01-15T10:00:00"
    }
  ]
}
```

**Instruções:**
1. Escolha uma especialidade que exista no banco (ex: "Cardiologia", "Pediatria")
2. Escolha um horário que esteja nos `availableTimes` de pelo menos um médico dessa especialidade
3. Execute o comando curl (use aspas para a URL com parâmetros)
4. Copie o output JSON completo

---

## **NOTAS FINAIS**

1. **Antes de enviar:**
   - Substitua todos os `<seu-usuario>` e `<seu-repo>` pelos valores reais
   - Certifique-se de que todos os arquivos estão commitados e pushados para o GitHub
   - Verifique que os links estão acessíveis publicamente
   - Execute todos os comandos SQL e curl para garantir que funcionam
   - Capture os screenshots com a aplicação funcionando

2. **Estrutura do repositório:**
   ```
   seu-repo/
   ├── user_stories.md
   ├── schema-design.md
   ├── Dockerfile
   ├── .github/workflows/compile-backend.yml
   ├── app/
   │   └── src/main/java/com/project/back_end/
   │       ├── models/
   │       │   ├── Doctor.java
   │       │   └── Appointment.java
   │       ├── controllers/
   │       │   ├── DoctorController.java
   │       │   └── PrescriptionController.java
   │       ├── services/
   │       │   ├── AppointmentService.java
   │       │   ├── DoctorService.java
   │       │   └── TokenService.java
   │       └── repo/
   │           └── PatientRepository.java
   └── frontend/
       ├── admin/
       ├── doctor/
       └── patient/
   ```

3. **Dicas:**
   - Teste todos os endpoints antes de copiar os outputs
   - Certifique-se de que o banco de dados tem dados suficientes para as queries SQL
   - Para os screenshots, use uma resolução adequada e certifique-se de que o texto está legível
   - Para os outputs SQL/curl, copie exatamente como aparece (incluindo headers e formatação)

---

**Boa sorte com o assignment! 🚀**

