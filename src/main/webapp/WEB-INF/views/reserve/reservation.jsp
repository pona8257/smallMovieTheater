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

/* 	function fnGetDate(){
		$.ajax({
			type: 'get',
			url: '${contextPath}/movie/date.do',
			dataType: 'json',
			success: function(resData){
				let str = '<nav><ul class="dateGnb">';
				$.each(resData.dateList, function(i, date){
					str += '<li>';
					str += '<a href="#" onclick="fnSearchScreenDate('+ date +')">' + date.slice(6, 8) + '</a>';
				})
				$('#date').append(str);
			}
		})
	}
	
	function fnSearchScreenDate(date){
		$.ajax({
			type: 'get',
			url: '${contextPath}/movie/searchScreenDate.do',
			data: 'date=' + date,
			dataType: 'json',
			success: function(resData){
				let str = '';
				$.each(resData.screenDateMovie, function(i, movie){
					str += '<div>';
					str += '<a href="#" onclick="fnNextPage()" name="screenDateMovie">' + movie.movieDTO.title + '</a>';
				})
				$('#time').html(str);
			}
		})
	} */
	
	
	
	function fnGetMovies(){
		$.ajax({
			type: 'get',
			url: '${contextPath}/movie/getMovieList.do',
			dataType: 'json',
			success: function(resData){
				let str = '';
				$.each(resData.movieList, function(i, movie){
					str += '<div>';
					str += '<a href="#" onclick="fnReserveSelectMovie(\'' + movie.title + '\')">' + movie.title + '</a>';
				})
				$('#movies').append(str);
			}
		})
	}
	
	function fnReserveSelectMovie(title) {
		if(${sessionScope.userId == null}){
			alert('로그인 이후 예매할 수 있습니다.');
			location.href = '${contextPath}/user/login.form';
			return;
		}
		$('#paymentInfo').hide();
		  $.ajax({
		    type: 'get',
		    url: '${contextPath}/movie/reserveSelectMovie.do',
		    data: 'title=' + title,
		    dataType: 'json',
		    success: function(resData) {
		      let str = '';
		      $.each(resData.dateList, function(i, screen){
		    	  let dateStr = screen.screenDate;
		    	  let formattedDate = dateStr.slice(0, 4) + '-' + dateStr.slice(4, 6) + '-' + dateStr.slice(6);
		    	  str += '<div>';
			      str += '<a href="#" onclick="fnReserveSelectTime(\''+screen.movieDTO.title+'\', \''+screen.screenDate+'\', \''+ screen.screenTime +'\')"><strong>' + formattedDate + "&nbsp;&nbsp;&nbsp;" + screen.screenTime + '</strong>' + '&nbsp;&nbsp;&nbsp;' + screen.movieDTO.title + '<br>' + '</a>';
			      $('#time').html(str);
		      })
		    }
		  })
	}
	
	function fnReserveSelectTime(title, date, time) {

		$.ajax({
			type: 'get',
			url: '${contextPath}/movie/reserveSelectTime.do',
			data: 'title=' + title + "&date=" + date + "&time=" + time,
			dataType: 'json',
			success: function(resData){
				var posterPath = resData.data.movieDTO.posterPath;
				var posterName = resData.data.movieDTO.posterName;
				var discountPct = 0.01*resData.data.discountPct;
				var moviePrice = 200000;
				var discountedPrice = moviePrice - moviePrice * discountPct;
				$('#selectMovieTitle').html('<input type="hidden" name="movieId" value="'+resData.data.movieDTO.movieId+'">'+ resData.data.movieDTO.title);
				$('#selectMovieTime').html('<input type="hidden" name="screenDateNo" value="'+resData.data.screenDateNo+'">'+'상영시간 : '+resData.data.screenTime);
				$('#selectMoviePoster').html('<img src="${contextPath}/resources/img/' + posterName + '" style=" width: 200px"/>');
				$('#selectMovieSeat').html('좌석 : -');
				$('#selectMoviePrice').html('<input type="hidden" name="paymentTotalCost" value="'+discountedPrice+'">'+'총 결제금액 : '+discountedPrice);
				$('#paymentInfo').show();
				$('#nextPage').html('<input type="button" value="다음" onclick="fnNextPage(\''+resData.data.movieDTO.movieId+'\', \''+resData.data.screenDateNo +'\')">');
			}
		})
	}
	
	
	
	function fnReset(){	// 리셋 버튼 클릭시 입력 값 초기화
		
	}
	
	function fnNextPage(movieId, screenDateNo){

		$('#nextPage').hide();
		$('#nextPage2').show();
		$.ajax({
			type: 'get',
			url: '${contextPath}/movie/getSeats.do',
			data: 'movieId=' + movieId + '&screenDateNo=' + screenDateNo,
			dataType: 'json',
			success: function(resData) {
				  var str = '';
				  for (let i = 0; i < 5; i++) {
				    str += '<div class="row">';
				    for (let j = 0; j < 5; j++) {
				      if (resData.seatData[i][j] == 1) {
				        str += '<div class="seat">';
				        str += '<input type="button" class="reserved" name="reserved" onclick="fnClickSeat(\'' + (i + 1) + '\', \'' + (j + 1) + '\')" value="' + (j + 1) + '">';
				      } else {
				        str += '<div class="seat">';
				        str += '<input type="button" class="non-reserved" name="non-reserved" onclick="fnClickSeat(\'' + (i + 1) + '\', \'' + (j + 1) + '\')" value="' + (j + 1) + '">';
				      }
				      str += '</div>'; // 닫는 </div> 추가
				    }
				    str += '</div>'; // 닫는 </div> 추가
				  }
				  $('#seats').html(str);
				}
		})
		$('#movieSelectScreen').hide();
		$('#seatSelectScreen').show();
		$('#paymentInfo').hide();
		
	}
	
	function fnClickSeat(row, column){

		$('#paymentInfo').show();
		var str = '<input type="hidden" id="row" name="row" value="'+row+'"><input type="hidden" id="column" name="column" value="'+column+'">좌석 : 행' + '&nbsp;' + row + ', 열' + '&nbsp;' + column;
		$('#selectMovieSeat').html(str);
	}
	
	function fnNextPage2(){

		$('#seatSelectScreen').hide();
		$('#paymentScreen').show();
		$('#nextPage2').hide();
		$('#btnPayment').show();

	}
	
	function handleChange(select){
		var selectVal = select.value;
		if(selectVal == 'kakaoPay'){
			$('#pay').show();
		} else {
			$('#pay').hide();
		}
	}
	
	function requestPay(){
		if(${sessionScope.userId == null}){
			alert('로그인 이후 예매할 수 있습니다.');
			location.href = '${contextPath}/user/login.form';
			return;
		}
	      IMP.init('imp34858868'); //portone 대신 자신의 "가맹점 식별코드"를 사용하시면 됩니다
	      IMP.request_pay({
	         merchant_uid : 'merchant_' + new Date().getTime(),
	         name : '결제테스트',
	         amount : $('input[name="paymentTotalCost"]').val(),
	         buyer_email : 'cs@portone.io',
	         buyer_name : '구매자',
	         buyer_tel : '010-1234-5678',
	         buyer_addr : '서울특별시 강남구 삼성동',
	         buyer_postcode : '123-456'
	      }, function(rsp) {
	         if ( rsp.success ) {
	            fnReserve();
	            alert('결제가 완료되었습니다.');
	            
	         } else {
	            location.href = '${contextPath}/movie/reserve.form';
	            alert('결제에 실패하셨습니다.');
	         }
	      });
	   }
	
	function fnReserve(){
		
		var userNo = $('input[name="userNo"]').val();
		var movieId = $('input[name="movieId"]').val();
		var screenDateNo = $('input[name="screenDateNo"]').val();
		var paymentTotalCost = $('input[name="paymentTotalCost"]').val();
		var row = $('input[name="row"]').val();
		var column = $('input[name="column"]').val();
		var paymentOption = $('select[name="paymentOption"]').val();
		
		$.ajax({
			type: 'post',
			url: '${contextPath}/movie/reservation.do',
			data: { userNo: userNo,
				    movieId: movieId,
				    screenDateNo: screenDateNo,
				    paymentTotalCost: paymentTotalCost,
				    row: row,
				    column: column,
				    paymentOption: paymentOption },
			dataType: 'json',
			success: function(resData){
				alert('예매완료');
				fnReservationInfo();
			}
		})
	}
	
	function fnReservationInfo(){
		$.ajax({
			
		})
	}
	
	$(function(){
		fnReset();
		/* fnGetDate(); */
		fnGetMovies();
		$('#seatSelectScreen').hide();
		$('#paymentScreen').hide();
		$('#paymentInfo').hide();
		$('#btnPayment').hide();
		$('#nextPage2').hide();
		$('#pay').hide();
	})
	
</script>
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
	.location > .home {
		font-size: 20px;
		color: gray;
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
	
	 .dateGnb {
	  height: 40px;
	  display: flex;
	  justify-content: space-evenly;
	  list-style-type: none;
	  border-bottom: #FFF solid 1px;
	  border-top: #FFF solid 1px;
	}
	.dateGnb > li {
	  width: 100px;
	}
	.dateGnb > li > a {
	  width: 100%;
	  height: 100%;
	  text-align: center;
	  line-height: 40px;
	  color: #FFF;
	  text-decoration: none;
	}
	.dateGnb > li > a:hover {
	  border-bottom: 2px solid white;
	}  
	
	a:hover { cursor: pointer; text-decoration: underline; }
	a:visited { color: gray; }
	a { text-decoration: none; font-size: 18px; }
	.selectWrap {
	  display: flex;
	  justify-content: space-between;
	  align-items: center;
	}
	
	.selectMovieWrap, .selectTimeWrap {
	  flex: 1;
	}

	.reserved {
    	pointer-events: none;
    	/* 원하는 스타일을 추가로 지정할 수 있습니다 */
    	opacity: 0.5; /* 클릭할 수 없는 버튼의 투명도를 설정합니다 */
	}
	.row{
		display: flex;
		margin: 0 auto;
	}
</style>
</head>
<body>

	<div class="body">
	
		<div class="header">
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
			<div class="pageUtil">
				<div class="page_innerWrap">
					<div class="location">
						<hr>
						<span class="home">Home</span>
						<a href="${contextPath}/movie/reserve.form" title="예매 페이지로 이동">예매</a>
						<a href="${contextPath}/movie/reserve.form" title="빠른예매 페이지로 이동">빠른예매</a>
					</div>
				</div>
			</div>
		</div>
		<h1>빠른예매</h1>
		<hr>
		
		
		<div id="movieSelectScreen">
<!-- 			<div class="yearWrap">
				<div class="year" id="year"></div>	날짜 선택시 해당일의 상영 목록을 보여준다.
				<div id="date" style="border: 1px solid white;">								

				</div>
			</div> -->
					
			<div class="selectWrap">
				<div class="selctMovieWrap">
					<span>영화</span>
					<div class="movies" id="movies" style="border: 1px solid white;">	<!-- 영화 목록을 보여준다. -->
						
					</div>
				</div>
				<div class="selectTimeWrap">
					<span>시간</span>
					<div class="time" id="time" style="border: 1px solid white;">	<!-- 영화 선택시 상영 시간 목록을 보여준다. -->
						
					</div>
				</div>
			</div>	
		</div>	
			
			
		<div id="seatSelectScreen">	
			
			<div class="seatsWrap" id="seatsWrap">
				<div class="container">
					
					<div>
						<h3>좌석선택</h3>
						<span>관람 인원은 1명입니다.</span>
						<input type="button" value="초기화" onclick="fnReset()">
					</div>
					
					<div class="seat_inner_wrap" id="seats" style="border: 1px solid white;">
						
					</div>
					
				</div>
			</div>
			
		</div>
		
		
		<div id="paymentScreen">
			<div class="paymentWrap" id="paymentWrap">
			
				<div>
					<h3>결제수단선택</h3>
					<div>
						<select name="paymentOption" onchange="handleChange(this)">
							<option> </option>
							<option value="kakaoPay">카카오페이</option>
							<option value="tossPay">토스페이</option>
						</select>
					</div>
					<div>
						
					</div>
				</div>
				
			</div>
		</div>
		
		<div id="paymentInfo" style="border: 1px solid white; width: 350px">
			<form action="${contextPath}/movie/reservation.do">
				<div><input type="hidden" name="userNo" value="${sessionScope.userNo}"></div>
				<div id="selectMovieTitle">
					
				</div>
				<div>
					<div id="selectMovieTime">
					
					</div>
					<div id="selectMoviePoster">
					
					</div>
				</div>
				<div id="selectMovieSeat">
					
				</div>
				<div id="selectMoviePrice">
					
				</div>
				<div id="nextPage">
					<input type="button" value="다음" onclick="fnNextPage()">
				</div>
				<div id="nextPage2">
					<input type="button" id="btnNextPage2" value="다음" onclick="fnNextPage2()">
				</div>
			</form>
				<button style="margin: 0px 20px 0px 20px;" onclick="requestPay()" id="pay">결제하기</button>
		</div>
		
		<div class="footer">
			<footer id="footer">
			
			</footer>
		</div>
		
	</div>
</body>
</html>