package com.dvcode.pictale.repository;

import com.dvcode.pictale.model.PhotoTag;
import com.dvcode.pictale.model.PhotoTagId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PhotoTagRepository extends JpaRepository<PhotoTag, PhotoTagId> {
    List<PhotoTag> findByPhotoId(Integer photoId);
    
    List<PhotoTag> findByTagId(Integer tagId);
    
    // Remover todas as tags de uma foto
    void deleteByPhotoId(Integer photoId);
}