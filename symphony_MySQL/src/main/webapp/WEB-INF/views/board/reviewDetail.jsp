<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../header.jsp"%>
<!-- 본문 template.jsp 시작 -->

<head>
	<title>Bootstrap Example</title>
	
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<!-- 부트스트랩 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

	<link rel="stylesheet" href="css/create.css"> 
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"> 
</head>

<style>

.button-like {
  border: 2px solid #8a8a8a;
  background-color: transparent;
  text-decoration: none;
  padding: 1rem;
  position: relative;
  vertical-align: middle;
  text-align: center;
  display: inline-block;
  border-radius: 3rem;
  color: #8a8a8a;
  transition: all ease 0.4s;
}

.button-like span {
  margin-left: 0.5rem;
}

.button-like .fa,
.button-like span {
  transition: all ease 0.4s;
}

.button-like:focus {
  background-color: transparent;
}

.button-like:focus .fa,
.button-like:focus span {
  color: #8a8a8a;
}

.button-like:hover {
  border-color: #cc4b37;
  background-color: transparent;
}

.button-like:hover .fa,
.button-like:hover span {
  color: #cc4b37;
}

.liked {
  background-color: #cc4b37;
  border-color: #cc4b37;
}

.liked .fa,
.liked span {
  color: #fefefe;
}

.liked:focus {
  background-color: #cc4b37;
}

.liked:focus .fa,
.liked:focus span {
  color: #fefefe;
}

.liked:hover {
  background-color: #cc4b37;
  border-color: #cc4b37;
}

.liked:hover .fa,
.liked:hover span {
  color: #fefefe;
}

</style>

<script>
	
	//jsp 시작할 때 실행하는 것
	$(document).ready(function (){
		checkLike();//좋아요 표시 함수 실행
	});

	function deleteEvent(){
		if(confirm("삭제하시겠습니까?")){
			
			location.href = 'reviewDelete.do?wNum=${detail.wNum}';
			
		};//if end
	}//deleteEvent() end
	
	//좋아요 확인
	function checkLike(){
		let wNum = ${detail.wNum};//model에서 가져온 글번호를 가져온다.
		
		let data = {
				 wNum : wNum
		};
		
		if(wNum != null && wNum != ""){//글번호가 null이 아니고 빈값이 아닐 때 실행
			$.ajax({
		         type : "POST",
		         url : "/checkLike.do",//post로 보내는 주소
		         data : JSON.stringify(data),//변수 data 에 담은 것을 ajax 로 넘긴다. 
		         contentType : "application/json",
		         cache : false,
		         success : function(result) {//ajax가 실행된 후 성공햇을 때 실행하는 것
		        	 console.log("result :", result);
		        	 
		        	 if(result){
			        	 let likeNum = result.likeNum;//리턴 값으로 좋아요 순번을 받아온다.

			        	 if(likeNum){//순번 있으면 실행
			        		 
				        	 $(".button-like").addClass('liked');//좋아요 빨강색 되게 클래스 추가
				        	 $("input[name=likeNum]").val(likeNum);//나중에 활용하기 위해 만들어놓은 hidden input 에 값을 넣어줌
				        	 
			        	 }else{//순번이 없을 경우 실행
			        		 $(".button-like").removeClass('liked');//좋아요 빨강색 없어지게 클래스 삭제
			        		 $("input[name=likeNum]").val("");//input 에 넣은 값 초기화
			        	 }
		        	 }else{
		        		 $(".button-like").removeClass('liked');
		        		 $("input[name=likeNum]").val("");
		        	 }
		         },
		         error : function(e) {
		            console.log(e);
		         }
		      });//ajax end 
		}
	}
	
	//좋아요 버튼 누르면 실행되는 함수
	function like(){
		
		let liked = $(".liked");//클래스 liked 된 것을 찾아온다. 
		let liked_yn = "";//좋아요가 되어진 상태 여부
		let wNum = ${detail.wNum};//리뷰 순번
		let likeNum = $("input[name=likeNum]").val();//checkLike() 함수에서 넣어준 값을 가지고 온다.
		
		console.log(liked);
		
		if(liked.length != 0){//좋아요가 이미 눌러진 상태
			likedYn = "Y";//좋아요인데 다시 좋아요를 눌렀으므로 좋아요 취소의 의미
		}else{
			likedYn = "N";//좋아요를 다시 누른다는 의미
		}
		
		let data = {
				  likedYn : likedYn		//좋아요 여부
				, wNum : wNum			//글 순번
				, likeNum : likeNum		//좋아요 순번
		};
		
 		$.ajax({
	         type : "POST",
	         url : "/like.do",
	         data : JSON.stringify(data),
	         contentType : "application/json",
	         cache : false,
	         success : function(result) {
	        	 checkLike();//좋아요 테이블에 값이 없는 경우 인설트하고 값이 있는 경우 업데이트하고 난 뒤 checkLike() 함수를 실행하여 빨강색 표시를 할 지 결정한다.
	         },
	         error : function(e) {
	            console.log(e);
	         }
	      });//ajax end 

	}//like() end
	
</script>

<body>
	<div class="container mt-3">
		<div class="body">
			
			<div class="mb-3 mt-3">
				<label>제목</label>
				<input type="text" class="form-control" name="wTitle" value="${detail.wTitle}" readonly>
			</div><!--mb-3 mt-3 end -->

			<div class="mb-3 mt-3">
				<label for="comment">내용</label>
				<textarea class="form-control" rows="5" id="comment" name="wText" readonly>${detail.wText}</textarea>
			</div><!--mb-3 mt-3 end -->
			
			<div class="mb-3 mt-3">
   				<video src="../storage/${detail.wPicPath}#t=0.5" width="500px" controls preload="metadata"></video>
   			</div>
			

			<div class='bottom'>
				<button type="button" class="btn btn-primary" onclick="location.href='reviewList.do'">목록</button>
			</div><!--bottom end--> 
			
		</div>
		
		<button type="button" class="btn btn-secondary" onclick="location.href='reviewUpdateForm.do?wNum=${detail.wNum}'">수정</button>
		<button type="button" class="btn btn-secondary" onclick="deleteEvent();">삭제</button>
		
		<!-- 좋아요 -->
		<c:if test="${!empty s_id}">
			<button class="button button-like" onClick="like();">
  				<i class="fa fa-heart"></i>
 				<span>Like</span>
			</button>
		</c:if>
		<input type="hidden" name="likeNum">
	</div><!--container end-->
</body>


	
<!-- 본문 template.jsp 끝 -->
<%@ include file="../footer.jsp"%>