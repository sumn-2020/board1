<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>	 <!-- 라이브러리 불러오기   -->
<%@ page import="bbs.Bbs" %>	
<%@ page import="bbs.BbsDAO" %>	
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>Insert title here</title>
</head>
<body>

	<%
	
		//  로그인 된 사람들은 그 정보를 담을 수 있게 하는 code 
		 String userID = null;
		 if(session.getAttribute("userID") != null) {
			 userID = (String) session.getAttribute("userID"); //로그인 한 사람들은 해당 userID가 userID변수에 담기 
		 }
		 
		 
		 //userID가 null인 경우(로그인 아직 안됐을 경우)
		 if(userID == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인을 하세요');");
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
		 }
		
	%>



	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expended="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1" aria-expanded="false">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			</ul>
		</div>
	</nav>
	
	
	<div class="container">
		<div class="row">
		
			<form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>">
				<table class="table talbe-striped" style="text-align:center; border: 1px solid #ddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eee; text-align:center">게시판 글 수정 양식</th>
						
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle() %>"></td>
						</tr>
						<tr>
							<td><textarea type="text" class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px" ><%= bbs.getBbsContent() %></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글 수정 ">
			</form>
			
			
				
		</div>
	</div>
	
	
	
	

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>