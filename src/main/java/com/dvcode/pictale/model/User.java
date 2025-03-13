// package com.dvcode.pictale.model;

// import java.util.List;

// import jakarta.persistence.Entity;
// import jakarta.persistence.Id;
// import jakarta.persistence.OneToMany;
// import jakarta.persistence.Table;
// import lombok.AllArgsConstructor;
// import lombok.Data;
// import lombok.NoArgsConstructor;

// @Entity
// @Table(name = "users")
// @Data
// @NoArgsConstructor
// @AllArgsConstructor
// public class User {

//     @Id
//     private String username;
//     private String password;
//     private Boolean enabled;

//     @OneToMany(mappedBy = "username")
//     List<Authority> authorities;
// }