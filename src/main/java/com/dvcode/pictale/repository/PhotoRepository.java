package com.dvcode.pictale.repository;

import com.dvcode.pictale.model.Photo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import org.springframework.data.jpa.repository.Query;

@Repository
public interface PhotoRepository extends JpaRepository<Photo, Integer> {
    // Buscar fotos de um fotógrafo específico
    List<Photo> findByPhotographerIdOrderByCreatedAtDesc(Integer photographerId);
    
    // Buscar fotos dos fotógrafos que um usuário segue (timeline)
    @Query("SELECT p FROM Photo p WHERE p.photographer.id IN " +
           "(SELECT f.followee.id FROM Follow f WHERE f.follower.id = :photographerId) " +
           "ORDER BY p.createdAt DESC")
    List<Photo> findTimelinePhotos(Integer photographerId);
    
    // Buscar fotos por hashtag
    @Query("SELECT DISTINCT p FROM Photo p LEFT JOIN p.photoTags pt WHERE pt.tag = :hashtag")
    List<Photo> findByPhotoTags(String hashtag);
}
