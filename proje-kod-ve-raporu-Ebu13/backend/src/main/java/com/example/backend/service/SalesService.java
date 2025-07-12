package com.example.backend.service;

import com.example.backend.model.OrderItem;
import com.example.backend.repository.OrderItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SalesService {

    @Autowired
    private OrderItemRepository orderItemRepository;

    // Toplam satış hesaplama metodu
    public double calculateTotalSales(Long productId) {
        List<OrderItem> orderItems = orderItemRepository.findByProductId(productId);
        return orderItems.stream()
                .mapToDouble(item -> item.getQuantity() * item.getPrice())
                .sum();
    }
}
