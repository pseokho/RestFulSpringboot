package com.Springboot.config;

import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.header.writers.frameoptions.WhiteListedAllowFromStrategy;
import org.springframework.security.web.header.writers.frameoptions.XFrameOptionsHeaderWriter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.Springboot.services.UserServiceImpl;

/**
 * @Brief Spring Security 제약 조건 설정하는 곳
 * @author p
 *
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    UserServiceImpl usersevice;

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(usersevice).passwordEncoder(usersevice.passwordEncoder());

    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        /*
         * http .authorizeRequests() .antMatchers("/home/**") .authenticated()
         * .antMatchers("/**") .permitAll() .and() .httpBasic();
         */
        http.authorizeRequests() 
            .antMatchers("**") 
            .authenticated()
            .and() .httpBasic();
        ;/*
          * http.authorizeRequests().antMatchers("/h2-console/**").permitAll().anyRequest
          * ().authenticated().and().csrf()
          * .ignoringAntMatchers("/h2-console/**").and().headers().addHeaderWriter( new
          * XFrameOptionsHeaderWriter(new
          * WhiteListedAllowFromStrategy(Arrays.asList("localhost")) // 여기!
          * )).and().httpBasic();
          */


    }

}
