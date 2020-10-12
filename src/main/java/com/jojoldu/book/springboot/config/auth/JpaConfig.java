package com.jojoldu.book.springboot.config.auth;


import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@Configuration
@EnableJpaAuditing // jpa Auditing 활성화
public class JpaConfig {
}
