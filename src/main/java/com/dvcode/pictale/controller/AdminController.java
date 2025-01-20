package com.dvcode.pictale.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dvcode.pictale.model.Photographer;
import com.dvcode.pictale.service.PhotographerService;
import com.dvcode.pictale.util.Role;

@Controller
@RequestMapping("/admin")
public class AdminController {
    private final PhotographerService photographerService;
    private static final String PHOTOGRAPHER_ARG = "photographer";
    private static final String REDIRECT_PHOTOGRAPHERS = "redirect:/admin/photographers";
    private static final String LAYOUT_ARG = "layout";
    private static final String CONTENT_ARG = "content";
    private static final String MESSAGE_ARG = "message";
    
    public AdminController(PhotographerService photographerService) {
        this.photographerService = photographerService;
    }
    
    @GetMapping("/photographers")
    public String listPhotographers(Model model, @SessionAttribute(name = PHOTOGRAPHER_ARG, required = true) Photographer photographer) {
        if (photographer == null || photographer.getRole() != Role.ADMIN) {
            return "redirect:/login";
        }
        model.addAttribute("photographers", photographerService.findAll());
        model.addAttribute(CONTENT_ARG, "photographers");
        return LAYOUT_ARG;
    }


    @PostMapping("/photographers/{id}/suspend")
    public String suspendPhotographer(@PathVariable Integer id, RedirectAttributes attr) {
        photographerService.suspend(id); // Marca o fotógrafo como suspenso
        attr.addFlashAttribute(MESSAGE_ARG, "Photographer suspended successfully!");
        return REDIRECT_PHOTOGRAPHERS;
    }

    @PostMapping("/photographers/{id}/unsuspend")
    public String unsuspendPhotographer(@PathVariable Integer id, RedirectAttributes attr) {
        photographerService.unsuspend(id); // Remove a suspensão do fotógrafo
        attr.addFlashAttribute(MESSAGE_ARG, "Photographer unsuspended successfully!");
        return REDIRECT_PHOTOGRAPHERS;
    }
}
