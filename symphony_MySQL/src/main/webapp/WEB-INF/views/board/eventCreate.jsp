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

	<link rel="stylesheet" href="css/create.css">
</head>

<body>
	<div class="container mt-3">
		<form class="body"  method="post" action="eventCreate.do">
			<h2>이벤트 글쓰기</h2>
			<div class="mb-3 mt-3">
				<label>제목</label>
				<input type="text" class="form-control" name="wTitle" placeholder="제목을 작성해주세요.">
			</div><!--mb-3 mt-3 end -->
	
			<div class="mb-3 mt-3">
				<label>내용</label>
				<textarea class="form-control" rows="5" id="comment" name="wText" placeholder="내용을 작성해주세요."></textarea>
			</div><!--mb-3 mt-3 end -->
	
	 		<div class='bottom'>
				<button type="button" class="btn btn-primary" onclick="location.href='eventList.do'">목록</button>
				<input type="submit" value="저장" class="btn btn-primary">
			</div><!--bottom end--> 
		</form>
	</div><!--container end-->
</body>

</html>	
	
<!-- 본문 template.jsp 끝 -->
<%@ include file="../footer.jsp"%>