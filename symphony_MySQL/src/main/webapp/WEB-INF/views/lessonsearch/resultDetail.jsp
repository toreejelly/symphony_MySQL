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
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.js"></script> -->

<!-- footer비교 -->
<!-- Bootstrap -->
<script src="../js/bootstrap.min.js"></script>

<!-- jQuery Easing -->
<!-- 	<script src="../js/jquery.easing.1.3.js"></script> -->

<!-- Waypoints -->
	<script src="../js/jquery.waypoints.min.js"></script>

<!-- Stellar Parallax -->
<!-- 	<script src="../js/jquery.stellar.min.js"></script>	 -->

<!-- Carousel -->
<!-- 	<script src="../js/owl.carousel.min.js"></script>	 -->

<!-- Flexslider -->
<!-- 	<script src="../js/jquery.flexslider-min.js"></script> -->

<!-- Main -->
	<script src="../js/main.js"></script>	
	
<!-- footer 끝 -->

<script>
$(document).ready(function(){
	
	//달력 생성
	$('.datepicker').datepicker({
		
	    format: 'yyyy-mm-dd',
	    autoclose: true,
	    startDate: '0d'
	    
	});
	
	//날짜 변경
	$(".datepicker").change(function(){
		
		$('#time').empty();//초기화
		
		//요일 확인
		let week = new Array('sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat');
		let today;
		let todayLabel;
		today = new Date($("input[name=date]").val()).getDay();//선택한 날짜를 가져옴. 숫자로 가져오게 된다.
		todayLabel = week[today];//선택한 날짜에 해당하는 요일 확인 week에 [위에 가져온 숫자]가 들어가서 배열 몇번째에 해당하는 요일이 나오는 것이다.
		
		const c_dates = "${detail.c_date}"; //전체 요일
		const c_date =  c_dates.split(','); //전체 요일을 ,로 나누어 배열로 담아놓은 상태
		let alertYn = "";//알림창을 띄워주는 여부
		
		for(var date of c_date){//배열만큼 반복문 실행
			if(todayLabel == date){//가능한 날짜인 경우
				alertYn = "Y";
			
				let data = {
						  c_id : "${detail.c_id}"			
						, date : $("input[name=date]").val() 
				};
				
				$.ajax({
			         type : "POST",
			         url : "/checkTime.do",
			         data : JSON.stringify(data),
			         contentType : "application/json",
			         cache : false,
			         success : function(result) {
			        	 
			     		const c_times = "${detail.c_time}"; //선택한 날짜에 가능한 전체 시간
			    		const c_time =  c_times.split(','); //위 전체 시간을 ,로 나눠 배열로 만듦

						for(var item of c_time){//전체 시간 표시
							if(item >= 12){
								$('#time').append('<div class="col-3 my-1 px-2"><div class="cell py-1" time="'+item+'">'+item+':00PM</div></div>');	
							}else{
								$('#time').append('<div class="col-3 my-1 px-2"><div class="cell py-1" time="'+item+'">'+item+':00AM</div></div>');	
							}
						}
						
						if(result){//이미 결제가 되어 있는 시간에 대해서는 클릭이 안되게 함
							for(var item of result){
								
								let itemTime = item.time;
								let divTime = $('div[time='+itemTime+']');
								
								divTime.css("pointer-events","none");//클릭 안됨
								divTime.css("text-decoration","line-through");//가로선
							}
						}
						
			         },
			         error : function(e) {
			            console.log(e);
			            
			         }
			      });//ajax end
			}
		
		}//for end
		
		//선택가능한 요일이 아닐 경우 알림창
		if(alertYn == "" || alertYn == null){
			alert( "선택가능한 요일은 " + c_dates + "입니다." );
			$("input[name=date]").val("");//선택한 날짜 초기화
		}
		
	});
	
	//시간 클릭
	$('#time').on('click','.cell',function() {
		//클릭 css
	    $('.cell').removeClass('select');
	    $(this).addClass('select');
	    
	    const checkDate = $("input[name=date]").val();//선택된 날짜
	    const checkTime = $(this).attr("time");//클릭한 시간
	    
	    let divDateTime = $('#'+checkDate+'_'+checkTime).find("input").val();
	    
	    if(divDateTime == null){//이미 클릭된 시간은 되면 안되기 때문에 그것 확인하고 실행
		    $('#check').append('<div id="'+checkDate+'_'+checkTime+'"><input type="checkbox" name="dateTime" value="'+checkDate+'/'+checkTime+'">'+'날짜 : '+checkDate+'  시간: '+checkTime+':00</div>');
	    }
	    	    
	});

});//$(document).ready(function() end

	//장바구니
	function cart(){
		const dateTime = $("input[name=dateTime]"); //이름이 dateTime인 모든 것을 가져옴
		let data = [];
		
		for(var i = 0 ; i < dateTime.length ; i++){//선택한 날짜와 시간은 가져온 dateTime을 개수만큼 반복문을 돌려서 data에 넣어줌

			var item = dateTime[i];//배열순번으로 하나씩 가져온 날짜와 시간 input
			var itemVal = $(item).val();//위 input의 value 값
			var temp = itemVal.split('/');//value 값에 날짜/시간 으로 값을 넣어뒀기 때문에 /로 나눠서 배열에 담음
			var date = temp[0];//날짜/시간으로 된 것을 나눠서 배열에 담았으르로 첫번째는 날짜 
			var time = temp[1];//두번째는 시간이 된다.
			var temp2 = {
					  c_id : "${detail.c_id}" 
					, c_title : "${detail.c_title}" 
					, price : "${detail.price}"
					, c_date : date
					, c_time : time
			};
			
			data.push(temp2);//위의 temp2를 data에 넣어준다.
			
		}
		
		$.ajax({
	         type : "POST",
	         url : "/submitCheck.do",
	         data : JSON.stringify(data),
	         contentType : "application/json",
	         cache : false,
	         success : function(result) {
				if(result){
					//ajax를 실행해서 컨트롤러에서 세션에 담아준 뒤 장바구니 페이지로 이동한다.
					location.href = "/cart.do";
				}
	         },
	         error : function(e) {
	            console.log(e);
	            
	         }
	      })
	};//cart() end
	
	//삭제
	function deleteCheck(){
		let checkedDivs = $("input:checked");//선택한 날짜와 시간중에서 체크박스에 체크되 것을 가져온다.
		
		if(checkedDivs){
			for(var checkedDiv of checkedDivs){//포문을 돌려 삭제한다.
				
				var checkedID = $(checkedDiv).parent().attr('id');
				$('#'+checkedID).remove();//삭제
			}	
		}
		
	}//deleteCheck() end


</script>

<body>
	<div class="top font-poppins">
		${detail.c_title}
	</div>		
	<!-- 분할 -->
	<div class="flex-container">
						
		<!-- 왼쪽 페이지 시작-->
		<div class="flex-item-left">
    		<div class="in-group">
        		<label class="label">프로필 사진</label>
        		<img src="../storage/${detail.prof_photo}" width="300">
    		</div>
								
			<br>
		
    		<div class="in-group">
        		<label class="label">강의설명</label>
        		<div class="input--style-4">${detail.c_content}</div>
    		</div>
			<br>
    		<div class="in-group">
        		<label class="label">강의 하는 악기</label>
        		<div class="input--style-4">${detail.q01ans}</div>
    		</div>
						 		                                               
			<br>
    		<div class="in-group">
        		<label class="label">강의 방식</label>
        		<div class="input--style-4">${detail.q03ans}</div>
   	 		</div>
			<br>
	    		<div class="in-group">
	        		<label class="label">강의 가능 지역</label>
	        		<div class="input--style-4">${detail.q04ans}</div>
	       		</div>
	   		<br>
       		<div class="in-group">
           		<label class="label">강의 기간</label>
           		<div class="input--style-4"></div>
			</div>
			<br>
							
			<div class="in-group">
				<label class="label">강의 가능 요일</label>
				<div class="input--style-4">${detail.c_date}</div>
			</div>
			<br>
				<div class="in-group">
					<label class="label">강의 가능 시간</label>
					<div class="input--style-4">${detail.c_time}</div>
				</div>
			<br>
			<div class="in-group">
				<label class="label">시간당 수강료</label>
				<div class="input--style-4">${detail.price} 원</div>
			</div>
		</div><!-- flex-item-left end -->
		<!-- 왼쪽 끝 -->
						
		<!-- 오른쪽 시작 -->  
		<div class="flex-item-right">
			<!-- 달력 -->
			<div class="container-fluid">
				<div class="row justify-content-center mx-0">
					<div class="col-lg-10">
						<div class="card border-0">
							<div class="card-header bg-dark">
								<div class="mx-0 mb-0 row justify-content-sm-center justify-content-start px-1">
									<input type="text" id="dp1" class="datepicker" placeholder="날짜를 선택해주세요." name="date" readonly>
									<span class="fa fa-calendar"></span>
								</div>
							</div>
							<div class="card-body p-15 p-sm-5">
								<div id="time" class="row text-center mx-0"></div>
							</div>
						</div>
					</div>
				</div>
				<!-- 달력 끝 -->
				<div>
					<label class="label">선택한 날짜</label>
					<div id="check"></div>
					<button class="delete_btn" onClick="deleteCheck();">삭제</button>
				</div>
			</div>
		</div>
		<!-- flex-item-right -->
		<!-- 오른쪽 끝 --> 
	</div><!-- flex-container end -->
	<!-- 분할 끝 -->                        
						
	<div class="p-t-15">
		<button type="button" class="btn btn--radius-2 btn--blue" onclick="history.back()">목록</button>                          
		<button class="btn btn--radius-2 btn--blue" onclick="cart();">장바구니</button>
	</div>

<!-- footer -->
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
						<li><a href="#">강의찾기</a></li>
						<li><a href="#">강사등록</a></li>
					</ul>
				</div>
				<div class="col-md-2 col-sm-4 col-xs-6 col-md-push-1 fh5co-widget">
					<h3>board</h3>
					<ul class="fh5co-footer-links">
						<li><a href="#">소개</a></li>
						<li><a href="#">공지사항</a></li>
						<li><a href="#">이벤트</a></li>
						<li><a href="#">수업후기</a></li>
					</ul>
				</div>
				<div class="col-md-2 col-sm-4 col-xs-6 col-md-push-1 fh5co-widget">
					<h3>Contact us</h3>
					<ul class="fh5co-footer-links">
						<li><a href="#">문의사항</a></li>
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

	<div class="gototop js-top">
		<a href="#" class="js-gotop"><i class="icon-arrow-up"></i></a>
	</div>
<!-- footer 끝 -->

</body>
</html>