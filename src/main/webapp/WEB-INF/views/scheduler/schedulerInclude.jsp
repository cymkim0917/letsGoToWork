<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="${ contextPath }/resources/images/favicon.ico">
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

<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script> -->
<script>
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var initialLocaleCode = 'ko';
    
    calendar = new FullCalendar.Calendar(calendarEl, {
      plugins: [ 'interaction', 'dayGrid', 'timeGrid', 'list'],
      defaultDate: new Date,
      locale: initialLocaleCode,
      buttonIcons: false,
      navLinks: false,
      selectable: true,
      businessHours: true,
      editable: false,
      eventLimit: true,
      events: []
    });

    calendar.render();
  });
</script>
<style>
	#calendar {
	align:center;
	width:95%;
    padding-top:20px;
    padding-right:30px;
  }
</style>
</head>
<body>
	
	<div class="row wrap">
		
		<section>
			<div>
				<div id='calendar'></div>
				
			</div>	
			</section>
			</div>

	
</body>
</html>









































