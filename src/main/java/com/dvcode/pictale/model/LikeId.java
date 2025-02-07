package com.dvcode.pictale.model;

import java.io.Serializable;

import jakarta.persistence.Embeddable;
import lombok.Data;

@Data
@Embeddable
public class LikeId implements Serializable {
    private Integer photoId;
    private Integer photographerId;

    private Long serialVersionUID = 1L;
}
