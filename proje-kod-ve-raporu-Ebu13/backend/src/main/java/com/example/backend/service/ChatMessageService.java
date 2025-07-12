package com.example.backend.service;

import com.example.backend.model.ChatMessage;
import com.example.backend.repository.ChatMessageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ChatMessageService {

    private final ChatMessageRepository chatMessageRepository;

    public List<ChatMessage> getMessagesByUserId(Long userId) {
        return chatMessageRepository.findByUserId(userId);
    }

    public Optional<ChatMessage> getMessageByIdAndUserId(Long id, Long userId) {
        return chatMessageRepository.findByIdAndUserId(id, userId);
    }

    public boolean existsByUserId(Long userId) {
        return chatMessageRepository.existsByUserId(userId);
    }

    public ChatMessage saveMessage(ChatMessage chatMessage) {
        return chatMessageRepository.save(chatMessage);
    }

    public void deleteMessage(Long id) {
        chatMessageRepository.deleteById(id);
    }
}
