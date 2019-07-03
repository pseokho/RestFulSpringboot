package com.Springboot;

import java.util.Arrays;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.Springboot.services.UserService;

@SpringBootApplication
@MapperScan(value = { "com.Springboot.mapper" })
@EnableWebSecurity
public class RestFulSpringbootApplication implements CommandLineRunner {

	public static void main(String[] args) {
		SpringApplication.run(RestFulSpringbootApplication.class, args);
	}

	@Autowired
	UserService userService;
	private PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

	@Override
	public void run(String... args) throws Exception {

		String[] meta = args;
		if (args.length > 2) {//비밀번호 아이디 등록이 들어온경우발동
			String user = meta[1];
			String pwd = passwordEncoder.encode(meta[2]);
			userService.createUsers(user, pwd);
			userService.createUserAuthority(user);
			System.out.println("user명  [" + user + "] 비밀번호 : [ ***** ] 으로 생성되었습니다.");
		}

	}

}
