package com.dvcode.pictale.controller;

import com.dvcode.pictale.model.Photographer;
import com.dvcode.pictale.model.Photo;
import com.dvcode.pictale.service.LikeService;
import com.dvcode.pictale.service.PhotoService;
import com.dvcode.pictale.service.PhotographerService;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.springframework.web.multipart.MultipartFile;

@Controller
public class PhotoController {

    private final PhotoService photoService;
    private final LikeService likeService;
    private final PhotographerService photographerService;

    public PhotoController(PhotoService photoService, LikeService likeService, PhotographerService photographerService) {
        this.photoService = photoService;
        this.likeService = likeService;
        this.photographerService = photographerService;
    }

     @GetMapping("/photos/{id}")
    @Transactional(readOnly = true)
    public String getPhoto(Model model, @PathVariable("id") Integer id, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails == null) {
            return "redirect:/login";
        }

        Photographer photographer = photographerService.findByEmail(userDetails.getUsername());
        Photo photo = photoService.getPhotoById(id);

        if (photo == null) {
            return "redirect:/photos";
        }

        boolean liked = likeService.isPhotoLikedByPhotographer(id, photographer.getId());

        model.addAttribute("photo", photo);
        model.addAttribute("liked", liked);
        model.addAttribute("content", "photo-detail");

        return "layout";
    }


    // @PostMapping("/photos/{id}/like")
    // public String likePhoto(@PathVariable("id") Integer id, @SessionAttribute(name = "photographer", required = false) Photographer photographer) {
    //     if (photographer == null) {
    //         return "redirect:/login";
    //     }

    //     // Verifica se o fotógrafo já curtiu a foto
    //     boolean liked = likeService.isPhotoLikedByPhotographer(id, photographer.getId());

    //     if (liked) {
    //         // Se já curtiu, remove o like
    //         likeService.removeLike(id, photographer.getId());
    //     } else {
    //         // Se não curtiu, adiciona o like
    //         likeService.addLike(id, photographer.getId());
    //     }

    //     // Redireciona de volta para a página da foto
    //     return "redirect:/photos/" + id;
    // }

    @PostMapping("/photos/{id}/like")
    public String likePhoto(@PathVariable("id") Integer id, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails == null) {
            return "redirect:/login";
        }

        Photographer photographer = photographerService.findByEmail(userDetails.getUsername());
        boolean liked = likeService.isPhotoLikedByPhotographer(id, photographer.getId());

        if (liked) {
            likeService.removeLike(id, photographer.getId());
        } else {
            likeService.addLike(id, photographer.getId());
        }

        return "redirect:/photos/" + id;
    }

    @PostMapping("/photos/{id}/comment")
    public String addComment(@PathVariable("id") Integer id, 
                            @RequestParam("commentText") String commentText,
                            @AuthenticationPrincipal UserDetails userDetails,
                            RedirectAttributes attr) {
        if (userDetails == null) {
            return "redirect:/login";
        }

        Photographer photographer = photographerService.findByEmail(userDetails.getUsername());

        try {
            photoService.addComment(id, commentText, photographer);
            attr.addFlashAttribute("message", "Comentário adicionado com sucesso!");
        } catch (Exception e) {
            attr.addFlashAttribute("error", "Erro ao adicionar comentário: " + e.getMessage());
        }

        return "redirect:/photos/" + id;
    }

    @PostMapping("/photos/{photoId}/comment/{commentId}/edit")
    public String editComment(@PathVariable("photoId") Integer photoId, 
                            @PathVariable("commentId") Integer commentId,
                            @RequestParam("commentText") String commentText,
                            @AuthenticationPrincipal UserDetails userDetails,
                          RedirectAttributes attr) {
        if (userDetails == null) {
            return "redirect:/login";
        }

        Photographer photographer = photographerService.findByEmail(userDetails.getUsername());

        try {
            boolean updated = photoService.editComment(commentId, commentText, photographer);
            if (updated) {
                attr.addFlashAttribute("message", "Comentário editado com sucesso!");
            } else {
                attr.addFlashAttribute("error", "Você não tem permissão para editar este comentário.");
            }
        } catch (Exception e) {
            attr.addFlashAttribute("error", "Erro ao editar comentário: " + e.getMessage());
        }

        return "redirect:/photos/" + photoId;
    }




    @GetMapping("/upload-photo")
    public String showUploadForm(Model model, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails == null) {
            return "redirect:/login";
        }

        Photographer photographer = photographerService.findByEmail(userDetails.getUsername());

        model.addAttribute("photographer", photographer);
        model.addAttribute("content", "upload-photo");  // Página para o formulário de upload
        return "layout";  // O layout da página
    }

    @PostMapping("/upload-photo")
    public String uploadPhoto(@RequestParam("file") MultipartFile file,
                              @RequestParam("caption") String caption,
                              @RequestParam("hashtags") String hashtags,
                              @AuthenticationPrincipal UserDetails userDetails,
                              RedirectAttributes attr) {
        if (userDetails == null) {
            return "redirect:/login";
        }

        Photographer photographer = photographerService.findByEmail(userDetails.getUsername());

        try {
            // Chama o serviço para realizar o upload da foto e associar as hashtags
            photoService.uploadPhoto(file, caption, hashtags, photographer);
            
            // Redireciona com uma mensagem de sucesso
            attr.addFlashAttribute("message", "Photo uploaded successfully!");
            return "redirect:/home";  // Página onde o fotógrafo pode ver as fotos
        } catch (Exception e) {
            // Caso haja um erro, exibe a mensagem de erro
            attr.addFlashAttribute("error", "Error uploading photo: " + e.getMessage());
            return "redirect:/upload-photo";
        }
    }
}
