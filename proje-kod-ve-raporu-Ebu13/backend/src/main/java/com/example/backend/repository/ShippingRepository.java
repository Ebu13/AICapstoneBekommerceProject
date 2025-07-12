package com.example.backend.repository;

import com.example.backend.model.Shipping;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ShippingRepository extends JpaRepository<Shipping, Long> {
    Optional<Shipping> findByOrderId(Long orderId);
    boolean existsByOrderId(Long orderId);
}
