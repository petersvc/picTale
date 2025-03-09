package com.dvcode.pictale.controller;

import com.dvcode.pictale.model.Comment;
import com.dvcode.pictale.service.CommentService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/comments")
public class CommentController {
    private final CommentService commentService;

    public CommentController(CommentService commentService) {
        this.commentService = commentService;
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> editComment(@PathVariable Integer id, @RequestBody String newText) {
        Comment updatedComment = commentService.editComment(id, newText);
        if (updatedComment == null) {
            return ResponseEntity.noContent().build(); // Comentário foi excluído
        }
        return ResponseEntity.ok(updatedComment);
    }
}
