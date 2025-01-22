package com.dvcode.pictale.controller;

import com.dvcode.pictale.model.Comment;
import com.dvcode.pictale.model.Photo;
import com.dvcode.pictale.model.Photographer;
import com.dvcode.pictale.service.CommentService;
import com.dvcode.pictale.service.PhotoService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/photos/{photoId}/comments")
public class CommentController {

    private final CommentService commentService;
    private final PhotoService photoService;

    public CommentController(CommentService commentService, PhotoService photoService) {
        this.commentService = commentService;
        this.photoService = photoService;
    }

    @GetMapping
    public String showPhotoComments(@PathVariable Integer photoId, Model model) {
        Photo photo = photoService.getPhotoById(photoId);
        if (photo == null) {
            throw new IllegalArgumentException("Foto não encontrada.");
        }
        model.addAttribute("photo", photo);
        model.addAttribute("comments", photo.getComments());
        return "photo-comments"; // Página de comentários
    }

    @PostMapping
    public String addComment(@PathVariable Integer photoId,
                             @RequestParam String commentText,
                             @SessionAttribute(name = "photographer", required = false) Photographer photographer,
                             Model model) {
        if (photographer == null) {
            return "redirect:/login";
        }

        Photo photo = photoService.getPhotoById(photoId);
        if (photo == null) {
            throw new IllegalArgumentException("Foto não encontrada.");
        }

        Comment comment = commentService.createComment(photo, photographer, commentText);

        model.addAttribute("photo", photo);
        model.addAttribute("comments", photo.getComments());
        return "redirect:/photos/" + photoId + "/comments"; // Redireciona após adicionar o comentário
    }
}
