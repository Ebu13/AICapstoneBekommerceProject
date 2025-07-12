package com.example.backend.service;

import com.example.backend.model.SupportTicket;
import com.example.backend.repository.SupportTicketRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class SupportTicketService {
    private final SupportTicketRepository supportTicketRepository;

    public SupportTicketService(SupportTicketRepository supportTicketRepository) {
        this.supportTicketRepository = supportTicketRepository;
    }

    @Transactional(readOnly = true)
    public List<SupportTicket> getUserTickets(Long userId) {
        return supportTicketRepository.findByUserId(userId);
    }

    @Transactional
    public SupportTicket createTicket(SupportTicket ticket) {
        return supportTicketRepository.save(ticket);
    }
}
