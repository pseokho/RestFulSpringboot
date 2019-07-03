package com.Springboot.vo;

import java.sql.Timestamp;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.springframework.data.jpa.repository.JpaRepository;

@Entity // user 개체선언
@Table(name = "histSearch")
public class HistSearch {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // pk생성전략을 DB에 위임한다는 의미입니다. mysql로 보면 pk 필드를 auto_increment로 설정해 놓은 경우로 본다
    private long id;
    @Column(nullable = false)
    private String username;

    @Column(nullable = false)
    private String keyword;

    @Column(name = "search_Time") 
    private Timestamp search_Time;
    

    public String getUsername() {
        return username;
    }

    public String getKeyword() {
        return keyword;
    }
    

    public interface HistSearchRepository extends JpaRepository<HistSearch, Long> {
    }

    @Override
    public String toString() {
        return "HistSearch [id=" + id + ", username=" + username + ", keyword=" + keyword + ", search_Time=" + search_Time
                + "]";
    }

}
