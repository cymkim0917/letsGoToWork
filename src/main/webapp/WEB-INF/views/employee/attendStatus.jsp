<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LetsGoToWork</title>
	<link href='${ contextPath }/resources/schedulerPackages/core/main.css' rel='stylesheet' />
	<link href='${ contextPath }/resources/schedulerPackages/daygrid/main.css' rel='stylesheet' />
	<link href='${ contextPath }/resources/schedulerPackages/timegrid/main.css' rel='stylesheet' />
	<link href='${ contextPath }/resources/schedulerPackages/list/main.css' rel='stylesheet' />
	<script src='${ contextPath }/resources/schedulerPackages/core/main.js'></script>
	<script src='${ contextPath }/resources/schedulerPackages/moment/main.min.js'></script>
	<script src='${ contextPath }/resources/schedulerPackages/interaction/main.js'></script>
	<script src='${ contextPath }/resources/schedulerPackages/daygrid/main.js'></script>
	<script src='${ contextPath }/resources/schedulerPackages/timegrid/main.js'></script>
	<script src='${ contextPath }/resources/schedulerPackages/list/main.js'></script>
	<script src="${ contextPath }/resources/schedulerPackages/core/locales-all.js"></script>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<script>
		document.addEventListener('DOMContentLoaded', function() {
		  var calendarEl = document.getElementById('calendar');
		  var initialLocaleCode = 'ko';

		  var calendar = new FullCalendar.Calendar(calendarEl, {
			  plugins: [ 'interaction', 'dayGrid', 'timeGrid', 'list'],
		      header: {
		          left: 'prevYear,prev,next,nextYear today',
		          center: 'title',
		          right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
		      },
		      defaultDate: new Date,
		      locale: initialLocaleCode,
		      buttonIcons: false,
		      navLinks: true,
		      selectable: true,
		      businessHours: true,
		      editable: true,
		      eventLimit: true,
		      events: []
		  });

		  calendar.render();
		});
	</script>
<style>
	p{
		font-size:150%;
	    font-weight:bold;
	}

</style>
</head>
	
	
<body>
	<jsp:include page="../common/menubar.jsp"/>
	<div class="row wrap">
		<jsp:include page="../common/sideMenu/employee.jsp"/>
		
		<section class="col-sm-10">
			<h1 class="title">근태현황</h1>
			<button type="button" class="btn btn-primary" onclick="location.href='showAttendStatus.em'">근태현황</button>
			<button type="button" class="btn btn-primary" onclick="location.href='showUpdateAttenStatus.em'">근태 수정 내역</button>
			<hr>
			<div class="content">
				<p>출/퇴근</p>
				<div id="calendar">
				
				
				</div>
				<hr>
				<p>근태 통계</p>
				<table class="table">
					    <thead>
						      <tr class="info">
						        <th>이름</th>
						        <th>소속</th>
						        <th>무단 결근</th>
						        <th>무단 지각</th>
						        <th>미체크</th>
						      </tr>
					    </thead>
					    <tbody>
					      	<tr>
					      		<td>김규형</td>
					      		<td>개발1팀</td>
					      		<td>0회</td>
					      		<td>0회</td>
					      		<td>0회</td>
					      	</tr>
					    </tbody>
				 	 </table>
			</div>
		</section>
	</div>
	
	<jsp:include page="../common/footer.jsp" />
</body>
</html>