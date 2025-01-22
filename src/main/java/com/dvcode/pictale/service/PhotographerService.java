package com.dvcode.pictale.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Set;

import org.hibernate.Hibernate;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import com.dvcode.pictale.model.Follow;
import com.dvcode.pictale.model.Photographer;
import com.dvcode.pictale.util.Role;
import com.dvcode.pictale.repository.FollowRepository;
import com.dvcode.pictale.repository.PhotographerRepository;

@Service
@Transactional
public class PhotographerService {
    private final PhotographerRepository photographerRepository;
    private final FollowRepository followRepository;

    public PhotographerService(PhotographerRepository photographerRepository, FollowRepository followRepository) {
        this.photographerRepository = photographerRepository;
        this.followRepository = followRepository;
    }

    public String uploadProfilePicture(MultipartFile file) throws IOException {
    if (file == null || file.isEmpty()) {
        throw new IllegalArgumentException("File must not be null or empty");
    }

    // Diretório para armazenar as imagens de perfil
    String projectRoot = System.getProperty("user.dir");
    String uploadDir = projectRoot + "/src/main/resources/static/uploads/profile-pictures";

    // Cria o diretório se ele não existir
    File directory = new File(uploadDir);
    if (!directory.exists() && !directory.mkdirs()) {
        throw new IOException("Failed to create directory: " + uploadDir);
    }

    // Define o nome do arquivo
    String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();

    // Salva o arquivo no diretório
    File destinationFile = new File(directory, fileName);
    file.transferTo(destinationFile);

    // Retorna a URL relativa para o arquivo
    return "/uploads/profile-pictures/" + fileName;
}


    public Photographer register(Photographer photographer) {
        if (photographerRepository.findByEmail(photographer.getEmail()).isPresent()) {
            throw new IllegalArgumentException("Email already registered");
        }

        photographer.setRole(Role.PHOTOGRAPHER);
        photographer.setSuspended(false);
        
        return photographerRepository.save(photographer);
    }

    public Photographer findByEmailAndPassword(String email, String password) {
        return photographerRepository.findByEmailAndPassword(email, password)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid email or password"));
    }
    public List<Photographer> findAll() {
        return photographerRepository.findAllByOrderByNameAsc();
    }

    public boolean isAdmin(Photographer photographer) {
        return photographer.getRole() == Role.ADMIN;
    }

    public void suspend(Integer id) {
        Photographer photographer = photographerRepository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Photographer not found"));
            
        photographer.setSuspended(true);
        photographerRepository.save(photographer);
    }

    public void unsuspend(Integer id) {
        Photographer photographer = photographerRepository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Photographer not found"));
            
        photographer.setSuspended(false);
        photographerRepository.save(photographer);
    }

    @Transactional(readOnly = true)
    public Photographer findById(Integer id) {
        return photographerRepository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Photographer not found"));
    }

    @Transactional(readOnly = true)
    public Object getFollowingCount(Integer photographerId) {
        return followRepository.countByFollowerId(photographerId);
    }

   public Set<Follow> getFollowing(Integer photographerId) {
        Photographer photographer = photographerRepository.findById(photographerId)
            .orElseThrow(() -> new IllegalArgumentException("Photographer not found"));
        // Inicializa a coleção "following"
        Hibernate.initialize(photographer.getFollowing());
        Set<Follow> following = photographer.getFollowing();

        return following;

    }

}