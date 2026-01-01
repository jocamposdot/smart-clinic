# 🤖 Captura Automática de Screenshots com Playwright

## 🚀 Instalação Rápida:

### 1. Instalar Node.js (se não tiver)

Baixe em: https://nodejs.org/ (versão LTS)

### 2. Instalar Playwright

No PowerShell, execute:

```powershell
cd "C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic"
npm install
npx playwright install chromium
```

### 3. Certificar-se que o backend está rodando

O backend precisa estar rodando em `http://localhost:8080` para os logins funcionarem.

### 4. Executar o script

```powershell
node capturar-screenshots.js
```

OU:

```powershell
npm run screenshots
```

---

## 📸 O que o script faz:

1. ✅ Abre cada portal automaticamente
2. ✅ Captura Q13, Q14, Q15 (telas de login)
3. ✅ Faz login no admin e preenche formulário (Q16)
4. ✅ Faz login no patient e busca médico (Q17)
5. ✅ Faz login no doctor e mostra consultas (Q18)
6. ✅ Salva todos os screenshots na pasta `screenshots/`

---

## 📁 Screenshots gerados:

Todos os screenshots serão salvos em: `smart-clinic/screenshots/`

- `q13-admin-login.png`
- `q14-doctor-login.png`
- `q15-patient-login.png`
- `q16-admin-add-doctor.png`
- `q17-patient-search-doctor.png`
- `q18-doctor-appointments.png`

---

## ⚠️ Requisitos:

- ✅ Backend rodando em `http://localhost:8080`
- ✅ Usuários criados no banco (execute `.\CRIAR_USUARIOS.ps1` antes)
- ✅ Node.js instalado
- ✅ Playwright instalado

---

## 🔧 Troubleshooting:

### Erro: "playwright not found"
```powershell
npm install
npx playwright install chromium
```

### Erro: "Cannot connect to backend"
- Verifique se o backend está rodando
- Teste: `curl http://localhost:8080/api/doctors`

### Screenshots não aparecem
- Verifique se a pasta `screenshots/` foi criada
- Verifique se o backend está respondendo

---

**Pronto! Execute o script e todos os screenshots serão capturados automaticamente! 🎉**

