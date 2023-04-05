<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	

	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


	<%
	
		// 로그아웃 시 할당된 세션 제거하기 
		session.invalidate();

	
	%>
	
	<script type="text/javascript">
		location.href = 'main.jsp';
	</script>


</body>
</html>