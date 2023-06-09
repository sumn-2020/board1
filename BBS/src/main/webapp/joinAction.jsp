<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ page import="user.UserDAO" %> <!-- 클래스 불러오기   -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트를 작성하기 위해 사용  -->
<%
request.setCharacterEncoding("UTF-8");
%>	<!-- 건너오는 모든 데이터를 UTF-8로 받기   -->

<!-- java beans 사용하기, 현재 페이지 안에서만 이 beans를 사용하겠다(scope="page")  -->
<jsp:useBean id="user" class="user.User" scope="page" />

<!-- join.jsp에서 넘겨준 name="userID" name="userPassword" 를 받아오기   -->
<jsp:setProperty name="user" property="userID" />	
<jsp:setProperty name="user" property="userPassword" />	
<jsp:setProperty name="user" property="userName" />	
<jsp:setProperty name="user" property="userGender" />	
<jsp:setProperty name="user" property="userEmail" />	
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


	<%
	
	
		// 로그인 된 사용자는 회원가입 페이지 못들어가게 막기
		String userID = null;
		if(session.getAttribute("userID") != null) { //할당된 세션이 없을 경우
			userID = (String) session.getAttribute("userID");// 자신에게 할당된 세션을 userID라는 변수에 담기 
		}
		if(userID != null) { //할당된 세션이 있을 경우 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인 되어있음');"); //이미 로그인 된 사람은 또다시 로그인 할 수 없도록 막기 
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
	
	
	
	
	
	
	
	
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || 
			user.getUserGender() == null || user.getUserEmail() == null) { //한 항목이라도 비어있을 경우 
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력 안 된 사항이 있음 ');");
			script.println("history.back()"); 
			script.println("</script>");
			
		}else {
			//인스턴스 만들기 
			UserDAO userDAO = new UserDAO();
		
			//join.jsp에서 id와 password값을 받아서 dao속에 있는 join메소드 실행
			int result = userDAO.join(user); //상단에서 받아온 각각의 name값들을 받은 것들을 매개변수로 사용
			
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디');");
				script.println("history.back()");  // 이전페이지로 이동
				script.println("</script>");
			}else { //로그인 성공했을 경우
				
				// 로그인 성공시 세션 부여하기 
				session.setAttribute("userID", user.getUserID());
				
				
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}

	
	%>


</body>
</html>