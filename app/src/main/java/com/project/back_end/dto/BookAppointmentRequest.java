package com.project.back_end.dto;

import jakarta.validation.constraints.NotNull;

import java.time.LocalDateTime;

public class BookAppointmentRequest {

    @NotNull
    private Long doctorId;

    @NotNull
    private LocalDateTime appointmentTime;

    public Long getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(Long doctorId) {
        this.doctorId = doctorId;
    }

    public LocalDateTime getAppointmentTime() {
        return appointmentTime;
    }

    public void setAppointmentTime(LocalDateTime appointmentTime) {
        this.appointmentTime = appointmentTime;
    }
}


