package org.zerock.config;

import java.io.IOException;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.core.io.FileSystemResource;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@EnableTransactionManagement
@EnableWebMvc //mvc 구성에 필요한 빈(객체)를 자동으로 생성해주는 annotation
@ComponentScan(basePackages = { "org.zerock.controller", "org.zerock.exception"})
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true) //어노테이션을 이용하는 spring security 설정
public class ServletConfig implements WebMvcConfigurer{ //webMvcConfigurer: 생성된 빈을 커스터마이징 가능하게 해줌
	
	//기존 servlet-context.xml 내용 작성하기
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		InternalResourceViewResolver bean = new InternalResourceViewResolver();
			bean.setViewClass(JstlView.class);
			bean.setPrefix("/WEB-INF/views/");
			bean.setSuffix(".jsp");
			registry.viewResolver(bean);
	}
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
	}
	
	@Bean
	public MultipartResolver multipartResolver() {
		StandardServletMultipartResolver resolver = new StandardServletMultipartResolver();
		return resolver;
	}
	
	/*
	 * @Bean(name="multipartResolver") public CommonsMultipartResolver getResolver()
	 * throws IOException { CommonsMultipartResolver resolver = new
	 * CommonsMultipartResolver();
	 * 
	 * //2MB 지정 resolver.setMaxUploadSizePerFile(1024 * 1024 * 2);
	 * 
	 * //temp upload resolver.setUploadTempDir(new
	 * FileSystemResource("C:\\workspaces\\upload\\temp"));
	 * resolver.setDefaultEncoding("UTF-8");
	 * 
	 * return resolver; }
	 */
}