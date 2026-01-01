package com.project.back_end.controllers;

import com.project.back_end.dto.ApiResponse;
import com.project.back_end.dto.BookAppointmentRequest;
import com.project.back_end.models.Appointment;
import com.project.back_end.security.AuthPrincipal;
import com.project.back_end.security.AuthService;
import com.project.back_end.services.AppointmentService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/appointments")
public class AppointmentController {

    private final AppointmentService appointmentService;
    private final AuthService authService;

    public AppointmentController(AppointmentService appointmentService, AuthService authService) {
        this.appointmentService = appointmentService;
        this.authService = authService;
    }

    @PostMapping("/book")
    public ResponseEntity<ApiResponse<Appointment>> book(@Valid @RequestBody BookAppointmentRequest requestBody,
                                                         HttpServletRequest request) {
        Optional<AuthPrincipal> principalOpt = authService.requireRole(request, "PATIENT");
        if (principalOpt.isEmpty()) {
            return ResponseEntity.status(401).body(ApiResponse.error("Token inválido/ausente ou sem permissão."));
        }
        AuthPrincipal principal = principalOpt.get();

        try {
            Appointment appt = appointmentService.bookAppointment(
                    requestBody.getDoctorId(),
                    principal.getUserId(),
                    requestBody.getAppointmentTime()
            );
            return ResponseEntity.ok(ApiResponse.ok("Consulta agendada com sucesso.", appt));
        } catch (IllegalArgumentException | IllegalStateException ex) {
            return ResponseEntity.badRequest().body(ApiResponse.error(ex.getMessage()));
        } catch (Exception ex) {
            return ResponseEntity.status(500).body(ApiResponse.error("Erro ao agendar consulta."));
        }
    }

    @GetMapping("/doctor")
    public ResponseEntity<ApiResponse<List<Appointment>>> doctorAppointmentsOnDate(
            @RequestParam("date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            HttpServletRequest request
    ) {
        Optional<AuthPrincipal> principalOpt = authService.requireRole(request, "DOCTOR");
        if (principalOpt.isEmpty()) {
            return ResponseEntity.status(401).body(ApiResponse.error("Token inválido/ausente ou sem permissão."));
        }
        AuthPrincipal principal = principalOpt.get();

        List<Appointment> appts = appointmentService.getAppointmentsForDoctorOnDate(principal.getUserId(), date);
        return ResponseEntity.ok(ApiResponse.ok("OK", appts));
    }
}


