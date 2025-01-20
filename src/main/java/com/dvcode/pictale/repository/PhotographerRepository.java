package com.dvcode.pictale.repository;

import com.dvcode.pictale.model.Photographer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

@Repository
public interface PhotographerRepository extends JpaRepository<Photographer, Integer> {
    Optional<Photographer> findByEmail(String email);

    Optional<Photographer> findByEmailAndPassword(String email, String password);
    
    // Para busca paginada de fotógrafos (caso de uso do admin)
    List<Photographer> findAllByOrderByNameAsc();
    
    // Buscar fotógrafos não suspensos
    Page<Photographer> findBySuspendedFalseOrderByNameAsc(Pageable pageable);
    
    // Buscar fotógrafos por nome ou email (para pesquisa)
    Page<Photographer> findByNameContainingIgnoreCaseOrEmailContainingIgnoreCase(
        String name, String email, Pageable pageable);
}
