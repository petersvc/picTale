package com.dvcode.pictale.controller;

import com.dvcode.pictale.model.Photo;
import com.dvcode.pictale.model.Photographer;
import com.dvcode.pictale.service.PhotoService;
import com.dvcode.pictale.service.PhotographerService;

import jakarta.validation.Valid;

import java.io.IOException;
import java.util.List;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/")
public class UserController {
    private static final String CONTENT_ARG = "content";
    private static final String MESSAGE_ARG = "message";
    private static final String ERROR_ARG = "error";
    private static final String LAYOUT_ARG = "layout";
    private static final String PHOTOGRAPHER_ARG = "photographer";

    private final PhotographerService photographerService;
    private final PhotoService photoService;


    public UserController(PhotographerService photographerService, PhotoService photoService) {
        this.photographerService = photographerService;
        this.photoService = photoService;
    }

    @GetMapping
    public String showLanding(Model model) {
        model.addAttribute(PHOTOGRAPHER_ARG, new Photographer());
        model.addAttribute(CONTENT_ARG, "landing");
        return LAYOUT_ARG;
    }

    @GetMapping("/home")
    public String home(Model model, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            Photographer currentUser = photographerService.findByEmail(userDetails.getUsername());
            
            List<Photo> photos = photoService.getTimelinePhotos(currentUser);
            
            model.addAttribute("photos", photos);
            model.addAttribute("currentUser", currentUser);
            model.addAttribute(CONTENT_ARG, "home");
            model.addAttribute("followingCount", photographerService.getFollowingCount(currentUser.getId()));
            
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
    public String register(Model model, @Valid Photographer photographer,
                            BindingResult result,
                            @RequestParam("profilePicture") MultipartFile profilePicture,
                            RedirectAttributes attr) {
        if (result.hasErrors()) {
            System.out.println("entrou no if 1");
            model.addAttribute("photographer", photographer);
            // FIX: Add content to the model directly
            model.addAttribute(CONTENT_ARG, "registration :: content");
            return LAYOUT_ARG;
        }

        try {
            if (!profilePicture.isEmpty()) {
                String profilePictureUrl = photographerService.uploadProfilePicture(profilePicture);
                photographer.setProfilePicture(profilePictureUrl);
            }
            photographerService.register(photographer);
            attr.addFlashAttribute(MESSAGE_ARG, "Registration successful!");
            return "redirect:/login";
        } catch (IOException e) {
            attr.addFlashAttribute(ERROR_ARG, "Error uploading profile picture: " + e.getMessage());
            // FIX: Add content to the model directly
            model.addAttribute(CONTENT_ARG, "registration :: content");
            return LAYOUT_ARG;
        }
    }

    // @PostMapping("/registration")
    // public String register(@Valid Photographer photographer, BindingResult result, RedirectAttributes attr) {
    //     if (result.hasErrors()) {
    //         attr.addFlashAttribute(CONTENT_ARG, "registration :: content");
    //         return LAYOUT_ARG;
    //     }
    //     photographerService.register(photographer);
    //     attr.addFlashAttribute(MESSAGE_ARG, "Registration successful!");
    //     return "redirect:/login";
    // }


    // @GetMapping("/login")
    // public String showLogin(Model model) {
    //     model.addAttribute(CONTENT_ARG, "login");
    //     return LAYOUT_ARG;
    // }

    @GetMapping("/login")
    public String showLogin(Model model, @RequestParam(required = false) String error) {
        if (error != null) {
            model.addAttribute("error", "Invalid email or password");
        }
        model.addAttribute(CONTENT_ARG, "login");
        return LAYOUT_ARG;
    }

    // @PostMapping("/login")
    // public String login(String email, String password, RedirectAttributes attr, HttpSession session) {
    //     Photographer photographer = photographerService.findByEmailAndPassword(email, password);

    //     if (photographer.isSuspended()) {
    //         attr.addFlashAttribute(ERROR_ARG, "Your account is suspended.");
    //         return "redirect:/login";
    //     }

    //     boolean isAdmin = photographerService.isAdmin(photographer);
    //     session.setAttribute(PHOTOGRAPHER_ARG, photographer); // Armazena na sessão

    //     if (isAdmin) {
    //         attr.addFlashAttribute(MESSAGE_ARG, "Login successful!");
    //         return REDIRECT_PHOTOGRAPHERS;
    //     } else {
    //         return "redirect:/home";
    //     }
    // }

    // @PostMapping("/login")
    // public String login(String email, String password, RedirectAttributes attr, HttpSession session) {
    //     Photographer photographer = photographerService.findByEmail(email);

    //     if (photographer == null || !passwordEncoder.matches(password, photographer.getPassword())) {
    //         attr.addFlashAttribute("error", "Email ou senha inválidos.");
    //         return "redirect:/login";
    //     }

    //     if (photographer.isSuspended()) {
    //         attr.addFlashAttribute("error", "Sua conta está suspensa.");
    //         return "redirect:/login";
    //     }

    //     session.setAttribute("photographer", photographer);
    //     return photographer.getRole() == Role.ADMIN ? REDIRECT_PHOTOGRAPHERS : "redirect:/home";
    // }

}
