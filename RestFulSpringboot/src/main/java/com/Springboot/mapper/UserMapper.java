package com.Springboot.mapper;

import java.util.List;

import com.Springboot.vo.User;

public interface UserMapper {


	/**
	 *  사용자의 정보를확인하기위해.
	 * @param username : 유저명
	 * @return User에 정보를 리턴한다.
	 */
	public User readUserInfo(String username);
	/**
	 * Spring-Securty 인증을위해 사용자에 인증 권한을 확인한다.
	 * @param username : 유저명
	 * @return 해당유저에 접근 권한을 설정한다.
	 */
	public List<String> readAuthority(String username);
    
	public void createUsers(String username ,String password);
	public void createUserAuthority(String username);
}
