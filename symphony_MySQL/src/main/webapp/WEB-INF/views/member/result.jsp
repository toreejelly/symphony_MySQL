<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../header.jsp"%>

<%
		String s_id=(String)request.getAttribute("id");
		out.println("<strong>" + s_id + "</strong> 님");
		out.println("<a href='logout.jsp'>[로그아웃]</a>");
		out.println("<br><br>");
		out.println("<a href='memberModify.jsp'>[회원정보수정]</a>");
		out.println("&nbsp;&nbsp;");
		out.println("<a href='memberWithdraw.jsp'>[회원탈퇴]</a>");
%>

<%@ include file="../footer.jsp"%>