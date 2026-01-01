# MySQL Schema Design - Smart Clinic Management System

## Visão geral

O banco `smart_clinic` usa um schema relacional com foco em:

- Identidade e autenticação (Admin/Doctor/Patient)
- Agendamento (Appointment)
- Prescrições (Prescription)
- Relatórios via stored procedures

## Tabelas (mínimo de 4) e relacionamentos

### `admins`
- **admin_id** (PK, BIGINT, AUTO_INCREMENT)
- **email** (VARCHAR(255), UNIQUE, NOT NULL)
- **password_hash** (VARCHAR(255), NOT NULL)
- **created_at** (DATETIME, NOT NULL)

### `doctors`
- **doctor_id** (PK, BIGINT, AUTO_INCREMENT)
- **name** (VARCHAR(255), NOT NULL)
- **email** (VARCHAR(255), UNIQUE, NOT NULL)
- **phone** (VARCHAR(30), UNIQUE, NULL)
- **specialty** (VARCHAR(120), NOT NULL)
- **password_hash** (VARCHAR(255), NOT NULL)
- **created_at** (DATETIME, NOT NULL)

### `patients`
- **patient_id** (PK, BIGINT, AUTO_INCREMENT)
- **name** (VARCHAR(255), NOT NULL)
- **email** (VARCHAR(255), UNIQUE, NOT NULL)
- **phone** (VARCHAR(30), UNIQUE, NULL)
- **password_hash** (VARCHAR(255), NOT NULL)
- **created_at** (DATETIME, NOT NULL)

### `doctor_available_times`
Armazena os horários-base (slots) que um médico oferece (ex.: 09:00, 09:30, 10:00...).
- **doctor_id** (FK -> `doctors.doctor_id`, NOT NULL)
- **time_slot** (TIME, NOT NULL)
- PK composta: (**doctor_id**, **time_slot**)

### `appointments`
- **appointment_id** (PK, BIGINT, AUTO_INCREMENT)
- **doctor_id** (FK -> `doctors.doctor_id`, NOT NULL)
- **patient_id** (FK -> `patients.patient_id`, NOT NULL)
- **appointment_time** (DATETIME, NOT NULL)
- **status** (VARCHAR(30), NOT NULL) (ex.: BOOKED, CANCELED, COMPLETED)
- **created_at** (DATETIME, NOT NULL)

Relacionamentos:
- Um `Doctor` tem muitas `Appointment`s (**1:N**)
- Um `Patient` tem muitas `Appointment`s (**1:N**)

Restrições recomendadas:
- Índice/unique composto para evitar duplicidade por médico+horário: (**doctor_id**, **appointment_time**)

### `prescriptions`
- **prescription_id** (PK, BIGINT, AUTO_INCREMENT)
- **doctor_id** (FK -> `doctors.doctor_id`, NOT NULL)
- **patient_id** (FK -> `patients.patient_id`, NOT NULL)
- **medication** (VARCHAR(255), NOT NULL)
- **dosage** (VARCHAR(255), NOT NULL)
- **instructions** (TEXT, NULL)
- **issued_at** (DATETIME, NOT NULL)

## Stored Procedures (relatórios)

### `GetDailyAppointmentReportByDoctor`

Objetivo: listar consultas de um médico em um dia específico.

Parâmetros:
- `p_doctor_id` BIGINT
- `p_date` DATE

Saída: lista de consultas (id, paciente, horário, status).

### `GetDoctorWithMostPatientsByMonth`

Objetivo: retornar o médico com maior quantidade de pacientes distintos no mês informado.

Parâmetros:
- `p_year` INT
- `p_month` INT

Saída: doctor_id, name, specialty, total_distinct_patients.

### `GetDoctorWithMostPatientsByYear`

Objetivo: retornar o médico com maior quantidade de pacientes distintos no ano informado.

Parâmetros:
- `p_year` INT

Saída: doctor_id, name, specialty, total_distinct_patients.


