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
	
		var attDay = "${attList[0].attendanceDate}";
		
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
		      events: [
		    	  {
		    		  id:'test',
		    		  title:'들어가나요~~~?',
		    		  start:attDay,
		    		  backgroundColor:'red'
		    	  }
		      ]
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
		<fmt:formatDate value="${attList[0].attendanceDate}" pattern="yyyy-MM-dd"/>
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
						        <th><input type="text" value="${attList[0].attendanceDate }" id="start"></th>
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
	
		<%-- $(function(){
			for(int i=0; i<${attList.length}; i++){
				
				var title = '출근 '+ ${attList[i].startTime}  + '퇴근 ' + ${attList[i].endTime}+'('+${attList[i].status}+')';
				var start = ${attList[i].attendanceDate}
				
				var color = if(attList[i].status=='정상'){
						'skyblue';
				}else if(${attList[i].status}=='출근미체크'||${attList[i].status}=='퇴근미체크'){
						'pink';
				}else{
					'red';
				}
			
			var event = {
					title:title,
					start:start,
					backgroundColor:color
			}
		}
		
			console.log(event);
			calendar.addEvent(event);
			
					
					
			
		});
	 --%>
	
</body>
</html>