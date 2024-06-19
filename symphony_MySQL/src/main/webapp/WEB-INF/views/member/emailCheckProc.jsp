<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>emailCheckProc.jsp</title>
</head>
<body>
  <div style="text-align: center">
    <h3>Email 중복확인 결과</h3>
<%
    int cnt  =Integer.parseInt(String.valueOf(request.getAttribute("cnt"))); //MemberController.java의 79행, 80행 참조
    String email=(String)request.getAttribute("email");//MemberController.java의 80행 참조  

	out.println("입력Email : <strong>" + email + "</strong>"); 
	if(cnt==0){
	    out.println("<p>사용 가능한 Email입니다</p>");
	    out.println("<a href='javascript:apply(\"" + email + "\")'>[적용]</a>");
%>
		<script>
			function apply(email) {
				opener.memfrm.email.value=email;
				window.close();
			}//apply() end
		</script>
<%	    
	}else{
	    out.println("<p style='color:red'>해당 Email는 사용할 수 없습니다</p>");
	}//if end
%>    
    <hr>
    <a href="javascript:history.back()">[다시검색]</a>
    &nbsp;&nbsp;
    <a href="javascript:window.close()">[창닫기]</a>

  </div>
</body>
</html>