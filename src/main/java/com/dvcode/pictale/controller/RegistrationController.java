package com.dvcode.pictale.controller;

import com.dvcode.pictale.model.Photographer;
import com.dvcode.pictale.service.PhotographerService;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/")
public class RegistrationController {
    private final PhotographerService photographerService;

    public RegistrationController(PhotographerService photographerService) {
        this.photographerService = photographerService;
    }

    @GetMapping("/landing")
    public String home() {
        return "landing"; // O nome do arquivo principal
    }
    
    @GetMapping("/registration")
    public String showRegistration(Model model) {
        model.addAttribute("photographer", new Photographer());
        model.addAttribute("title", "Photographer Registration");
        model.addAttribute("content", "registration"); // Deve corresponder ao fragmento existente
        return "layout"; // O nome do arquivo principal
    }
    
    @PostMapping("/registration")
    public String register(@Valid Photographer photographer, BindingResult result, RedirectAttributes attr) {
        if (result.hasErrors()) {
            attr.addFlashAttribute("content", "registration :: content");
            return "layout"; // Garante que o layout seja retornado
        }
        photographerService.register(photographer);
        attr.addFlashAttribute("message", "Registration successful!");
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String showLogin(Model model) {
        model.addAttribute("title", "Photographer Login");
        model.addAttribute("content", "login"); // Deve corresponder ao fragmento existente
        return "layout"; // O nome do arquivo principal
    }

    // @GetMapping("/logout")
    // public String logout(Model model) {
    //     model.addAttribute("title", "Logout");
    //     model.addAttribute("content", "logout"); // Deve corresponder ao fragmento existente
    //     return "layout"; // O nome do arquivo principal
    // }

    // @PostMapping("/login")
    // public String login(Model model) {
    //     model.addAttribute("title", "Login");
    //     model.addAttribute("content", "login"); // Deve corresponder ao fragmento existente
    //     return "layout"; // O nome do arquivo principal
    // }

}
