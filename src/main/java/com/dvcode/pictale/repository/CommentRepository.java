package com.dvcode.pictale.repository;

import com.dvcode.pictale.model.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Integer> {
    // Buscar comentários de uma foto
}