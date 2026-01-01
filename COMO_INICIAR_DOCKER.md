# 🐳 Como Iniciar o Docker Desktop

## Método 1: Pelo Menu Iniciar (Mais Fácil)

1. **Pressione a tecla `Windows`** (ou clique no botão Iniciar)
2. **Digite:** `Docker Desktop`
3. **Clique** no aplicativo "Docker Desktop" que aparecer
4. **Aguarde** ele iniciar (pode levar 30-60 segundos)

### Como saber que está rodando:
- Você verá um **ícone de baleia** 🐳 na **bandeja do sistema** (canto inferior direito)
- O ícone ficará **verde** ou **azul** quando estiver pronto
- Se passar o mouse sobre ele, aparecerá "Docker Desktop is running"

---

## Método 2: Pelo Explorador de Arquivos

1. Abra o **Explorador de Arquivos** (pasta amarela)
2. Vá para: `C:\Program Files\Docker\Docker\`
3. Clique duas vezes em: **`Docker Desktop.exe`**

---

## Método 3: Pelo PowerShell (Tentar iniciar automaticamente)

Tente executar no PowerShell:

```powershell
Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"
```

**OU se estiver em outro local:**

```powershell
& "C:\Program Files\Docker\Docker\Docker Desktop.exe"
```

---

## ⏳ Tempo de Inicialização

- **Primeira vez:** Pode levar 1-2 minutos
- **Próximas vezes:** 30-60 segundos

---

## ✅ Verificar se Está Rodando

Depois de iniciar, **abra o PowerShell** e execute:

```powershell
docker ps
```

Se aparecer uma lista (mesmo que vazia) ou uma mensagem de erro sobre conexão, significa que está tentando conectar. Se aparecer algo como:

```
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

Ou nenhum erro, está funcionando!

**Se aparecer erro "cannot find the file specified":**
- O Docker Desktop ainda não terminou de iniciar
- Aguarde mais alguns segundos e tente novamente

---

## ⚠️ Problemas Comuns

### Docker Desktop não aparece no menu:
- **Solução:** Procure na pasta `C:\Program Files\Docker\Docker\`
- Se não encontrar, pode não estar instalado

### Docker não inicia:
- Verifique se o **WSL 2** está instalado (requisito do Docker Desktop)
- Reinicie o computador
- Verifique se há atualizações pendentes do Windows

### Docker inicia mas não conecta:
- Feche e abra o Docker Desktop novamente
- Reinicie o computador se necessário

---

## 🚀 Depois que o Docker estiver rodando:

Execute no PowerShell:

```powershell
cd "C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic"
docker-compose up -d mysql
```

E continue com os outros passos!

---

**Dica:** Deixe o Docker Desktop rodando em segundo plano. Ele não precisa ser fechado.
