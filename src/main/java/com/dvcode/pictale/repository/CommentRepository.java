package com.dvcode.pictale.repository;

import com.dvcode.pictale.model.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Integer> {
    // Buscar comentários de uma foto
    Page<Comment> findByPhotoIdOrderByCreatedAtDesc(Integer photoId, Pageable pageable);
    
    // Buscar comentários por hashtag
    @Query("SELECT c FROM Comment c LEFT JOIN c.hashtags h WHERE h LIKE :hashtag")
    Page<Comment> findByHashtag(String hashtag, Pageable pageable);
    
    // Buscar comentários feitos por um fotógrafo
    Page<Comment> findByPhotographerIdOrderByCreatedAtDesc(Integer photographerId, Pageable pageable);
}