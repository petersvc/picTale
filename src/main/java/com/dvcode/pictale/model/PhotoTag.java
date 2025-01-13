package com.dvcode.pictale.model;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import lombok.Data;

@Data
@Entity
public class PhotoTag {
    @EmbeddedId
    private PhotoTagId id;
    
    @ManyToOne
    @MapsId("photoId")
    private Photo photo;
    
    @ManyToOne
    @MapsId("tagId")
    private Tag tag;
}
