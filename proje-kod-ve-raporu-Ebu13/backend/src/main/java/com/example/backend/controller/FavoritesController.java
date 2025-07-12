package com.example.backend.controller;

import com.example.backend.model.Favorites;
import com.example.backend.service.FavoritesService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/favorites")
public class FavoritesController {
    private final FavoritesService favoritesService;

    public FavoritesController(FavoritesService favoritesService) {
        this.favoritesService = favoritesService;
    }

    @GetMapping("/{buyerId}")
    @PreAuthorize("hasRole('BUYER')")
    public ResponseEntity<List<Favorites>> getUserFavorites(@PathVariable Long buyerId) {
        return ResponseEntity.ok(favoritesService.getUserFavorites(buyerId));
    }

    @PostMapping
    @PreAuthorize("hasRole('BUYER')")
    public ResponseEntity<Favorites> addFavorite(@RequestBody Favorites favorite) {
        return ResponseEntity.ok(favoritesService.addFavorite(favorite));
    }

    @DeleteMapping("/{buyerId}/{productId}")
    @PreAuthorize("hasRole('BUYER')")
    public ResponseEntity<Void> removeFavorite(@PathVariable Long buyerId, @PathVariable Long productId) {
        favoritesService.removeFavorite(buyerId, productId);
        return ResponseEntity.noContent().build();
    }
}
