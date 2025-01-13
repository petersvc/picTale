package com.dvcode.pictale.controller;

import com.dvcode.pictale.model.Photographer;
import com.dvcode.pictale.service.PhotographerService;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin")
// @PreAuthorize("hasRole('ADMIN')")
public class AdminController {
    private PhotographerService photographerService;
    
    public AdminController(PhotographerService photographerService) {
        this.photographerService = photographerService;
    }
    
    @GetMapping("/photographers")
    public String listPhotographers(Model model, 
                                  @PageableDefault(size = 10) Pageable pageable) {
        Page<Photographer> photographers = photographerService.findAll(pageable);
        model.addAttribute("photographers", photographers);
        return "admin/photographers";
    }
    
    @PostMapping("/photographers/{id}/suspend")
    public String suspendPhotographer(@PathVariable Integer id, 
                                    RedirectAttributes attr) {
        photographerService.suspend(id);
        attr.addFlashAttribute("message", "Photographer suspended successfully!");
        return "redirect:/admin/photographers";
    }
}
