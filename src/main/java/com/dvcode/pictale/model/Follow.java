package com.dvcode.pictale.model;

import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@Entity
public class Follow {
    @EmbeddedId
    private FollowId id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("followerId")
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private Photographer follower;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("followeeId")
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private Photographer followee;

    @CreationTimestamp
    private LocalDateTime createdAt;
}
