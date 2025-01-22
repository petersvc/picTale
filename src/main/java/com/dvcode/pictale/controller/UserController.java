package com.dvcode.pictale.controller;

import com.dvcode.pictale.model.Photo;
import com.dvcode.pictale.model.Photographer;
import com.dvcode.pictale.service.PhotoService;
import com.dvcode.pictale.service.PhotographerService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/")
public class UserController {
    private static final String CONTENT_ARG = "content";
    private static final String MESSAGE_ARG = "message";
    private static final String LAYOUT_ARG = "layout";
    private static final String PHOTOGRAPHER_ARG = "photographer";
    private static final String REDIRECT_PHOTOGRAPHERS = "redirect:/admin/photographers";

    private final PhotographerService photographerService;
    private final PhotoService photoService;

    public UserController(PhotographerService photographerService, PhotoService photoService) {
        this.photographerService = photographerService;
        this.photoService = photoService;
    }

    @GetMapping("/home")
    public String home(Model model, @SessionAttribute(name = PHOTOGRAPHER_ARG, required = false) Photographer currentUser) {
        if (currentUser != null) {
            List<Photo> photos = photoService.getTimelinePhotos(currentUser);

            // if (currentUser.getFollowedPhotographers().isEmpty()) {
            //     photos = photoService.getPopularPhotos(); // Exibe fotos populares se não seguir ninguém
            // } else {
            //     photos = photoService.getPhotosFromFollowed(currentUser);
            // }

            model.addAttribute("photos", photos);
            model.addAttribute(PHOTOGRAPHER_ARG, currentUser);
            model.addAttribute(CONTENT_ARG, "home");

            return LAYOUT_ARG;
        }
        return "landing";
    }
    
    @GetMapping("/registration")
    public String showRegistration(Model model) {
        model.addAttribute(PHOTOGRAPHER_ARG, new Photographer());
        model.addAttribute(CONTENT_ARG, "registration");
        return LAYOUT_ARG;
    }
    
    @PostMapping("/registration")
    public String register(@Valid Photographer photographer, BindingResult result, RedirectAttributes attr) {
        if (result.hasErrors()) {
            attr.addFlashAttribute(CONTENT_ARG, "registration :: content");
            return LAYOUT_ARG;
        }
        photographerService.register(photographer);
        attr.addFlashAttribute(MESSAGE_ARG, "Registration successful!");
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String showLogin(Model model) {
        model.addAttribute(CONTENT_ARG, "login");
        return LAYOUT_ARG;
    }

    @PostMapping("/login")
    public String login(String email, String password, RedirectAttributes attr, HttpSession session) {
        Photographer photographer = photographerService.findByEmailAndPassword(email, password);
        boolean isAdmin = photographerService.isAdmin(photographer);
        session.setAttribute(PHOTOGRAPHER_ARG, photographer); // Armazena na sessão

        if (isAdmin) {
            attr.addFlashAttribute(MESSAGE_ARG, "Login successful!");
            return REDIRECT_PHOTOGRAPHERS;
        } else {
            return "redirect:/home";
        }
    }
}
