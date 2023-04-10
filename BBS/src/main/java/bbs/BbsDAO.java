package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
	 public int getNext() { //다음으로 작성될 글 번호
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
	
	 
	 
	 
	 /**
	  * 
	  * 게시판 목록 출력하기
	  * 
	  * 
	  */
	 public ArrayList<Bbs> getList(int pageNumber) {
		 String SQL = "select * from bbs where bbsID < ? and bbsAavailable = 1 order by bbsID desc LIMIT 10"; //삭제되지 않아서 available이 1인 글들을 10개까지만 출력하기 
		 ArrayList<Bbs> list = new ArrayList<Bbs>();
		 
		 try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10); 
			//getNext : 그 다음으로 작성될 글의 번호 (=> 만약 현재 게시글 갯수가 5라면 getNext는 6!! 6이 sql문장의 ?안에 들어가게됨 ) 
			
			rs = pstmt.executeQuery();
			while(rs.next()) { // 결과가 있을 경우
				Bbs bbs = new Bbs();
				
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAavailable(rs.getInt(6));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;  
	 }
	 
	 
	 /**
	  * 
	  * 페이징 처리
	  * 게시글이 10개 이상이라면 이전 다음 버튼 출력 
	  * 
	  * 
	  */
	  public boolean nextPage(int pageNumber) {
		  
		  String SQL = "select * from bbs where bbsID < ? and bbsAavailable = 1";  
			 
			 try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10); 
				rs = pstmt.executeQuery();
				while(rs.next()) { // 결과가 있을 경우
					return true; //다음 페이지로 넘어감
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;   
	  }
	 
	 
	  
	  /**
	   * 
	   * 뷰 페이지 출력기능 - 하나의 글 클릭시 상세 페이지 출력 
	   * 
	   */
	  public Bbs getBbs(int bbsID) {
		  
		  String SQL = "select * from bbs where bbsID = ?";  
			 
			 try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1,  bbsID); 
				rs = pstmt.executeQuery();
				while(rs.next()) { // 결과가 있을 경우
					Bbs bbs = new Bbs();
					//결과로 나온 각각의 항목들은 bbs라는 인스턴스에 넣어서 getBbs라는 함수를 부른 대상에게 넘겨주기 
					bbs.setBbsID(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setUserID(rs.getString(3));
					bbs.setBbsDate(rs.getString(4));
					bbs.setBbsContent(rs.getString(5));
					bbs.setBbsAavailable(rs.getInt(6));
					return bbs;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		   return null;   //해당글이 존재 하지 않을 경우 null반환 
	  }
	  
	  
	  
	  /**
	   * 수정하기 
	   * 
	   */
	  public int update(int bbsID, String bbsTitle, String bbsContent) {
		  String SQL = "update bbs set bbsTitle = ?, bbsContent = ? where bbsID = ?";
			 
			 try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, bbsTitle); 
				pstmt.setString(2, bbsContent); 
				pstmt.setInt(3, bbsID); // 사용자아이디 
				
				return pstmt.executeUpdate();  //update 성공했을 경우 
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류 
	  }
	  
	  
	 
	 
	
}
