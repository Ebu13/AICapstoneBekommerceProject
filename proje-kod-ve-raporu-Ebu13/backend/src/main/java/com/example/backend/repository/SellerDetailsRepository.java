package com.example.backend.repository;

import com.example.backend.model.SellerDetails;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface SellerDetailsRepository extends JpaRepository<SellerDetails, Long> {
    Optional<SellerDetails> findByUserId(Long userId);
    boolean existsByUserId(Long userId);
}
