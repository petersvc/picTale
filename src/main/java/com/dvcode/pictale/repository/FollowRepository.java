package com.dvcode.pictale.repository;

import com.dvcode.pictale.model.Follow;
import com.dvcode.pictale.model.FollowId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

@Repository
public interface FollowRepository extends JpaRepository<Follow, FollowId> {
    // Verificar se um fotógrafo segue outro
    boolean existsByFollowerIdAndFolloweeId(Integer followerId, Integer followeeId);
    
    // Contar seguidores de um fotógrafo
    Integer countByFolloweeId(Integer followeeId);
    
    // Contar quantos um fotógrafo está seguindo
    Integer countByFollowerId(Integer followerId);
    
    // Buscar seguidores de um fotógrafo
    Page<Follow> findByFolloweeId(Integer followeeId, Pageable pageable);
    
    // Buscar quem um fotógrafo está seguindo
    Page<Follow> findByFollowerId(Integer followerId, Pageable pageable);
}
