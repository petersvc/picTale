package com.dvcode.pictale.model;

import java.io.Serializable;

import jakarta.persistence.Embeddable;
import lombok.Data;

// Classe identificadora composta para Like
@Data
@Embeddable
public class LikeId implements Serializable {
    private Integer photoId;
    private Integer photographerId;
    private Long serialVersionUID;
}