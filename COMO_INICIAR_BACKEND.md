# 🚀 Como Iniciar o Backend - Guia Rápido

## ⚡ Método Rápido (Recomendado):

### Opção 1: Usar o script automático

```powershell
cd "C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic"
.\INICIAR_TUDO.ps1
```

Isso irá:
- ✅ Iniciar MySQL
- ✅ Iniciar Backend em nova janela
- ✅ Configurar variáveis automaticamente

---

### Opção 2: Manual (Passo a Passo)

#### 1. Abrir PowerShell

#### 2. Navegar até a pasta:
```powershell
cd "C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic"
```

#### 3. Configurar variáveis:
```powershell
$env:SPRING_PROFILES_ACTIVE="dev"
$env:APP_JWT_SECRET="change-me-dev-secret-key-for-screenshots-2024"
```

#### 4. Navegar para pasta app:
```powershell
cd app
```

#### 5. Iniciar backend:
```powershell
mvn spring-boot:run
```

---

## ⏱️ Tempo de Inicialização:

- **Primeira vez:** 60-90 segundos (baixa dependências)
- **Próximas vezes:** 30-60 segundos

---

## ✅ Como saber que está rodando:

Você verá no terminal:
```
Started SmartClinicApplication in X.XXX seconds
```

**OU** execute em outro terminal:
```powershell
.\VERIFICAR_BACKEND.ps1
```

---

## 🔧 Troubleshooting:

### Erro: "Cannot connect to MySQL"
- Verifique se MySQL está rodando: `docker ps`
- Se não estiver: `docker-compose up -d mysql`

### Erro: "Port 8080 already in use"
- Pare outras aplicações na porta 8080
- OU mude a porta no `application-dev.properties`

### Backend inicia mas não responde
- Aguarde mais alguns segundos (pode levar tempo)
- Verifique os logs no terminal onde iniciou
- Verifique se MySQL está acessível

---

## 📋 Checklist:

- [ ] Docker Desktop rodando
- [ ] MySQL rodando (`docker ps`)
- [ ] Variáveis configuradas
- [ ] Backend iniciando (`mvn spring-boot:run`)
- [ ] Aguardou 30-60 segundos
- [ ] Viu mensagem "Started SmartClinicApplication"

---

**Depois que o backend estiver rodando, você pode usar os portais normalmente! 🎉**

