package com.example.backend.repository;

import com.example.backend.model.Cart;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CartRepository extends JpaRepository<Cart, Long> {
    List<Cart> findByBuyerId(Long buyerId);
    Optional<Cart> findByBuyerIdAndProductId(Long buyerId, Long productId);
    void deleteByBuyerIdAndProductId(Long buyerId, Long productId);
    void deleteAllByBuyerId(Long buyerId);
    boolean existsByBuyerIdAndProductId(Long buyerId, Long productId);
}
