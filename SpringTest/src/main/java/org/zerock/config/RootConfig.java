package org.zerock.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@ComponentScan(basePackages = {"org.zerock.service"})
@ComponentScan(basePackages = {"org.zerock.task"})
@MapperScan(basePackages = {"org.zerock.mapper"})
@EnableAspectJAutoProxy
@EnableScheduling // quartz-scheduler에 대한 설정
@EnableTransactionManagement //aspectj-autoproxy에 대한 설정
public class RootConfig {

	@Bean //ConnectionPool
	public DataSource dataSource() { HikariConfig hikariConfig = new HikariConfig();
	  //hikariConfig.setDriverClassName("oracle.jdbc.driver.OracleDriver");
	  //hikariConfig.setJdbcUrl("jdbc:oracle:thin:@localhost:1521:xe");
	  
	  //log4jdbc-log4j properties 설정 추가로 변경된 오라클 드라이버
	  	hikariConfig.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
	  	hikariConfig.setJdbcUrl("jdbc:log4jdbc:oracle:thin:@localhost:1521:xe");
	  	hikariConfig.setUsername("System"); 
	  	hikariConfig.setPassword("admin1234");
	  
	  	HikariDataSource dataSource = new HikariDataSource(hikariConfig);
	  
	  	return dataSource; 
	}
	  
	@Bean //SQL session을 만들고 Connection을 생성하거나 sql문을 전달하고 리턴받는 역할을 함
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
		sqlSessionFactory.setDataSource(dataSource());
	  
		return (SqlSessionFactory) sqlSessionFactory.getObject();
	} 
	@Bean
	public DataSourceTransactionManager txManager() {
		return new DataSourceTransactionManager(dataSource());
	}
}
