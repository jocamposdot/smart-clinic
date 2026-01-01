# 📸 RESUMO RÁPIDO: Capturar Screenshots Q13-Q18

## ✅ Status Atual:

- ✅ Docker Desktop rodando
- ✅ MySQL rodando na porta 3307
- ✅ Backend iniciando (janela PowerShell aberta)
- ⏳ Aguardando backend terminar de iniciar
- ⏳ Depois criar usuários
- ⏳ Depois abrir portais e capturar screenshots

---

## 🚀 O QUE FAZER AGORA:

### PASSO 1: Aguardar Backend Iniciar

Você deve ter uma **janela PowerShell** aberta onde o backend está iniciando.

**Aguarde aparecer:** `Started SmartClinicApplication in X.XXX seconds`

Isso pode levar 30-60 segundos.

---

### PASSO 2: Criar Usuários (DEPOIS que backend iniciar)

Quando o backend terminar de iniciar, **em outro PowerShell**, execute:

```powershell
cd "C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic"
.\CRIAR_USUARIOS.ps1
```

---

### PASSO 3: Abrir Portais

Depois de criar os usuários, execute:

```powershell
.\ABRIR_PORTALS.ps1
```

Isso abrirá os 3 portais no navegador automaticamente!

---

### PASSO 4: Capturar Screenshots

Siga o guia completo em: **`CAPTURAR_SCREENSHOTS.md`**

**Resumo rápido:**

1. **Q13:** Portal Admin - tela de login (sem fazer login)
2. **Q14:** Portal Doctor - tela de login (sem fazer login)
3. **Q15:** Portal Patient - tela de login (sem fazer login)
4. **Q16:** Portal Admin - fazer login → preencher formulário adicionar médico → screenshot
5. **Q17:** Portal Patient - fazer login → buscar "João" → screenshot dos resultados
6. **Q18:** Portal Doctor - fazer login → ver lista de consultas → screenshot

**Credenciais:**
- Admin: `admin@smartclinic.com` / `senha123`
- Doctor: `joao.silva@smartclinic.com` / `senha123`
- Patient: `maria.santos@example.com` / `senha123`

---

## ⏱️ Timeline Estimada:

1. Backend iniciar: 30-60 segundos
2. Criar usuários: 5 segundos
3. Abrir portais: 5 segundos
4. Capturar screenshots: 5-10 minutos

---

## 📋 Checklist:

- [ ] Backend iniciou completamente (visto "Started SmartClinicApplication")
- [ ] Usuários criados (executado .\CRIAR_USUARIOS.ps1)
- [ ] Portais abertos (executado .\ABRIR_PORTALS.ps1)
- [ ] Q13 screenshot capturado
- [ ] Q14 screenshot capturado
- [ ] Q15 screenshot capturado
- [ ] Q16 screenshot capturado
- [ ] Q17 screenshot capturado
- [ ] Q18 screenshot capturado

---

**Tudo está quase pronto! Só aguardar o backend iniciar! 🚀**

