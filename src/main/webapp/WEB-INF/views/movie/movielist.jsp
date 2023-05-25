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
</head>

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
  div {
    margin: 0 auto;
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
  .searchAndselect {
   height: 22px;
   width: 1000px;
   text-align: right;
   float: right;
   
  }
  .searchAndselect > a:hover {
    border-bottom: 1px solid white;
  }
  
  .movieList{
    width: 1000px;
    height: 400px;
    margin: 0 auto;
    display: flex;
    flex-wrap: wrap;
  }
  .movie {
    width: 300px;
    height: 300px;
    margin: 10px;
    text-align: center;
    flex-wrap: nowrap;
  }
  img {
    height: 80%;
    padding: 10px;
  } 
  
  .searchMovieList {
    margin-top: 20px;
    display: flex;
  }
</style>
<script>

  function fnSearch(){
	  $('#btnSearch').on('click', function(){
		  $.ajax({
			  type: 'get',
			  url: '${contextPath}/movie/searchMovie.do',
			  data:$('#movieSearch').serialize(),
			  dataType: 'json',
			  success: function(resData){
				  alert(resData.message);
				  $('.searchMovieList').empty();
				  $('.movieList').hide();
				  if(resData.list != ''){
					  $.each(resData.list, function(i, movie){
						  let str = '<div class="movie">';
						  str += '<a href="${contextPath}/movie/movieDetail.do?movieId=' + movie.movieId + '">';
						  str += '<img src="${contextPath}/resources/img/' + movie.posterName + '">';
						  str += '<div style="font-weight:bold">' + movie.title + '</div>';
						  str += '</a>';
						  $('.searchMovieList').append(str);
					  })
				  } else if(resData.list == null){
					  return;
				  }
			  }
		  })
	  })
  }
  
  function fnList(){
	  location.href = '${contextPath}/movie/movielist.do';
  }
  function fnLogin(){
	    location.href = '${contextPath}/user/login.form';
	  }
  function fnLogout(){
	    location.href = '${contextPath}/user/logout.do';
  }
  function fnJoin(){
    location.href = '${contextPath}/user/join.form';
  }
  
  $(function(){
	  fnSearch();
	  
  })
  
  
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
      <div style="text-align: right;">
        <a href="${contextPath}/user/mypage.do">${sessionScope.userId}</a>님 반갑습니다 ♥
        <input type="button" onclick="fnLogout()" value="로그아웃">
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
  

  
  <div style="width:900px;">
    <h1>현재 상영작</h1>
  </div>
   
  <div class="searchAndselect">
    <form id="movieSearch">
      <select id="column" name="column">
        <option value="TITLE">제목</option>
        <option value="GENRE">장르</option>
      </select>
      <input type="text" name="searchText">
      <input type="button" id="btnSearch" value="검색">
      <input type="button" value="목록" onclick="fnList()">
    </form>
    
  </div>
  
  <div class="movieList">
    <c:forEach items="${movieList}" var="movie" varStatus="i">
      <div class="movie">
        <div style="width:188px; border:1px solid #FFF;"><strong>NO.${i.index+1}</strong></div>
        <a href="${contextPath}/movie/movieDetail.do?movieId=${movie.movieId}">
            <img src="${contextPath}/resources/img/${movie.posterName}">
        </a>
        <div>
          <a href="${contextPath}/movie/movieDetail.do?movieId=${movie.movieId}" style="font-weight:bold">${movie.title}</a>
        </div>
      </div>
    </c:forEach>
  </div>
  
  
  
  <div class="searchMovieList">
    
  </div>
  
</body>
</html>