<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>

<link rel="stylesheet" href="../css/result.css">

<!-- 달력 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap-responsive.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.js"></script>

<script>
$(document).ready(function(){

	$('.datepicker').datepicker({
	    format: 'dd-mm-yyyy',
	    autoclose: true,
	    startDate: '0d'
	});
	
	$('.cell').click(function(){
	    $('.cell').removeClass('select');
	    $(this).addClass('select');
	});

});
</script>

<body>
<div class="page-wrapper bg-gra-02 p-t-130 font-poppins">
	<div class="wrapper wrapper--w1200">
		<div class="card card-4">
			<div class="card-body">
				<h2 class="title">${detail.c_title}</h2>
					<form name="frm" method="GET" action="resultDetail.do">
 
						<!-- 분할 -->
						<div class="flex-container">
						
							<!-- 왼쪽 페이지 시작-->
							<div class="flex-item-left">
								<div class="col-2">
						    		<div class="input-group">
						        		<label class="label">프로필 사진</label> 
						        		<img src="../storage/${detail.prof_photo}" width="500"><br>   
						    		</div>
								</div>
						
								<div class="col-2">
						    		<div class="input-group">
						        		<label class="label">강의설명</label>
						        		<div class="input--style-4">${detail.c_content}</div>
						    		</div>
								</div>
								
								<br>
								
								<div class="col-2">
						    		<div class="input-group">
						        		<label class="label">강의 하는 악기</label>
						        		<div class="input--style-4">${detail.q01ans}</div>
						    		</div>
						 		</div> 
						 		  
						    	<br>
						    	                                                    
								<div class="col-2">
						    		<div class="input-group">
						        		<label class="label">강의 방식</label>
						        		<div class="input--style-4">${detail.q03ans}</div>
						   	 		</div>
								</div>
								<br>
								<div class="col-2">
						    		<div class="input-group">
						        		<label class="label">강의 가능 지역</label>
						        		<div class="input--style-4">${detail.q04ans}</div>
						       		</div>
						   		</div>           
								<br>
								<div class="col-2">
						       		<div class="input-group">
						           		<label class="label">강의 기간</label>
						           		<div class="input--style-4"></div>
									</div>
								</div>
								<br>
								<div class="col-2">
									<div class="input-group">
										<label class="label">강의 가능 요일</label>
										<div class="input--style-4">${detail.c_date}</div>
									</div>
								</div>
								<br>
								<div class="col-2">
									<div class="input-group">
										<label class="label">강의 가능 시간</label>
										<div class="input--style-4">${detail.c_time}</div>
									</div>
								</div>                           
								<br>
								<div class="col-2">
									<div class="input-group">
										<label class="label">시간당 수강료</label>
										<div class="input--style-4">${detail.price} 원</div>
									</div>
								</div>
							</div><!-- flex-item-left end -->
							<!-- 왼쪽 끝 -->
						
							<!-- 오른쪽 시작 -->  
							<div class="flex-item-right">
						
						
							</div><!-- flex-item-right -->
							<!-- 오른쪽 끝 --> 
						
						</div><!-- flex-container end -->
						<!-- 분할 끝 -->                        
						
						<div class="p-t-15">
							<button type="button" class="btn btn--radius-2 btn--blue" onclick="location.href='lessonlist.do'">목록</button>                          
							<button type="button" class="btn btn--radius-2 btn--blue" onclick="cart();">장바구니</button>
						</div>
    
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div class="p-b-100 font-poppins"></div>
	
<div class="container-fluid px-0 px-sm-4 mx-auto">
  <div class="row justify-content-center mx-0">
    <div class="col-lg-10">
      <div class="card border-0">
        <form autocomplete="off">
          <div class="card-header bg-dark">
            <div class="mx-0 mb-0 row justify-content-sm-center justify-content-start px-1">
              <input type="text" id="dp1" class="datepicker" placeholder="Pick Date" name="date" readonly><span class="fa fa-calendar"></span>
            </div>
          </div>
          <div class="card-body p-3 p-sm-5">
            <div class="row text-center mx-0">
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">9:00AM</div></div>
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">9:30AM</div></div>
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">9:45AM</div></div>
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">10:00AM</div></div>
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">10:30AM</div></div>
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">10:45AM</div></div>
            </div>
            <div class="row text-center mx-0">
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">11:00AM</div></div>
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">11:30AM</div></div>
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">11:45AM</div></div>
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">12:00PM</div></div>
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">12:30PM</div></div>
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">12:45PM</div></div>
            </div>
            <div class="row text-center mx-0">
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">1:00PM</div></div>
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">1:30PM</div></div>
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">1:45PM</div></div>
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">2:00PM</div></div>
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">2:30PM</div></div>
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">2:45PM</div></div>
            </div>
            <div class="row text-center mx-0">
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">3:00PM</div></div>
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">3:30PM</div></div>
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">4:15PM</div></div>
              <div class="col-md-2 col-4 my-1 px-2"><div class="cell py-1">5:00PM</div></div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
</body>


	<script>
		function deleteLesson() {
			if (confirm("삭제하시겠습니까?")) {
				location.href = 'lessondelete.do?c_id=${r_detail.c_id}';
			};//if end
		}//deleteLesson() end


		function cart() {
			if (confirm("장바구니에 추가 하시겠습니까?")) {
				location.href = 'cart.do?c_id=${r_detail.c_id}';	
			};//if end
		}//cart() end
	</script>
	
</html>

<%@ include file="../footer.jsp"%>