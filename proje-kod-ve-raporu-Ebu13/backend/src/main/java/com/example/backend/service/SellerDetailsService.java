package com.example.backend.service;

import com.example.backend.model.SellerDetails;
import com.example.backend.repository.SellerDetailsRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
public class SellerDetailsService {
    private final SellerDetailsRepository sellerDetailsRepository;

    public SellerDetailsService(SellerDetailsRepository sellerDetailsRepository) {
        this.sellerDetailsRepository = sellerDetailsRepository;
    }

    @Transactional(readOnly = true)
    public Optional<SellerDetails> getSellerByUserId(Long userId) {
        return sellerDetailsRepository.findByUserId(userId);
    }
    public SellerDetails saveSellerDetails(SellerDetails sellerDetails) {
        return sellerDetailsRepository.save(sellerDetails);
    }
}
