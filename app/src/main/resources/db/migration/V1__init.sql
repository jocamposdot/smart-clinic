CREATE TABLE IF NOT EXISTS admins (
  admin_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL
);

CREATE TABLE IF NOT EXISTS doctors (
  doctor_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  phone VARCHAR(30) NULL UNIQUE,
  specialty VARCHAR(120) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL
);

CREATE TABLE IF NOT EXISTS patients (
  patient_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  phone VARCHAR(30) NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL
);

CREATE TABLE IF NOT EXISTS doctor_available_times (
  doctor_id BIGINT NOT NULL,
  time_slot TIME NOT NULL,
  PRIMARY KEY (doctor_id, time_slot),
  CONSTRAINT fk_doc_times_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

CREATE TABLE IF NOT EXISTS appointments (
  appointment_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  doctor_id BIGINT NOT NULL,
  patient_id BIGINT NOT NULL,
  appointment_time DATETIME NOT NULL,
  status VARCHAR(30) NOT NULL,
  created_at DATETIME NOT NULL,
  CONSTRAINT fk_appt_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
  CONSTRAINT fk_appt_patient FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
  CONSTRAINT uq_appt_doctor_time UNIQUE (doctor_id, appointment_time)
);

CREATE TABLE IF NOT EXISTS prescriptions (
  prescription_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  doctor_id BIGINT NOT NULL,
  patient_id BIGINT NOT NULL,
  medication VARCHAR(255) NOT NULL,
  dosage VARCHAR(255) NOT NULL,
  instructions TEXT NULL,
  issued_at DATETIME NOT NULL,
  CONSTRAINT fk_rx_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
  CONSTRAINT fk_rx_patient FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

DELIMITER //

DROP PROCEDURE IF EXISTS GetDailyAppointmentReportByDoctor //
CREATE PROCEDURE GetDailyAppointmentReportByDoctor(IN p_doctor_id BIGINT, IN p_date DATE)
BEGIN
  SELECT
    a.appointment_id,
    a.appointment_time,
    a.status,
    p.patient_id,
    p.name AS patient_name,
    p.email AS patient_email
  FROM appointments a
  JOIN patients p ON p.patient_id = a.patient_id
  WHERE a.doctor_id = p_doctor_id
    AND DATE(a.appointment_time) = p_date
  ORDER BY a.appointment_time ASC;
END //

DROP PROCEDURE IF EXISTS GetDoctorWithMostPatientsByMonth //
CREATE PROCEDURE GetDoctorWithMostPatientsByMonth(IN p_year INT, IN p_month INT)
BEGIN
  SELECT
    d.doctor_id,
    d.name,
    d.specialty,
    COUNT(DISTINCT a.patient_id) AS total_distinct_patients
  FROM appointments a
  JOIN doctors d ON d.doctor_id = a.doctor_id
  WHERE YEAR(a.appointment_time) = p_year
    AND MONTH(a.appointment_time) = p_month
  GROUP BY d.doctor_id, d.name, d.specialty
  ORDER BY total_distinct_patients DESC
  LIMIT 1;
END //

DROP PROCEDURE IF EXISTS GetDoctorWithMostPatientsByYear //
CREATE PROCEDURE GetDoctorWithMostPatientsByYear(IN p_year INT)
BEGIN
  SELECT
    d.doctor_id,
    d.name,
    d.specialty,
    COUNT(DISTINCT a.patient_id) AS total_distinct_patients
  FROM appointments a
  JOIN doctors d ON d.doctor_id = a.doctor_id
  WHERE YEAR(a.appointment_time) = p_year
  GROUP BY d.doctor_id, d.name, d.specialty
  ORDER BY total_distinct_patients DESC
  LIMIT 1;
END //

DELIMITER ;


