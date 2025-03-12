package com.dvcode.pictale.service;

import com.dvcode.pictale.model.Authority;
import com.dvcode.pictale.model.Photographer;
import com.dvcode.pictale.repository.PhotographerRepository;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.stream.Collectors;

import org.springframework.security.authentication.DisabledException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class UserDetailsServiceImpl implements UserDetailsService {
    private final PhotographerRepository photographerRepository;

    public UserDetailsServiceImpl(PhotographerRepository photographerRepository) {
        this.photographerRepository = photographerRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Photographer photographer = photographerRepository.findByEmail(email)
            .orElseThrow(() -> new UsernameNotFoundException("User not found with email: " + email));

        if (photographer.isSuspended()) {
            throw new DisabledException("Account is suspended");
        }

        return User.builder()
            .username(photographer.getEmail())
            .password(photographer.getPassword())
            .authorities(
                photographer.getAuthorities().stream()
                    .map(Authority::getAuthority) // Pega as authorities associadas ao Photographer
                    .collect(Collectors.toList()) // Converte para List<String>
                    .toArray(new String[0]) // Converte para array de String
            )
            .disabled(photographer.isSuspended())
            .accountExpired(false)
            .accountLocked(false)
            .credentialsExpired(false)
            .build();

        // return User.builder()
        //     .username(photographer.getEmail())
        //     .password(photographer.getPassword())
        //     .roles() // photographer.getRoles().toArray(new String[0]
        //     .disabled(photographer.isSuspended())
        //     .accountExpired(false)
        //     .accountLocked(false)
        //     .credentialsExpired(false)
        //     .build();
    }
}
