package com.example.backend.repository;

import com.example.backend.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByBuyerId(Long buyerId);
    Optional<Order> findByIdAndBuyerId(Long orderId, Long buyerId);
    boolean existsByBuyerId(Long buyerId);
    long countByBuyerId(Long buyerId);
}
