package user;

public class User {
	
	//VO => 한명의 회원 데이터를 다룰 수 있는 데이터베이스 및 java beans
	// 하나의 데이터를 관리하고 처리할 수 있는 기법을 jsp에서 구현하는 것을 java beans라고 함  
	
	//DB컬럼명과 동일하게 작성 
	private String userID;
	private String userPassword;
	private String usreName;
	private String userGender;
	private String userEmail;
	
	
	//source > generate getters and setters
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUsreName() {
		return usreName;
	}
	public void setUsreName(String usreName) {
		this.usreName = usreName;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	
	
	
	
	
	
}
