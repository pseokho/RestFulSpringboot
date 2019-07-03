package com.Springboot.vo;

import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

/**
 * @brief 유져 테이블에 필드값과 매칭되는 값들 Vo선언. 기본적으로 NULL값은 비허용이다. username, password
 *        ,role은 변경 되지않는 걸 가장해 setter를 사용하지않는다
 * @author pyun.
 * @deprecated tostring은 개발 시 값 확인을위해 넣어둔것으로 추후 삭제해도 무관함.
 */
@Entity // user 개체선언
@Table(name = "users")
public class User implements UserDetails {

    @Id
    private String username;

    @Column(nullable = false)
    private String password; // 패스워드 필드

    @Column
    private Boolean isAccountNonExpired = true;
    @Column
    private Boolean isAccountNonLocked = true;
    @Column
    private Boolean isCredentialsNonExpired = true;
    @Column
    private Boolean isEnabled = true;

    @Transient
    private Collection<? extends GrantedAuthority> authorities;

    public void setAuthorities(Collection<? extends GrantedAuthority> authorities) {
        this.authorities = authorities;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setAccountNonExpired(boolean isAccountNonExpired) {
        this.isAccountNonExpired = isAccountNonExpired;
    }

    public void setAccountNonLocked(boolean isAccountNonLocked) {
        this.isAccountNonLocked = isAccountNonLocked;
    }

    public void setCredentialsNonExpired(boolean isCredentialsNonExpired) {
        this.isCredentialsNonExpired = isCredentialsNonExpired;
    }

    public void setEnabled(boolean isEnabled) {
        this.isEnabled = isEnabled;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    @Override
    public boolean isAccountNonExpired() {
        return isAccountNonExpired;
    }

    @Override
    public boolean isAccountNonLocked() {
        return isAccountNonLocked;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return isCredentialsNonExpired;
    }

    @Override
    public boolean isEnabled() {
        return isEnabled;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    public interface UserRepository extends JpaRepository<User, Long> {
    }

    @Override
    public String toString() {
        return "User [username=" + username + ", password=" + password + ", isAccountNonExpired=" + isAccountNonExpired
                + ", isAccountNonLocked=" + isAccountNonLocked + ", isCredentialsNonExpired=" + isCredentialsNonExpired
                + ", isEnabled=" + isEnabled + ", authorities=" + authorities + "]";
    }
    
    
}
