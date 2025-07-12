package com.example.backend.repository;

import com.example.backend.model.ProductReview;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ProductReviewRepository extends JpaRepository<ProductReview, Long> {
    List<ProductReview> findByProductId(Long productId);
    List<ProductReview> findByUserId(Long userId);
    Optional<ProductReview> findByIdAndUserId(Long id, Long userId);
    boolean existsByProductId(Long productId);
}
