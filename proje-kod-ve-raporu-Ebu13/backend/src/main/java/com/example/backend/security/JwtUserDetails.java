package com.example.backend.security;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;

public class JwtUserDetails extends User {

    private Long id;

    public JwtUserDetails(String username, String password, String role, Long id) {
        super(username, password, AuthorityUtils.createAuthorityList(role));
        this.id = id;
    }

    public Long getId() {
        return id;
    }
}
