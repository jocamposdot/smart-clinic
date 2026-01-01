package com.project.back_end.controllers;

import com.project.back_end.dto.ApiResponse;
import com.project.back_end.models.Appointment;
import com.project.back_end.repo.AppointmentRepository;
import com.project.back_end.security.AuthPrincipal;
import com.project.back_end.security.AuthService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/patients")
public class PatientController {

    private final AppointmentRepository appointmentRepository;
    private final AuthService authService;

    public PatientController(AppointmentRepository appointmentRepository, AuthService authService) {
        this.appointmentRepository = appointmentRepository;
        this.authService = authService;
    }

    @GetMapping("/me/appointments")
    public ResponseEntity<ApiResponse<List<Appointment>>> myAppointments(HttpServletRequest request) {
        Optional<AuthPrincipal> principalOpt = authService.requireRole(request, "PATIENT");
        if (principalOpt.isEmpty()) {
            return ResponseEntity.status(401).body(ApiResponse.error("Token inválido/ausente ou sem permissão."));
        }
        AuthPrincipal principal = principalOpt.get();
        List<Appointment> appts = appointmentRepository.findByPatientId(principal.getUserId());
        return ResponseEntity.ok(ApiResponse.ok("OK", appts));
    }
}


