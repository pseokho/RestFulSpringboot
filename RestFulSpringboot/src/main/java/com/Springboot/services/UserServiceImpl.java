package com.Springboot.services;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.Springboot.mapper.UserMapper;
import com.Springboot.vo.User;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper userMapper;

    private PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userMapper.readUserInfo(username);
        user.setAuthorities(getAuthorities(username));
        return user;
    }

    public Collection<GrantedAuthority> getAuthorities(String username) {
        List<String> string_authorities = userMapper.readAuthority(username);

        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        for (String authority : string_authorities) {
            authorities.add(new SimpleGrantedAuthority(authority));
        }

        return authorities;

    }

    @Override
    public User readUserInfo(String username) {
        User user = userMapper.readUserInfo(username);
        return user;
    }

    @Override
    public PasswordEncoder passwordEncoder() {
        return this.passwordEncoder;
    }

    @Override
    public void createUsers(String username, String password) {
        userMapper.createUsers(username, password);
    }

    @Override
    public void createUserAuthority(String username) {
        userMapper.createUserAuthority(username);
        
    }

}
