<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>loginResult</title>
</head>
<body>
	<h2>* 로그인 결과 *</h2>
<%
	String s_id=(String)request.getAttribute("id"); 
%>
	<strong><%=s_id%></strong> 님;
	<a href='#'>[로그아웃]</a>;
	<br>
	<br>;
	<a href='#'>[회원정보수정]</a>;
	&nbsp;&nbsp;
	<a href='#'>[회원탈퇴]</a>;
	<hr>

</body>
</html>