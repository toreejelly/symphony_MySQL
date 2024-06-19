<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../header.jsp"%>
<!-- 본문 template.jsp 시작 -->    

<!DOCTYPE HTML>
<html lang="kor">
<head>
	<link rel="stylesheet" href="../css/course.css">
	<title>Village Symphony &mdash; 맞춤형 음악 강의, 빌리지심포니</title>


	<!-- Icomoon Icon Fonts-->
	<link rel="stylesheet" href="css/icomoon.css">
	
	<!-- Bootstrap  -->
	<link rel="stylesheet" href="css/bootstrap.css">

	<!-- Owl Carousel  -->
	<link rel="stylesheet" href="css/owl.carousel.min.css">
	<link rel="stylesheet" href="css/owl.theme.default.min.css">

	<!-- Flexslider  -->
	<link rel="stylesheet" href="css/flexslider.css">

	<!-- Theme style  -->
	<link rel="stylesheet" href="css/style.css">

</head>

<script>

$(document).ready(function(){
	//현재 선택된 페이지 표시
	$("#"+${page.nowPage}).attr("class","active");

});

</script>
	
<body>
		
<div class="fh5co-loader"></div>

<div class="fh5co-loader"></div>
	
	<!-- 까만부분 -->
	<aside id="fh5co-hero">
		<div class="flexslider">
			<ul class="slides">
		   	<li style="background-image: url(images/img_bg_4.jpg);">
		   		<div class="overlay-gradient"></div>
		   		<div class="container">
		   			<div class="row">
			   			<div class="col-md-8 col-md-offset-2 text-center slider-text">
			   				<div class="slider-text-inner">
			   					<h1 class="heading-section">Village Symphony Class</h1>
									<h2>우수한 선생님들을 여러분에게 소개해드립니다<a href="http://freehtml5.co/" target="_blank">village.symphony.com</a></h2>
			   				</div>
			   			</div>
			   		</div>
		   		</div>
		   	</li>
		  	</ul>
	  	</div>
	</aside>
	<!-- 까만부분 끝 -->
	
	<!-- 중간 -->
	<div id="fh5co-course">
		<div class="container">
		
			<!-- 중간 -->
			<div class="row animate-box">
				<div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
					<h2>Village Symphony Courses Catalog</h2>
					<p>당신에게 알맞는 강의들을 소개해드립니다</p>
				</div>
			</div>
			<!-- 중간 끝 -->
			
			<!-- 목록 -->
			<div class="row">
			
				<c:forEach var="dto" items="${list}">
				<div class="col-md-6 animate-box">
					<div class="course">
						<a href="#" class="course-img" style="background-image: url(storage/${dto.prof_photo});"></a>
						<div class="desc">
							<h3><a href="#">${dto.c_title}</a></h3>
							<p>${dto.c_content}</p>
							<span><a href="resultDetail.do?c_id=${dto.c_id}" class="btn btn-primary btn-sm btn-course">상세보기</a></span>
						</div>
					</div>
				</div>
				</c:forEach>
														
			</div>
			<!-- 목록  끝 -->
			
		</div><!-- container 끝 -->
	</div><!-- fh5co-course 끝 -->

	<!-- Paging 시작--> 
	<div class="paging">
		<ul class="pagination">
			<c:if test="${page.prev}"><!-- 이전 버튼값이 true 여야 전으로 클릭하는 화살표가 나오게 된다. -->
				<li class="page-item">
					<a class="page-link" href="result.do?nowPage=${page.startPage - 1}">◀</a>
				</li>
			</c:if>
			<c:forEach begin="${page.startPage }" end="${page.endPage }" var="idx">
				<li class="page-item" id="${idx}">
					<!-- 페이징으로 넘어가서도 학생이 선택한 질문을 유지하여 get으로 넘기기 위한 url -->
					<a class="page-link" href="result.do?nowPage=${idx}&q01ans=${dto.q01ans}&q02ans=${dto.q02ans}&q03ans=${dto.q03ans}&q04ans=${dto.q04ans}">${idx}</a>
				</li>
			</c:forEach>
			<c:if test="${page.next && page.endPage > 0}">
				<li class="page-item">
					<a class="page-link"href="result.do?nowPage=${page.endPage +1}">▶</a>
				</li>
			</c:if>
		</ul>
	</div>
	<!-- Paging 끝 -->

	

<!----------------------------------------------------------------------------------------------------->
<!-- 본문 template.jsp 끝 -->
<%@ include file="../footer.jsp"%>
	
	<!-- Magnific Popup -->
	<script src="js/jquery.magnific-popup.min.js"></script>
	<script src="js/magnific-popup-options.js"></script>
	<!-- Count Down -->
	<script src="js/simplyCountdown.js"></script>

	<script>
    var d = new Date(new Date().getTime() + 1000 * 120 * 120 * 2000);

    // default example
    simplyCountdown('.simply-countdown-one', {
        year: d.getFullYear(),
        month: d.getMonth() + 1,
        day: d.getDate()
    });

    //jQuery example
    $('#simply-countdown-losange').simplyCountdown({
        year: d.getFullYear(),
        month: d.getMonth() + 1,
        day: d.getDate(),
        enableUtc: false
    });
	</script>
	
	</body>
</html>