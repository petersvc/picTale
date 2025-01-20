package com.dvcode.pictale.controller;

import com.dvcode.pictale.model.Photographer;
import com.dvcode.pictale.model.Photo;
import com.dvcode.pictale.service.PhotoService;
import com.dvcode.pictale.util.Role;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.SessionAttribute;

import org.springframework.web.multipart.MultipartFile;

@Controller
public class PhotoController {

    private final PhotoService photoService;

    public PhotoController(PhotoService photoService) {
        this.photoService = photoService;
    }

    @GetMapping("/upload-photo")
    public String showUploadForm(Model model, @SessionAttribute(name = "photographer", required = false) Photographer photographer) {
        if (photographer == null || photographer.getRole() != Role.PHOTOGRAPHER) {
            return "redirect:/login";
        }
        model.addAttribute("photographer", photographer);
        model.addAttribute("content", "upload-photo");  // Página para o formulário de upload
        return "layout";  // O layout da página
    }

    @PostMapping("/upload-photo")
    public String uploadPhoto(@RequestParam("file") MultipartFile file,
                              @RequestParam("caption") String caption,
                              @RequestParam("hashtags") String hashtags,
                              @SessionAttribute(name = "photographer", required = false) Photographer photographer,
                              RedirectAttributes attr) {
        if (photographer == null || photographer.getRole() != Role.PHOTOGRAPHER) {
            return "redirect:/login";
        }

        try {
            // Chama o serviço para realizar o upload da foto e associar as hashtags
            Photo photo = photoService.uploadPhoto(file, caption, hashtags, photographer);
            
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
