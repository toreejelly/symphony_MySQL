<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
										<li><a href="lessonlist.do">강의목록</a></li>
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
							</ul>
						</div>
					</div>
				</div>
			</div>
		</nav>