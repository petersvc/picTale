package com.dvcode.pictale.model;

import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "likes") // Renomeando a tabela
public class Like {
    @EmbeddedId
    private LikeId id;
    
    @ManyToOne
    @MapsId("photographerId")
    private Photographer photographer;
    
    @ManyToOne
    @MapsId("photoId")
    private Photo photo;

    @CreationTimestamp
    private LocalDateTime createdAt;
}
