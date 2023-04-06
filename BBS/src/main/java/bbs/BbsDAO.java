package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BbsDAO {

	
	 /**
	  * mysql에 접속하기 (DAO : 데이터 접근객체)
	  * ct + shift + o  : 외부 라이브러리 추가 
	  * 
	  */
	 private Connection conn;
	 private ResultSet rs; //정보를 담을 수 있는 객체 
	 public BbsDAO() {
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
	 
	
	 
	 
	 /**
	  * 
	  * 현재 시간 가져오기 (글 작성 시 현재 시간)
	  * 
	  */
	 public String getDate() {
		 String SQL = "SELECT NOW()";
		 try {
			
			//각각의 함수끼리 데이터베이스 접근할 때 마찰이 나는 것을 방지하기 위해서 PreparedStatement는 각각의 함수 안쪽에 선언해줌 
			PreparedStatement pstmt = conn.prepareStatement(SQL); //SQL을 실행 준비 단계로 만들어주기 
			rs = pstmt.executeQuery(); //실행한 결과 rs에 담기 
			if(rs.next()) { // 결과가 있을 경우
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류 
	 }
	 
	 
	 
	 
	 /**
	  * 게시글 번호 가져오기 
	  * 게시글 번호를 점차 늘어나야하니까 마지막에 쓰인 번호에서 +1해서 점차 증가하게 만들기 
	  * 
	  */
	 public int getNext() {
		 String SQL = "select bbsID from BBS order by bbsID desc";
		 try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) { // 결과가 있을 경우
				return rs.getInt(1) + 1;
			}
			return 1;  //현재가 첫 번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 
	 }
	 
	 
	 
	 
	 /**
	  * 
	  *  글 작성하기
	  * 
	  */
	 public int write(String bbsTitle, String userID, String bbsContent) {
		 String SQL = "insert into bbs values (?, ?, ?,? ,? ,?)";
		 
		 try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); // 게시글 번호 
			pstmt.setString(2, bbsTitle); // 게시글 번호 
			pstmt.setString(3, userID); // 사용자아이디 
			pstmt.setString(4, getDate()); // 작성날짜
			pstmt.setString(5, bbsContent); // 게시글 내용
			pstmt.setInt(6, 1); // 삭제됐는지 여부 삭제 안됐을 경우1 삭제 됐을 경우 -1
			
			return pstmt.executeUpdate();  //insert 성공했을 경우 
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 
	 }
	
	
}
