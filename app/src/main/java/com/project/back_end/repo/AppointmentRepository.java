package com.project.back_end.repo;

import com.project.back_end.models.Appointment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;

public interface AppointmentRepository extends JpaRepository<Appointment, Long> {

    @Query("""
            SELECT a
            FROM Appointment a
            WHERE a.doctor.id = :doctorId
              AND a.appointmentTime >= :start
              AND a.appointmentTime < :end
            ORDER BY a.appointmentTime ASC
            """)
    List<Appointment> findByDoctorIdAndDate(@Param("doctorId") Long doctorId,
                                           @Param("start") LocalDateTime start,
                                           @Param("end") LocalDateTime end);

    @Query("""
            SELECT a
            FROM Appointment a
            WHERE a.patient.id = :patientId
            ORDER BY a.appointmentTime DESC
            """)
    List<Appointment> findByPatientId(@Param("patientId") Long patientId);
}


