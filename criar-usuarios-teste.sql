-- Script SQL para criar usuários de teste
-- Execute após o backend ter criado as tabelas (via Flyway)

-- IMPORTANTE: As senhas abaixo são hashes BCrypt de "senha123"
-- Se precisar criar novos, use um gerador BCrypt ou crie via API

-- 1. Criar Admin
INSERT INTO admins (email, password_hash, created_at) VALUES
('admin@smartclinic.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', NOW())
ON DUPLICATE KEY UPDATE email=email;

-- 2. Criar Doctor
INSERT INTO doctors (name, email, phone, specialty, password_hash, created_at) VALUES
('Dr. João Silva', 'joao.silva@smartclinic.com', '(11) 98765-4321', 'Cardiologia', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', NOW())
ON DUPLICATE KEY UPDATE email=email;

-- Adicionar horários disponíveis para o médico
SET @doctor_id = (SELECT doctor_id FROM doctors WHERE email = 'joao.silva@smartclinic.com' LIMIT 1);

INSERT INTO doctor_available_times (doctor_id, time_slot) VALUES
(@doctor_id, '09:00:00'),
(@doctor_id, '10:00:00'),
(@doctor_id, '14:00:00'),
(@doctor_id, '15:00:00')
ON DUPLICATE KEY UPDATE doctor_id=doctor_id;

-- 3. Criar Patient
INSERT INTO patients (name, email, phone, password_hash, created_at) VALUES
('Maria Santos', 'maria.santos@example.com', '(11) 98765-4322', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', NOW())
ON DUPLICATE KEY UPDATE email=email;

-- NOTA: A senha para TODOS os usuários acima é: senha123
-- Hash BCrypt gerado: $2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy

-- 4. (Opcional) Criar um appointment de exemplo para o médico
SET @patient_id = (SELECT patient_id FROM patients WHERE email = 'maria.santos@example.com' LIMIT 1);
SET @appointment_date = DATE_ADD(NOW(), INTERVAL 1 DAY);

INSERT INTO appointments (doctor_id, patient_id, appointment_time, status, created_at) VALUES
(@doctor_id, @patient_id, CONCAT(DATE(@appointment_date), ' 09:00:00'), 'BOOKED', NOW())
ON DUPLICATE KEY UPDATE appointment_id=appointment_id;

-- Verificar usuários criados
SELECT 'ADMINS' as tipo, admin_id as id, email FROM admins
UNION ALL
SELECT 'DOCTORS', doctor_id, email FROM doctors
UNION ALL
SELECT 'PATIENTS', patient_id, email FROM patients;

