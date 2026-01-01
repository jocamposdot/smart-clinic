# Smart Clinic Management System (Capstone)

Este projeto foi criado do zero para atender aos requisitos do assignment **"Building a Smart Clinic Management System"**.

## Estrutura

- `user_stories.md`: user stories (Doctor, Patient, Admin)
- `schema-design.md`: design do schema MySQL (tabelas, chaves, relacionamentos e procedures)
- `app/`: backend Java (Spring Boot + JPA + JWT)
- `portal/`: frontend simples (HTML/CSS/JS) para capturar screenshots
- `Dockerfile`: build multi-stage do backend
- `.github/workflows/compile-backend.yml`: CI para compilar com Maven
- `docker-compose.yml`: MySQL local (e opcionalmente o backend)

## Requisitos

- Java 17+
- Maven 3.9+
- MySQL 8+

## Como rodar localmente (dev)

1) Subir o MySQL:

```bash
docker compose up -d mysql
```

2) Configurar variáveis (PowerShell):

```powershell
$env:SPRING_PROFILES_ACTIVE="dev"
$env:SPRING_DATASOURCE_URL="jdbc:mysql://localhost:3306/smart_clinic?createDatabaseIfNotExist=true&allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC"
$env:SPRING_DATASOURCE_USERNAME="smartclinic"
$env:SPRING_DATASOURCE_PASSWORD="smartclinic"
$env:APP_JWT_SECRET="change-me-dev-secret"
```

3) Rodar o backend:

```bash
cd app
mvn spring-boot:run
```

Backend: `http://localhost:8080`

## Preparação do banco (para Q19–Q23)

O schema e procedures são criados automaticamente via **Flyway** ao iniciar o backend.

Para gerar as evidências de SQL (Q19–Q23), você precisa ter dados. Para **não “simular dados em dev/prod” no código**, use inserts manuais no MySQL (exemplo mínimo):

1) Criar 5 pacientes (Q20):

```sql
INSERT INTO patients (name, email, phone, password_hash, created_at) VALUES
('Paciente 1','p1@example.com','5511999000001','$2a$10$abcdefghijklmnopqrstuv', NOW()),
('Paciente 2','p2@example.com','5511999000002','$2a$10$abcdefghijklmnopqrstuv', NOW()),
('Paciente 3','p3@example.com','5511999000003','$2a$10$abcdefghijklmnopqrstuv', NOW()),
('Paciente 4','p4@example.com','5511999000004','$2a$10$abcdefghijklmnopqrstuv', NOW()),
('Paciente 5','p5@example.com','5511999000005','$2a$10$abcdefghijklmnopqrstuv', NOW());
```

> Observação: `password_hash` deve ser um hash BCrypt válido. Gere um rapidamente no backend (ex.: com `BCryptPasswordEncoder`) ou troque depois via API/seed local.

## Portal (screenshots)

Abra `portal/index.html` no navegador e use os fluxos de login e telas para tirar os screenshots (Q13–Q18).

> Observação: os screenshots dependem de você rodar o backend + MySQL e executar ações (ex.: cadastrar médico, buscar médico, listar consultas).


