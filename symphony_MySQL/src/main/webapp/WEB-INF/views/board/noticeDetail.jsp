<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<!-- 본문 template.jsp 시작 -->

<!DOCTYPE html>
<html lang="ko">

<head>

	<title>Bootstrap Example</title>
  
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
  
	<!-- 부트스트랩 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  
  	<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> -->
  
	<link rel="stylesheet" href="css/create.css">
  
</head>

<script>
	function deleteNotice(){
		if(confirm("삭제하시겠습니까?")){
			
			location.href = 'noticeDelete.do?wNum=${detail.wNum}';
			
		};//if end
	}//deleteNotice() end

</script>

<body>
	
	<div class="container mt-3">
		<form class="body"  method="get" action="noticeCreate.do">
	    	<div class="mb-3 mt-3">
	        	<label>제목</label>
				<input type="text" class="form-control" name="wTitle" value="${detail.wTitle}" readonly>
			</div><!--mb-3 mt-3 end -->
	      
			<div class="mb-3 mt-3">
				<label for="comment">내용</label>
				<textarea class="form-control" rows="5" id="comment" name="wText" readonly>${detail.wText}</textarea>
			</div><!--mb-3 mt-3 end -->
	      
			<div class='bottom'>
				<button type="button" class="btn btn-primary" onclick="location.href='noticeList.do'">목록</button>
	      	</div><!--bottom end--> 
		</form>  	  

		<button type="button" class="btn btn-secondary" onclick="location.href='noticeUpdateForm.do?wNum=${detail.wNum}'">수정</button>
		<button type="button" class="btn btn-secondary" onclick="deleteNotice();">삭제</button>
		
	</div><!--container end-->
	
</body>

</html>	
	
<!-- 본문 template.jsp 끝 -->
<%@ include file="../footer.jsp"%>