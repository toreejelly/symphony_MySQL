<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!DOCTYPE html>
<html>
<head>

	<link rel="stylesheet" href="../css/course.css">
	
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

</head>

<script>

	$(document).ready(function(){
		
		$("#ques2").hide();//숨김
		$("#ques3").hide();//숨김
		$("#ques4").hide();//숨김
		
	});
	
	function q1() {//첫번째 질문에서 다음을 클릭했을 때 실행
		
		const q01ans = $('input[name="q01ans"]:checked').val();//첫번째 질문에 값 체크 되어있는 것을 가지고 옴
		
		if(q01ans != null && q01ans != ""){//질문에 값이 없을 있을 경우만 실행
			$("#ques1").hide();
			$("#ques2").show();//사라진 부분 다시 보여주는 함수
			$("#ques3").hide();
			$("#ques4").hide();
		}else{//없을 경우 알림창
			alert("선택 해주세요.");
		}
	}//
	
	function q2() {//두번째 질문에서 다음을 클릭했을 때 실행
		
		const q02ans = $('input[name="q02ans"]:checked').val();
		
		if(q02ans != null && q02ans != ""){
			$("#ques1").hide();
			$("#ques2").hide();
			$("#ques3").show();
			$("#ques4").hide();
		}else{
			alert("선택 해주세요.");
		}

	}//
	
	function q3() {//세번째 질문에서 다음을 클릭했을 때 실행
		
		const q03ans = $('input[name="q03ans"]:checked').val();
		
		if(q03ans != null && q03ans != ""){
			$("#ques1").hide();
			$("#ques2").hide();
			$("#ques3").hide();
			$("#ques4").show();
		}else{
			alert("선택 해주세요.");
		}
	}//
	
	function q4() {//네번째 질문에서 다음을 클릭했을 때 실행
		
		const q04ans = $('input[name="q04ans"]:checked').val();
		
		if(q04ans != null && q04ans != ""){
			if(confirm("제출하시겠습니까?")){
				$("#submitAns").submit();//form 에 걸어둔 id로 action에 있는 주소로 submit 한다.
			};
		}else{
			alert("선택 해주세요.");
		}
	}//
	
	
	function qr2(ret) {

		if (ret == "r2"){
			$("#ques1").show();
			$("#ques2").hide();
			$("#ques3").hide();
			$("#ques4").hide();
		}else if(ret == "r3"){
			$("#ques1").hide();
			$("#ques2").show();
			$("#ques3").hide();
			$("#ques4").hide();
		}else if(ret == "r4"){
			$("#ques1").hide();
			$("#ques2").hide();
			$("#ques3").show();
			$("#ques4").hide();
		}//if end
		
	}//

</script>

<body>
	<div>
	    
	    <h1>빌리지 심포니에 오신 여러분 모두 환영합니다.</h1>
		
		<form id="submitAns"  method="post" action="result.do">
		
			<div class="ques"  id = "ques1">
		        <div class="quesDiv">
		            <label>
		                1. 어떤 악기를 수강하고 싶으신가요?
		            </label>
		 			
		 			<br/>
		 			
		 			<div>
		                <input type="radio" name="q01ans" value="classic_p">클래식 피아노
		                <br/>
		                <input type="radio" name="q01ans" value="jazz_p">재즈 피아노
		                <br/>
		                <input type="radio" name="q01ans" value="pop_p">팝/뉴에이지 피아노
		                <br/>
		                <input type="radio" name="q01ans" value="acou_g">통기타
		                <br/>
		                <input type="radio" name="q01ans" value="elec_g">일렉기타
		                <br/>
		                <input type="radio" name="q01ans" value="bass_g">베이스기타
		                <br/>
		                <input type="radio" name="q01ans" value="vio">바이올린
		            </div>
		            		
					<br/>
					
					<button type="button" style="color:#fff" onClick="q1();">다음</button>
					
				</div>
			</div>	
				
			<div class="ques"  id = "ques2">
				<div class="quesDiv">
		            <label>
		                2. 선호하는 강사의 성별은?
		            </label>
		 			
		 			<br/>
		 			
		 			<div>
		                <input type="radio" name="q02ans" value="M">남성
		                <br/>
		                <input type="radio" name="q02ans" value="F">여성
		                <br/>
		                <input type="radio" name="q02ans" value="E">상관없음
		            </div>
		            		
					<br/>
					
					<button type="button" style="color:#fff" onClick="qr2('r2');">이전</button>
					<button type="button" style="color:#fff" onClick="q2();">다음</button>
				
				</div>
			</div>
			
			<div class="ques"  id = "ques3">
				<div class="quesDiv">
		            <label>
		                3. 수업을 어떤 형태로 진행하고 싶은신가요?
		            </label>
		 			
		 			<br/>
		 			
		 			<div>
		                <input type="radio" name="q03ans" value="ttos">선생님이 학생에게 방문
		                <br/>
		                <input type="radio" name="q03ans" value="stot">학생이 선생님에게 방문
		                <br/>
		                <input type="radio" name="q03ans" value="online">실시간 온라인 화상수업
		            </div>
		            		
					<br/>
					
					<button type="button" style="color:#fff" onClick="qr2('r3');">이전</button>
					<button type="button" style="color:#fff" onClick="q3();">다음</button>
				
				</div>
			</div>
			
			<div class="ques"  id = "ques4">
				<div class="quesDiv">
		            <label>
		                4. 어느 지역에서 수강하시길 원하시나요?
		            </label>
		 			
		 			<br/>
		 			
		 			<div>
		                <input type="radio" name="q04ans" value="seoul">서울특별시
		                <br/>
		                <input type="radio" name="q04ans" value="gg">경기도
		                <br/>
		                <input type="radio" name="q04ans" value="in">인천
		                <br/>
		                <input type="radio" name="q04ans" value="dontcare">온라인수업참여
		            </div>
		            		
					<br/>
					
					<button type="button" style="color:#fff" onClick="qr2('r4');">이전</button>
					<button type="button" style="color:#fff" onClick="q4();">제출</button>
				
				</div>
			</div>
		</form>
	</div><!-- course1 end -->

</body>
</html>

<%@ include file="../footer.jsp"%>