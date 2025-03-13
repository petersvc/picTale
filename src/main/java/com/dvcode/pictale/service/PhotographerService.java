package com.dvcode.pictale.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.hibernate.Hibernate;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import com.dvcode.pictale.model.Authority;
import com.dvcode.pictale.model.Follow;
import com.dvcode.pictale.model.Photographer;
import com.dvcode.pictale.util.Role;
import com.dvcode.pictale.repository.AuthorityRepository;
import com.dvcode.pictale.repository.FollowRepository;
import com.dvcode.pictale.repository.PhotographerRepository;

@Service
@Transactional
public class PhotographerService {
    private final PhotographerRepository photographerRepository;
    private final FollowRepository followRepository;
    private final AuthorityRepository authorityRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    public PhotographerService(PhotographerRepository photographerRepository, FollowRepository followRepository, AuthorityRepository authorityRepository, BCryptPasswordEncoder passwordEncoder) {
        this.photographerRepository = photographerRepository;
        this.followRepository = followRepository;
        this.authorityRepository = authorityRepository;
        this.passwordEncoder = passwordEncoder;
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

    // public Photographer register(Photographer photographer) {
    //     if (photographerRepository.findByEmail(photographer.getEmail()).isPresent()) {
    //         throw new IllegalArgumentException("Email already registered");
    //     }

    //     // List<Role> roles = photographer.getRoles();
    //     // roles.add(Role.PHOTOGRAPHER);
    //     // roles.add(Role.CREATE_COMMENT);

    //     // photographer.setRoles(roles);
    //     photographer.setSuspended(false);
    //     photographer.setPassword(passwordEncoder.encode(photographer.getPassword()));

        
    //     return photographerRepository.save(photographer);
    // }

    public Photographer register(Photographer photographer) {
        if (photographerRepository.findByEmail(photographer.getEmail()).isPresent()) {
            throw new IllegalArgumentException("Email already registered");
        }
    
        // Define senha criptografada e status inicial
        photographer.setSuspended(false);
        photographer.setPassword(passwordEncoder.encode(photographer.getPassword()));
        photographer.setUsername(photographer.getEmail());
    
        // Salva primeiro o Photographer
        Photographer savedPhotographer = photographerRepository.save(photographer);
        photographerRepository.flush(); // Garante que o ID foi gerado
    
        if (savedPhotographer.getId() == null) {
            throw new IllegalStateException("Photographer ID is null after save!");
        }
    
        System.out.println(savedPhotographer.getId() + "------------------------------------------------------------------------------");
    
        // Define authorities padrões
        List<Authority> defaultAuthorities = List.of(
            new Authority(null, savedPhotographer, Role.ROLE_PHOTOGRAPHER.name()),
            new Authority(null, savedPhotographer, Role.ROLE_CREATE_COMMENT.name())
        );
    
        // Salva as authorities no banco
        authorityRepository.saveAll(defaultAuthorities);
    
        return savedPhotographer;
    }
    

    public Photographer findByUsername(String username) {
        return photographerRepository.findByUsername(username)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Photographer not found"));
    }

    public Photographer findByEmail(String email) {
        return photographerRepository.findByEmail(email)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Photographer not found"));
    }

    public Photographer findByEmailAndPassword(String email, String password) {
        return photographerRepository.findByEmailAndPassword(email, password)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid email or password"));
    }

    // public List<Photographer> findAll() {
    //     return photographerRepository.findAllByOrderByNameAsc();
    // }

    public Page<Photographer> findAll(Pageable pageable) {
        return photographerRepository.findAllByOrderByNameAsc(pageable);
    }

    public boolean isAdmin(Photographer photographer) {
        return photographer.getAuthorities().stream()
            .anyMatch(auth -> auth.getAuthority().equals(Role.ROLE_ADMIN.name()));
        // return photographer.getRole() == Role.ADMIN;
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

    @Transactional(readOnly = true)
    public Photographer findByIdWithAuthorities(Integer id) {
        Photographer photographer = photographerRepository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Photographer not found"));
        
        // Inicializa a coleção de autoridades explicitamente
        Hibernate.initialize(photographer.getAuthorities());
        
        return photographer;
    }

    public void suspendCommentAbility(Integer id) {
        Photographer photographer = findByIdWithAuthorities(id);
        
        // Encontrar e remover a autoridade corretamente
        List<Authority> authorities = photographer.getAuthorities();
        List<Authority> toRemove = new ArrayList<>();
        
        for (Authority auth : authorities) {
            if (Role.ROLE_CREATE_COMMENT.name().equals(auth.getAuthority())) {
                toRemove.add(auth);
            }
        }
        
        // Remover as autoridades da lista do fotógrafo
        authorities.removeAll(toRemove);
        
        // Remover as autoridades do banco de dados
        for (Authority auth : toRemove) {
            authorityRepository.delete(auth);
        }
        
        // Salvar o fotógrafo atualizado
        photographerRepository.save(photographer);
    }

    public void unsuspendCommentAbility(Integer id) {
        Photographer photographer = findByIdWithAuthorities(id);
        
        // Verificar se já tem a autoridade
        boolean hasCommentAuthority = photographer.getAuthorities().stream()
            .anyMatch(auth -> auth.getAuthority().equals(Role.ROLE_CREATE_COMMENT.name()));
        
        // Adicionar a autoridade se não tiver
        if (!hasCommentAuthority) {
            Authority commentAuthority = new Authority(null, photographer, Role.ROLE_CREATE_COMMENT.name());
            authorityRepository.save(commentAuthority);
            photographer.getAuthorities().add(commentAuthority);
        }
        
        photographerRepository.save(photographer);
    }

    public boolean canComment(Integer id) {
        Photographer photographer = findByIdWithAuthorities(id);
        
        return photographer.getAuthorities().stream()
            .anyMatch(auth -> auth.getAuthority().equals(Role.ROLE_CREATE_COMMENT.name()));
    }

}