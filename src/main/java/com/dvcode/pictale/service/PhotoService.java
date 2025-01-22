package com.dvcode.pictale.service;

import com.dvcode.pictale.model.Comment;
import com.dvcode.pictale.model.Photo;
import com.dvcode.pictale.model.Photographer;
import com.dvcode.pictale.model.PhotoTag;
import com.dvcode.pictale.model.Tag;
import com.dvcode.pictale.repository.CommentRepository;
import com.dvcode.pictale.repository.PhotoRepository;
import com.dvcode.pictale.repository.TagRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import org.springframework.transaction.annotation.Transactional;

import com.dvcode.pictale.repository.PhotoTagRepository;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class PhotoService {

    private final PhotoRepository photoRepository;
    private final TagRepository tagRepository;
    private final PhotoTagRepository photoTagRepository;
    private final CommentRepository commentRepository;
    @PersistenceContext
    private EntityManager entityManager;

    public PhotoService(PhotoRepository photoRepository, TagRepository tagRepository, PhotoTagRepository photoTagRepository, CommentRepository commentRepository) {
        this.photoRepository = photoRepository;
        this.tagRepository = tagRepository;
        this.photoTagRepository = photoTagRepository;
        this.commentRepository = commentRepository;
    }

    public Photo uploadPhoto(MultipartFile file, String caption, String hashtags, Photographer photographer) throws IOException {
        Photo photo = new Photo();
        photo.setPhotographer(photographer);
        photo.setCaption(caption);
    
        // Salva a imagem no sistema de arquivos e no banco de dados
        String imageUrl = saveImage(file);
        photo.setImageUrl(imageUrl);
        saveImageData(file, photo); // Salva os dados binários, se necessário
    
        // Salva a foto no banco de dados
        photo = photoRepository.save(photo);
    
        // Processa as hashtags
        Set<Tag> tags = parseHashtags(hashtags);
        for (Tag tag : tags) {
            PhotoTag photoTag = new PhotoTag();
            photoTag.setPhoto(photo);
            photoTag.setTag(tag);
            photoTagRepository.save(photoTag);
        }
    
        return photo;
    }

    private void saveImageData(MultipartFile file, Photo photo) throws IOException {
        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("File must not be null or empty");
        }
    
        // Salva os dados binários da imagem no campo `imageData`
        // photo.setImageData(file.getBytes());
    }    

    // Salva a imagem (exemplo)
    private String saveImage(MultipartFile file) throws IOException {
        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("File must not be null or empty");
        }
    
        // Obtém o diretório raiz do projeto dinamicamente
        String projectRoot = System.getProperty("user.dir");
    
        // Diretório onde as imagens serão armazenadas, relativo à raiz do projeto
        String uploadDir = projectRoot + "/src/main/resources/static/uploads/photos";
    
        // Cria o diretório se ele não existir
        File directory = new File(uploadDir);
        if (!directory.exists()) {
            boolean dirCreated = directory.mkdirs();
            if (!dirCreated) {
                throw new IOException("Failed to create directory: " + uploadDir);
            }
        }
    
        // Define o nome do arquivo
        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
    
        // Salva o arquivo no diretório
        File destinationFile = new File(directory, fileName);
        file.transferTo(destinationFile);
    
        // Retorna a URL do arquivo
        return "/uploads/photos/" + fileName;
    }
    
    

    // Processa as hashtags e cria as tags se necessário
    private Set<Tag> parseHashtags(String hashtags) {
        Set<Tag> tagSet = new HashSet<>();
        if (hashtags != null && !hashtags.isEmpty()) {
            String[] tags = hashtags.split(",");
            for (String tagName : tags) {
                tagName = tagName.trim();
                Tag tag = tagRepository.findByTagName(tagName).orElse(null);
                if (tag == null) {
                    // Se a tag não existir, cria uma nova
                    tag = new Tag();
                    tag.setTagName(tagName);
                    tag = tagRepository.save(tag); // Salva a nova tag no banco de dados
                }
                tagSet.add(tag);
            }
        }
        return tagSet;
    }

    public List<Photo> getPhotos(Photographer photographer) {
        return photoRepository.findByPhotographer(photographer);
    }

    public List<Photo> getAllPhotos() {
        return photoRepository.findAll();
    }

    @Transactional
    public List<Photo> getTimelinePhotos(Photographer photographer) {
        return photoRepository.findByPhotographerNot(photographer);
    }

    @Transactional(readOnly = true)
    public Photo getPhotoById(Integer id) {    
        return photoRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Foto não encontrada"));
    }

    @Transactional
    public void addComment(Integer photoId, String commentText, Photographer photographer) {
        Photo photo = photoRepository.findById(photoId)
                .orElseThrow(() -> new IllegalArgumentException("Foto não encontrada"));
    
        Comment comment = new Comment();
        comment.setCommentText(commentText);
        comment.setPhoto(photo);
        comment.setPhotographer(photographer);
    
        commentRepository.save(comment);
    }   
}
