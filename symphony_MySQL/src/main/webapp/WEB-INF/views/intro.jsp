 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="kr.co.symphony.member.*"%>
    
<!DOCTYPE HTML>
<html lang="kor">
<head>
	<title>Village Symphony &mdash; 맞춤형 음악 강의, 빌리지심포니</title>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="author" content="freehtml5.co" />
	<meta property="og:title" content=""/>
	<meta property="og:image" content=""/>
	<meta property="og:url" content=""/>
	<meta property="og:site_name" content=""/>
	<meta property="og:description" content=""/>
	<meta name="twitter:title" content="" />
	<meta name="twitter:image" content="" />
	<meta name="twitter:url" content="" />
	<meta name="twitter:card" content="" />

	<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Roboto+Slab:300,400" rel="stylesheet">
	
	<!-- Animate.css -->
	<link rel="stylesheet" href="css/animate.css">
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
	function lessoncreate(){
		if("${s_id}" != "" && "${s_ulevel}" == "T"){
			location.href = "lessoncreate.do";
		}else{
			alert("강사만이 강의등록을 할 수 있습니다.");
		}
	}
</script>

<body>
	
<%
	//세션의 회원정보 가져오기
	//로그인 성공시 info라는 이름으로 담아준 세션의 정보가있고, 로그인 실패 or 하지않은상태라면 null
	//가져오는 데이터타입이 MemberDTO 
	
	MemberDTO info = (MemberDTO)session.getAttribute("info");

%>
		
<div class="fh5co-loader"></div>
	<div id="page">
		<nav class="fh5co-nav" role="navigation">
			<div class="top-menu">
				<div class="container">
					<div class="row">
						<div class="col-xs-2">
							<div id="fh5co-logo"><a href="home.do"><i class="icon-study"></i>village symphony<span></span></a></div>
						</div>
						<div class="col-xs-10 text-right menu-1">
							<ul>
								<li class="active"><a href="home.do">홈</a></li>
								<li><a href="courses.do">강의찾기</a></li>
								<li><a href="#" onClick="lessoncreate();">강사등록</a></li>
								<li class="has-dropdown">
									<a href="#">게시판</a>
									<ul class="dropdown">
										<li><a href="noticeList.do">공지사항</a></li>
										<li><a href="eventList.do">이벤트</a></li>
										<li><a href="reviewList.do">수업후기</a></li>
										<li><a href="lessonlist.do">강의찾기</a></li>
									</ul>
								</li>
								<li><a href="contact.html">문의사항</a></li>
								
								<% if(info != null){ %>
									<li class="btn-cta"><a href="loginform.do"><span>내정보</span></a></li>
									<li class="btn-cta"><a href="logoutproc.do"><span>로그아웃</span></a></li>
								<%} else {%>
									<li class="btn-cta"><a href="loginform.do"><span>로그인</span></a></li>
									<li class="btn-cta"><a href="signin.do"><span>회원가입</span></a></li>
								<%} %>
								
								<!--
								<li class="btn-cta"><a href="loginform.do"><span>로그인</span></a></li>
								<li class="btn-cta"><a href="signin.do"><span>회원가입</span></a></li>
								-->
							</ul>
						</div>
					</div>
				</div>
			</div>
		</nav>
	
		<aside id="fh5co-hero">
			<div class="flexslider">
				<ul class="slides">
			   	<li style="background-image: url(images/guitar1.jpg);">
			   		<div class="overlay-gradient"></div>
			   		<div class="container">
			   			<div class="row">
				   			<div class="col-md-8 col-md-offset-2 text-center slider-text">
				   				<div class="slider-text-inner">
				   					<h1>당신에게 꼭 맞는 강의를 찾아보세요!</h1>
										<h2>실력있는 다양한 강사진들이 여러분들을 기다리고 있습니다</h2>
										<p><a class="btn btn-primary btn-lg" href="courses.do">맞춤형 강의찾기</a></p>
				   				</div>
				   			</div>
				   		</div>
			   		</div>
			   	</li>
			   	<li style="background-image: url(images/piano1.jpg);">
			   		<div class="overlay-gradient"></div>
			   		<div class="container">
			   			<div class="row">
				   			<div class="col-md-8 col-md-offset-2 text-center slider-text">
				   				<div class="slider-text-inner">
				   					<h1>빌리지심포니는 최고의 강사진 여러분들을 언제나 기다리고 있습니다.</h1>
										<h2>빨리 강사등록ㄱㄱ</h2>
										<p><a class="btn btn-primary btn-lg btn-learn" href="lessoncreate.do">강사등록하기</a></p>
				   				</div>
				   			</div>
				   		</div>
			   		</div>
			   	</li>
			   	<li style="background-image: url(images/vioin1.jpg);">
			   		<div class="overlay-gradient"></div>
			   		<div class="container">
			   			<div class="row">
				   			<div class="col-md-8 col-md-offset-2 text-center slider-text">
				   				<div class="slider-text-inner">
				   					<h1>이달의 베스트 학생 후기를 만나보세요</h1>
										<h2>June, 2022 Best Villager <a href="http://freehtml5.co/" target="_blank">click here</a></h2>
										<p><a class="btn btn-primary btn-lg btn-learn" href="reviewList.do">다양한 후기영상 보러가기</a></p>
				   				</div>
				   			</div>
				   		</div>
			   		</div>
			   	</li>		   	
			  	</ul>
		  	</div>
		</aside>

		<div id="fh5co-course-categories">
			<div class="container">
				<div class="row animate-box">
					<div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
						<h2>강의 카테고리</h2>
						<p>다양한 악기, 실력있는 강사진이 여러분들을 기다리고 있습니다</p>
					</div>
				</div>
				<div class="row">
					<div class="col-md-3 col-sm-6 text-center animate-box">
						<div class="services">
							<span class="icon">
								<i class="icon-shop"></i>
							</span>
							<div class="desc">
								<h3><a href="#">Classic Piano</a></h3>
								<p>20세기 전반까지의 음악들을 보통 클래식 음악으로 분류한다. 화성학과 관현악 형태의 클래식 음악들이 많다.</p>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 text-center animate-box">
						<div class="services">
							<span class="icon">
								<i class="icon-heart4"></i>
							</span>
							<div class="desc">
								<h3><a href="#">Jazz Piano</a></h3>
								<p>아프리카계 미국인 문화에서 탄생해 20세기 초반에서 중반까지 전세계적으로 크게 유행한 음악 장르이다.</p>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 text-center animate-box">
						<div class="services">
							<span class="icon">
								<i class="icon-banknote"></i>
							</span>
							<div class="desc">
								<h3><a href="#">POP & New age Piano</a></h3>
								<p>뉴에이지 운동을 음악적 표현으로 재해석한 음악 장르이다.</p>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 text-center animate-box">
						<div class="services">
							<span class="icon">
								<i class="icon-lab2"></i>
							</span>
							<div class="desc">
								<h3><a href="#">Violin</a></h3>
								<p>유럽의 대표적인 찰현악기. 빠른 속주부터 서정적 멜로디까지 다양한 연주가 가능하다.</p>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 text-center animate-box">
						<div class="services">
							<span class="icon">
								<i class="icon-photo"></i>
							</span>
							<div class="desc">
								<h3><a href="#">Acoustic Guitar</a></h3>
								<p>속칭 "통기타". 픽업을 쓰지 않고 울림통을 이용해서 소리를 증폭시키는 기타. 일반적으로 어쿠스틱 기타라고만 말할 경우, 어쿠스틱 포크 기타를 의미한다.</p>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 text-center animate-box">
						<div class="services">
							<span class="icon">
								<i class="icon-home-outline"></i>
							</span>
							<div class="desc">
								<h3><a href="#">Electric Guitar</a></h3>
								<p>현의 울림을 자석과 코일로 구성된 마그네틱 픽업을 이용해 전기신호로 변환시켜 앰프로 증폭/출력하는 기타. 줄을 손이나 피크등으로 튕겨서 소리를 내는 발현악기다.</p>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 text-center animate-box">
						<div class="services">
							<span class="icon">
								<i class="icon-bubble3"></i>
							</span>
							<div class="desc">
								<h3><a href="#">Bass Guitar</a></h3>
								<p>원류는 재즈 밴드에서 쓰이던 콘트라베이스를 소형화하고 저렴하게 사용하기 위해 개발된 악기다. 일렉트릭 기타와 비슷한 몸체를 지닌 4현의 전기악기 형태로 만들었다.</p>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 text-center animate-box">
						<div class="services">
							<span class="icon">
								<i class="icon-world"></i>
							</span>
							<div class="desc">
								<h3><a href="#">And More...</a></h3>
								<p>더 많은 악기와 수업을 만들기 위해 Village Symphony가 노력중입니다. 기대해주세요 !</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div id="fh5co-course">
			<div class="container">
				<div class="row animate-box">
					<div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
						<h2>Our Course</h2>
						<p></p>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6 animate-box">
						<div class="course">
							<a href="#" class="course-img" style="background-image: url(images/project-1.jpg);">
							</a>
							<div class="desc">
								<h3><a href="#">즐거운 클래식 피아노</a></h3>
								<p>클래식 피아노를 즐겁고 쉽게 배울 수 있습니다. 어렵게만 느껴졌던 클래식이라는 장르를 즐겁고 쉽게 가르쳐드립니다.</p>
								<span><a href="#" class="btn btn-primary btn-sm btn-course">Take A Course</a></span>
							</div>
						</div>
					</div>
					<div class="col-md-6 animate-box">
						<div class="course">
							<a href="#" class="course-img" style="background-image: url(images/project-2.jpg);">
							</a>
							<div class="desc">
								<h3><a href="#">재즈피아노 배우기</a></h3>
								<p>초보도 쉽게 배우는 재즈피아노 초보도 쉽게 배우는 재즈피아노입니다. 누구나 나이에 상관없이 즐겁게 참여해 보세요! 온라인으로 수업 진행합니다.</p>
								<span><a href="#" class="btn btn-primary btn-sm btn-course">Take A Course</a></span>
							</div>
						</div>
					</div>
					<div class="col-md-6 animate-box">
						<div class="course">
							<a href="#" class="course-img" style="background-image: url(images/project-3.jpg);">
							</a>
							<div class="desc">
								<h3><a href="#">둥둥둥~ 베이스기타</a></h3>
								<p>가슴을 떨리게 만드는 베이스. 직접 배워보시겠어요? 학원에서는 큰 스피커로, 집에서 연습할 때는 헤드폰으로! 베이스 정말 멋진 악기입니다.</p>
								<span><a href="#" class="btn btn-primary btn-sm btn-course">Take A Course</a></span>
							</div>
						</div>
					</div>
					<div class="col-md-6 animate-box">
						<div class="course">
							<a href="#" class="course-img" style="background-image: url(images/project-4.jpg);">
							</a>
							<div class="desc">
								<h3><a href="#">초보자도 배우기 쉬운 바이올린</a></h3>
								<p>어렵게 생각한 현악기라도 쉽게 배울 수 있는 바이올린 수업입니다. 수준, 나이에 상관없이 눈높이에 맞춰 수업을 진행해 드립니다.문의해주세요!</p>
								<span><a href="#" class="btn btn-primary btn-sm btn-course">Take A Course</a></span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<footer id="fh5co-footer" role="contentinfo" style="background-image: url(images/img_bg_4.jpg);">
			<div class="overlay"></div>
			<div class="container">
				<div class="row row-pb-md">
					<div class="col-md-3 fh5co-widget">
						<h3>About Education</h3>
						<p>Facilis ipsum reprehenderit nemo molestias. Aut cum mollitia reprehenderit. Eos cumque dicta adipisci architecto culpa amet.</p>
					</div>
					<div class="col-md-2 col-sm-4 col-xs-6 col-md-push-1 fh5co-widget">
						<h3>Learning</h3>
						<ul class="fh5co-footer-links">
							<li><a href="courses.do">강의찾기</a></li>
							<li><a href="#" onClick="lessoncreate();">강사등록</a></li>
						</ul>
					</div>
	
					<div class="col-md-2 col-sm-4 col-xs-6 col-md-push-1 fh5co-widget">
						<h3>board</h3>
						<ul class="fh5co-footer-links">
							<li><a href="#">소개</a></li>
							<li><a href="noticeList.do">공지사항</a></li>
							<li><a href="eventList.do">이벤트</a></li>
							<li><a href="reviewList.do">수업후기</a></li>
						</ul>
					</div>
	
					<div class="col-md-2 col-sm-4 col-xs-6 col-md-push-1 fh5co-widget">
						<h3>Contact us</h3>
						<ul class="fh5co-footer-links">
							<li><a href="contact.html">문의사항</a></li>
						</ul>
					</div>
				</div>
				<div class="row copyright">
					<div class="col-md-12 text-center">
						<p>
							<small class="block">&copy; 2022 4조 졸업프로젝트. All Rights Reserved.</small> 
						</p>
					</div>
				</div>
			</div>
		</footer>
	</div>

	<div class="gototop js-top">
		<a href="#" class="js-gotop"><i class="icon-arrow-up"></i></a>
	</div>
	
	<!-- jQuery -->
	<script src="js/jquery.min.js"></script>
	<!-- jQuery Easing -->
	<script src="js/jquery.easing.1.3.js"></script>
	<!-- Bootstrap -->
	<script src="js/bootstrap.min.js"></script>
	<!-- Waypoints -->
	<script src="js/jquery.waypoints.min.js"></script>
	<!-- Stellar Parallax -->
	<script src="js/jquery.stellar.min.js"></script>
	<!-- Carousel -->
	<script src="js/owl.carousel.min.js"></script>
	<!-- Flexslider -->
	<script src="js/jquery.flexslider-min.js"></script>
	<!-- countTo -->
	<script src="js/jquery.countTo.js"></script>
	<!-- Main -->
	<script src="js/main.js"></script>
	
	</body>
</html>