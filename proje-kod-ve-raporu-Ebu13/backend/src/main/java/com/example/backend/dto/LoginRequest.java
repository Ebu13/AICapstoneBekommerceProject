package com.example.backend.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginRequest {

    @Schema(example = "user@example.com", description = "Kullanıcının email adresi", required = true)
    private String email;

    @Schema(example = "password123", description = "Kullanıcının şifresi", required = true)
    private String password;
}
