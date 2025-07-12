package com.example.backend.repository;

import com.example.backend.model.OrderItem;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {
    List<OrderItem> findByOrderId(Long orderId);
    boolean existsByOrderId(Long orderId);
    List<OrderItem> findByProductId(Long productId);
}
