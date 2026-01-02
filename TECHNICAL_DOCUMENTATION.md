# Smart Clinic Management System - Technical Documentation

## 📋 Table of Contents
1. [Overview](#overview)
2. [System Architecture](#system-architecture)
3. [Technologies](#technologies)
4. [Database Schema](#database-schema)
5. [API Endpoints](#api-endpoints)
6. [Setup and Installation](#setup-and-installation)
7. [Testing Guide](#testing-guide)
8. [Security Implementation](#security-implementation)

---

## 🎯 Overview

Smart Clinic Management System is a comprehensive healthcare management platform that enables three types of users (Admin, Doctor, and Patient) to manage appointments, prescriptions, and medical records through RESTful APIs and web portals.

### Key Features
- **Multi-role Authentication**: JWT-based authentication for Admin, Doctor, and Patient
- **Appointment Management**: Book, view, and manage medical appointments
- **Doctor Availability**: Real-time availability checking and scheduling
- **Prescription Management**: Digital prescription creation and tracking
- **Analytics**: SQL stored procedures for reporting and statistics

---

## 🏗️ System Architecture

### Architecture Pattern
- **Backend**: Layered architecture (Controller → Service → Repository)
- **Database**: MySQL 8.3 with Flyway migrations
- **Frontend**: Vanilla JavaScript with REST API integration
- **Authentication**: JWT (JSON Web Tokens) with role-based access control

### Component Structure
```
smart-clinic/
├── app/                          # Spring Boot Backend
│   ├── src/main/java/
│   │   └── com/project/back_end/
│   │       ├── config/          # Application configuration
│   │       ├── controllers/     # REST API endpoints
│   │       ├── dto/             # Data Transfer Objects
│   │       ├── models/          # JPA entities
│   │       ├── repo/            # JPA repositories
│   │       ├── security/        # Authentication logic
│   │       └── services/        # Business logic
│   └── src/main/resources/
│       ├── application.properties
│       ├── application-dev.properties
│       └── db/migration/        # Flyway SQL migrations
│
├── frontend/                     # Web Portals
│   ├── admin/                   # Admin portal
│   ├── doctor/                  # Doctor portal
│   └── patient/                 # Patient portal
│
├── docker-compose.yml           # MySQL container setup
└── Dockerfile                   # Backend container image
```

---

## 🛠️ Technologies

### Backend
- **Framework**: Spring Boot 3.3.6
- **Language**: Java 21
- **Database**: MySQL 8.3
- **ORM**: Hibernate / JPA
- **Migration**: Flyway 10.21.0
- **Security**: JWT (jjwt 0.12.6)
- **Build Tool**: Maven 3.9.9

### Frontend
- **HTML5 + CSS3**: Responsive design
- **JavaScript (ES6+)**: REST API consumption
- **Fetch API**: HTTP requests

### DevOps
- **Container**: Docker & Docker Compose
- **CI/CD**: GitHub Actions (Java compilation workflow)
- **Version Control**: Git

---

## 🗄️ Database Schema

### Tables

#### 1. **admins**
```sql
id BIGINT PRIMARY KEY AUTO_INCREMENT
name VARCHAR(100) NOT NULL
email VARCHAR(100) UNIQUE NOT NULL
password VARCHAR(255) NOT NULL
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
```

#### 2. **doctors**
```sql
id BIGINT PRIMARY KEY AUTO_INCREMENT
name VARCHAR(100) NOT NULL
specialty VARCHAR(100) NOT NULL
email VARCHAR(100) UNIQUE NOT NULL
phone VARCHAR(20)
password VARCHAR(255) NOT NULL
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
```

#### 3. **doctor_available_times**
```sql
doctor_id BIGINT (FK → doctors.id)
available_time TIME NOT NULL
PRIMARY KEY (doctor_id, available_time)
```

#### 4. **patients**
```sql
id BIGINT PRIMARY KEY AUTO_INCREMENT
name VARCHAR(100) NOT NULL
date_of_birth DATE NOT NULL
email VARCHAR(100) UNIQUE NOT NULL
phone VARCHAR(20)
address TEXT
password VARCHAR(255) NOT NULL
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
```

#### 5. **appointments**
```sql
id BIGINT PRIMARY KEY AUTO_INCREMENT
doctor_id BIGINT NOT NULL (FK → doctors.id)
patient_id BIGINT NOT NULL (FK → patients.id)
appointment_time DATETIME NOT NULL
status ENUM('SCHEDULED', 'BOOKED', 'COMPLETED', 'CANCELLED')
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
```

#### 6. **prescriptions**
```sql
id BIGINT PRIMARY KEY AUTO_INCREMENT
appointment_id BIGINT (FK → appointments.id)
doctor_id BIGINT NOT NULL (FK → doctors.id)
patient_id BIGINT NOT NULL (FK → patients.id)
medication TEXT NOT NULL
dosage VARCHAR(100)
instructions TEXT
issued_date DATE NOT NULL
```

### Stored Procedures

1. **GetDailyAppointmentReportByDoctor** - Daily appointment report for a specific doctor
2. **GetDoctorWithMostPatientsByMonth** - Doctor with most appointments in a month
3. **GetDoctorWithMostPatientsByYear** - Doctor with most appointments in a year

---

## 🔌 API Endpoints

### Base URL
```
http://localhost:8090/api
```

### Authentication Endpoints

#### Admin Login
```http
POST /auth/admin/login
Content-Type: application/json

{
  "email": "admin@smartclinic.com",
  "password": "admin123"
}

Response:
{
  "success": true,
  "message": "Login realizado com sucesso.",
  "data": {
    "token": "eyJhbGci...",
    "role": "ADMIN",
    "userId": 1,
    "email": "admin@smartclinic.com"
  }
}
```

#### Doctor Login
```http
POST /auth/doctor/login
Content-Type: application/json

{
  "email": "doctor@smartclinic.com",
  "password": "senha123"
}
```

#### Patient Login
```http
POST /auth/patient/login
Content-Type: application/json

{
  "email": "patient@example.com",
  "password": "senha123"
}
```

### Admin Endpoints

#### Create Doctor
```http
POST /admin/doctors
Authorization: Bearer {admin_token}
Content-Type: application/json

{
  "name": "Dr. João Silva",
  "specialty": "Cardiologia",
  "email": "joao.silva@smartclinic.com",
  "phone": "(11) 98765-4321",
  "password": "senha123",
  "availableTimes": ["09:00", "10:00", "14:00", "15:00"]
}
```

#### List All Doctors
```http
GET /admin/doctors
Authorization: Bearer {admin_token}
```

### Doctor Endpoints

#### Get Doctor Availability
```http
GET /doctors/{doctorId}/availability?date=2026-01-15
Authorization: Bearer {token}

Response:
{
  "success": true,
  "data": ["09:00", "10:00", "14:00", "15:00"]
}
```

#### Get Doctor Appointments
```http
GET /doctors/me/appointments?date=2026-01-15
Authorization: Bearer {doctor_token}
```

### Patient Endpoints

#### Search Doctors by Specialty
```http
GET /patients/doctors/search?specialty=Cardiologia
Authorization: Bearer {patient_token}
```

#### Book Appointment
```http
POST /appointments
Authorization: Bearer {patient_token}
Content-Type: application/json

{
  "doctorId": 1,
  "appointmentTime": "2026-01-15T09:00:00"
}
```

#### Get Patient Appointments
```http
GET /patients/me/appointments
Authorization: Bearer {patient_token}
```

### Prescription Endpoints

#### Create Prescription
```http
POST /prescriptions
Authorization: Bearer {doctor_token}
Content-Type: application/json

{
  "appointmentId": 1,
  "patientId": 1,
  "medication": "Medicamento A",
  "dosage": "500mg",
  "instructions": "Tomar 2x ao dia",
  "issuedDate": "2026-01-15"
}
```

---

## ⚙️ Setup and Installation

### Prerequisites
- Java 21 or higher
- Maven 3.9+
- Docker Desktop
- Git

### Step 1: Clone Repository
```bash
git clone https://github.com/jocamposdot/smart-clinic.git
cd smart-clinic
```

### Step 2: Start MySQL Database
```bash
docker-compose up -d mysql
```

Wait 30 seconds for MySQL to initialize, then verify:
```bash
docker-compose ps
```

### Step 3: Start Backend
```bash
cd app
mvn spring-boot:run -Dspring-boot.run.profiles=dev
```

The backend will start on `http://localhost:8090`

### Step 4: Access Web Portals
- **Admin Portal**: `frontend/admin/index.html`
- **Doctor Portal**: `frontend/doctor/index.html`
- **Patient Portal**: `frontend/patient/index.html`

Open the HTML files directly in your browser (they connect to localhost:8090).

---

## 🧪 Testing Guide

### 1. Database Setup Test
```bash
# Check MySQL is running
docker exec -it smart-clinic-mysql mysql -u smartclinic -psmartclinic -e "SHOW DATABASES;"

# Verify tables exist
docker exec -it smart-clinic-mysql mysql -u smartclinic -psmartclinic smart_clinic -e "SHOW TABLES;"
```

### 2. Backend Health Check
```bash
# Check if backend is running
curl http://localhost:8090/actuator/health

# Or simply check the port
netstat -ano | findstr :8090
```

### 3. Create Test Admin User
```sql
-- Connect to MySQL
docker exec -it smart-clinic-mysql mysql -u smartclinic -psmartclinic smart_clinic

-- Insert admin (password: admin123, BCrypt hashed)
INSERT INTO admins (name, email, password) 
VALUES ('Admin', 'admin@smartclinic.com', 
'$2a$10$KbXQfH8K5vK4tH4H8K5vKOKbXQfH8K5vK4tH4H8K5vKOKbXQfH8K5u');
```

### 4. Test Authentication Flow

#### Test Admin Login
```bash
curl -X POST http://localhost:8090/api/auth/admin/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@smartclinic.com","password":"admin123"}'
```

Expected: JWT token in response

#### Test Doctor Creation (requires admin token)
```bash
curl -X POST http://localhost:8090/api/admin/doctors \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer {TOKEN}" \
  -d '{
    "name": "Dr. Test",
    "specialty": "Cardiologia",
    "email": "test@smartclinic.com",
    "phone": "(11) 99999-9999",
    "password": "senha123",
    "availableTimes": ["09:00", "10:00", "14:00"]
  }'
```

### 5. Test Frontend Portals

#### Admin Portal Test
1. Open `frontend/admin/index.html`
2. Login with: `admin@smartclinic.com` / `admin123`
3. Try creating a new doctor
4. Verify doctor appears in the list

#### Doctor Portal Test
1. Open `frontend/doctor/index.html`
2. Login with doctor credentials
3. Check appointment dashboard
4. Verify daily appointments are displayed

#### Patient Portal Test
1. Open `frontend/patient/index.html`
2. Login with patient credentials
3. Search for doctors by specialty
4. Book an appointment
5. View appointment history

### 6. Test SQL Stored Procedures

```sql
-- Test daily appointment report
CALL GetDailyAppointmentReportByDoctor(1, '2026-01-15');

-- Test doctor with most patients (month)
CALL GetDoctorWithMostPatientsByMonth(1, 2026);

-- Test doctor with most patients (year)
CALL GetDoctorWithMostPatientsByYear(2026);
```

### 7. Integration Test Checklist

- [ ] MySQL container starts successfully
- [ ] Flyway migrations execute without errors
- [ ] Backend starts on port 8090
- [ ] Admin can login and receive JWT token
- [ ] Admin can create doctors
- [ ] Doctor can login
- [ ] Doctor can view appointments
- [ ] Patient can login
- [ ] Patient can search doctors
- [ ] Patient can book appointments
- [ ] Patient can view appointment history
- [ ] Doctor can create prescriptions
- [ ] All API endpoints return proper HTTP status codes
- [ ] JWT authentication blocks unauthorized requests
- [ ] CORS is properly configured for frontend

---

## 🔒 Security Implementation

### Authentication
- **JWT Tokens**: Signed with HS256 algorithm
- **Token Expiration**: 2 hours (configurable)
- **Password Hashing**: BCrypt with strength 10
- **Role-Based Access Control**: Admin, Doctor, Patient roles

### Security Features
1. **Password Encryption**: All passwords stored as BCrypt hashes
2. **Token Validation**: Every protected endpoint validates JWT
3. **SQL Injection Protection**: JPA/Hibernate parameterized queries
4. **CORS Configuration**: Controlled cross-origin requests
5. **Input Validation**: Bean Validation (JSR-380) annotations

### Security Headers
```java
// Implemented in AppConfig.java
- CORS enabled for localhost:8090
- Authorization header required for protected endpoints
- Content-Type validation
```

---

## 📊 Performance Considerations

### Database Optimization
- Indexed columns: `email`, `doctor_id`, `patient_id`, `appointment_time`
- Foreign key constraints for referential integrity
- Connection pooling via HikariCP

### API Performance
- Connection timeout: 30 seconds
- Maximum pool size: 10 connections
- Lazy loading for entity relationships

---

## 🐛 Troubleshooting

### Backend Won't Start
**Issue**: Port 8080 or 8090 already in use
```bash
# Find process using port
netstat -ano | findstr :8090

# Kill process (replace PID)
taskkill /PID <PID> /F
```

### MySQL Connection Failed
**Issue**: Backend can't connect to MySQL
```bash
# Check MySQL is running
docker-compose ps

# Check MySQL logs
docker logs smart-clinic-mysql

# Restart MySQL
docker-compose restart mysql
```

### Flyway Migration Errors
**Issue**: "Unsupported Database" or migration failed
```bash
# Clean database and restart
docker-compose down -v
docker-compose up -d mysql
# Wait 30 seconds, then restart backend
```

### CORS Errors in Frontend
**Issue**: Browser blocks API requests
- Verify backend is running on port 8090
- Check `AppConfig.java` CORS configuration
- Ensure frontend uses correct API URL

### 401 Unauthorized Errors
**Issue**: JWT token invalid or expired
- Check token is included in `Authorization: Bearer {token}` header
- Verify token hasn't expired (2 hour limit)
- Re-login to get fresh token

---

## 📝 API Response Format

All API responses follow this standardized format:

### Success Response
```json
{
  "success": true,
  "message": "Operation successful",
  "data": { ... }
}
```

### Error Response
```json
{
  "success": false,
  "message": "Error description",
  "data": null
}
```

### HTTP Status Codes
- `200 OK`: Request successful
- `201 Created`: Resource created successfully
- `400 Bad Request`: Invalid input data
- `401 Unauthorized`: Missing or invalid JWT token
- `403 Forbidden`: Insufficient permissions
- `404 Not Found`: Resource not found
- `500 Internal Server Error`: Server-side error

---

## 🚀 Deployment Notes

### Environment Variables
```properties
# Database
SPRING_DATASOURCE_URL=jdbc:mysql://localhost:3307/smart_clinic
SPRING_DATASOURCE_USERNAME=smartclinic
SPRING_DATASOURCE_PASSWORD=smartclinic

# JWT
APP_JWT_SECRET=your-production-secret-key-here

# Server
SERVER_PORT=8090
```

### Production Checklist
- [ ] Change JWT secret key (minimum 256 bits)
- [ ] Use strong MySQL passwords
- [ ] Enable HTTPS/TLS
- [ ] Configure proper CORS origins
- [ ] Set up application logging
- [ ] Enable Spring Actuator endpoints
- [ ] Configure database connection pool limits
- [ ] Set up automated backups
- [ ] Implement rate limiting
- [ ] Add monitoring (e.g., Prometheus, Grafana)

---

## 📚 Additional Resources

- **GitHub Repository**: https://github.com/jocamposdot/smart-clinic
- **Spring Boot Documentation**: https://spring.io/projects/spring-boot
- **JWT Introduction**: https://jwt.io/introduction
- **MySQL Documentation**: https://dev.mysql.com/doc/

---

## 👥 User Roles and Permissions

| Feature | Admin | Doctor | Patient |
|---------|-------|--------|---------|
| Login | ✅ | ✅ | ✅ |
| Create Doctors | ✅ | ❌ | ❌ |
| View All Doctors | ✅ | ❌ | ✅ (search) |
| View Appointments | ✅ | ✅ (own) | ✅ (own) |
| Book Appointments | ❌ | ❌ | ✅ |
| Create Prescriptions | ❌ | ✅ | ❌ |
| View Availability | ✅ | ✅ | ✅ |

---

## 📄 License

This project was developed for educational purposes as part of a Smart Clinic Management System assignment.

---

**Document Version**: 1.0  
**Last Updated**: January 2, 2026  
**Maintained By**: Development Team

