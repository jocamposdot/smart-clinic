package com.project.back_end.services;

import com.project.back_end.dto.ApiResponse;
import com.project.back_end.dto.LoginRequest;
import com.project.back_end.dto.LoginResponse;
import com.project.back_end.models.Admin;
import com.project.back_end.repo.AdminRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AdminService {

    private final AdminRepository adminRepository;
    private final PasswordEncoder passwordEncoder;
    private final TokenService tokenService;

    public AdminService(AdminRepository adminRepository,
                        PasswordEncoder passwordEncoder,
                        TokenService tokenService) {
        this.adminRepository = adminRepository;
        this.passwordEncoder = passwordEncoder;
        this.tokenService = tokenService;
    }

    public ApiResponse<LoginResponse> login(LoginRequest request) {
        Optional<Admin> adminOpt = adminRepository.findByEmail(request.getEmail());
        if (adminOpt.isEmpty()) {
            return ApiResponse.error("Credenciais inválidas.");
        }
        Admin admin = adminOpt.get();
        boolean ok = passwordEncoder.matches(request.getPassword(), admin.getPasswordHash());
        if (!ok) {
            return ApiResponse.error("Credenciais inválidas.");
        }
        String token = tokenService.generateToken(admin.getEmail(), "ADMIN", admin.getId());
        LoginResponse data = new LoginResponse(token, "ADMIN", admin.getId(), admin.getEmail());
        return ApiResponse.ok("Login realizado com sucesso.", data);
    }
}


