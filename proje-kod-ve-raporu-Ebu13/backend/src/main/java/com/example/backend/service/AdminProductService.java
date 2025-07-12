package com.example.backend.service;

import com.example.backend.model.Product;
import com.example.backend.model.ProductReview;
import com.example.backend.repository.ProductRepository;
import com.example.backend.repository.ProductReviewRepository;
import com.example.backend.dto.ProductDTO;
import com.example.backend.dto.ProductReviewDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class AdminProductService {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private ProductReviewRepository productReviewRepository;

    @Autowired
    private SalesService salesService;  // SalesService'i ekliyoruz

    // Tüm ürünleri listeleyen metod
    public List<ProductDTO> getAllProducts() {
        List<Product> products = productRepository.findAll();
        return products.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    // Ürün ID'ye göre tek bir ürünü getiren metod
    public ProductDTO getProductById(Long id) {
        return productRepository.findById(id)
                .map(this::convertToDTO)
                .orElse(null);
    }

    // Ürün DTO'ya dönüşüm
    private ProductDTO convertToDTO(Product product) {
        ProductDTO productDTO = new ProductDTO();
        productDTO.setId(product.getId());
        productDTO.setName(product.getName());
        productDTO.setPrice(product.getPrice());
        productDTO.setStock(product.getStock());
        productDTO.setCategory(product.getCategory().toString());
        productDTO.setDescription(product.getDescription());
        productDTO.setSeller(product.getSeller().getName());
        productDTO.setImageUrl(product.getImageUrl());

        // Ürün toplam satışını hesapla
        double totalSales = salesService.calculateTotalSales(product.getId());
        productDTO.setTotalSales(totalSales);  // Burada double olarak set ediliyor

        // Ürün yorumlarını al
        List<ProductReview> productReviews = productReviewRepository.findByProductId(product.getId());
        List<ProductReviewDTO> reviews = productReviews.stream()
                .map(this::convertToReviewDTO)
                .collect(Collectors.toList());
        productDTO.setReviews(reviews);

        return productDTO;
    }

    // Yorum DTO'ya dönüşüm
    private ProductReviewDTO convertToReviewDTO(ProductReview review) {
        ProductReviewDTO reviewDTO = new ProductReviewDTO();
        reviewDTO.setId(review.getId());
        reviewDTO.setUser(review.getUser().getName());  // Yorum yapan kullanıcının ismini al
        reviewDTO.setComment(review.getComment());
        reviewDTO.setCreatedAt(review.getCreatedAt());
        return reviewDTO;
    }
}
