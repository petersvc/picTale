package com.dvcode.pictale.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dvcode.pictale.model.Photographer;
import com.dvcode.pictale.service.FollowService;
import com.dvcode.pictale.service.PhotographerService;

@Controller
public class PhotographerController {

    private final PhotographerService photographerService;
    private final FollowService followService;

    public PhotographerController(PhotographerService photographerService, FollowService followService) {
        this.photographerService = photographerService;
        this.followService = followService;
    }

    @GetMapping("/photographers/{id}")
    public String getPhotographerPage(@PathVariable Integer id, Model model, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails == null) {
            return "redirect:/login";
        }

        Photographer currentUser = photographerService.findByEmail(userDetails.getUsername());
        Photographer photographer = photographerService.findById(id);
        
        model.addAttribute("photographer", photographer);
        model.addAttribute("content", "photographer");
        return "layout";
    }

    @PostMapping("/photographers/{id}/follow")
    public String followPhotographer(@PathVariable Integer id, 
                                   @AuthenticationPrincipal UserDetails userDetails, 
                                   RedirectAttributes redirectAttributes) {
        Photographer currentUser = photographerService.findByEmail(userDetails.getUsername());
        Photographer photographerToFollow = photographerService.findById(id);

        if (currentUser.equals(photographerToFollow)) {
            redirectAttributes.addFlashAttribute("error", "Você não pode seguir a si mesmo.");
            return "redirect:/photographers/" + id;
        }

        boolean isFollowing = followService.follow(currentUser, photographerToFollow);
        if (isFollowing) {
            redirectAttributes.addFlashAttribute("message", 
                "Você agora está seguindo " + photographerToFollow.getName() + "!");
        } else {
            redirectAttributes.addFlashAttribute("error", 
                "Você já segue " + photographerToFollow.getName() + ".");
        }
        return "redirect:/photographers/" + id;
    }

    @GetMapping("/following")
    public String profile(Model model, @AuthenticationPrincipal UserDetails userDetails) {
        Photographer currentUser = photographerService.findByEmail(userDetails.getUsername());
        
        model.addAttribute("photographer", currentUser);
        model.addAttribute("followingCount", photographerService.getFollowingCount(currentUser.getId()));
        model.addAttribute("followedPhotographers", photographerService.getFollowing(currentUser.getId()));
        model.addAttribute("content", "following");
        return "layout";
    }

}
