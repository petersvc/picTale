package com.dvcode.pictale.service;

import com.dvcode.pictale.model.Comment;
import com.dvcode.pictale.model.Photo;
import com.dvcode.pictale.model.Photographer;
import com.dvcode.pictale.repository.CommentRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class CommentService {

    private final CommentRepository commentRepository;

    public CommentService(CommentRepository commentRepository) {
        this.commentRepository = commentRepository;
    }

    public Comment createComment(Photo photo, Photographer photographer, String commentText) {
        Comment comment = new Comment();
        comment.setPhoto(photo);
        comment.setPhotographer(photographer);
        comment.setCommentText(commentText);
        comment.setCreatedAt(LocalDateTime.now());

        return commentRepository.save(comment);
    }
}
