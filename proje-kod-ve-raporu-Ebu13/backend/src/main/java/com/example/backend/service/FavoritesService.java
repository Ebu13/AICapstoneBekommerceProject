package com.example.backend.service;

import com.example.backend.model.Favorites;
import com.example.backend.repository.FavoritesRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class FavoritesService {
    private final FavoritesRepository favoritesRepository;

    public FavoritesService(FavoritesRepository favoritesRepository) {
        this.favoritesRepository = favoritesRepository;
    }

    @Transactional(readOnly = true)
    public List<Favorites> getUserFavorites(Long buyerId) {
        return favoritesRepository.findByBuyerId(buyerId);
    }

    @Transactional
    public Favorites addFavorite(Favorites favorite) {
        return favoritesRepository.save(favorite);
    }

    @Transactional
    public void removeFavorite(Long buyerId, Long productId) {
        favoritesRepository.deleteByBuyerIdAndProductId(buyerId, productId);
    }
}
