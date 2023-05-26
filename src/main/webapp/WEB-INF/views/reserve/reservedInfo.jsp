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
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script>

	

</script>
<style>

	

</style>
</head>
<body>

	<header>
	    <a href="${contextPath}/">
	      <strong>작은영화관</strong>
	    </a>
    	<nav>
	    	<ul class="gnb">
		      <li><a href="${contextPath}/movie/movielist.do">영화</a></li>
		      <li><a href="javascript:void(0)">공지사항</a></li>
		      <li><a href="${contextPath}/store/store.do">스토어</a></li>
		      <li><a href="${contextPath}/movie/reserve.form">예매</a></li>
	    	</ul>
  		</nav>
	</header>

	<c:if test="${sessionScope.userId == null}">
		<script>
			function(){
				alert('로그인 서비스입니다.');
				loaction.href = '${contextPath}/user/login.form';
			}
		</script>
 	</c:if>
 	<c:if test="${sessionScope.userId != null">
 		
 	</c:if>

</body>
</html>