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
<title>Insert title here</title>
<script src="${contextPath}/resources/js/lib/jquery-3.6.4.min.js"></script>
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
	
<script>
	
	function fnList(){
		location.href = '${contextPath}/store/store.do';
	}
	
</script>

</head>
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
	
	<div>
		<h1>결제가 완료되었습니다.</h1>
	</div>
	
	<div style="margin: 0px 20px 0px 20px;">
		<table border="1" style="width: 100%;">
			<thead>
				<tr>
					<td width="10%">주문번호 </td>
					<td width="10%">주문날짜</td>	
					<td width="10%">사진</td>
					<td width="50%">제품명 </td>	
					<td width="10%">수량 </td>
					<td width="10%">제품가격</td>		
				</tr>
			</thead>
				
			<tbody>
				<c:forEach items="${carts}" var="cart" varStatus="i">
						<tr>
							<td width="70px">${i.index + 1}</td>
							<td>${orders[i.index].orderDate}</td>
							<td width="100px"><img src="${contextPath}/resources/img/${cart.productDTO.imageName}.jpg" style="width: 100px;" ></td>
							<td>${cart.productDTO.productName }</td>
							<td>${cart.count }개</td>
							<td>${cart.productDTO.price}원</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="6">총 결제금액 ${totalPrice }</td>
					</tr>
			</tbody>
		</table>
		<input type="button" value="홈 화면" onclick="fnList()">
	</div>
	
	
	
	
	

</body>
</html>