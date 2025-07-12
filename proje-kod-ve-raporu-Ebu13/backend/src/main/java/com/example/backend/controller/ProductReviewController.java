package com.example.backend.controller;

import com.example.backend.model.ProductReview;
import com.example.backend.service.ProductReviewService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/product-reviews")
public class ProductReviewController {
    private final ProductReviewService productReviewService;

    public ProductReviewController(ProductReviewService productReviewService) {
        this.productReviewService = productReviewService;
    }

    @GetMapping("/product/{productId}")
    @PreAuthorize("hasRole('BUYER') or hasRole('SELLER') or hasRole('ADMIN')")
    public ResponseEntity<List<ProductReview>> getReviewsByProduct(@PathVariable Long productId) {
        return ResponseEntity.ok(productReviewService.getReviewsByProductId(productId));
    }

    @GetMapping("/user/{userId}")
    @PreAuthorize("hasRole('BUYER')")
    public ResponseEntity<List<ProductReview>> getReviewsByUser(@PathVariable Long userId) {
        return ResponseEntity.ok(productReviewService.getReviewsByUserId(userId));
    }

    @PostMapping
    @PreAuthorize("hasRole('BUYER')")
    public ResponseEntity<ProductReview> addReview(@RequestBody ProductReview productReview) {
        return ResponseEntity.ok(productReviewService.saveReview(productReview));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('BUYER') or hasRole('ADMIN')")
    public ResponseEntity<Void> deleteReview(@PathVariable Long id) {
        productReviewService.deleteReview(id);
        return ResponseEntity.noContent().build();
    }
}
