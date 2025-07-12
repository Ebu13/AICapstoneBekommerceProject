package com.example.backend.controller;

import com.example.backend.model.SellerDetails;
import com.example.backend.service.SellerDetailsService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/sellers")
public class SellerDetailsController {
    private final SellerDetailsService sellerDetailsService;

    public SellerDetailsController(SellerDetailsService sellerDetailsService) {
        this.sellerDetailsService = sellerDetailsService;
    }

    @GetMapping("/{userId}")
    public ResponseEntity<SellerDetails> getSellerByUserId(@PathVariable Long userId) {
        return sellerDetailsService.getSellerByUserId(userId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<SellerDetails> createSeller(@RequestBody SellerDetails sellerDetails) {
        SellerDetails savedSeller = sellerDetailsService.saveSellerDetails(sellerDetails);
        return ResponseEntity.ok().body(savedSeller);
    }

}
