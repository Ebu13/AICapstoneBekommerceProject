package com.example.backend.spec;

import com.example.backend.model.*;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;

public class ProductSpecifications {

    public static Specification<Product> withFilters(String search, List<String> categories, List<String> brands,
                                                     Double minPrice, Double maxPrice, Double minRating, Boolean inStock) {
        return (root, query, cb) -> {
            var predicates = cb.conjunction();

            if (search != null && !search.isBlank()) {
                predicates = cb.and(predicates,
                        cb.like(cb.lower(root.get("name")), "%" + search.toLowerCase() + "%"));
            }

            if (categories != null && !categories.isEmpty()) {
                predicates = cb.and(predicates, root.get("category").in(categories));
            }

            if (brands != null && !brands.isEmpty()) {
                predicates = cb.and(predicates, root.get("brand").in(brands));
            }

            if (minPrice != null) {
                predicates = cb.and(predicates, cb.greaterThanOrEqualTo(root.get("price"), minPrice));
            }

            if (maxPrice != null) {
                predicates = cb.and(predicates, cb.lessThanOrEqualTo(root.get("price"), maxPrice));
            }

            if (minRating != null) {
                predicates = cb.and(predicates, cb.greaterThanOrEqualTo(root.get("rating"), minRating));
            }

            if (inStock != null && inStock) {
                predicates = cb.and(predicates, cb.greaterThan(root.get("stock"), 0));
            }

            return predicates;
        };
    }
}
