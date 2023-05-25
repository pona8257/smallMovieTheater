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
	

</head>
<body>
	
	<div> gdgd</div>

</body>
</html>