package com.dvcode.pictale.model;

import java.io.Serializable;
import java.util.Objects;

import jakarta.persistence.Embeddable;
import lombok.Data;

@Data
@Embeddable
public class PhotoTagId implements Serializable {

    private Integer photoId;
    private Integer tagId;

    // Implementação de equals e hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        PhotoTagId that = (PhotoTagId) o;
        return Objects.equals(photoId, that.photoId) &&
               Objects.equals(tagId, that.tagId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(photoId, tagId);
    }
}
