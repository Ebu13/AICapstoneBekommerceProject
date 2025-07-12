package com.example.backend.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "shipping")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Shipping {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "order_id", nullable = false, unique = true)
    private Order order;

    @Column(name = "tracking_number", nullable = false, unique = true)
    private String trackingNumber;

    @Column(nullable = false)
    private String carrier;

    @Column(name = "estimated_delivery", nullable = false)
    private String estimatedDelivery;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Status status = Status.YOLDA;

    public enum Status {
        YOLDA, TESLIM_EDILDI
    }
}
