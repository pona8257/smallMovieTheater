<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<script src="${contextPath}/resources/js/lib/jquery-3.6.4.min.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<style>

	a {
    text-decoration: none;
    color: #FFF;
  }
  body {
    color: #FFF;
    padding: 20px;
    
    background-color: #000;
  }
  header {
    padding: 30px;
    text-align: center;
    text-decoration: none;
  }
  header > * {
    color: #FFF;
    font-size: 32px;
    text-decoration: none;
  }
  
  .login{
    text-align: right;
  }
  .gnb {
    height: 40px;
    display: flex;
    justify-content: space-evenly;
    list-style-type: none;
    border-bottom: #FFF solid 1px;
    border-top: #FFF solid 1px;
  }
  .gnb > li {
    width: 100px;
  }
  .gnb > li > a {
    width: 100%;
    height: 100%;
    text-align: center;
    line-height: 40px;
    color: #FFF;
    text-decoration: none;
  }
  .gnb > li > a:hover {
    border-bottom: 2px solid white;
  }
  
  .wrap {
  	margin: 0px 20px 0px 20px;
  }
  
  .wrap > table {
  	width: 100%;
  }
  
  
  
</style>
<script type="text/javascript">
	
	
	
	function fnStore(){
		location.href = '${contextPath}/store/store.do';
	}
	
	function requestPay(){
		
		
		IMP.init('imp34858868'); //portone 대신 자신의 "가맹점 식별코드"를 사용하시면 됩니다
		IMP.request_pay({
			merchant_uid : 'merchant_' + new Date().getTime(),
			name : '결제테스트',
			amount : ${totalPrice},
			buyer_email : 'cs@portone.io',
			buyer_name : '구매자',
			buyer_tel : '010-1234-5678',
			buyer_addr : '서울특별시 강남구 삼성동',
			buyer_postcode : '123-456'
		}, function(rsp) {
			if ( rsp.success ) {
				location.href = '${contextPath}/store/paymentDetail.do';
				alert('결제가 완료되었습니다.');
				
			} else {
				location.href = '${contextPath}/store/store.do';
				alert('결제에 실패하셨습니다.');
			}
		});
	}
	
	// 선택 항목 삭제
	function fnRemoveList(){
		$('#frm_remove').on('submit', function(event){
			if($('.chk_one:checked').length == 0){
				alert('선택된 상품이 없습니다.');
				event.preventDefault();
				return;
			}
			if(confirm('선택한 상품을 삭제할까요?') == false){
				event.preventDefault();
				return;
			}
		})
	}
	
	$(function(){
		fnRemoveList();
	})
	
	
</script>
</head>
<body>

	<header>
	    <a href="${contextPath}/">
	      <strong>작은영화관</strong>
	    </a>
  	</header>
   
	  <nav>
	    <ul class="gnb">
	      <li><a href="${contextPath}/movie/movielist.do">영화</a></li>
	      <li><a href="javascript:void(0)">공지사항</a></li>
	      <li><a href="${contextPath}/store/store.do">스토어</a></li>
	      <li><a href="${contextPath}/movie/reserve.form">예매</a></li>
	    </ul>
	  </nav>
	
	<h1>장바구니</h1>
	<div>
		<form action="${contextPath}/store/remove.do" class="wrap" method="post" id="frm_remove">
			<c:if test="${empty carts}">
				<table border="1">
					<tr>
						<td><div>장바구니에 담긴 제품이 없습니다.</div></td>
					</tr>
				</table>			
				<input type="button" value="스토어" onclick="fnStore()">
			</c:if>
			<c:if test="${not empty carts}">
				<table border="1">
				<thead>
					<tr>
						<td>제품번호</td>
						<td>제품사진</td>
						<td>제품명</td>
						<td>설명</td>
						<td>개수</td>
					</tr>
				</thead>
				<c:forEach items="${carts}" var="cart" varStatus="i">
					<tr>
						<td>${i.index + 1}  <input type="checkbox" value="${cart.cartNo}" name="cartNo" class="chk_one"></td>
							
						<td><img src="${contextPath}/resources/img/${cart.productDTO.imageName}.jpg"></td>
						<td>
							${cart.productDTO.productName }
							${cart.productDTO.price }원
						</td>
						<td>${cart.productDTO.productContent } </td>
						<td>${cart.count } 개 </td>
					</tr>
				</c:forEach>
					<tr>
						<td colspan="3">총 상품 수 : ${cartsCount }</td>
						<td colspan="3">총 결제금액 : ${totalPrice }</td>
					</tr>
				</table>
				<button>장바구니에서 빼기</button>
				<input type="button" value="스토어" onclick="fnStore()">
			</c:if>
		</form>
		<button style="margin: 0px 20px 0px 20px;" onclick="requestPay()" id="pay">결제하기</button>
	</div>
	
	
	

</body>
</html>