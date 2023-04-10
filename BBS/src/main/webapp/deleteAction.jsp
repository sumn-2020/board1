<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ page import="bbs.Bbs" %>	
<%@ page import="bbs.BbsDAO" %> <!-- 클래스 불러오기   -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트를 작성하기 위해 사용  -->
<%
request.setCharacterEncoding("UTF-8");
%>	<!-- 건너오는 모든 데이터를 UTF-8로 받기   -->


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
		if(userID == null) { //할당된 세션이 있을 경우 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요 ');"); //이미 로그인 된 사람은 또다시 로그인 할 수 없도록 막기 
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		
		
		
		 // 현재 수정하고자 하는 글번호가 없을 경우 
		 int bbsID = 0;
		 if(request.getParameter("bbsID") != null) { //매개변수로서 bbsID값이 정상적으로 넘어왔다면 그 값을 bbsID라는 변수에 담아서 
			 bbsID = Integer.parseInt(request.getParameter("bbsID"));
		 }
		 //bbsID값이 있는 글만 상세페이지 볼수 있도록 하기 
		 if(bbsID == 0) { //bbsID가 0이라면 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글입니다.');");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");
		 }

		 // 현재 작성한 글이 작성한 사람 본인인지 확인하기 
		 Bbs bbs = new BbsDAO().getBbs(bbsID); //넘어온 bbsID를 가지고 해당 글을 확인하기 
		 if(!userID.equals(bbs.getUserID())) { //이 글을 작성한 사람의 id가 넘어온 id값이 같지 않다면 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('권한이 없습니다. ');");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");
		 }else {
			

			//인스턴스 만들기 
			BbsDAO bbsDAO = new BbsDAO();
		
			//write.jsp에서 getBbsTitle과 getBbsContent값을 받아서 dao속에 있는 delete메소드  실행
			int result = bbsDAO.delete(bbsID); 
			
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제 실패');");
				script.println("history.back()");  // 이전페이지로 이동
				script.println("</script>");
			}else { // 글 삭제 성공했을 경우 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");
			}
			
		}
	

	
	%>


</body>
</html>