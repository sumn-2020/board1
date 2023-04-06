<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>	 <!-- 라이브러리 불러오기   -->
	
	
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
		
			<form method="post" action="writeAction.jsp">
				<table class="table talbe-striped" style="text-align:center; border: 1px solid #ddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eee; text-align:center">게시판 글쓰기 양식</th>
						
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" ></td>
						</tr>
						<tr>
							<td><textarea type="text" class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px" ></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
			</form>
			
			
				
		</div>
	</div>
	
	
	
	
	

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>