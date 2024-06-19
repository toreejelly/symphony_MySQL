<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../header.jsp"%>

<link rel="stylesheet" href="../css/cart.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script>

<script>

	$(document).ready(function(){
		$("#size").val(${list.size()});	//장바구니에 담긴 배열의 사이즈를 확인해서 수량을 넣어준다.
	});

	//장바구니 item 삭제
	function deleteCart(item){
		let id = item;
		let size = $("#size").val();//수량
		size = size - 1 ;//빼기 1
		let price = ${list[0].price};
		let total = ${list[0].price} * size;//-1된 수량으로 전체금액 다시 계산

		$("#"+id).remove();//한 줄 삭제
		$("#size").val(size);//수량
		$("#sizeDiv").text(size + "시간");
		$("#sizeDiv").text(size + "시간");
		$("#total").text(total + "원");

	};
	
	//결제
	function submit(){
		if(confirm("결제하시겠습니까?")){
			$("#paySubmit").submit();	
		}
	}
	
</script>

<div class="container cart-title"><h1>장바구니</h1></div>

<div class="container cart-container">
	<form id="paySubmit" action="pay.do" method="POST">
		<table class="table">
			<thead class="thead-dark">
				<tr>
					<th>강의제목</th>
					<th>강사</th>
					<th>가격</th>
					<th>선택한 날짜</th>
					<th>선택한 시간</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="dto" items="${list}" varStatus="status">
				<tr id="${dto.c_date}_${dto.c_time}">
					<!-- arrayList로 넘기기 위해 name -->
					<td>${dto.c_title}<input type="hidden" name="dtos[${status.index}].c_title" value="${dto.c_title}"></td>
					<td>${dto.name}<input type="hidden" name="dtos[${status.index}].name" value="${dto.name}"></td>
					<td>${dto.price}<input type="hidden" name="dtos[${status.index}].price" value="${dto.price}"></td>
					<td>${dto.c_date}<input type="hidden" name="dtos[${status.index}].c_date" value="${dto.c_date}"></td>
					<td>
						${dto.c_time}
						<input type="hidden" name="dtos[${status.index}].c_time" value="${dto.c_time}">
						<input type="hidden" name="dtos[${status.index}].c_id" value="${dto.c_id}">
					</td>
					<td><button type="button" onClick="deleteCart('${dto.c_date}_${dto.c_time}');">삭제</button></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</form>
</div>

<div class="content_total_section container">
	<div class="total_wrap">
		<table class="ttable">
			<tr>
				<td>
					<table class="ttable">
						<tr>
							<td>1시간 당 가격</td>
							<td><span class="totalPrice_span">${list[0].price}</span> 원</td>
						</tr>
						<tr>
							<td>총 주문 시간</td>
							<td>
								<div id="sizeDiv">${list.size()} 시간</div>
								<input type="hidden" id="size">
							</td>
						</tr>
					</table>
				</td>
				<td>
					<table class="ttable">
						<tr>
							<td></td>
							<td></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<div class="boundary_div">구분선</div>
		<table class="ttable">
			<tr>
				<td>
					<table class="ttable">
						<tbody>
							<tr>
								<td><strong>총 결제 예상 금액</strong></td>
								<td>
									<div id="total">${list[0].price*list.size()} 원</div>
								</td>
							</tr>
						</tbody>
					</table>
				</td>
				<td></td>
			</tr>
		</table>
	</div>
</div>

<!-- 구매 버튼 영역 -->
<div class="content_btn_section container">
	<a href="#" onClick="submit();" style="color: inherit; text-decoration: none;">주문하기</a>
</div>

<%@ include file="../footer.jsp"%>