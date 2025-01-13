package com.dvcode.pictale.repository;

import com.dvcode.pictale.model.Photo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;

@Repository
public interface PhotoRepository extends JpaRepository<Photo, Integer> {
    // Buscar fotos de um fotógrafo específico
    Page<Photo> findByPhotographerIdOrderByCreatedAtDesc(Integer photographerId, Pageable pageable);
    
    // Buscar fotos dos fotógrafos que um usuário segue (timeline)
    @Query("SELECT p FROM Photo p WHERE p.photographer.id IN " +
           "(SELECT f.followee.id FROM Follow f WHERE f.follower.id = :photographerId) " +
           "ORDER BY p.createdAt DESC")
    Page<Photo> findTimelinePhotos(Integer photographerId, Pageable pageable);
    
    // Buscar fotos por hashtag
    @Query("SELECT DISTINCT p FROM Photo p LEFT JOIN p.hashtags h WHERE h LIKE :hashtag")
    Page<Photo> findByHashtag(String hashtag, Pageable pageable);
}
