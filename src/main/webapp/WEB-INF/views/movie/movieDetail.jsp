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
  img {
    height: 100%;
    width: 100%;
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
  strong {
   text-align: center;
  }
  .main_section {
    display: flex;
    height: 500px;
    margin: 0px 20px 0px 20px;
  }
  .movie_poster {
    height: 90%;
    width: 30%;
    padding: 10px;
  }
  .right_section {
    display: block;
    width: 70%;
    float: right;
  }
  .movie_detail {
    height: 10%;
    width: 100%;
    line-height: 60px;
    text-align: left;
    padding: 10px;
  }
  .coment_all {
    display: flex;
    height: 70px;
    margin: 0px 20px 0px 20px;
  }
  .coment  {
    height: 90%;
    width: 70%;
  }
  .coment > .input_content {
    width: 100%;
    height: 100%;
  }
  .rating{
    height: 90%;
    width: 15%;
  }
  .rating > .input_rating {
    width: 100%;
    height: 100%;
  }
  .button {
    height: 100%;
    width: 15%;
  }
  .button > * {
    height: 100%;
    width: 80%;
  }
  .user_review_section {
    display: flex;
    margin: 0px 20px 0px 20px;
  }
  .movie_review_all {
    margin: 0px 20px 0px 20px;
  }
  .movie_review_all > table {
    width:100%;
  }
  .movie_review {
    border: 1px solid #FFF;
    display: flex;
    width: 100%;
  }
  .movie_review > div {
    border-right: 1px solid #FFF;
  }
  
        
</style>

<script>
  let addResult = '${addResult}';
  if(addResult != ''){
    if(addResult == '1'){
      alert('게시글 등록 성공');
    } else {
      alert('게시글 등록 실패');
    }
  }
  let deleteResult = '${deleteResult}';
  if(deleteResult != ''){
	  if(deleteResult == '1'){
		  alert('게시물 삭제 성공');
	  } else {
	      alert('게시글 삭제 실패');
	  }
  }
  function fnLogin(){
	    location.href = '${contextPath}/user/login.form';
  }
  function fnJoin(){
    location.href = '${contextPath}/user/join.form';
  }
  function fnLogout(){
    location.href = '${contextPath}/user/logout.do';
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
  
  <div class="main_section">
    <div class="movie_poster">
      <img src="${contextPath}/resources/img/${movieDetail.posterName}">
    </div>
    <div class="right_section">
      <div class="movie_detail">제목 : ${movieDetail.title}</div>
      <div class="movie_detail">감독 : ${movieDetail.director}</div>
      <div class="movie_detail">장르 : ${movieDetail.genre}</div>
      <div class="movie_detail">평점 : ${movieDetail.rating}</div>
      <div class="movie_detail">개봉일 : ${movieDetail.startDate}</div>
      <div class="movie_detail">줄거리 : ${movieDetail.plot}</div>
    </div>
  </div>
  
  <hr>
  <h2 style="text-align:left; margin-left:20px;">영화 한줄평 남기기</h2> 
    <form method="post" action="${contextPath}/movie/addMovieReview.do">
        <div class="coment_all">
          <div class="coment">
            <input type="text" class="input_content" placeholder="한줄평 남기기" name="reviewContent">
          </div>
          <div class="rating">
            <input type="text" class="input_rating" placeholder="평점(5.0 만점)" name="reviewRating">
          </div>
          <input type="hidden" value="${movieDetail.movieId}" name="movieId">
          <c:if test="${sessionScope.userId ne null}">
            <div class="button">
              <button>등록</button>
            </div>
          </c:if>
          <c:if test="${sessionScope.userId eq null}">
          </c:if>
        </div>
    </form>
    
   <hr>
    
  <div class="movie_review_all">
    <c:if test="${empty movieReviewList}">
      <strong>한줄평을 적어주세요!!</strong>
    </c:if>
    <c:if test="${not empty movieReviewList}">
      <div class="movie_review">
        <div style="width:10%;">순번</div>
        <div style="width:20%;">평점</div>
        <div style="width:50%;">한줄평</div>
        <div style="width:20%;">삭제</div>
       </div>
      <c:forEach items="${movieReviewList}" var="movieReview" varStatus="i">
       <form method="post" action="${contextPath}/movie/deleteMovieReview.do">
         <div class="movie_review">
          <div style="width:10%;">${i.index + 1} </div>
          <div style="width:20%;">${movieReview.reviewRating}</div>
          <div style="width:50%;">${movieReview.reviewContent}</div>
          <input type="hidden" value="${movieReview.reviewNo}" name="reviewNo">
          <input type="hidden" value="${movieDetail.movieId}" name="movieId">
          <c:if test="${movieReview.userId == sessionScope.userId}">
            <div style="width:20%;"><button>삭제</button></div>
          </c:if>
         </div>
       </form>
      </c:forEach>
    </c:if>
  </div>
    
</body>
</html>