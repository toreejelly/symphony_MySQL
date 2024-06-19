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
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
  	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
	<link rel="stylesheet" href="css/create.css">
</head>

<script>

	function updateReview(){
		if(confirm("수정하시겠습니까?")){
			
			$("#form").submit();
			
		};//if end
	}//updateReview() end

</script>

<body>
	<div class="container mt-3">
		<form id="form" class="body"  method="post" action="reviewUpdate.do" enctype="multipart/form-data">
			<input type="hidden" name="wNum" value="${update.wNum}" >
			<div class="mb-3 mt-3">
				<label>제목</label>
				<input type="text" class="form-control" name="wTitle" value="${update.wTitle}" >
			</div><!--mb-3 mt-3 end -->

			<div class="mb-3 mt-3">
				<label for="comment">내용</label>
				<textarea class="form-control" rows="5" id="wText" name="wText">${update.wText}</textarea>
			</div><!--mb-3 mt-3 end -->
			
			<p>첨부파일</p>
		    <div class="custom-file mb-3">
		      <input type="file" class="custom-file-input" id="customFile" name=filenameMF ">
		      <label class="custom-file-label" for="customFile">파일선택</label>
		    </div>
			
			<div class="mb-3 mt-3">
				<label>등록된 파일</label>
				<input type="text" class="form-control" name="wPic" value="${update.wPic}" readonly>
				<input type="hidden" class="form-control" name="wPicPath" value="${update.wPicPath}" >
			</div><!--mb-3 mt-3 end -->

			<div class='bottom'>
				<button type="button" class="btn btn-primary" onclick="location.href='reviewList.do'">목록</button>
			</div><!--bottom end--> 
			
		</form>
		
		<button type="button" class="btn btn-secondary" onclick="updateReview();">저장</button>
		<button type="button" class="btn btn-secondary" onclick="location.href='reviewList.do'">취소</button>
	
	</div><!--container end-->
</body>

<script>
	// Add the following code if you want the name of the file appear on select
	$(".custom-file-input").on("change", function() {
		
		 var filenameMF = $(this).val().split("\\").pop();
		 $(this).siblings(".custom-file-label").addClass("selected").html(filenameMF);
	 
	});
</script>

</html>	
	
<!-- 본문 template.jsp 끝 -->
<%@ include file="../footer.jsp"%>