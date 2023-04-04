<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ page import="user.UserDAO" %> <!-- 클래스 불러오기   -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트를 작성하기 위해 사용  -->
<%
request.setCharacterEncoding("UTF-8");
%>	<!-- 건너오는 모든 데이터를 UTF-8로 받기   -->

<!-- java beans 사용하기, 현재 페이지 안에서만 이 beans를 사용하겠다(scope="page")  -->
<jsp:useBean id="user" class="user.User" scope="page" />

<!-- login.jsp에서 넘겨준 name="userID" name="userPassword" 를 받음  -->
<jsp:setProperty name="user" property="userID" />	
<jsp:setProperty name="user" property="userPassword" />	
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


	<%
		//인스턴스 만들기 
		UserDAO userDAO = new UserDAO();
	
		//login.jsp에서 id와 password값을 받아서 dao속에 있는 login메소드 실행
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		
		if(result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}else if(result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호 틀림');");
			script.println("history.back()"); //다시 로그인페이지로 돌려보냄
			script.println("</script>");
		}else if(result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디');");
			script.println("history.back()"); //다시 로그인페이지로 돌려보냄
			script.println("</script>");
		}else if(result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류 발생');");
			script.println("history.back()"); //다시 로그인페이지로 돌려보냄
			script.println("</script>");
		}
	
	%>


</body>
</html>