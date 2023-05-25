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
<script>	

		// 전역 변수 (각종 검사 통과 유무를 저장하는 변수)
		var verifyPw = false;
		var verifyRePw = false;
		var verifyName = false;
		var verifyMobile = false;
		var verifyEmail = false;
		
		// 함수 정의  
	    function fnEditPwInit(){
		    $('#pw').val('');
		    $('#rePw').val('');
		    $('#msgPw').val('');
		    $('#msgRePw').val('');
	  }
		
	    function fnToggleEditPwArea(){
	        $('#editPw').hide();
	        $('#btnOpenEditPw').on('click', function(){
	        	fnEditPwInit();
	        	$('#btnOpenEditPw').hide();
	          $('#editPw').show();
	        });
	        $('#btnCloseEditPw').on('click', function(){
	        	fnEditPwInit();
	        	$('#btnOpenEditPw').show();
	        	$('#editPw').hide();
	        });
	      }
		
		
</script>
</head>
<body>

<h1 align="center"> * M Y P A G E * </h1>
	<div class="">
		<form action="/index.do" method="post">
			<table>
				

				<tr>
					<td>* 비밀번호 변경</td>
					<td><input type="password" name="userPassword" value="${user.userId}"></td>
					
				</tr>
				
				<tr>
					<td>* 전화번호 변경</td>
					<td><input type="text" name="userMobile" value="${user.userMobile}"></td>
				</tr>
				<tr>
					<td>* 우편번호</td>
					<td><input type="text" name="postCode" value="${postCode}" ></td>
					<!-- 배열로 값을 받았다면 ${addreess[0]}으로 표기하여 출력할수 있다-->
				</tr>
				<tr>
					<td>* 주소</td>
					<td><input type="text" name="roadAddress" value="${roadAddress}"></td>
				</tr>
				<tr>
				<td colspan="2" align="center">
			<a href="javascript:fnUpdate()">수정하기</a>
			<a href="javascript:fnLeave()">탈퇴하기</a>
		
			<!-- //type을 button으로 꼭 적어줘야! submit이 되지 않는다!! 꼭 기억하기!
				 -->
				</td>
				</tr>
			</table>
			
		</form>
	</div>

<script>
  function fnUpdate(){
	    if(confirm('회원정보가 수정되었습니다.')){
	    	event.preventDefault();
			  return;
	      location.href = '${contextPath}/user/index.do';
	    }
  }
  
  function fnLeave(){
	    if(confirm('동일한 아이디로 재가입이 불가능합니다. 회원 탈퇴하시겠습니까?')){
	    	event.preventDefault();
			  return;
	      location.href = '${contextPath}/user/leave.do';
	    }
	  }
  
 
  
</script>
</body>
</html>