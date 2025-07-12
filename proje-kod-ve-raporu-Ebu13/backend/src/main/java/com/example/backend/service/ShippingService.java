package com.example.backend.service;

import com.example.backend.model.Shipping;
import com.example.backend.repository.ShippingRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
public class ShippingService {
    private final ShippingRepository shippingRepository;

    public ShippingService(ShippingRepository shippingRepository) {
        this.shippingRepository = shippingRepository;
    }

    @Transactional(readOnly = true)
    public Optional<Shipping> getShippingByOrderId(Long orderId) {
        return shippingRepository.findByOrderId(orderId);
    }

    public Shipping saveShipping(Shipping shipping) {
        return shippingRepository.save(shipping);
    }

}
