<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../header.jsp"%>
<%@ include file="ssi.jsp"%>

<link rel="stylesheet" href="../css/layout.css">

<!-- 본문 template.jsp 시작 -->
<div class="container-fluid bg-3 text-center">    
	<div class="row">

	<h3>* 글 목록 *</h3>
	<c:if test="${!empty s_id && s_id eq 'webmaster'}">
		<p><a href="noticeCreate.do">[글쓰기]</a></p>
	</c:if>

		<div class="container">
			<table class="table table-hover">
				<thead>
					<tr class="success">
						<th>번호</th>
						<th>작성자</th>
						<th>제목</th>
						<th>등록일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
<%
			// 한페이지당 출력할 행의 갯수
			int recordPerPage=5;

			ArrayList<NoticeDTO> list = dao1.list2(col, word, nowPage, recordPerPage);
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
					dto1=list.get(i); // 한줄 가져오기
%>
					<tr>
						<td><%=dto1.getwNum()%></td>
						<td><%=dto1.getId()%></td>
						<td style="text-align: left">
	
							<a href="noticeDetail.do?wNum=<%=dto1.getwNum()%>&col=<%=col%>&word=<%=word%>"><%=dto1.getwTitle()%></a>
<%						
						// 조회수 10이상이면 hot이미지 출력
						if(dto1.getwViews() >= 10) {
							out.println("<img src='../images/hot.gif'>");
						}
							
%>
						</td>
						<td><%=dto1.getwDate().substring(0, 10)%></td>
						<td><%=dto1.getwViews()%></td>
					</tr>

<%
				}
				int totalRecord=dao1.count2(col, word);
%>			
					<!-- 페이지 리스트. -->
					<tr>
						<td colspan='4' style='text-align:center; height:50px;'>
<%
						String paging=new Paging().paging1(totalRecord, nowPage, recordPerPage, col, word, "noticeList.do");
						out.print(paging);
%>
						</td>
					</tr>
	
					<!-- 검색시작 -->
					<tr>
						<td colspan='4' style='text-align:center; height: 50px;'>
							<form action="noticeList.do">
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
<%@ include file="../footer.jsp"%>