package com.dvcode.pictale.service;

import org.springframework.stereotype.Service;

import com.dvcode.pictale.model.Like;
import com.dvcode.pictale.model.LikeId;
import com.dvcode.pictale.model.Photo;
import com.dvcode.pictale.model.Photographer;
import com.dvcode.pictale.repository.LikeRepository;
import com.dvcode.pictale.repository.PhotoRepository;
import com.dvcode.pictale.repository.PhotographerRepository;

@Service
public class LikeService {

    private final LikeRepository likeRepository;
    private final PhotoRepository photoRepository;
    private final PhotographerRepository photographerRepository;

    public LikeService(LikeRepository likeRepository, PhotoRepository photoRepository, PhotographerRepository photographerRepository) {
        this.likeRepository = likeRepository;
        this.photoRepository = photoRepository;
        this.photographerRepository = photographerRepository;
    }

    public boolean isPhotoLikedByPhotographer(Integer photoId, Integer photographerId) {
        return likeRepository.existsByPhotoIdAndPhotographerId(photoId, photographerId);
    }

    public void addLike(Integer photoId, Integer photographerId) {
        Photo photo = photoRepository.findById(photoId).orElseThrow(() -> new RuntimeException("Foto não encontrada"));
        Photographer photographer = photographerRepository.findById(photographerId).orElseThrow(() -> new RuntimeException("Fotógrafo não encontrado"));

        Like like = new Like();
        LikeId likeId = new LikeId();
        likeId.setPhotoId(photoId);
        likeId.setPhotographerId(photographerId);
        like.setId(likeId);
        like.setPhotographer(photographer);
        like.setPhoto(photo);

        likeRepository.save(like);
    }

    public void removeLike(Integer photoId, Integer photographerId) {
        LikeId likeId = new LikeId();
        likeId.setPhotoId(photoId);
        likeId.setPhotographerId(photographerId);
        likeRepository.deleteById(likeId);
    }
}
