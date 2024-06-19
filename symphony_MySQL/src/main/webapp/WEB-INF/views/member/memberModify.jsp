<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../header.jsp"%>

<!-- 본문 시작 memberModify.jsp-->

<!-- myscript.js -->

    <!-- Icons font CSS-->
    <link href="../vendor/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
    <link href="../vendor/font-awesome-4.7/css/font-awesome.min.css" rel="stylesheet" media="all">
    <!-- Font special for pages-->
    <link href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Vendor CSS-->
    <link href="../vendor/select2/select2.min.css" rel="stylesheet" media="all">
    <link href="../vendor/datepicker/daterangepicker.css" rel="stylesheet" media="all">

    <!-- Main CSS-->
    <link href="../css/signin.css" rel="stylesheet" media="all">


<div class="page-wrapper bg-gra-02 p-t-130 font-poppins">
        <div class="wrapper wrapper--w680">
            <div class="card card-4">
                <div class="card-body">
                    <h2 class="title">회원정보수정</h2>
                    <h4 class="undertitle">빌리지 심포니에 오신 여러분들을 환영합니다</h4>
                    
                    
                    
                    
                    <form method="POST" action="modifyproc.do" onsubmit="return memberCheck()" name="memfrm" id="memfrm">
                    <br>
                    <br>
                        <div class="row row-space">
                            <div class="col-2">
                                <div class="input-group">
                                <div class="id">
                                    <label class="label">아이디</label>
                                    <input class="input--style-4" type="text" id="id" name="id"size="40" value="<%=(String)session.getAttribute("s_id") %>" readonly><br>

                                </div>
                                </div>
                            </div>
                         </div>
                         <div class="row row-space">
                            <div class="col-2">
                                <div class="input-group">
                                    <label class="label">비밀번호</label>
                                    <input class="input--style-4" type="password" name="passwd" id="passwd" size="40" value="<%=(String)session.getAttribute("s_passwd") %>" required>
                                </div>
                            </div>
                            <div class="col-2">
                                <div class="input-group">
                                    <label class="label">비밀번호확인</label>
                                    <input class="input--style-4" type="password" name="repasswd" id="repasswd" size="40" value="<%=(String)session.getAttribute("s_passwd") %>" required>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row row-space">
                            <div class="col-2">
                                <div class="input-group">
                                    <label class="label">이름</label>
                                    <input class="input--style-4" type="text" name="uname" size="40" id="uname" required>
                                </div>
                            </div>
                            <div class="col-2">
                                <div class="input-group">
                                    <label class="label">핸드폰번호</label>
                                    <input class="input--style-4" type="text" name="tel"size="40" id="tel" required>
                                    
                                    
                                </div>
                            </div>
                            
                        </div>
                        <div class="row row-space">
                        <div class="col-2">
                                <div class="input-group">
                                    <label class="label">주소찾기</label>
                                    <input class="input--style-4" type="text" id="sample4_postcode" placeholder="우편번호" name="zipcode" id="zipcode" required>
                                    <input class="input--style-5" type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
                                    <input class="input--style-4" type="text" id="sample4_roadAddress" placeholder="도로명주소" size="40" name="address1" id="address1" required><br>
                                    <input type="hidden" id="sample4_jibunAddress" placeholder="지번주소"  size="40">
                                    <span id="guide" style="color:#999;display:none"></span>
                                    <input class="input--style-4" type="text" id="sample4_detailAddress" placeholder="상세주소"  size="40" name="address2" id="address2" required><br>
                                    <input type="hidden" id="sample4_extraAddress" placeholder="참고항목"  size="40">
                                    <input type="hidden" id="sample4_engAddress" placeholder="영문주소"  size="40" ><br>
                                    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
         
                document.getElementById("sample4_engAddress").value = data.addressEnglish;
                       
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>

                                    
                                </div> 
                        </div>

                            <div class="col-2">
                                <div class="input-group">
                                <div class="id">
                                    <label class="label">Email</label>
                                    <input class="input--style-4" type="email" name="email" size="40" id="email"><br>
                                    <input class="input--style-5" type="button" onclick="emailCheck()" value="중복확인">
                                </div>
                                </div>
                            </div>
                        </div>
                        
                            
                        
                      
                      
                        <br>
                        <br>
                        <div class="p-t-15">
                            <button class="btn btn--radius-2 btn--blue" type="submit">제출하기</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
<div class="p-b-100 font-poppins">
</div>

    <!-- Jquery JS-->
    <script src="../vendor/jquery/jquery.min.js"></script>
    
    <!-- Vendor JS-->
    <script src="../vendor/select2/select2.min.js"></script>
    <script src="../vendor/datepicker/moment.min.js"></script>
    <script src="../vendor/datepicker/daterangepicker.js"></script>

    <!-- Main JS-->
    <script src="../js/signin.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    
    <script>
function check(){
	id = $("#user_id").val();
	
	$.ajax({
	    url: 'ID_Check',
	    type: 'POST',
	    dataType: 'text', //서버로부터 내가 받는 데이터의 타입
	    contentType : 'text/plain; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
	    data: id ,

	    success: function(data){
	         if(data == 0){
	         console.log("아이디 없음");
	         alert("사용하실 수 있는 아이디입니다.");
	         }else{
	         	console.log("아이디 있음");
	         	alert("중복된 아이디가 존재합니다.");
	         }
	    },
	    error: function (){        
	                      
	    }
	  });


}
</script>

<!-- 본문 끝 -->           
<%@ include file="../footer.jsp"%>