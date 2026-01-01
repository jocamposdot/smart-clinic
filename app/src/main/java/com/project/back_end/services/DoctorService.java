package com.project.back_end.services;

import com.project.back_end.dto.ApiResponse;
import com.project.back_end.dto.LoginRequest;
import com.project.back_end.dto.LoginResponse;
import com.project.back_end.models.Appointment;
import com.project.back_end.models.Doctor;
import com.project.back_end.repo.AppointmentRepository;
import com.project.back_end.repo.DoctorRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class DoctorService {

    private final DoctorRepository doctorRepository;
    private final AppointmentRepository appointmentRepository;
    private final PasswordEncoder passwordEncoder;
    private final TokenService tokenService;

    public DoctorService(DoctorRepository doctorRepository,
                         AppointmentRepository appointmentRepository,
                         PasswordEncoder passwordEncoder,
                         TokenService tokenService) {
        this.doctorRepository = doctorRepository;
        this.appointmentRepository = appointmentRepository;
        this.passwordEncoder = passwordEncoder;
        this.tokenService = tokenService;
    }

    /**
     * Requisito do assignment: retorna slots disponíveis para médico em uma data.
     */
    public List<LocalTime> getAvailableTimeSlots(Long doctorId, LocalDate date) {
        Doctor doctor = doctorRepository.findById(doctorId)
                .orElseThrow(() -> new IllegalArgumentException("Médico não encontrado."));

        LocalDateTime start = date.atStartOfDay();
        LocalDateTime end = date.plusDays(1).atStartOfDay();
        List<Appointment> appts = appointmentRepository.findByDoctorIdAndDate(doctorId, start, end);

        Set<LocalTime> booked = appts.stream()
                .map(a -> a.getAppointmentTime().toLocalTime())
                .collect(Collectors.toSet());

        // Copia defensiva para manter consistência
        Set<LocalTime> baseSlots = new HashSet<>(doctor.getAvailableTimes());
        baseSlots.removeAll(booked);

        return baseSlots.stream().sorted().toList();
    }

    /**
     * Requisito do assignment: valida credenciais de login e retorna resposta estruturada.
     */
    public ApiResponse<LoginResponse> login(LoginRequest request) {
        Optional<Doctor> doctorOpt = doctorRepository.findByEmail(request.getEmail());
        if (doctorOpt.isEmpty()) {
            return ApiResponse.error("Credenciais inválidas.");
        }

        Doctor doctor = doctorOpt.get();
        boolean ok = passwordEncoder.matches(request.getPassword(), doctor.getPasswordHash());
        if (!ok) {
            return ApiResponse.error("Credenciais inválidas.");
        }

        String token = tokenService.generateToken(doctor.getEmail(), "DOCTOR", doctor.getId());
        LoginResponse data = new LoginResponse(token, "DOCTOR", doctor.getId(), doctor.getEmail());
        return ApiResponse.ok("Login realizado com sucesso.", data);
    }
}


