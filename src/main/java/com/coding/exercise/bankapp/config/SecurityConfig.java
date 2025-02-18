package com.coding.exercise.bankapp.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {
        httpSecurity
                .authorizeHttpRequests(authorizeRequests -> authorizeRequests
                        .requestMatchers("/").permitAll()
                        // .requestMatchers("/h2-console/**").permitAll()
                        .requestMatchers("/customers/**").permitAll()
                        .requestMatchers("/accounts/**").permitAll() // Allow access to /customers/** endpoints
                        .anyRequest().permitAll())
                .csrf(csrf -> csrf.disable())
                .headers(headers -> headers.frameOptions(frameOptions -> frameOptions.disable()));

        return httpSecurity.build();
    }
}