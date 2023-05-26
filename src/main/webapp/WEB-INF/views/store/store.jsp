<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스토어</title>
<script src="${contextPath}/resources/js/lib/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<style>
	#cart {
		text-align: right;
	}
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
  .productList {
  	display: flex;
    margin: 0 auto;
    flex-wrap: wrap;
  }
  .product {
  	width: 350px;
  	height: 350px;
  	margin: 10px;
  	text-align: center;
  }
  .productList > #img {
  	width: 100%;
  	height: 80%;
  	
  }
  .productTitle {
  	text-align: left;
  	margin-left: 40px;
  }
</style>
<script type="text/javascript">

	
	
	function fnLogin(){
		  location.href = '${contextPath}/user/login.form';
	}
	function fnJoin(){
		  location.href = '${contextPath}/user/join.form';
	}
	function fnLogout(){
		  location.href = '${contextPath}/user/logout.do';
	}
	
	if(${insertResult} != 0){
		if(confirm('장바구니에 상품을 담았습니다.\n장바구니로 이동하시겠습니까?')){
			location.href = '${contextPath}/store/cart.form';
		}
	}
	
	if(${insertResult} == 0){
		if(confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')){
			location.href = '${contextPath}/user/login.form';
		} else {
			history.back();
		}
	}
	
</script>
<body>

	<header>
    <a href="${contextPath}/">
      <strong>작은영화관</strong>
    </a>
  </header>
  
  <c:if test="${sessionScope.userId == null}">
    <div class="login">
      <input type="button" onclick="fnJoin()" value="회원가입">
      <input type="button" onclick="fnLogin()" value="로그인">
    </div>
  </c:if>
  
  <c:if test="${sessionScope.userId != null}">
      <div style="text-align: right;" id="cart">
        <a href="${contextPath}/user/mypage.do">${sessionScope.userId}</a>님 반갑습니다 ♥
        <input type="button" onclick="fnLogout()" value="로그아웃">
		<a href="${contextPath }/store/cart.form" id="cart_label"><i class="fa-solid fa-cart-shopping fa-2x"></i></a>
      </div>
  </c:if>
  
 	 
   
  <nav>
    <ul class="gnb">
      <li><a href="${contextPath}/movie/movielist.do">영화</a></li>
      <li><a href="javascript:void(0)">공지사항</a></li>
      <li><a href="${contextPath}/store/store.do">스토어</a></li>
      <li><a href="${contextPath}/movie/reserve.form">예매</a></li>
    </ul>
  </nav>
  
  <h1>스토어</h1>
	
	
	<div class="productTitle">
		<h2>콤보</h2>
	</div>
	<hr>
	<div class="productList">
		<c:forEach items="${products }" var="product" end="3">
			<div class="product">
				<a id="img" href="${contextPath }/store/detail.do?productNo=${product.productNo}"><img src="${contextPath}/resources/img/${product.imageName}.jpg"></a>
				<div>${product.productName}</div>
				<div>${product.price}</div>
			</div>
		</c:forEach>
	</div>
	<div class="productTitle">
		<h2>팝콘</h2>
	</div>
	<hr>
	<div class="productList">
		<c:forEach items="${products }" var="product" begin="4" end="5">
			<div class="product">
				<a id="img" href="${contextPath }/store/detail.do?productNo=${product.productNo}">
					<img src="${contextPath}/resources/img/${product.imageName}.jpg">
				</a>
				<div>${product.productName}</div>
				<div>${product.price}</div>
			</div>
		</c:forEach>
	</div>
	<div class="productTitle">
		<h2>음료</h2>
	</div>
	<hr>
	<div class="productList">
		<c:forEach items="${products }" var="product" begin="6" end="7">
			<div class="product">
				<a id="img" href="${contextPath }/store/detail.do?productNo=${product.productNo}"><img src="${contextPath}/resources/img/${product.imageName}.jpg"></a>
				<div>${product.productName}</div>
				<div>${product.price}</div>
			</div>
		</c:forEach>
	</div>
	
	
	
	
</body>
</html>