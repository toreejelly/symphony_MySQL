<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="auth.jsp" %>
<%@ include file="../header.jsp"%>
 

	<link rel="stylesheet" type="text/css" href="../css/login2.css">
	<link rel="stylesheet" type="text/css" href="../css/login1.css">
	<link rel="stylesheet" type="text/css" href="../js/myscript.js">
	<link rel="stylesheet" type="text/css" href="../css/profile.css">
	
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js" rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js" rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/3.6.95/css/materialdesignicons.css" rel="stylesheet">
<!--===============================================================================================-->

	
	<div class="limiter">

<%
	if(s_id.equals("guest") || s_passwd.equals("guest") || s_ulevel.equals("guest")) {

	// 아이디 저장 쿠키 확인
	Cookie[] cookies=request.getCookies(); // 사용자PC에 저장된 모든 쿠키값 가져오기
	String c_id="";
	if(cookies!=null) { // 쿠키가 존재하는가
		for(int i=0; i<cookies.length; i++) { // 모든 쿠키값을 검색함
			Cookie cookie=cookies[i]; // 쿠키 하나씩 가져오기
			if(cookie.getName().equals("c_id")==true) {
				c_id=cookie.getValue(); // 쿠키변수값 가져오기
			}
		}
	}

%>

	<div class="container-login100">
			<div class="wrap-login100">
				<form class="login100-form validate-form p-l-55 p-r-55 p-t-178" name="loginfrm" id="loginfrm" method="post" action="login.do" onsubmit="return loginCheck()">
					<span class="login100-form-title">
						로그인
					</span>

					<div class="wrap-input100 validate-input m-b-16" data-validate="아이디를 입력해주세요">
						<input class="input100" type="text" name="id" id="id" value="<%=c_id%>" placeholder="아이디">
						<span class="focus-input100"></span>
					</div>
					

					<div class="wrap-input100 validate-input" data-validate = "비밀번호를 입력해주세요">
						<input class="input100" type="password" name="passwd" id="passwd" placeholder="비밀번호">
						<span class="focus-input100"></span>
					</div>

					<div class="text-right p-t-13 p-b-26">
						<label><input type="checkbox" name="c_id" value="SAVE" <%if(!c_id.isEmpty()) {out.print("checked");} %>>아이디 저장</label>	
						<a href="findid.do" class="txt2">
							아이디/비밀번호찾기
						</a>	
					</div>


					<div class="container-login100-form-btn">
						<button class="login100-form-btn" type="submit">
							로그인하기
						</button>
					</div>

					<div class="flex-col-c p-t-170 p-b-40">
						<span class="txt1 p-b-9">
							아직 계정이 없으신가요?
						</span>

						<a href="signin.do" class="txt3">
							회원가입하기
						</a>
					</div>
				</form>
			</div>
		</div>

<%
	} else {


		out.println("<div class=\"container-login100\">");
		out.println("<div class=\"wrap-login100\">");
		out.println("<strong>" + s_id + "</strong> 님");
		out.println("<a href='logoutproc.do'>[로그아웃]</a>");
		out.println("<br><br>");
		out.println("<a href='modify.do'>[회원정보수정]</a>");
		out.println("&nbsp;&nbsp;");
		out.println("<a href='memberdelete.do'>[회원탈퇴]</a>");
		out.println("</div>");
		out.println("</div>");

		
		
/*
out.println("<div class=\"page-content page-container\" id=\"page-content\">");
out.println("<div class=\"padding\">");
out.println("<div class=\"row container d-flex justify-content-center\">");
out.println("<div class=\"col-xl-6 col-md-12\">");
out.println("<div class=\"card user-card-full\">");
out.println("<div class=\"row m-l-0 m-r-0\">");
out.println("<div class=\"col-sm-4 bg-c-lite-green user-profile\">");
out.println("<div class=\"card-block text-center text-white\">");
out.println("<div class=\"m-b-25\">");
out.println("<img src=\"https://img.icons8.com/bubbles/100/000000/user.png\" class=\"img-radius\" alt=\"User-Profile-Image\">");
out.println("</div>");
out.println("<h1 class=\"f-w-600\">" + s_id + "</h1>");
out.println("<p>Welcome</p>");
out.println("</div>");
out.println("</div>");
out.println("<div class=\"col-sm-8\">");
out.println("<div class=\"card-block\">");
out.println("<h4 class=\"m-b-20 p-b-5 b-b-default f-w-600\">Information</h4>");
out.println("<div class=\"row\">");
out.println("<div class=\"col-sm-6\">");
out.println("<p class=\"m-b-10 f-w-600\">Email</p>");
out.println("<h6 class=\"text-muted f-w-400\">asd</h6>");
out.println("</div>");
out.println("<div class=\"col-sm-6\">");
out.println("<p class=\"m-b-10 f-w-600\">Phone</p>");
out.println("<h6 class=\"text-muted f-w-400\">98979989898</h6>");
out.println("</div>");
out.println("</div>");
out.println("<h6 class=\"m-b-20 m-t-40 p-b-5 b-b-default f-w-600\">Projects</h6>");
out.println("<div class=\"row\">");
out.println("<div class=\"col-sm-6\">");
out.println("<p class=\"m-b-10 f-w-600\">Recent</p>");
out.println("<h6 class=\"text-muted f-w-400\">Sam Disuja</h6>");
out.println("</div>");
out.println("<div class=\"col-sm-6\">");
out.println("<p class=\"m-b-10 f-w-600\">Most Viewed</p>");
out.println("<h6 class=\"text-muted f-w-400\">Dinoter husainm</h6>");
out.println("</div>");
out.println("</div>");
out.println("<ul class=\"social-link list-unstyled m-t-40 m-b-10\">");
out.println("<li><a href=\"#\" data-toggle=\"tooltip\" data-placement=\"bottom\" data-original-title=\"facebook\" data-abc=\"true\"><i class=\"mdi mdi-facebook feather icon-facebook facebook\" aria-hidden=\"true\"></i></a></li>");
out.println("<li><a href=\"#\" data-toggle=\"tooltip\" data-placement=\"bottom\"  data-original-title=\"twitter\" data-abc=\"true\"><i class=\"mdi mdi-twitter feather icon-twitter twitter\" aria-hidden=\"true\"></i></a></li>");
out.println("<li><a href=\"#\" data-toggle=\"tooltip\" data-placement=\"bottom\" data-original-title=\"instagram\" data-abc=\"true\"><i class=\"mdi mdi-instagram feather icon-instagram instagram\" aria-hidden=\"true\"></i></a></li>");
out.println("</ul>");
out.println("</div>");
out.println("</div>");
out.println("</div>");
out.println("</div>");
out.println("</div>");
out.println("</div>");
out.println("</div>");
out.println("</div>");
*/

	}
%>

</div>
	
	


	
	
<!--===============================================================================================-->
	<script src="../loginvendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="../loginvendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="../loginvendor/bootstrap/js/popper.js"></script>
	<script src="../loginvendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="../loginvendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="../loginvendor/daterangepicker/moment.min.js"></script>
	<script src="../loginvendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="../loginvendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="../js/login.js"></script>

	

<%@ include file="../footer.jsp"%>