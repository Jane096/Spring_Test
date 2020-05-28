package org.zerock.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

import lombok.extern.log4j.Log4j;

@Configuration
@EnableWebSecurity //spring MVC와 spring security를 결합하는 용도
@Log4j
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	
	@Override
	public void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
			.antMatchers("/sample/all").permitAll()
			.antMatchers("/sample/admin").access("hasRole('ROLE_ADMIN')")
			.antMatchers("/sample/member").access("hasRole('ROLE_ADMIN')");
		
		http.formLogin().loginPage("/customLogin").loginProcessingUrl("/login");
	}
	
	@Override
	public void configure(AuthenticationManagerBuilder auth) throws Exception {
		log.info("Configure called!");
		auth.inMemoryAuthentication().withUser("admin").password("{noop} admin").roles("ADMIN");
		auth.inMemoryAuthentication().withUser("member").password("{noop} member").roles("MENBER");
	}
}