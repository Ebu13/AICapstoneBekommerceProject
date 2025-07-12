package com.example.backend.controller;


import com.example.backend.model.*;
import com.example.backend.service.*;
import org.springframework.web.bind.annotation.*;

        import java.util.List;

@RestController
@RequestMapping("/api/gproducts")
@CrossOrigin
public class GProductController {

    private final GProductService productService;

    public GProductController(GProductService productService) {
        this.productService = productService;
    }

    @GetMapping
    public List<Product> getFilteredProducts(
            @RequestParam(required = false) String search,
            @RequestParam(required = false) List<String> categories,
            @RequestParam(required = false) List<String> brands,
            @RequestParam(required = false) Double minPrice,
            @RequestParam(required = false) Double maxPrice,
            @RequestParam(required = false) Double minRating,
            @RequestParam(required = false) Boolean inStock,
            @RequestParam(required = false) String sort
    ) {
        return productService.getAllProductsWithFilters(search, categories, brands, minPrice, maxPrice, minRating, inStock, sort);
    }

    @GetMapping("/{id}")
    public Product getProductById(@PathVariable Long id) {
        return productService.getProductById(id);
    }

    @GetMapping("/{id}/reviews")
    public List<ProductReview> getReviews(@PathVariable Long id) {
        return productService.getReviewsByProductId(id);
    }

    @PostMapping("/{id}/reviews")
    public ProductReview addReview(@PathVariable Long id, @RequestBody ProductReview review) {
        return productService.addReview(id, review);
    }
}

