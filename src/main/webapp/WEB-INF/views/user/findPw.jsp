<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script>

	
	function fn_findPw(){
		$('#btn_findPw').click(function(){
			new Promise(function(resolve, reject){
				if($('#userId').val() == '' || $('#userEmail').val() == ''){
					reject('아이디와 이메일을 입력하세요.');
					return;
				}
				$.ajax({
					url: '${contextPath}/user/findPw',
					type: 'post',
					contentType: 'application/json',
					data: JSON.stringify({
						'userId': $('#userId').val(),
						'userEmail': $('#userEmail').val()
					}),
					dataType: 'json',
					success: function(resData){
						if(resData.findUser != null){
							resolve(resData.findUser);
						} else {
							reject('일치하는 회원 정보가 없습니다.');
						}
					}
				});		
			}).then(function(findUser){
				$.ajax({
					url: '${contextPath}/user/sendTemporaryPassword',
					type: 'post',
					data: 'userNo=' + findUser.userNo + '&userEmail=' + findUser.userEmail,
					dataType: 'json',
					success: function(resData){
						if(resData.isSuccess){
							alert('등록된 이메일로 임시 비밀번호가 발송되었습니다.');
							location.href = '${contextPath}';
						}
					}
				});
			}).catch(function(msg){
				alert(msg);
			});
		});
	}
	
	$(function(){
		fnFindPw();
	});

</script>
</head>
<body>
	
	<h1>비밀번호 찾기</h1>
	
	<hr>
	
	<div>
		<form id="frmFindPw" method="post" action="${contextPath}/user/findPw">
			<div>
				<label for="userId">
					*아이디<br>
					<input type="text" name="userId" id="userId">
				</label>
			</div>
			
			<div>
				<label for="userEmail">
					*이메일<br>
					<input type="text" name="userEmail" id="userEmail">
				</label>
			</div>
			
			<input type="button" value="임시 비밀번호 발급" id="btn_findPw">
			<br><br>
			
			<div>
				<a href="${contextPath}/user/login.form">로그인</a> |
				<a href="${contextPath}/user/findId.form">아이디 찾기</a> |
				<a href="${contextPath}/user/agree.form">회원가입</a>
			</div>
			
		</form>
	</div>
	
</body>
</html>