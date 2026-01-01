package com.project.back_end.controllers;

import com.project.back_end.dto.ApiResponse;
import com.project.back_end.models.Doctor;
import com.project.back_end.repo.DoctorRepository;
import com.project.back_end.security.AuthService;
import com.project.back_end.services.DoctorService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/doctors")
public class DoctorController {

    private final DoctorService doctorService;
    private final DoctorRepository doctorRepository;
    private final AuthService authService;

    public DoctorController(DoctorService doctorService, DoctorRepository doctorRepository, AuthService authService) {
        this.doctorService = doctorService;
        this.doctorRepository = doctorRepository;
        this.authService = authService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<List<Doctor>>> listAllDoctors() {
        return ResponseEntity.ok(ApiResponse.ok("OK", doctorRepository.findAll()));
    }

    @GetMapping("/search")
    public ResponseEntity<ApiResponse<List<Doctor>>> searchByName(@RequestParam("name") String name) {
        return ResponseEntity.ok(ApiResponse.ok("OK", doctorRepository.findByNameContainingIgnoreCase(name)));
    }

    @GetMapping("/filter")
    public ResponseEntity<ApiResponse<List<Doctor>>> filterBySpecialtyAndTime(
            @RequestParam("specialty") String specialty,
            @RequestParam("time") @DateTimeFormat(pattern = "HH:mm") LocalTime time
    ) {
        return ResponseEntity.ok(ApiResponse.ok("OK", doctorRepository.findBySpecialtyAndAvailableTime(specialty, time)));
    }

    /**
     * Requisito do assignment (Q5):
     * - GET endpoint para disponibilidade usando parâmetros dinâmicos
     * - valida token e retorna resposta estruturada usando ResponseEntity
     */
    @GetMapping("/{doctorId}/availability")
    public ResponseEntity<ApiResponse<List<LocalTime>>> getDoctorAvailability(
            @PathVariable("doctorId") Long doctorId,
            @RequestParam("date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            HttpServletRequest request
    ) {
        Optional<?> principal = authService.authenticate(request);
        if (principal.isEmpty()) {
            return ResponseEntity.status(401).body(ApiResponse.error("Token inválido ou ausente."));
        }

        try {
            List<LocalTime> slots = doctorService.getAvailableTimeSlots(doctorId, date);
            return ResponseEntity.ok(ApiResponse.ok("Disponibilidade retornada com sucesso.", slots));
        } catch (IllegalArgumentException ex) {
            return ResponseEntity.status(404).body(ApiResponse.error(ex.getMessage()));
        } catch (Exception ex) {
            return ResponseEntity.status(500).body(ApiResponse.error("Erro ao buscar disponibilidade."));
        }
    }
}


