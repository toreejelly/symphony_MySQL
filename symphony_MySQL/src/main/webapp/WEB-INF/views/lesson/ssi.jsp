<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- ssi.jsp 공통코드 --%>

<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="kr.co.symphony.review.*"%>
<%@ page import="kr.co.symphony.notice.*"%>
<%@ page import="kr.co.symphony.event.*"%>
<%@ page import="kr.co.symphony.lessonreg.*"%>
<%@ page import="net.utility.*"%>

<jsp:useBean id="dao" class="kr.co.symphony.review.ReviewDAO" scope="page"></jsp:useBean>
<jsp:useBean id="dto" class="kr.co.symphony.review.ReviewDTO" scope="page"></jsp:useBean>

<jsp:useBean id="dao1" class="kr.co.symphony.notice.NoticeDAO" scope="page"></jsp:useBean>
<jsp:useBean id="dto1" class="kr.co.symphony.notice.NoticeDTO" scope="page"></jsp:useBean>
<jsp:useBean id="dao2" class="kr.co.symphony.event.EventDAO" scope="page"></jsp:useBean>
<jsp:useBean id="dto2" class="kr.co.symphony.event.EventDTO" scope="page"></jsp:useBean>
<jsp:useBean id="dao3" class="kr.co.symphony.lessonreg.RegDAO" scope="page"></jsp:useBean>
<jsp:useBean id="dto3" class="kr.co.symphony.lessonreg.RegDTO" scope="page"></jsp:useBean>


<%request.setCharacterEncoding("UTF-8");%>

<%
	// 검색
	String word=request.getParameter("word"); // 검색어
	String col=request.getParameter("col"); // 검색 칼럼
	word=Utility.checkNull(word); // 문자열값이 null이면 빈문자열로 치환
	col=Utility.checkNull(col);
	
	// 현재페이지 --------------------------------------------------------------------
		int nowPage=1;
		if(request.getParameter("nowPage") != null) {
			nowPage=Integer.parseInt(request.getParameter("nowPage"));
		}
	
%>