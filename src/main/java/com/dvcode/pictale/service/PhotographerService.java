package com.dvcode.pictale.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import com.dvcode.pictale.model.Photographer;
import com.dvcode.pictale.util.Role;
import com.dvcode.pictale.repository.PhotographerRepository;

@Service
@Transactional
public class PhotographerService {
    private final PhotographerRepository photographerRepository;

    public PhotographerService(PhotographerRepository photographerRepository) {
        this.photographerRepository = photographerRepository;
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
}