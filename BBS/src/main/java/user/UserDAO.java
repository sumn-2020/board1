package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	// DAO(database access object)
	// 실질적으로 데이터베이스에서 데이터를 불러오거나 데이터를 집어넣을때 사용
	
	
	 //ct + shift + o  : 외부 라이브러리 추가 
	 private Connection conn;
	 private PreparedStatement pstmt;
	 private ResultSet rs; //정보를 담을 수 있는 객체 
	 
	
	 //  mysql에 접속하기 
	 public UserDAO() {
		 try {
			
			 String dbURL = "jdbc:mysql://localhost:3306/BBS"; //mysql에 BBS라는 테이블에 접속
			 String dbID = "root";
			 String dbPassword = "java";
			 Class.forName("com.mysql.jdbc.Driver"); //db에 접근할 수 있는 라이브러리 
			 conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace(); //오류가 뭔지 출력하기 
		}
	 }
	 
	 
	 //로그인 기능 
	 public int login(String userID, String userPassword) {
		 String SQL = "select userPassword from user where userID = ?";
		
		 try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID); //sql inject 해킹 기법을 방어하기 위함  => 직접적으로 sql문장에 원하는 값을 넣는게 아니라 sql문장 속 ?  안에 userID를 매개변수로 받아서 간접적으로 넣음
			rs = pstmt.executeQuery(); //실행한 결과 rs에 담기 
			
			if(rs.next()) { //찾는 아이디가  db에 존재할 경우 
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공
				}else {
					return 0; //비밀번호 불일치 
				}
			}
			return -1; //찾는 아이디가 없을 경우 
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		 return -2; //데이터베이스 오류 
	 }
	 
}
