package com.project.back_end.controllers;

import com.project.back_end.dto.ApiResponse;
import com.project.back_end.dto.LoginRequest;
import com.project.back_end.dto.LoginResponse;
import com.project.back_end.services.AdminService;
import com.project.back_end.services.DoctorService;
import com.project.back_end.services.PatientService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final AdminService adminService;
    private final DoctorService doctorService;
    private final PatientService patientService;

    public AuthController(AdminService adminService, DoctorService doctorService, PatientService patientService) {
        this.adminService = adminService;
        this.doctorService = doctorService;
        this.patientService = patientService;
    }

    @PostMapping("/admin/login")
    public ResponseEntity<ApiResponse<LoginResponse>> adminLogin(@Valid @RequestBody LoginRequest request) {
        ApiResponse<LoginResponse> resp = adminService.login(request);
        return resp.isSuccess() ? ResponseEntity.ok(resp) : ResponseEntity.status(401).body(resp);
    }

    @PostMapping("/doctor/login")
    public ResponseEntity<ApiResponse<LoginResponse>> doctorLogin(@Valid @RequestBody LoginRequest request) {
        ApiResponse<LoginResponse> resp = doctorService.login(request);
        return resp.isSuccess() ? ResponseEntity.ok(resp) : ResponseEntity.status(401).body(resp);
    }

    @PostMapping("/patient/login")
    public ResponseEntity<ApiResponse<LoginResponse>> patientLogin(@Valid @RequestBody LoginRequest request) {
        ApiResponse<LoginResponse> resp = patientService.login(request);
        return resp.isSuccess() ? ResponseEntity.ok(resp) : ResponseEntity.status(401).body(resp);
    }
}


