package com.example.backend.repository;

import com.example.backend.model.ChatMessage;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ChatMessageRepository extends JpaRepository<ChatMessage, Long> {
    List<ChatMessage> findByUserId(Long userId);
    Optional<ChatMessage> findByIdAndUserId(Long id, Long userId);
    boolean existsByUserId(Long userId);
}

