package com.example.backend.repository;

import com.example.backend.model.SupportTicket;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface SupportTicketRepository extends JpaRepository<SupportTicket, Long> {
    List<SupportTicket> findByUserId(Long userId);
    Optional<SupportTicket> findByIdAndUserId(Long ticketId, Long userId);
    boolean existsByUserId(Long userId);
}
