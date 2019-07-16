<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LetsGoToWork</title>
	<link rel="shortcut icon" href="${ contextPath }/resources/images/favicon.ico">
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
			
		var attDay = "${attList[0].attendanceDate}";
			
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
		      events:[]
		  });
		  calendar.render();
		
		  var result = new Array();
			
			<c:forEach items="${attList}" var="att">
				var json = new Object();
				json.attendanceDate="${att.attendanceDate}";
				json.empNo="${att.empNo}";
				json.startTime = "${att.startTime}";
				json.endTime = "${att.endTime}";
				json.status = "${att.status}";
				result.push(json);
			 </c:forEach>
			 
			 console.log(result.length);
			 
			 var list = new Array();
			 
			 for(var i =0; i<result.length; i++){
				 var color ='';
				 if(result[i].status =='정상'){
					color='skyblue';
				 }else{
					 color='red';
				 }
				 list[i]={id:result[i].empNo,title:'출근'+result[i].startTime+'/'+'퇴근'+result[i].endTime,start:result[i].attendanceDate,backgroundColor:color};
			 } 
			 
			 console.log(list[0]);                 
			 for(var key in list){
				 console.log(list[key]);
				 calendar.addEvent(list[key]);
			 }
		
		
		
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
			<!-- <button type="button" class="btn btn-primary" onclick="location.href='showAttendStatus.em'">근태현황</button>
			<button type="button" class="btn btn-primary" onclick="location.href='showUpdateAttenStatus.em'">근태 수정 내역</button> -->
			<hr>
			<div class="content">
				<p>출/퇴근</p>
				<div id="calendar">
				
				</div>
				<hr>
				
			</div>
		</section>
	</div>
	<jsp:include page="../common/footer.jsp" />
	
</body>
</html>