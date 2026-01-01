package com.project.back_end.controllers;

import com.project.back_end.dto.ApiResponse;
import com.project.back_end.dto.CreatePrescriptionRequest;
import com.project.back_end.models.Prescription;
import com.project.back_end.security.AuthPrincipal;
import com.project.back_end.security.AuthService;
import com.project.back_end.services.PrescriptionService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@RequestMapping("/api/prescriptions")
public class PrescriptionController {

    private final PrescriptionService prescriptionService;
    private final AuthService authService;

    public PrescriptionController(PrescriptionService prescriptionService, AuthService authService) {
        this.prescriptionService = prescriptionService;
        this.authService = authService;
    }

    /**
     * Requisito do assignment (Q7):
     * - POST salva prescrição com token + validação de body
     * - retorna mensagens estruturadas com ResponseEntity
     */
    @PostMapping
    public ResponseEntity<ApiResponse<Prescription>> createPrescription(
            @Valid @RequestBody CreatePrescriptionRequest requestBody,
            HttpServletRequest request
    ) {
        Optional<AuthPrincipal> principalOpt = authService.requireRole(request, "DOCTOR");
        if (principalOpt.isEmpty()) {
            return ResponseEntity.status(401).body(ApiResponse.error("Token inválido/ausente ou sem permissão."));
        }

        AuthPrincipal principal = principalOpt.get();
        try {
            Prescription saved = prescriptionService.createPrescription(
                    principal.getUserId(),
                    requestBody.getPatientId(),
                    requestBody.getMedication(),
                    requestBody.getDosage(),
                    requestBody.getInstructions()
            );
            return ResponseEntity.ok(ApiResponse.ok("Prescrição salva com sucesso.", saved));
        } catch (IllegalArgumentException ex) {
            return ResponseEntity.badRequest().body(ApiResponse.error(ex.getMessage()));
        } catch (Exception ex) {
            return ResponseEntity.status(500).body(ApiResponse.error("Erro ao salvar prescrição."));
        }
    }
}


