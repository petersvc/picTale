package com.dvcode.pictale.model;

import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import lombok.Data;

@Data
@Entity
public class Follow {
    @EmbeddedId
    private FollowId id;
    
    @ManyToOne
    @MapsId("followerId")
    private Photographer follower;
    
    @ManyToOne
    @MapsId("followeeId")
    private Photographer followee;

    @CreationTimestamp
    private LocalDateTime createdAt;
}
