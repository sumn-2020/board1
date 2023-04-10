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
		 //만약 파라미터값이 제대로 넘어왔다? 그러면 해당 bbsID값을 getBbs메소드로 넘겨서 함수 실행 
		 Bbs bbs = new BbsDAO().getBbs(bbsID);
		 

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
			
			
			
			<%
				//접속하기는 로그인 되어있지 않을 경우에만 나오게 하기 
				 if(userID == null) { //로그인 되어있지 않다면 
			%>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="login.jsp">로그인</a></li>
							<li><a href="join.jsp">회원가입</a></li>
						</ul></li>
				</ul>
			<%
				 }else { // 로그인 되어있다면 
			%>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false"> 회원관리 <span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="logoutAction.jsp">로그아웃</a></li>
						</ul></li>
				</ul>
			
			<%
				 }
			%>
			
			
		</div>
	</nav>
	
	
	<div class="container">
		<div class="row">
		
				<table class="table talbe-striped" style="text-align:center; border: 1px solid #ddd">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eee; text-align:center">게시판 글 보기</th>
						
						</tr>
					</thead>
					<tbody>
						<tr>	
							<td style="width: 20%;"> 글 제목 </td>
							<td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ", "&npsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
						</tr>
						<tr>
							<td> 작성자 </td>
							<td colspan="2"><%= bbs.getUserID() %></td>
						</tr>
						<tr>
							<td> 작성일자 </td>
							<td colspan="2"> <%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시" + bbs.getBbsDate().substring(14, 16) + "분"   %></td>
						</tr>
						<tr>
							<td> 내용 </td>
							<td colspan="2" style="min-height:200px; text-align:left;"><%= bbs.getBbsContent().replaceAll(" ", "&npsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
					</tbody>
				</table>
				<a href="bbs.jsp" class="btn btn-primary">목록</a>
				<%
					//해당 글의 작성자가 본인이라면 수정할 수 있게 만들기 
					if(userID != null && userID.equals(bbs.getUserID())) {
				%>
					
					<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('정말 삭제하시겠습니까?')"   href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
				
				<%
					}
				%>		
			
				
		</div>
	</div>
	
	
	
	
	

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>