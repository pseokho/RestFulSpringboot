package com.Springboot.vo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.data.jpa.repository.JpaRepository;
@Entity // user 개체선언
@Table(name = "authority")
public class Authority {
	@Id
	private String username  ;

	@Column(nullable = false)
	private String authority_name ;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getAuthority_name() {
		return authority_name;
	}

	public void setAuthority_name(String authority_name) {
		this.authority_name = authority_name;
	}
	
	 public interface AuthorityRepository extends JpaRepository<Authority, Long> {
	 }
	
}
