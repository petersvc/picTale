package com.dvcode.pictale.repository;

import com.dvcode.pictale.model.Tag;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

@Repository
public interface TagRepository extends JpaRepository<Tag, Integer> {
    Optional<Tag> findByTagName(String tagName);
    
    // Buscar tags mais usadas
    @Query("SELECT t, COUNT(pt) as count FROM Tag t " +
           "LEFT JOIN t.photoTags pt " +
           "GROUP BY t ORDER BY count DESC")
    Page<Tag> findMostUsedTags(Pageable pageable);
}
