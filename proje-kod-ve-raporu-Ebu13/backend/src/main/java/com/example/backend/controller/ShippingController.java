package com.example.backend.controller;

import com.example.backend.model.Shipping;
import com.example.backend.service.ShippingService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/shipping")
public class ShippingController {
    private final ShippingService shippingService;

    public ShippingController(ShippingService shippingService) {
        this.shippingService = shippingService;
    }

    @GetMapping("/{orderId}")
    @PreAuthorize("hasRole('BUYER') or hasRole('SELLER')")
    public ResponseEntity<Shipping> getShippingByOrderId(@PathVariable Long orderId) {
        return shippingService.getShippingByOrderId(orderId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    @PreAuthorize("hasRole('SELLER')")
    public ResponseEntity<Shipping> createShipping(@RequestBody Shipping shipping) {
        Shipping savedShipping = shippingService.saveShipping(shipping);
        return ResponseEntity.ok().body(savedShipping);
    }
}
