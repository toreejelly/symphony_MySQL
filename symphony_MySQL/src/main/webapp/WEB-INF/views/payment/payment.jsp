<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../header.jsp"%>

<link rel="stylesheet" href="../css/cart.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">


<div class="container cart-title"><h1>주문서</h1></div>

<div class="container cart-container">
  <table class="table">
    <thead class="thead-dark">
      <tr>
        <th>강의제목</th>
        <th>강사</th>
        <th>가격</th>
        <th>선택한 날짜</th>
        <th>선택한 시간</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>클래식 피아노</td>
        <td>park123</td>
        <td>30000</td>
        <td>6/16</td>
        <td>10</td>
      </tr>
      <tr>
        <td>클래식 피아노</td>
        <td>park123</td>
        <td>30000</td>
        <td>6/17</td>
        <td>10, 11</td>
      </tr>
      <tr>
        <td>클래식 피아노</td>
        <td>park123</td>
        <td>30000</td>
        <td>6/18</td>
        <td>14,15,16</td>
      </tr>
    </tbody>
  </table>
</div>

<div class="container oid">
    <strong class="onum">주문번호 : 2206171659</strong>
</div>

<div class="container bank">
    결제방법 : 
    <select name="subject">
        <option value="kakao">카카오뱅크</option>
        <option value="kakao">네이버페이</option>
        <option value="kakao">토스</option>
        <option value="kakao">은행</option>
    </select>
</div>

<div class="container price">
    <strong>총 결제 금액</strong>
    <span class="finalTotalPrice_span">180000</span> 원
</div>

<!-- 구매 버튼 영역 -->
<div class="content_btn_section container">
  <a href="#" style="color: inherit; text-decoration: none;">주문하기</a>
</div>

<%@ include file="../footer.jsp"%>