# 📸 Guia: Capturar Screenshots (Questões 13-18)

## ✅ Status Atual:

- ✅ Docker Desktop rodando
- ✅ MySQL iniciado na porta 3307
- ✅ Usuários de teste criados
- ⏳ Backend precisa ser iniciado
- ⏳ Portais precisam ser abertos

---

## 🚀 PASSO 1: Iniciar o Backend

Abra um **NOVO PowerShell** e execute:

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

**Aguarde aparecer:** `Started SmartClinicApplication in X.XXX seconds`

Isso pode levar 30-60 segundos.

---

## 🌐 PASSO 2: Abrir os Portais

**Depois que o backend iniciar**, execute:

```powershell
cd "C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic"
.\ABRIR_PORTALS.ps1
```

**OU abra manualmente no navegador:**
1. Vá até: `C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic\frontend`
2. Abra as pastas e clique duas vezes nos arquivos `index.html`:
   - `admin\index.html`
   - `doctor\index.html`
   - `patient\index.html`

---

## 📋 PASSO 3: Credenciais para Login

Use estas credenciais para fazer login:

- **Admin:** `admin@smartclinic.com` / `senha123`
- **Doctor:** `joao.silva@smartclinic.com` / `senha123`
- **Patient:** `maria.santos@example.com` / `senha123`

---

## 📸 PASSO 4: Capturar Screenshots

### **Questão 13: Admin Portal Login Screen**

1. No portal admin (já deve estar aberto)
2. Você verá a tela de login com campos de email e senha
3. **Capture o screenshot** (Windows: `Win + Shift + S` ou `PrtScn`)
4. **Salve como:** `q13-admin-login.png`

---

### **Questão 14: Doctor Portal Login Screen**

1. No portal doctor (já deve estar aberto)
2. Você verá a tela de login
3. **Capture o screenshot**
4. **Salve como:** `q14-doctor-login.png`

---

### **Questão 15: Patient Portal Login Screen**

1. No portal patient (já deve estar aberto)
2. Você verá a tela de login
3. **Capture o screenshot**
4. **Salve como:** `q15-patient-login.png`

---

### **Questão 16: Admin Adding Doctor**

1. No portal admin, **faça login:**
   - Email: `admin@smartclinic.com`
   - Senha: `senha123`

2. Você verá o formulário "Adicionar Novo Médico"

3. **Preencha o formulário** (exemplo):
   - Nome: `Dr. Maria Costa`
   - Email: `maria.costa@smartclinic.com`
   - Telefone: `(11) 98765-4323`
   - Especialidade: `Pediatria`
   - Senha: `senha123`
   - Horários Disponíveis: `08:00,09:00,14:00,15:00`

4. **Capture o screenshot** ANTES de clicar em "Adicionar Médico" (formulário preenchido)
   - **OU** capture DEPOIS de adicionar (mostrando mensagem de sucesso)

5. **Salve como:** `q16-admin-add-doctor.png`

---

### **Questão 17: Patient Searching Doctor**

1. No portal patient, **faça login:**
   - Email: `maria.santos@example.com`
   - Senha: `senha123`

2. Você verá o campo de busca "Buscar Médico"

3. **Digite no campo de busca:** `João` (ou `Silva`)

4. **Clique no botão "Buscar"**

5. **Capture o screenshot** mostrando:
   - O campo de busca com o texto digitado
   - Os resultados da busca abaixo (médico encontrado)

6. **Salve como:** `q17-patient-search-doctor.png`

---

### **Questão 18: Doctor Viewing Appointments**

1. No portal doctor, **faça login:**
   - Email: `joao.silva@smartclinic.com`
   - Senha: `senha123`

2. A página deve mostrar automaticamente a seção "Minhas Consultas"

3. **Capture o screenshot** mostrando:
   - O título "Minhas Consultas"
   - A lista de consultas (pode estar vazia ou mostrar consultas - ambos estão OK)
   - OU a mensagem "Nenhuma consulta agendada para hoje" (também OK)

4. **Salve como:** `q18-doctor-appointments.png`

---

## 💡 Dicas para Screenshots:

1. **Use Windows + Shift + S** para captura rápida
2. **OU use PrtScn** e cole no Paint/Editor
3. **Salve em formato PNG** (melhor qualidade)
4. **Certifique-se de que o texto está legível**
5. **Capture a tela inteira ou a área relevante**

---

## ✅ Checklist Final:

- [ ] Backend iniciado e rodando
- [ ] Portal Admin aberto e screenshot Q13 capturado
- [ ] Portal Doctor aberto e screenshot Q14 capturado
- [ ] Portal Patient aberto e screenshot Q15 capturado
- [ ] Login feito no admin e screenshot Q16 capturado
- [ ] Login feito no patient e screenshot Q17 capturado
- [ ] Login feito no doctor e screenshot Q18 capturado
- [ ] Todos os screenshots salvos com nomes apropriados

---

## 🎯 Próximo Passo:

Depois de capturar todos os screenshots, você pode:
1. Enviá-los nas questões 13-18 do assignment
2. Continuar com as questões 19-26 (SQL e Curl)

---

**Boa sorte com os screenshots! 📸**

