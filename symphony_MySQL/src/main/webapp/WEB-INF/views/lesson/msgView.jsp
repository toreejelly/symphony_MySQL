<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    
    <title>msgView.jsp</title>
    
    <style> 
      *{ font-family: gulim; font-size: 24px; } 
    </style> 
    
    <link href="../css/style.css" rel="stylesheet" type="text/css">
</head>

<body>
	<script>
		if('${msg}'){    	
			alert('${msg}');
			location.href="${url}";
		}//if end
	</script>  
</body>

</html> 