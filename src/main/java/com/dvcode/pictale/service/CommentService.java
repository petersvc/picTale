package com.dvcode.pictale.service;

import com.dvcode.pictale.model.Comment;
import com.dvcode.pictale.repository.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {

    @Autowired
    private CommentRepository commentRepository;

    public List<Comment> getCommentsByPhotoIdOrderedByDate(Integer photoId) {
        return commentRepository.findByPhotoIdOrderByCreatedAtAsc(photoId);
    }
}

