package com.dvcode.pictale.model;

import java.time.LocalDateTime;
import java.util.Set;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.Data;

@Data
@Entity
public class Photo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Lob
    private byte[] imageData;

    private String imageUrl;

    @Column(length = 512)
    private String caption;

    @CreationTimestamp
    private LocalDateTime createdAt;

    @ManyToOne
    @JoinColumn(name = "photographer_id", nullable = false)
    private Photographer photographer;

    @OneToMany(mappedBy = "photo", cascade = CascadeType.ALL)
    private Set<Like> likes;

    @OneToMany(mappedBy = "photo", cascade = CascadeType.ALL)
    private Set<Comment> comments;

    @OneToMany(mappedBy = "photo", cascade = CascadeType.ALL)
    private Set<PhotoTag> photoTags;  // Relacionamento com as hashtags
}

