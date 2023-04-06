<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>	 <!-- 라이브러리 불러오기   -->
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
	
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
		 
		 int pageNumber = 1; //기본 페이지 
		 if(request.getParameter("pageNumber") != null) { //파라미터로 페이지번호가 넘어왔을 경우 
			 pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
						<th style="background-color: #eee; text-align:center">번호</th>
						<th style="background-color: #eee; text-align:center">제목</th>
						<th style="background-color: #eee; text-align:center">작성자</th>
						<th style="background-color: #eee; text-align:center">작성일</th>
					</tr>
				</thead>
				<tbody>
					
					<%
					
						BbsDAO bbsDAO = new BbsDAO(); //인스턴스 만들기 
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++) {
					%>
				
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID()%>"><%= list.get(i).getBbsTitle()  %></a></td>
						<td><%= list.get(i).getUserID()%></td>
						<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시" + list.get(i).getBbsDate().substring(14, 16) + "분"   %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			
			
			<%
				if(pageNumber != 1) {
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arrow-left">이전</a>
			<%
				} if(bbsDAO.nextPage(pageNumber + 1)) { //다음페이지가 존재한다면 
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arrow-left">다음</a>
			<%
				}
			%>
			
			
			
			
			
				
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>	
		</div>
	</div>
	
	
	
	
	

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>