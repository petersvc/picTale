package com.dvcode.pictale.controller;

import com.dvcode.pictale.service.CommentService;
import com.dvcode.pictale.service.PhotoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dvcode.pictale.model.Photographer;
import com.dvcode.pictale.service.PhotographerService;
import com.dvcode.pictale.util.Role;

import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;

import com.dvcode.pictale.model.Comment;
import com.dvcode.pictale.model.Photo;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@RequestMapping("/admin")
@PreAuthorize("hasRole('ADMIN')")  // Adicione esta anotação para segurança extra
public class AdminController {
    private final PhotographerService photographerService;
    private static final String LAYOUT_ARG = "layout";
    private static final String CONTENT_ARG = "content";
    private static final String MESSAGE_ARG = "message";

    @Autowired
    private PhotoService photoService;

    @Autowired
    private CommentService commentService;

    public AdminController(PhotographerService photographerService) {
        this.photographerService = photographerService;
    }

    // @GetMapping("/photographers")
    // public String listPhotographers(Model model, @AuthenticationPrincipal UserDetails userDetails) {
    //     Photographer admin = photographerService.findByEmail(userDetails.getUsername());
        
    //     boolean isAdmin = admin.getAuthorities().stream()
    //         .anyMatch(auth -> auth.getAuthority().equals(Role.ROLE_ADMIN.name()));

    //     if (!isAdmin) {
    //         return "redirect:/login";
    //     }

    //     model.addAttribute("photographers", photographerService.findAll());
    //     model.addAttribute(CONTENT_ARG, "photographers");
    //     return LAYOUT_ARG;
    // }

    // @GetMapping("/photographers")
    // public String listPhotographers(
    //         Model model, 
    //         @AuthenticationPrincipal UserDetails userDetails,
    //         @RequestParam(defaultValue = "0") int page,
    //         @RequestParam(defaultValue = "3") int size) {
        
    //     Photographer admin = photographerService.findByEmail(userDetails.getUsername());
    //     boolean isAdmin = admin.getAuthorities().stream()
    //             .anyMatch(auth -> auth.getAuthority().equals(Role.ROLE_ADMIN.name()));
        
    //     if (!isAdmin) {
    //         return "redirect:/login";
    //     }
        
    //     Pageable pageable = PageRequest.of(page, size, Sort.by("name").ascending());
    //     Page<Photographer> photographerPage = photographerService.findAll(pageable);
        
    //     model.addAttribute("photographers", photographerPage.getContent());
    //     model.addAttribute("currentPage", page);
    //     model.addAttribute("totalPages", photographerPage.getTotalPages());
    //     model.addAttribute("totalItems", photographerPage.getTotalElements());
    //     model.addAttribute(CONTENT_ARG, "photographers");
        
    //     return LAYOUT_ARG;
    // }

    @GetMapping("/photographers")
    public String listPhotographers(
            Model model, 
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "3") int size) {
        
        Photographer admin = photographerService.findByEmail(userDetails.getUsername());
        boolean isAdmin = admin.getAuthorities().stream()
                .anyMatch(auth -> auth.getAuthority().equals(Role.ROLE_ADMIN.name()));
        
        if (!isAdmin) {
            return "redirect:/login";
        }
        
        Pageable pageable = PageRequest.of(page, size, Sort.by("name").ascending());
        Page<Photographer> photographerPage = photographerService.findAll(pageable);
        
        model.addAttribute("photographers", photographerPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", photographerPage.getTotalPages());
        model.addAttribute("totalItems", photographerPage.getTotalElements());
        model.addAttribute("photographerService", photographerService);  // Adicionando o serviço ao modelo
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

    @PostMapping("/photographers/{id}/suspend-comment")
    public String suspendPhotographerComment(@PathVariable Integer id, RedirectAttributes attr) {
        photographerService.suspendCommentAbility(id);
        attr.addFlashAttribute(MESSAGE_ARG, "Comment ability suspended successfully!");
        return "redirect:/admin/photographers";
    }

    @PostMapping("/photographers/{id}/unsuspend-comment")
    public String unsuspendPhotographerComment(@PathVariable Integer id, RedirectAttributes attr) {
        photographerService.unsuspendCommentAbility(id);
        attr.addFlashAttribute(MESSAGE_ARG, "Comment ability restored successfully!");
        return "redirect:/admin/photographers";
    }

    @GetMapping("/photo/{photoId}/comments/pdf")
    public ResponseEntity<ByteArrayResource> generateCommentsPdfAndDownload(@PathVariable Integer photoId) throws IOException {
        // Passo 1: Obter a foto e seus comentários
        Photo photo = photoService.getPhotoById(Math.toIntExact(photoId));
        List<Comment> comments = commentService.getCommentsByPhotoIdOrderedByDate(photoId);

        // Passo 2: Gerar o PDF em memória
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        generatePdf(comments, byteArrayOutputStream);

        // Passo 3: Criar o ByteArrayResource a partir do PDF gerado
        ByteArrayResource resource = new ByteArrayResource(byteArrayOutputStream.toByteArray());

        // Passo 4: Preparar a resposta para download do PDF
        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_PDF)
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=comments.pdf")
                .body(resource);
    }

    private void generatePdf(List<Comment> comments, ByteArrayOutputStream byteArrayOutputStream) throws IOException {
        // Inicializa o PdfWriter com um ByteArrayOutputStream
        PdfWriter writer = new PdfWriter(byteArrayOutputStream);

        // Inicializa o PdfDocument com o writer
        PdfDocument pdfDocument = new PdfDocument(writer);

        // Cria o Document para adicionar conteúdo ao PDF
        Document document = new Document(pdfDocument);

        // Adiciona o título
        document.add(new Paragraph("Comentários da Foto"));
        document.add(new Paragraph("--------------------------------------------------"));
        document.add(new Paragraph());

        // Adiciona os comentários ordenados por data
        for (Comment comment : comments) {
            String commentText = comment.getCommentText();
            String commentDate = comment.getCreatedAt().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
            String photographerName = comment.getPhotographer().getName();

            document.add(new Paragraph("Comentário de: " + photographerName));
            document.add(new Paragraph("Data: " + commentDate));
            document.add(new Paragraph("Comentário: " + commentText));
            document.add(new Paragraph());
        }

        // Fecha o documento
        document.close();
    }

}