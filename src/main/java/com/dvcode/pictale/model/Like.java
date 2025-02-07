package com.dvcode.pictale.model;

import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@Entity
@Table(name = "likes") // Renomeando a tabela
public class Like {
    @EmbeddedId
    @NotNull
    private LikeId id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("photographerId")
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private Photographer photographer;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("photoId")
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private Photo photo;

    @CreationTimestamp
    private LocalDateTime createdAt;
}
