# Guia Completo: Enviar Projeto para o GitHub

Este guia te ajudará a criar o repositório no GitHub e enviar todo o código.

---

## **PASSO 1: Criar Conta/Login no GitHub**

1. Acesse: https://github.com
2. Faça login (ou crie uma conta se não tiver)
3. Anote seu **username** do GitHub (exemplo: `seu-usuario`)

---

## **PASSO 2: Criar Repositório no GitHub**

1. No GitHub, clique no botão **"+"** no canto superior direito
2. Selecione **"New repository"**
3. Preencha:
   - **Repository name**: `smart-clinic` (ou outro nome que preferir, ex: `java-database-capstone`)
   - **Description**: "Smart Clinic Management System - Capstone Project"
   - **Visibility**: ✅ **Public** (deve ser público para o assignment)
   - **NÃO marque** "Add a README file" (já temos um)
   - **NÃO marque** "Add .gitignore" (já temos um)
   - **NÃO marque** "Choose a license"
4. Clique em **"Create repository"**

5. **Anote a URL do repositório** que aparece:
   ```
   https://github.com/seu-usuario/smart-clinic.git
   ```
   (Substitua `seu-usuario` pelo seu username real)

---

## **PASSO 3: Abrir Terminal na Pasta do Projeto**

1. Abra o **PowerShell** ou **Terminal**
2. Navegue até a pasta do projeto:
   ```powershell
   cd "C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic"
   ```

---

## **PASSO 4: Inicializar Git (se ainda não foi feito)**

Execute os seguintes comandos **na ordem**:

```powershell
# 1. Inicializar repositório Git (se ainda não foi feito)
git init

# 2. Adicionar todos os arquivos
git add .

# 3. Fazer o primeiro commit
git commit -m "Initial commit: Smart Clinic Management System"
```

**Nota:** Se você receber erro sobre email/nome, configure primeiro:
```powershell
git config --global user.name "Seu Nome"
git config --global user.email "seu-email@example.com"
```

---

## **PASSO 5: Conectar ao Repositório GitHub e Enviar**

**Substitua `seu-usuario` e `smart-clinic` pelos valores reais do seu repositório:**

```powershell
# 1. Adicionar o repositório remoto (SUBSTITUA a URL pela sua)
git remote add origin https://github.com/seu-usuario/smart-clinic.git

# 2. Renomear branch para main (se necessário)
git branch -M main

# 3. Enviar para o GitHub
git push -u origin main
```

**⚠️ IMPORTANTE:** 
- Na primeira vez, o GitHub pode pedir autenticação
- Você pode precisar usar um **Personal Access Token** ao invés de senha
- Veja instruções abaixo sobre como criar um token

---

## **PASSO 6: Autenticação no GitHub (se solicitado)**

Se o `git push` pedir usuário/senha:

1. **Criar Personal Access Token:**
   - Acesse: https://github.com/settings/tokens
   - Clique em **"Generate new token"** → **"Generate new token (classic)"**
   - Dê um nome: `smart-clinic-project`
   - Selecione escopo: ✅ **repo** (marque todas as opções de "repo")
   - Clique em **"Generate token"**
   - **COPIE O TOKEN** (ele só aparece uma vez!)

2. **Usar o token:**
   - Quando pedir **Username**: digite seu username do GitHub
   - Quando pedir **Password**: cole o token (não a senha!)

**OU** use o GitHub CLI (mais fácil):
```powershell
# Instalar GitHub CLI (se não tiver)
# Baixe em: https://cli.github.com/
# Depois execute:
gh auth login
```

---

## **PASSO 7: Verificar se Funcionou**

1. Acesse seu repositório no GitHub:
   ```
   https://github.com/seu-usuario/smart-clinic
   ```
2. Você deve ver todos os arquivos lá!

---

## **PASSO 8: Atualizar os Links no RESPOSTAS_ASSIGNMENT.md**

Depois que o repositório estiver no GitHub:

1. Abra o arquivo `RESPOSTAS_ASSIGNMENT.md`
2. Procure por `<seu-usuario>` e substitua pelo seu username real
3. Procure por `<seu-repo>` e substitua pelo nome do repositório (ex: `smart-clinic`)
4. Salve o arquivo
5. Faça commit e push das mudanças:

```powershell
git add RESPOSTAS_ASSIGNMENT.md
git commit -m "Update GitHub links in answers"
git push
```

---

## **Comandos Rápidos (Copia e Cola)**

Se você já tem o Git configurado, pode executar tudo de uma vez:

```powershell
# Navegar até a pasta
cd "C:\Users\rafav\Downloads\mvto - em andamento\replica-projeto-mvto\smart-clinic"

# Inicializar e fazer commit (se ainda não foi feito)
git init
git add .
git commit -m "Initial commit: Smart Clinic Management System"

# Adicionar remote e fazer push (SUBSTITUA a URL!)
git remote add origin https://github.com/SEU-USUARIO/SEU-REPO.git
git branch -M main
git push -u origin main
```

---

## **Troubleshooting**

### Erro: "remote origin already exists"
```powershell
git remote remove origin
git remote add origin https://github.com/seu-usuario/smart-clinic.git
```

### Erro: "failed to push some refs"
```powershell
# Se você criou o repositório com README no GitHub, faça pull primeiro:
git pull origin main --allow-unrelated-histories
git push -u origin main
```

### Erro: "authentication failed"
- Verifique se você está usando o **Personal Access Token** e não a senha
- Ou use o GitHub CLI: `gh auth login`

---

## **Próximos Passos**

Depois de enviar para o GitHub:

1. ✅ Verifique se todos os arquivos estão lá
2. ✅ Atualize os links no `RESPOSTAS_ASSIGNMENT.md`
3. ✅ Teste os links clicando neles (devem abrir os arquivos no GitHub)
4. ✅ Agora você pode usar os links nas respostas do assignment!

---

**Boa sorte! 🚀**

