package com.project.back_end.repo;

import com.project.back_end.models.Doctor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

public interface DoctorRepository extends JpaRepository<Doctor, Long> {
    Optional<Doctor> findByEmail(String email);

    List<Doctor> findByNameContainingIgnoreCase(String name);

    @Query("""
            SELECT DISTINCT d
            FROM Doctor d
            JOIN d.availableTimes t
            WHERE LOWER(d.specialty) = LOWER(:specialty)
              AND t = :time
            """)
    List<Doctor> findBySpecialtyAndAvailableTime(@Param("specialty") String specialty, @Param("time") LocalTime time);
}


