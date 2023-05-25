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
<title>상세보기</title>
<script src="${contextPath}/resources/js/lib/jquery-3.6.4.min.js"></script>
<script type="text/javascript " src="https://service.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<style>
	a {
    text-decoration: none;
    color: #FFF;
  }
  body {
    color: #FFF;
    padding: 20px;
    text-align: center;
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
  
</style>
<script>
	
	$('cart_label').on('click', function(ev){
		if(${sessionScope.userId == null}){
			if(confirm('로그인이 필요한 서비스입니다. \n 로그인창으로 이동하시겠습니까?')){
				location.href = '${contextPath}/user/login.form';
			}
		}
	})
	
	function fnStore(){
		location.href = '${contextPath}/store/store.do';
	}
	
	function fnInCart(){
		
		if(${sessionScope.userId == null}){
			if(confirm('로그인이 필요한 서비스입니다. \n로그인창으로 이동하시겠습니까?')){
				location.href = '${contextPath}/user/login.form';
			} else {
				location.href = '${contextPath}/store/store.do';
			}
		}
		
	}
	
</script>
</head>
<body>

	<header>
	    <a href="${contextPath}/">
	      <strong>작은영화관</strong>
	    </a>
  	</header>
  
	  <div class="login">
	    <button>로그인</button>
	  </div>
   
	  <nav>
	    <ul class="gnb">
	      <li><a href="${contextPath}/movie/movielist.do">영화</a></li>
	      <li><a href="javascript:void(0)">공지사항</a></li>
	      <li><a href="${contextPath}/store/store.do">스토어</a></li>
	      <li><a href="${contextPath}/movie/reserve.form">예매</a></li>
	    </ul>
	  </nav>
	
	<form id="cart_Add" action="${contextPath }/store/cart.do" method="post">
		<table border="1">
			<tr>
				<td rowspan="4"><img src="${contextPath}/resources/img/${product.imageName}.jpg"> </td>
				<td>상품명</td>
				<td>${product.productName}</td>
			</tr>
			<tr>
				<td>가격</td>
				<td>${product.price}원</td>
			</tr>
			<tr>
				<td>상품소개</td>
				<td>${product.productContent}</td>
			</tr>
			<tr>
				<td><label for="count">수량</label>
	       		 <input type="number" id="count" min="1" max="10" value="1" name="count">개
	       		 <input type="hidden" name="productNo" value="${product.productNo}">
	       		 <br>
	       		 <br>
	       		 <button onclick="fnInCart()">장바구니에 담기</button>
	       		</td>
	       		<td><input type="button" value="뒤로가기" onclick="fnStore()"></td>
			</tr>
		</table>
	</form>
	

</body>
</html>