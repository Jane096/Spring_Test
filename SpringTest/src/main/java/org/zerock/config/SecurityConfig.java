package org.zerock.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.zerock.security.CustomLoginSuccessHandler;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Configuration
@EnableWebSecurity //spring MVC와 spring security를 결합하는 용도
@Log4j
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	
	@Setter(onMethod_ = {@Autowired})
	private DataSource dataSource;
	
	@Override
	public void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
			.antMatchers("/sample/all").permitAll()
			.antMatchers("/sample/admin").access("hasRole('ROLE_ADMIN')")
			.antMatchers("/sample/member").access("hasRole('ROLE_ADMIN')");
		
		http.formLogin().loginPage("/customLogin").loginProcessingUrl("/login")
				.successHandler(loginSuccessHandler()); //로그인처리
		
		//로그아웃 처리, 로그인 시 생성된 쿠키를 확인하고 로그아웃 이후 쿠키값이 삭제되고 다른값으로 변경 되었는지 확인
		http.logout().logoutUrl("/customLogout").invalidateHttpSession(true)
				.deleteCookies("remember-me", "JSESSION_ID"); 

	}
	
	@Override
	//spring security 인증 Java 설정방법
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		log.info("Configure JDBC!");
		
		String queryUser = "select userid, userpw, enabled from tbl_member where userid = ?";
		String queryDetails = "select userid, userpw, auth from tbl_member_auth where userid = ?";
		
		auth.jdbcAuthentication().dataSource(dataSource)
				.passwordEncoder(passwordEncoder())
				.usersByUsernameQuery(queryUser)
				.authoritiesByUsernameQuery(queryDetails);
	}

	@Bean //로그인 처리 Handler
	public AuthenticationSuccessHandler loginSuccessHandler() {
		return new CustomLoginSuccessHandler();
	}
	
	@Bean //passwordEncoder 지정, jdbc의 복잡한 구성을 사용하기 위해 미리 준비
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}
