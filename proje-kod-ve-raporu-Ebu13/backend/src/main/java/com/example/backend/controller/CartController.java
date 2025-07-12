package com.example.backend.controller;

import com.example.backend.model.Cart;
import com.example.backend.service.CartService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/cart")
public class CartController {
    private final CartService cartService;

    public CartController(CartService cartService) {
        this.cartService = cartService;
    }

    @GetMapping("/{buyerId}")
    @PreAuthorize("hasRole('BUYER')")
    public ResponseEntity<List<Cart>> getCartItems(@PathVariable Long buyerId) {
        return ResponseEntity.ok(cartService.getCartItems(buyerId));
    }

    @PostMapping
    @PreAuthorize("hasRole('BUYER')")
    public ResponseEntity<Cart> addToCart(@RequestBody Cart cart) {
        return ResponseEntity.ok(cartService.addToCart(cart));
    }

    @DeleteMapping("/{buyerId}/{productId}")
    @PreAuthorize("hasRole('BUYER')")
    public ResponseEntity<Void> removeFromCart(@PathVariable Long buyerId, @PathVariable Long productId) {
        cartService.removeFromCart(buyerId, productId);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/{buyerId}")
    @PreAuthorize("hasRole('BUYER')")
    public ResponseEntity<Void> clearCart(@PathVariable Long buyerId) {
        cartService.clearCart(buyerId);
        return ResponseEntity.noContent().build();
    }
}
