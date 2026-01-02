# Smart Clinic Management System

> A comprehensive healthcare management platform built with Spring Boot, MySQL, and modern web technologies.

## 🎯 Overview

Smart Clinic is a full-stack clinic management system that enables three types of users (Admin, Doctor, and Patient) to manage appointments, prescriptions, and medical records through RESTful APIs and intuitive web portals.

### Key Features
- 🔐 JWT-based authentication with role-based access control
- 📅 Real-time appointment booking and management
- 👨‍⚕️ Doctor availability tracking
- 💊 Digital prescription management
- 📊 SQL analytics with stored procedures
- 🌐 Responsive web portals for all user types

## 📚 Documentation

- **[Technical Documentation](TECHNICAL_DOCUMENTATION.md)** - Complete technical reference
- **[Quick Start Guide](QUICK_START_GUIDE.md)** - Get started in 5 minutes
- **[Schema Design](schema-design.md)** - Database architecture
- **[User Stories](user_stories.md)** - Feature requirements

## 🚀 Quick Start

### Prerequisites
- Java 21+
- Maven 3.9+
- Docker Desktop
- Git

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/jocamposdot/smart-clinic.git
cd smart-clinic
```

2. **Start MySQL**
```bash
docker-compose up -d mysql
```

3. **Start Backend**
```bash
cd app
mvn spring-boot:run -Dspring-boot.run.profiles=dev
```

4. **Access Web Portals**
- Admin: `frontend/admin/index.html`
- Doctor: `frontend/doctor/index.html`
- Patient: `frontend/patient/index.html`

Backend API: `http://localhost:8090/api`

## 🏗️ Project Structure

```
smart-clinic/
├── app/                          # Spring Boot Backend
│   ├── src/main/java/           # Java source code
│   └── src/main/resources/      # Configurations & migrations
├── frontend/                     # Web Portals
│   ├── admin/                   # Admin portal
│   ├── doctor/                  # Doctor portal
│   └── patient/                 # Patient portal
├── docker-compose.yml           # MySQL container
├── Dockerfile                   # Backend container image
└── .github/workflows/           # CI/CD pipelines
```

## 🛠️ Technology Stack

**Backend**
- Spring Boot 3.3.6
- Java 21
- MySQL 8.3
- Hibernate/JPA
- Flyway (migrations)
- JWT (authentication)

**Frontend**
- HTML5 + CSS3
- Vanilla JavaScript
- Fetch API

**DevOps**
- Docker & Docker Compose
- GitHub Actions
- Maven

## 🔌 API Endpoints

### Authentication
```http
POST /api/auth/admin/login
POST /api/auth/doctor/login
POST /api/auth/patient/login
```

### Admin Operations
```http
POST /api/admin/doctors          # Create doctor
GET  /api/admin/doctors          # List all doctors
```

### Doctor Operations
```http
GET  /api/doctors/{id}/availability    # Check availability
GET  /api/doctors/me/appointments      # View appointments
POST /api/prescriptions                # Create prescription
```

### Patient Operations
```http
GET  /api/patients/doctors/search      # Search doctors
POST /api/appointments                 # Book appointment
GET  /api/patients/me/appointments     # View appointments
```

## 🧪 Testing

Refer to the **[Quick Start Guide](QUICK_START_GUIDE.md)** for detailed testing procedures.

### Quick Test
```bash
# Test admin login
curl -X POST http://localhost:8090/api/auth/admin/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@smartclinic.com","password":"admin123"}'
```

## 🔒 Security

- **Authentication**: JWT tokens (HS256)
- **Password Hashing**: BCrypt (strength 10)
- **Access Control**: Role-based (Admin, Doctor, Patient)
- **SQL Protection**: JPA parameterized queries
- **CORS**: Configured for localhost development

## 📊 Database

### Schema
- 6 tables: admins, doctors, patients, appointments, prescriptions, doctor_available_times
- 3 stored procedures for analytics
- Foreign key constraints
- Indexed columns for performance

### Migrations
Database schema is managed by Flyway and auto-migrated on startup.

## 🤝 Contributing

This project was developed for educational purposes as part of a Smart Clinic Management System assignment.

## 📄 License

Educational project - All rights reserved

## 🔗 Links

- **Repository**: https://github.com/jocamposdot/smart-clinic
- **Documentation**: See [TECHNICAL_DOCUMENTATION.md](TECHNICAL_DOCUMENTATION.md)

---

**Version**: 1.0  
**Last Updated**: January 2, 2026

