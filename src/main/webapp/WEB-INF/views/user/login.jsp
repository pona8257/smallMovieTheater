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
<!-- cdnjs.com 에서 jquery-cookie 검색 후 jquery-cookie 라이브러리 포함 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<style>
/* 전체 화면을 채우는 컨테이너 */
body {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100vh;
  margin: 0;
}

/* 로그인 박스 스타일 */
.login-box {
  width: 300px;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
  background-color: #f9f9f9;
}

/* 로그인 박스 내부 요소 스타일 */

.login-box h1 {
  text-align: center;
}

.login-box input[type="text"],
.login-box input[type="password"] {
  width: 100%;
  padding: 10px;
  margin-bottom: 10px;
  box-sizing: border-box;
}

.login-box button {
  width: 100%;
  padding: 10px;
  background-color: #4caf50;
  border: none;
  color: #fff;
  cursor: pointer;
}
</style>

<script>
  
	  // 로그인하기
	  function fnLogin(){
	  
    	$('#frmLogin').on('submit', function(event){
      
      // 아이디, 비밀번호 공백 검사
      if($('#userId').val() == '' || $('#userPassword').val() == ''){
        alert('아이디와 비밀번호를 모두 입력하세요.');
        event.preventDefault();
        return;
      }
      
      // 아이디 기억을 체크하면 rememberId 쿠키에 입력된 아이디를 저장
      if($('#chkRememberId').is(':checked')){
        $.cookie('rememberId', $('#userId').val());
      } else {
        $.cookie('rememberId', '');
      }
    });
    
  }
  	  // 체크박스 아이디 기억하기
  	  function fnbtn1(){
  		  $('#chkRememberId').on('click', function(){
  			  if($('#chkRememberId').is(':checked')){
  				  alert('아이디 기억하기를 체크하였습니다.');	  
  			  }else{
  				  alert('아이디 기억하기를 해제하였습니다.');
  			  }
  		  });
  	  }
  	  // 체크박스 자동 로그인
  	  function fnbtn2(){
  		  $('#chkAutoLogin').on('click', function(){
  			  if($('#chkAutoLogin').is(':checked')){
  				  alert('자동 로그인하기를 체크하였습니다.');	  
  			  }else{
  				  alert('자동 로그인하기를 해제하였습니다.');
  			  }
  		  });
  	  }
  
	  // 쿠키에 기억된 아이디 보여주기(아이디 기억)
	  function fnDisplayRememberId(){
	    
	    // rememberId 쿠키에 저장된 아이디를 가져와서 표시
	    
	    let rememberId = $.cookie('rememberId');
	    if(rememberId == ''){
	      $('#userId').val('');
	      $('#chkRememberId').prop('checked', false);
	    } else {
	      $('#userId').val(rememberId);
	      $('#chkRememberId').prop('checked', true);
	    }
	    
	  }
	  
	  $(function(){
	    fnLogin();
	    fnDisplayRememberId();
	    fnbtn1();
	    fnbtn2();
	  })
  
</script>
</head>
<body>

    <form id="frmLogin" method="post" action="${contextPath}/user/login.do" >
    
  <div class="login-box">
  
  <h1>*작은 영화관*</h1>
  
      <!-- 로그인 이후에 이동할 주소 -->
      <input type="hidden" name="url" value="${url}">
    	<div>
    	<table>
    	
    		<tr>
    			<td>아이디</td>
    			<td><input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요"></td>
    		</tr>
    	
    	
    		<tr>
    			<td>비밀번호</td>
    			<td><input type="password" id="userId" name="userPassword" placeholder="비밀번호를 입력하세요"></td>
    		</tr>
    	
    	
    		<tr>
    			<td colspan="2"><button>로그인</button></td>
    		</tr>
    	
    	
    		<tr>
    			<td>
		           	<label for="chkRememberId">
		           	<input type="checkbox" id="chkRememberId">
	           		아이디 기억
	         		</label>
         		</td>
         		<td>
		         	<label for="chkAutoLogin">
		           	<input type="checkbox" name="chkAutoLogin" id="chkAutoLogin">
		           	자동 로그인
        			</label>
		        </td>   	
      		</tr>
      	
    	</table>
    	</div>
      	<div>
    	  <a href="${contextPath}/user/findId.form">아이디 찾기</a> | 
	      <a href="${contextPath}/user/findPw.form">비밀번호 찾기</a> |
	      <a href="${contextPath}/user/agree.form">회원가입</a>
      	</div>   
    
    </form>
</body>
</html>