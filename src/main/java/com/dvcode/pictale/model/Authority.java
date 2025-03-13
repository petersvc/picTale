package com.dvcode.pictale.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "authorities")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Authority {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "username", referencedColumnName = "username")
    private Photographer photographer;

    @Column(name = "authority")
    private String authority;

    // @Embeddable
    // @Data
    // @NoArgsConstructor
    // @AllArgsConstructor
    // public static class AuthorityId implements Serializable {
    //     private String username;
    //     private String authority;
    // }
}
