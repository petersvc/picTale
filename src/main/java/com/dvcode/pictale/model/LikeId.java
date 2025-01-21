package com.dvcode.pictale.model;

import java.io.Serializable;

import jakarta.persistence.Embeddable;
import lombok.Data;

@Data
@Embeddable
public class LikeId implements Serializable {
    private Integer photoId;
    private Integer photographerId;

    // Adicionar um valor fixo ou gerar automaticamente
    private Long serialVersionUID = 1L; // Defina o valor fixo ou gere conforme necessário
}
