# Guia Completo: Capturar Screenshots (Questões 13-18)

Este guia te ajudará a iniciar o projeto e capturar todos os screenshots necessários.

---

## **PASSO 1: Preparar o Ambiente**

### 1.1. Verificar Pré-requisitos

Certifique-se de ter instalado:
- ✅ **Java 17+** (verificar: `java -version`)
- ✅ **Maven 3.9+** (verificar: `mvn -version`)
- ✅ **Docker Desktop** (para MySQL)
- ✅ **Navegador** (Chrome, Firefox, Edge, etc.)

### 1.2. Navegar até a Pasta do Projeto

```powershell
cd "C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic"
```

---

## **PASSO 2: Iniciar o MySQL**

Abra um terminal e execute:

```powershell
docker-compose up -d mysql
```

Aguarde alguns segundos e verifique se está rodando:

```powershell
docker ps
```

Você deve ver o container `smart-clinic-mysql` rodando.

---

## **PASSO 3: Configurar Variáveis de Ambiente**

No PowerShell, configure as variáveis (elas são temporárias, apenas para esta sessão):

```powershell
$env:SPRING_PROFILES_ACTIVE="dev"
$env:APP_JWT_SECRET="change-me-dev-secret-key-for-screenshots-2024"
```

**Nota:** O Spring Boot já está configurado para usar as configurações padrão do `application-dev.properties`, então não precisa configurar `SPRING_DATASOURCE_*` (já estão definidas no arquivo).

---

## **PASSO 4: Iniciar o Backend Spring Boot**

Abra um **NOVO terminal** (mantenha o MySQL rodando) e execute:

```powershell
cd "C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic\app"
mvn spring-boot:run
```

Aguarde a aplicação iniciar. Você verá uma mensagem como:
```
Started SmartClinicApplication in X.XXX seconds
```

**O backend estará rodando em:** `http://localhost:8080`

---

## **PASSO 5: Criar Usuários de Teste**

Para fazer login nos portais, você precisa criar usuários no banco. Vou te ajudar a criar scripts SQL.

### Opção 1: Via SQL direto (Recomendado)

1. Conecte ao MySQL:
```powershell
docker exec -it smart-clinic-mysql mysql -u smartclinic -psmartclinic smart_clinic
```

2. Execute os comandos SQL (veja arquivo `criar-usuarios-teste.sql` que vou criar)

### Opção 2: Via API (Depois que o backend estiver rodando)

Você pode criar usuários via API ou diretamente no MySQL.

---

## **PASSO 6: Abrir os Portais Frontend**

### 6.1. Portal Admin
1. Abra o arquivo: `frontend/admin/index.html` no navegador
   - Clique com botão direito → "Abrir com" → seu navegador
   - OU arraste o arquivo para o navegador

### 6.2. Portal Doctor
1. Abra o arquivo: `frontend/doctor/index.html` no navegador

### 6.3. Portal Patient
1. Abra o arquivo: `frontend/patient/index.html` no navegador

**IMPORTANTE:** Os portais precisam que o backend esteja rodando para funcionar!

---

## **PASSO 7: Capturar Screenshots**

### **Questão 13: Admin Portal Login**
1. Abra `frontend/admin/index.html`
2. Você verá a tela de login
3. Capture o screenshot (Windows: `Win + Shift + S` ou `PrtScn`)

### **Questão 14: Doctor Portal Login**
1. Abra `frontend/doctor/index.html`
2. Capture o screenshot da tela de login

### **Questão 15: Patient Portal Login**
1. Abra `frontend/patient/index.html`
2. Capture o screenshot da tela de login

### **Questão 16: Admin Adding Doctor**
1. No portal admin, faça login (veja credenciais abaixo)
2. Preencha o formulário "Adicionar Novo Médico"
3. Capture o screenshot do formulário preenchido OU após clicar em "Adicionar Médico" (com mensagem de sucesso)

### **Questão 17: Patient Searching Doctor**
1. No portal patient, faça login
2. No campo de busca, digite parte do nome de um médico (ex: "João")
3. Clique em "Buscar"
4. Capture o screenshot mostrando os resultados da busca

### **Questão 18: Doctor Viewing Appointments**
1. No portal doctor, faça login
2. A página deve mostrar a lista de consultas do dia
3. Capture o screenshot mostrando a lista (mesmo que vazia, está OK)

---

## **CREDENCIAIS DE TESTE**

Antes de fazer login, você precisa criar os usuários. Veja o próximo passo.

---

## **COMANDOS RÁPIDOS (Tudo de uma vez)**

Copie e cole no PowerShell (um de cada vez):

```powershell
# 1. Navegar até a pasta
cd "C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic"

# 2. Iniciar MySQL
docker-compose up -d mysql

# 3. Configurar variáveis (nova sessão PowerShell)
$env:SPRING_PROFILES_ACTIVE="dev"
$env:APP_JWT_SECRET="change-me-dev-secret-key-for-screenshots-2024"

# 4. Iniciar backend (em novo terminal)
cd app
mvn spring-boot:run
```

---

## **TROUBLESHOOTING**

### Erro: "Cannot connect to MySQL"
- Verifique se o Docker está rodando
- Verifique se o container está ativo: `docker ps`
- Aguarde alguns segundos após `docker-compose up`

### Erro: "Port 8080 already in use"
- Pare outras aplicações na porta 8080
- OU mude a porta no `application-dev.properties`

### Frontend não conecta ao backend
- Verifique se o backend está rodando em `http://localhost:8080`
- Verifique o console do navegador (F12) para erros
- Certifique-se de que não há problemas de CORS

### Erro de login
- Verifique se os usuários foram criados no banco
- Verifique se as senhas estão corretas (devem ser hashes BCrypt)

---

**Vou criar agora um script SQL para criar os usuários de teste!**

