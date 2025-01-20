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
    private PhotoTagId id = new PhotoTagId(); // Inicialize a chave composta para evitar NullPointerException

    @ManyToOne
    @MapsId("photoId")
    private Photo photo;

    @ManyToOne
    @MapsId("tagId")
    private Tag tag;

    public void setPhoto(Photo photo) {
        this.photo = photo;
        this.id.setPhotoId(photo.getId()); // Garante que a chave composta seja atualizada
    }

    public void setTag(Tag tag) {
        this.tag = tag;
        this.id.setTagId(tag.getId()); // Garante que a chave composta seja atualizada
    }
}
