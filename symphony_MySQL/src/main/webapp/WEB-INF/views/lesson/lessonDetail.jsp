<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../header.jsp"%>

<!-- Icons font CSS-->
    <link href="../vendor/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
    <link href="../vendor/font-awesome-4.7/css/font-awesome.min.css" rel="stylesheet" media="all">
    <!-- Font special for pages-->
    <link href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Vendor CSS-->
    <link href="../vendor/select2/select2.min.css" rel="stylesheet" media="all">
    <link href="../vendor/datepicker/daterangepicker.css" rel="stylesheet" media="all">

    <!-- Main CSS-->
    <link href="../css/classreg.css" rel="stylesheet" media="all">

    <div class="page-wrapper bg-gra-02 p-t-130 font-poppins">
        <div class="wrapper wrapper--w1200">
            <div class="card card-4">
                <div class="card-body">
                    <h2 class="title">강사등록</h2>
                    <form name="frm" method="GET" action="lessoncreate.do">
 
 <!--------- --------------------------------질문지 시작------------------------------------------------ -->

                            <div class="col-2">
                                <div class="input-group">
                                    <label class="label">강의 제목</label>
                                    <div class="input--style-4">
                                    	${r_detail.c_title}
                                    </div>
                                </div>
                            </div>
                            <div class="col-2">
                                <div class="input-group">
                                    <label class="label">프로필 사진</label>
                                    
                                    <img src="../storage/${r_detail.prof_photo}" width="500"><br>
                                    
                                </div>
                            </div>
                      
                            <div class="col-2">
                                <div class="input-group">
                                    <label class="label">강의설명</label>
                                    <div class="input--style-4">
                                    	${r_detail.c_content}
                                    </div>
                                </div>
                            </div>
                            <br>
                            <div class="col-2">
                                <div class="input-group">
                                    <label class="label">강의 하는 악기</label>
                                    <div class="input--style-4">
                                        ${r_detail.q01ans}
                                    </div>
                                </div>
                             </div>   
                                <br>
                                <br>
                                <br>
                          
                            <div class="col-2">
                                <div class="input-group">
                                    <label class="label">강의 방식</label>
                                    <div class="p-t-10">
                                    	${r_detail.q03ans}
                                    </div>
                                </div>
                            </div>
                            <br>
                            <div class="col-2">
                                <div class="input-group">
                                    <label class="label">강의 가능 지역</label>
                                    <div class="p-t-10">
                                        ${r_detail.q04ans}
                                    </div>
                                </div>
                            </div>
                        
                        
                        <br>
                       
                            <div class="col-2">
                                <div class="input-group">
                                    <label class="label">강의 가능 시간</label>
                                    <div class="p-t-10">
                                        ${r_detail.c_time}
                                    </div>
                                </div>
                            </div>
                            <br>
                            <div class="col-2">
                                <div class="input-group">
                                    <label class="label">강의 가능 요일</label>
                                    <div class="p-t-10">
                                        ${r_detail.c_date}
                                    </div>
                                </div>
                            </div>
                            <br>
                            
                            <!-- 
                            <div class="col-2">
                                <div class="input-group">
                                    <label class="label">수업 시작일을 선택해주세요</label>
                                    <div class="input-group-icon">
                                        <input class="input--style-4 js-datepicker" type="text" name="startday">
                                        <i class="zmdi zmdi-calendar-note input-icon js-btn-calendar"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-2">
                                <div class="input-group">
                                    <label class="label">수업 종료일을 선택해주세요</label>
                                    <div class="input-group-icon">
                                        <input class="input--style-4 js-datepicker" type="text" name="lastday">
                                        <i class="zmdi zmdi-calendar-note input-icon js-btn-calendar" ></i>
                                    </div>
                                </div>
                            </div>
                            -->
                       
         
                        <div class="col-2">
                            <div class="input-group">
                                <label class="label">시간당 수강료</label>
                                <div class="p-t-10">
                                    ${r_detail.price} 원
                             	</div>
                            </div>
                        </div>
                        
                        
                        <div class="p-t-15">
                        	<button type="button" class="btn btn--radius-2 btn--blue" onclick="location.href='lessonlist.do'">목록</button>
                            <button type="button" class="btn btn--radius-2 btn--blue" onclick="location.href='lessonupdateform.do?c_id=${r_detail.c_id}'">수정</button>
                            <button type="button" class="btn btn--radius-2 btn--blue" onclick="deleteLesson();">삭제</button>
                            <button type="button" class="btn btn--radius-2 btn--blue" onclick="cart();">장바구니</button>
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

	<script>
		function deleteLesson() {
			if (confirm("삭제하시겠습니까?")) {
	
				location.href = 'lessondelete.do?c_id=${r_detail.c_id}';
	
			};//if end
		}//deleteNotice() end
		
		
		function cart() {
			if (confirm("장바구니에 추가 하시겠습니까?")) {

				location.href = 'cart.do?c_id=${r_detail.c_id}';

			}
			;//if end
		}//deleteNotice() end
	</script>

<%@ include file="../footer.jsp"%>