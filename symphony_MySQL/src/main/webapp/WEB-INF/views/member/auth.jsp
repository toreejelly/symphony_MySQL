<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- auth.jsp 공통코드--%>
<%-- 로그인 상태 정보 확인 --%>
<%
	String s_id="";
	String s_passwd="";
	String s_ulevel="";
	
	if(session.getAttribute("s_id")==null||session.getAttribute("s_passwd")==null||session.getAttribute("s_ulevel")==null){
	    //로그인하지 않았다면 
	    s_id="guest";
	    s_passwd="guest";
	    s_ulevel="guest";
	}else{
	    //로그인 성공 했다면
	    s_id    =(String)session.getAttribute("s_id");
	    s_passwd=(String)session.getAttribute("s_passwd");
	    s_ulevel=(String)session.getAttribute("s_ulevel");
	}//if end
%>


