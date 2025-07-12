package com.example.backend.service;

import com.example.backend.model.ProductReview;
import com.example.backend.repository.ProductReviewRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ProductReviewService {

    private final ProductReviewRepository productReviewRepository;

    public List<ProductReview> getReviewsByProductId(Long productId) {
        return productReviewRepository.findByProductId(productId);
    }

    public List<ProductReview> getReviewsByUserId(Long userId) {
        return productReviewRepository.findByUserId(userId);
    }

    public Optional<ProductReview> getReviewByIdAndUserId(Long id, Long userId) {
        return productReviewRepository.findByIdAndUserId(id, userId);
    }

    public boolean existsByProductId(Long productId) {
        return productReviewRepository.existsByProductId(productId);
    }

    public ProductReview saveReview(ProductReview productReview) {
        return productReviewRepository.save(productReview);
    }

    public void deleteReview(Long id) {
        productReviewRepository.deleteById(id);
    }
}
