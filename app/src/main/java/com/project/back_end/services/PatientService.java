package com.project.back_end.services;

import com.project.back_end.dto.ApiResponse;
import com.project.back_end.dto.LoginRequest;
import com.project.back_end.dto.LoginResponse;
import com.project.back_end.models.Patient;
import com.project.back_end.repo.PatientRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class PatientService {

    private final PatientRepository patientRepository;
    private final PasswordEncoder passwordEncoder;
    private final TokenService tokenService;

    public PatientService(PatientRepository patientRepository,
                          PasswordEncoder passwordEncoder,
                          TokenService tokenService) {
        this.patientRepository = patientRepository;
        this.passwordEncoder = passwordEncoder;
        this.tokenService = tokenService;
    }

    public ApiResponse<LoginResponse> login(LoginRequest request) {
        Optional<Patient> patientOpt = patientRepository.findByEmail(request.getEmail());
        if (patientOpt.isEmpty()) {
            return ApiResponse.error("Credenciais inválidas.");
        }
        Patient patient = patientOpt.get();
        boolean ok = passwordEncoder.matches(request.getPassword(), patient.getPasswordHash());
        if (!ok) {
            return ApiResponse.error("Credenciais inválidas.");
        }
        String token = tokenService.generateToken(patient.getEmail(), "PATIENT", patient.getId());
        LoginResponse data = new LoginResponse(token, "PATIENT", patient.getId(), patient.getEmail());
        return ApiResponse.ok("Login realizado com sucesso.", data);
    }
}


