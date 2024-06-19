<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../header.jsp"%>
<!-- 본문 template.jsp 시작 -->

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>deleteForm.jsp</title>
	
	<style> 
		*{ font-family: gulim; font-size: 24px; } 
	</style> 
    
    <link href="../css/style.css" rel="stylesheet" type="text/css">
</head>

<body>
	<div class="title">공지사항 삭제</div>
		<form name="frm" method="post" action="noticeDelete.do">
			<input type="text" name="wNum" value=${requestScope.wNum}>
			
			<div class='content'>
				<p>공지사항을 삭제하시겠습니까?</p>
			</div>
			  
			<div>
				<input type='submit' value='삭제'>
				<input type='button' value='목록' onclick="location.href='noticeList.do'">
			</div>
		</form>
</body>

</html> 
	
<!-- 본문 template.jsp 끝 -->
<%@ include file="../footer.jsp"%>