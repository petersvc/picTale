package com.dvcode.pictale.model;

import java.io.Serializable;

import jakarta.persistence.Embeddable;
import lombok.Data;

// Classe identificadora composta para Follow
@Data
@Embeddable
public class FollowId implements Serializable {
    private Integer followeeId;
    private Integer followerId;
    private Long serialVersionUID;
}