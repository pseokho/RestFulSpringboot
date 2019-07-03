package com.Springboot.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.springframework.stereotype.Service;

@Service
public class CreateaUserTmp {

    final String JDBC_DRIVER = "org.h2.Driver"; // 드라이버
    final String DB_URL = "jdbc:h2:mem:test"; // 접속할 DB 서버       		
    		
    final String USER_NAME = "sa"; // DB에 접속할 사용자 이름을 상수로 정의
    final String PASSWORD = ""; // 사용자의 비밀번호를 상수로 정의
    CreateaUserTmp() {
    	
    }
	public void inserUser(String user,String pwd) {
        

        Connection conn = null;
        Statement st = null; //DB로 명령전달하는 객체
        ResultSet rs = null;
        PreparedStatement ps = null;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, USER_NAME, PASSWORD);

            System.out.println("DB 연결 성공");
            
            String sql = "INSERT INTO users(username, password)  VALUES(? , ? );";

            ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pwd);
            int result = ps.executeUpdate();
           
 
            System.out.print("처리된 레코드의 개수: "+ result);
            System.out.println();
           
            //st.close();
            conn.commit();
            ps.close();
            conn.close();
        } catch (Exception e) {
            // 예외 발생 시 처리부분
        	System.out.println("실패");
            e.printStackTrace();
        } finally { // 예외가 있든 없든 무조건 실행
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException ex1) {
                //
            }
        }
	}
}
