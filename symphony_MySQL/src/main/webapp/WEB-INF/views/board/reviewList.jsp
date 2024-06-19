<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../header.jsp"%>
<%@ include file="ssi.jsp"%>

	<meta name="viewport" content="width=device-width, initial-scale=1">

	<link rel="stylesheet" href="../css/layout.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<link rel="stylesheet" href="css/list.css">
	
<script>
	$(document).ready(function(){
		
		let nowPage = <%=nowPage%>;//1페이지에만 나오게 하기 위한 변수
		let date = new Date();//이번 달 날짜를 가져오기위한 것
		let month = date.getMonth() + 1;//날짜가 0부터 시작하므로 +1 함
		
		if(nowPage == "1"){//1페이지인 경우 실행
			$.ajax({
		         type : "GET",//파라미터 던지는 것이 필요없으므로 get
		         url : "/likeList.do",
		         contentType : "application/json",
		         cache : false,
		         success : function(result) {

		        	 if(result){
						for(var item of result){//셀렉트 해 온 세개의 리스트를 반복문 돌림
							
							let html = '<div class="w3-third w3-container w3-margin-bottom">';
							html += '<video src="../storage/'+item.wPicPath+'#t=0.5" alt="Norway" preload="metadata" style="width:100%" class="w3-hover-opacity" controls></video>';
							html += '<div class="w3-container w3-white">';
							html += '<p class="flo-le"><a href="reviewDetail.do?wNum='+item.wNum+'"><b>'+month+'월의 좋아요 '+item.rank+'등</a></b></p>';
							html += '<p class="flo-rig">좋아요 '+item.wLike+'</p></div></div>';
							
							$("#likeList").append(html);//div의 id가 likeList 인 것 안에 넣어줌
						}
					}else{
						$("#likeList").empty();//만약 콘트롤러에서 돌아온 리턴값이 없을 경우 혹시라도 남아있는 좋아요 순위 리스트를 비워줌
					}
				 },
		         error : function(e) {
		            console.log(e);
		         }
	      	});//ajax end
		};
	});

</script>
	
<!-- 본문 template.jsp 시작 -->
<div class="container-fluid bg-3 text-center">    
	<div class="row">

	<h3>* 글 목록 *</h3>
	<p><a href="reviewCreate.do">[글쓰기]</a></p>

	<!-- 순위 -->
	<!-- Sidebar/menu -->
	<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

		<!-- !PAGE CONTENT! -->
		<div class="body">

			<!-- First Photo Grid-->
			<div id="likeList" class="w3-row-padding"></div>
			<!-- w3-row-padding end -->
			<!-- 순위 끝 --> 

		<div class="container">
			<table class="table table-hover">
				<thead>
					<tr class="success">
						<th>번호</th>
						<th>작성자</th>
						<th>제목</th>
						<th>등록일</th>
						<th>조회수</th>
						<th>좋아요</th>
					</tr>
				</thead>
				<tbody>
<%
				// 한페이지당 출력할 행의 갯수
				int recordPerPage = 5;
				
				ArrayList<ReviewDTO> list = dao.list2(col, word, nowPage, recordPerPage);
				
				if(list == null) {
					out.println("<tr>");
					out.println("<td colspan='4'>");
					out.println("<strong>관련자료 없음</strong>");
					out.println("</td>");
					out.println("</tr>");
				} else {
					
					// 오늘 날짜를 문자열 "2022-05-04" 만들기
					String today=Utility.getDate();
					
					for(int i=0; i<list.size(); i++) {
						dto=list.get(i); // 한줄 가져오기
%>
					<tr>
						<td><%=dto.getwNum()%></td>
						<td><%=dto.getId()%></td>
						<td style="text-align: left">
							<a href="reviewDetail.do?wNum=<%=dto.getwNum()%>&col=<%=col%>&word=<%=word%>"><%=dto.getwTitle()%></a>
<%						
						// 조회수 10이상이면 hot이미지 출력
						if(dto.getwViews() >= 10) {
							out.println("<img src='../images/hot.gif'>");
						}
							
%>
						</td>
						<td><%=dto.getwDate().substring(0, 10)%></td>
						<td><%=dto.getwViews()%></td>
						<td><%=dto.getwLike()%></td>
						<td></td>
					</tr>
<%
					}
					int totalRecord=dao.count2(col, word);
%>			
					<!-- 페이지 리스트 -->
					<tr>
						<td colspan='4' style='text-align:center; height:50px;'>
<%
						String paging=new Paging().paging1(totalRecord, nowPage, recordPerPage, col, word, "reviewList.do");
						out.print(paging);
	%>
						</td>
					</tr>
	
					<!-- 검색시작 -->
					<tr>
						<td colspan='4' style='text-align:center; height: 50px;'>
							<form action="reviewList.do">
								<select name="col">
									<option value="w_title_w_text">제목+내용
									<option value="w_title">제목
									<option value="w_text">내용
									<option value="id">작성자
								</select>
								<input type="text" name="word" id="word">
								<input type="submit" value="검색" class="btn btn-primary">
							</form>
						</td>
					</tr>
					<!-- 검색끝 -->
<%			
			}
%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
	
	
<!-- 본문 template.jsp 끝 -->
<%@ include file="../footer.jsp"%>