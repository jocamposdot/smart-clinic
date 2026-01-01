package com.project.back_end.controllers;

import com.project.back_end.dto.ApiResponse;
import com.project.back_end.dto.CreateDoctorRequest;
import com.project.back_end.models.Doctor;
import com.project.back_end.security.AuthPrincipal;
import com.project.back_end.security.AuthService;
import com.project.back_end.repo.DoctorRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.Optional;

@RestController
@RequestMapping("/api/admin")
public class AdminController {

    private final AuthService authService;
    private final DoctorRepository doctorRepository;
    private final PasswordEncoder passwordEncoder;

    public AdminController(AuthService authService, DoctorRepository doctorRepository, PasswordEncoder passwordEncoder) {
        this.authService = authService;
        this.doctorRepository = doctorRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @PostMapping("/doctors")
    public ResponseEntity<ApiResponse<Doctor>> createDoctor(
            @Valid @RequestBody CreateDoctorRequest requestBody,
            HttpServletRequest request
    ) {
        Optional<AuthPrincipal> principalOpt = authService.requireRole(request, "ADMIN");
        if (principalOpt.isEmpty()) {
            return ResponseEntity.status(401).body(ApiResponse.error("Token inválido/ausente ou sem permissão."));
        }

        Doctor doctor = new Doctor();
        doctor.setName(requestBody.getName());
        doctor.setEmail(requestBody.getEmail());
        doctor.setPhone(requestBody.getPhone());
        doctor.setSpecialty(requestBody.getSpecialty());
        doctor.setPasswordHash(passwordEncoder.encode(requestBody.getPassword()));
        doctor.setCreatedAt(LocalDateTime.now());
        doctor.setAvailableTimes(requestBody.getAvailableTimes());

        Doctor saved = doctorRepository.save(doctor);
        return ResponseEntity.ok(ApiResponse.ok("Médico criado com sucesso.", saved));
    }
}


