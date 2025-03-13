package com.dvcode.pictale.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dvcode.pictale.model.Photographer;
import com.dvcode.pictale.service.PhotographerService;
import com.dvcode.pictale.util.Role;

@Controller
@RequestMapping("/admin")
@PreAuthorize("hasRole('ADMIN')")  // Adicione esta anotação para segurança extra
public class AdminController {
    private final PhotographerService photographerService;
    private static final String LAYOUT_ARG = "layout";
    private static final String CONTENT_ARG = "content";
    private static final String MESSAGE_ARG = "message";

    public AdminController(PhotographerService photographerService) {
        this.photographerService = photographerService;
    }

    @GetMapping("/photographers")
    public String listPhotographers(Model model, @AuthenticationPrincipal UserDetails userDetails) {
        Photographer admin = photographerService.findByEmail(userDetails.getUsername());
        
        boolean isAdmin = admin.getAuthorities().stream()
            .anyMatch(auth -> auth.getAuthority().equals(Role.ROLE_ADMIN.name()));

        if (!isAdmin) {
            return "redirect:/login";
        }

        model.addAttribute("photographers", photographerService.findAll());
        model.addAttribute(CONTENT_ARG, "photographers");
        return LAYOUT_ARG;
    }

    @PostMapping("/photographers/{id}/suspend")
    public String suspendPhotographer(@PathVariable Integer id, RedirectAttributes attr) {
        photographerService.suspend(id);
        attr.addFlashAttribute(MESSAGE_ARG, "Photographer suspended successfully!");
        return "redirect:/admin/photographers";
    }

    @PostMapping("/photographers/{id}/unsuspend")
    public String unsuspendPhotographer(@PathVariable Integer id, RedirectAttributes attr) {
        photographerService.unsuspend(id);
        attr.addFlashAttribute(MESSAGE_ARG, "Photographer unsuspended successfully!");
        return "redirect:/admin/photographers";
    }
}