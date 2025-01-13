package com.dvcode.pictale.model;

import java.io.Serializable;

import jakarta.persistence.Embeddable;

import lombok.Data;

@Data
@Embeddable
public class PhotoTagId implements Serializable {
    private Integer photoId;
    private Integer tagId;
    private Long serialVersionUID;
}
