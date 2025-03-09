package com.dvcode.pictale.service;

import com.dvcode.pictale.model.Comment;
import com.dvcode.pictale.repository.CommentRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CommentService {
    private final CommentRepository commentRepository;

    public CommentService(CommentRepository commentRepository) {
        this.commentRepository = commentRepository;
    }

    @Transactional
    public Comment editComment(Integer commentId, String newText) {
        Comment comment = commentRepository.findById(commentId)
            .orElseThrow(() -> new EntityNotFoundException("Comentário não encontrado"));

        if (newText == null || newText.trim().isEmpty()) {
            commentRepository.delete(comment);
            return null; // Indica que o comentário foi deletado
        }

        comment.setCommentText(newText);
        return commentRepository.save(comment);
    }
}
