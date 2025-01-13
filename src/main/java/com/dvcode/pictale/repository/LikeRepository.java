package com.dvcode.pictale.repository;

import com.dvcode.pictale.model.Like;
import com.dvcode.pictale.model.LikeId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LikeRepository extends JpaRepository<Like, LikeId> {
    // Verificar se uma foto foi curtida por um fotógrafo
    boolean existsByPhotoIdAndPhotographerId(Integer photoId, Integer photographerId);
    
    // Contar curtidas de uma foto
    Integer countByPhotoId(Integer photoId);
    
    // Buscar todas as curtidas de um fotógrafo
    List<Like> findByPhotographerId(Integer photographerId);
}