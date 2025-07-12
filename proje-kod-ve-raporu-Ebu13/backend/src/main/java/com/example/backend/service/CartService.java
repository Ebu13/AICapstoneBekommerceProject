package com.example.backend.service;

import com.example.backend.model.Cart;
import com.example.backend.repository.CartRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CartService {
    private final CartRepository cartRepository;

    public CartService(CartRepository cartRepository) {
        this.cartRepository = cartRepository;
    }

    @Transactional(readOnly = true)
    public List<Cart> getCartItems(Long buyerId) {
        return cartRepository.findByBuyerId(buyerId);
    }

    @Transactional
    public Cart addToCart(Cart cart) {
        return cartRepository.save(cart);
    }

    @Transactional
    public void removeFromCart(Long buyerId, Long productId) {
        cartRepository.deleteByBuyerIdAndProductId(buyerId, productId);
    }

    @Transactional
    public void clearCart(Long buyerId) {
        cartRepository.deleteAllByBuyerId(buyerId);
    }
}