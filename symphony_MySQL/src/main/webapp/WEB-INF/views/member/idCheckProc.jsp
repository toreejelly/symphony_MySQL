<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>idCheckProc.jsp</title>
</head>
<body>
	
	<div style="text-align: center">
        <h3>아이디 중복확인 결과</h3>
<%
		int cnt  =Integer.parseInt(String.valueOf(request.getAttribute("cnt"))); //MemberController.java의 79행, 80행 참조
		String id=(String)request.getAttribute("id");//MemberController.java의 80행 참조
		
		out.println("입력ID : <strong>" + id + "</strong>");
		if(cnt==0){
		    out.println("<p>사용 가능한 아이디 입니다</p>");
		    //사용 가능한 id를 부모창에 전달하기
		    out.println("<a href='javascript:apply(\"" + id + "\")'>[적용]</a>");
%>
			<script>
				function apply(id){
					//alert(id);
					//중복 확인된 id를 부모창(opener)에 적용
					opener.document.memfrm.id.value=id;
					window.close();
				}//apply() end
			</script>
<%		    
		}else{
		    out.println("<p style='color:red'>해당 아이디는 사용할 수 없습니다</p>");
		}//if end
%>        
		<hr>
		<a href="javascript:history.back()">[다시검색]</a>
		&nbsp;&nbsp;
		<a href="javascript:window.close()">[창닫기]</a>
	</div>  
	   
</body>
</html>