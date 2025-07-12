package com.example.backend.service;

import com.example.backend.model.Product;
import com.example.backend.model.ProductReview;
import com.example.backend.repository.ProductRepository;
import com.example.backend.repository.ProductReviewRepository;
import com.example.backend.spec.ProductSpecifications;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GProductService {

    private final ProductRepository productRepository;
    private final ProductReviewRepository reviewRepository;

    public GProductService(ProductRepository productRepository, ProductReviewRepository reviewRepository) {
        this.productRepository = productRepository;
        this.reviewRepository = reviewRepository;
    }

    public List<Product> getAllProductsWithFilters(String search, List<String> categories, List<String> brands,
                                                   Double minPrice, Double maxPrice, Double minRating,
                                                   Boolean inStock, String sortOption) {
        Sort sort = switch (sortOption) {
            case "priceLow" -> Sort.by("price").ascending();
            case "priceHigh" -> Sort.by("price").descending();
            case "rating" -> Sort.by("rating").descending();
            default -> Sort.unsorted();
        };

        return productRepository.findAll(ProductSpecifications.withFilters(search, categories, brands, minPrice, maxPrice, minRating, inStock), sort);
    }

    public Product getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }

    public List<ProductReview> getReviewsByProductId(Long productId) {
        return reviewRepository.findByProductId(productId);
    }

    public ProductReview addReview(Long productId, ProductReview review) {
        Product product = new Product();
        product.setId(productId);
        review.setProduct(product);
        return reviewRepository.save(review);
    }
}
