# 🚀 Comandos Rápidos - Copiar e Colar

## 📍 ONDE EXECUTAR: PowerShell (Terminal do Windows)

---

## **PASSO 1: Abrir o PowerShell**

1. Pressione `Win + X`
2. Clique em **"Terminal"** ou **"Windows PowerShell"**
3. OU pesquise por "PowerShell" no menu Iniciar

---

## **PASSO 2: Navegar até a Pasta do Projeto**

**Cole este comando no PowerShell:**

```powershell
cd "C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic"
```

Pressione Enter. Você deve ver algo como:
```
PS C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic>
```

---

## **PASSO 3: Iniciar Docker Desktop (MANUAL)**

1. Procure "Docker Desktop" no menu Iniciar
2. Clique para abrir
3. Aguarde ele iniciar (ícone na bandeja ficará verde/azul)

**NÃO execute nada no terminal ainda. Aguarde o Docker Desktop iniciar completamente.**

---

## **PASSO 4: Iniciar MySQL**

**No mesmo PowerShell onde você navegou até a pasta, cole:**

```powershell
docker-compose up -d mysql
```

Pressione Enter. Aguarde alguns segundos.

**Verificar se funcionou:**
```powershell
docker ps
```

Você deve ver algo como:
```
CONTAINER ID   IMAGE          ...   NAMES
abc123def456   mysql:8.4     ...   smart-clinic-mysql
```

---

## **PASSO 5: Iniciar o Backend**

**Abra um NOVO PowerShell** (mantenha o anterior aberto):

1. Pressione `Win + X` → Terminal (ou abra outro PowerShell)
2. Navegue até a pasta:
   ```powershell
   cd "C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic"
   ```

3. Execute o script:
   ```powershell
   .\INICIAR_BACKEND.ps1
   ```

   **OU execute manualmente:**
   ```powershell
   $env:SPRING_PROFILES_ACTIVE="dev"
   $env:APP_JWT_SECRET="change-me-dev-secret-key-for-screenshots-2024"
   cd app
   mvn spring-boot:run
   ```

**Aguarde aparecer:** `Started SmartClinicApplication in X.XXX seconds`

Isso pode levar 30-60 segundos na primeira vez.

---

## **PASSO 6: Criar Usuários de Teste**

**No PRIMEIRO PowerShell** (onde você iniciou o MySQL), execute:

```powershell
.\CRIAR_USUARIOS.ps1
```

**OU manualmente:**
```powershell
docker exec -i smart-clinic-mysql mysql -u smartclinic -psmartclinic smart_clinic < criar-usuarios-teste.sql
```

---

## **PASSO 7: Abrir Portais (MANUAL - no Navegador)**

1. Abra o **Windows Explorer** (Explorador de Arquivos)
2. Navegue até:
   ```
   C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic\frontend
   ```
3. Abra as pastas e os arquivos `.html`:
   - `admin\index.html` → Clique com botão direito → "Abrir com" → Chrome/Firefox/Edge
   - `doctor\index.html` → Mesmo processo
   - `patient\index.html` → Mesmo processo

---

## 📋 RESUMO VISUAL:

```
┌─────────────────────────────────────┐
│  PowerShell 1 (Terminal 1)          │
├─────────────────────────────────────┤
│ cd "C:\Users\rafav\...\smart-clinic"│
│ docker-compose up -d mysql          │
│ .\CRIAR_USUARIOS.ps1                │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│  PowerShell 2 (Terminal 2)          │
├─────────────────────────────────────┤
│ cd "C:\Users\rafav\...\smart-clinic"│
│ .\INICIAR_BACKEND.ps1               │
│ (aguardar backend iniciar)          │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│  Navegador (Chrome/Firefox/Edge)    │
├─────────────────────────────────────┤
│ frontend/admin/index.html           │
│ frontend/doctor/index.html          │
│ frontend/patient/index.html         │
└─────────────────────────────────────┘
```

---

## ⚠️ IMPORTANTE:

- **PowerShell 1:** MySQL e criar usuários
- **PowerShell 2:** Backend Spring Boot (deixe rodando)
- **Navegador:** Abrir os portais HTML

---

## 🔧 Se der erro:

### Erro: "docker-compose: command not found"
```powershell
docker compose up -d mysql
```
(Tente sem hífen: `docker compose` ao invés de `docker-compose`)

### Erro: "cannot find path"
Certifique-se de estar na pasta correta:
```powershell
pwd
```
Deve mostrar: `C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic`

### Erro: "execution of scripts is disabled"
Execute:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## ✅ Credenciais para Login:

- **Admin:** `admin@smartclinic.com` / `senha123`
- **Doctor:** `joao.silva@smartclinic.com` / `senha123`
- **Patient:** `maria.santos@example.com` / `senha123`

---

**Pronto! Agora é só seguir na ordem! 🚀**

