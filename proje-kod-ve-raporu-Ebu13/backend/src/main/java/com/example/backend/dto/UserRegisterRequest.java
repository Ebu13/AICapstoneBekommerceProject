package com.example.backend.dto;

import com.example.backend.model.User.Role;
import lombok.Data;

@Data
public class UserRegisterRequest {
    private String name;
    private String email;
    private String password;
    private Role role;
}