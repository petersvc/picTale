package com.dvcode.pictale.repository;

import com.dvcode.pictale.model.Photo;
import com.dvcode.pictale.model.Photographer;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

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

    List<Photo> findByPhotographer(Photographer photographer);

    @Query("""
        SELECT p
        FROM Photo p
        LEFT JOIN Follow f ON f.followee = p.photographer
        WHERE p.photographer <> :photographer
        ORDER BY
        CASE
        WHEN f.follower = :currentPhotographer THEN 1 ELSE 2
        END,
        (SELECT COUNT(f2.id) FROM Follow f2 WHERE f2.followee = p.photographer) DESC,
        p.createdAt DESC
        """)
    Page<Photo> findByPhotographerNot(
        @Param("photographer") Photographer photographer,
        @Param("currentPhotographer") Photographer currentPhotographer,
        Pageable pageable);
    
    // List<Photo> findByPhotographerNot(Photographer photographer);

    // @Query("""
    //     SELECT p
    //     FROM Photo p
    //     LEFT JOIN Follow f ON f.followee = p.photographer
    //     WHERE p.photographer <> :photographer
    //     ORDER BY 
    //         CASE 
    //             WHEN f.follower = :currentPhotographer THEN 1 ELSE 2 
    //         END,
    //         (SELECT COUNT(f2.id) FROM Follow f2 WHERE f2.followee = p.photographer) DESC,
    //         p.createdAt DESC
    // """)
    // List<Photo> findByPhotographerNot(@Param("photographer") Photographer photographer, 
    //                                   @Param("currentPhotographer") Photographer currentPhotographer);
}
