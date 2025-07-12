package com.example.backend.controller;

import com.example.backend.model.ChatMessage;
import com.example.backend.service.ChatMessageService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/chat-messages")
public class ChatMessageController {
    private final ChatMessageService chatMessageService;

    public ChatMessageController(ChatMessageService chatMessageService) {
        this.chatMessageService = chatMessageService;
    }

    @GetMapping("/{userId}")
    @PreAuthorize("hasRole('BUYER') or hasRole('SELLER') or hasRole('ADMIN')")
    public ResponseEntity<List<ChatMessage>> getMessagesByUser(@PathVariable Long userId) {
        return ResponseEntity.ok(chatMessageService.getMessagesByUserId(userId));
    }

    @PostMapping
    @PreAuthorize("hasRole('BUYER') or hasRole('SELLER')")
    public ResponseEntity<ChatMessage> sendMessage(@RequestBody ChatMessage chatMessage) {
        return ResponseEntity.ok(chatMessageService.saveMessage(chatMessage));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Void> deleteMessage(@PathVariable Long id) {
        chatMessageService.deleteMessage(id);
        return ResponseEntity.noContent().build();
    }
}
