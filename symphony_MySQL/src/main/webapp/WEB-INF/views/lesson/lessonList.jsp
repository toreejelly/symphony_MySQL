<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<%@ include file="ssi.jsp"%>
<link rel="stylesheet" href="../css/layout.css">
<!-- 본문 template.jsp 시작 -->

<div class="container-fluid bg-3 text-center">    
  		<div class="row">

<h3>* 글 목록 *</h3>
<p><a href="lessoncreate.do">[글쓰기]</a></p>

<div class="container">
	<table class="table table-hover">
		<thead>
			<tr class="success">
				<th>번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>등록일</th>
				<th>조회수</th>
				<th>가격</th>
			</tr>
		</thead>
		<tbody>
<%
			// 한페이지당 출력할 행의 갯수
			int recordPerPage=5;

			ArrayList<RegDTO> list = dao3.list2(col, word, nowPage, recordPerPage);
			if(list==null) {
				out.println("<tr>");
				out.println("<td colspan='4'>");
				out.println("<strong>관련자료 없음</strong>");
				out.println("</td>");
				out.println("</tr>");
			} else {
				
				// 오늘 날짜를 문자열 "2022-05-04" 만들기
				String today=Utility.getDate();
				
				for(int i=0; i<list.size(); i++) {
					dto3=list.get(i); // 한줄 가져오기
%>
				<tr>
					<td><%=dto3.getC_id()%></td>
					<td><%=dto3.getId()%></td>
					<td style="text-align: left">

						<a href="lessondetail.do?c_id=<%=dto3.getC_id()%>&col=<%=col%>&word=<%=word%>"><%=dto3.getC_title()%></a>
<%						
						// 조회수 10이상이면 hot이미지 출력
						if(dto3.getW_views() >= 10) {
							out.println("<img src='../images/hot.gif'>");
						}
							
%>
					</td>
					<td><%=dto3.getDdate().substring(0, 10)%></td>
					<td><%=dto3.getW_views()%></td>
					<td><%=dto3.getPrice()%></td>
				</tr>

<%
				}
				int totalRecord=dao3.count2(col, word);
%>			

				<!-- 페이지 리스트 -->
				<tr>
					<td colspan='4' style='text-align:center; height:50px;'>
<%
						String paging=new Paging().paging1(totalRecord, nowPage, recordPerPage, col, word, "lessonlist.do");
						out.print(paging);
%>
					</td>
				</tr>

				<!-- 검색시작 -->
				<tr>
					<td colspan='4' style='text-align:center; height: 50px;'>
						<form action="lessonlist.do">
							<select name="col">
								<option value="c_title_c_content">제목+내용
								<option value="c_title">제목
								<option value="c_content">내용
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
	
	
<!-- 본문 template.jsp 끝 -->
<%@ include file="../footer.jsp"%>