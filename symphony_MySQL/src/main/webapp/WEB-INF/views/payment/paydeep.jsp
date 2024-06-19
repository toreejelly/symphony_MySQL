<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../header.jsp"%>

<link rel="stylesheet" href="../css/cart.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">


<div class="container pay-title"><h1>상세주문내역서</h1></div>

<div class="container pay-container">
  <table class="table">
    <thead class="thead-dark">
      <tr>
        <th>주문서번호</th>
        <th>내용</th>
        <th>총 시간</th>
        <th>총 가격</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>2206171659</td>
        <td>6/16, 10<br>6/17, 10, 11<br>6/18, 14, 15, 16</td>
        <td>6</td>
        <td>180000</td>
      </tr>
    </tbody>
  </table>
</div>

<%@ include file="../footer.jsp"%>