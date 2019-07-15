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
      header: {
      },
      defaultDate: new Date,
      locale: initialLocaleCode,
      buttonIcons: false,
      navLinks: false,
      selectable: false,
      businessHours: false,
      editable: false,
      eventLimit: false,
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
<!-- <style>
  #calendar {
    max-width: 90%;
    margin: 0 auto;
  }
  .fc-sun{
  	color:red;
  }
  .fc-sat{
  	color:blue;
  }
  .label{
  	margin-top : 5px;
  	width : 2.5em;
  	padding: 2px 1px;
  }
  .label span{
  position: relative;
  	left: -3px;
  	display : block;
  	height : 15px !important;
  	width : 15px !important;
  }
  .c1{
  	background:red;
  }
  .c2{
  	background:orange;
  }
  .c3{
  	background:yellow;
  }
  .c4{
  	background:green;
  }
  .c5{
  	background:blue;
  }
  .c6{
  	background:navy;
  }
  .c7{
  	background:purple;
  }
  .on{
  	border: 2px solid blue; 
  }
  .modal-footer{
  	text-align: center !important;
  } 
  .modal-footer button{
  	background:lightgray;
  	border:1px solid black;
  }
  .modal-body td{
  	padding-top:5px;
  }
  .colorSp {
  	position: relative;
  	/* display : inline-block; */
  	left: -5px;
  	bottom : 2px;
  	height : 10px !important;
  	width : 10px !important;
  } 
  .inout {
  	background:black;
  	color:white;
  	
  }
  body {
  	padding-right:0 !important;
  }
  
</style> -->
</head>
<body>
	
	<div class="row wrap">
		
		<section>
			<div>
				<div id='calendar'></div>
				
			</div>	
			</section>
			</div>

	
	
	
	
	
	<script>
      	$(function(){
      		console.log("온로드 펑션입니다.");
      		$.ajax({
      			url:"allSelectSchedule/sc",
      			type:"get",
      			success:function(data){
      				console.log(data.empScList);
      				console.log(data.gpScList);
      				console.log(data.scList);
      				$("#empScheduler > tbody > tr").remove();
  					var $empScheduler = $("#empScheduler");
  					
  					$("#groupScheduler > tbody > tr").remove();
  					var $groupScheduler = $("#groupScheduler");
  	
      				
      				for(var key in data.scList){
      					var id = data.scList[key].scheduleNo;
      					console.log(data.scList[key].schedulerList[0].schedulerType);
      					if(data.scList[key].schedulerList[0].schedulerType == "개인"){
      						var title = data.scList[key].scheduleName;
      					}else{
      						var title = "[GS] " + data.scList[key].scheduleName;
      					}
      					var startD = data.scList[key].startDate.split(" ");
      					var endD = data.scList[key].endDate.split(" ");
      					var color = data.scList[key].schedulerList[0].schedulerColor;
      					console.log(startD);
      					var startT = data.scList[key].startTime;
      					var endT = data.scList[key].endTime;
      					var type = data.scList[key].schedulerList[0].schedulerType;
      					console.log(type);
      					var endDate = new Date(endD[0]);
      					
      					if(data.scList[key].schedulerList[0].schedulerType == "공용" && 
      							data.scList[key].groupList[0].gmStatus == "N"){
      						
      					}else if(data.scList[key].schedulerList[0].schedulerType == "공용" &&
      							data.scList[key].groupList[0].authority == "N"){
      						if(startT == null){
	      						endDate.setDate(endDate.getDate() + 1);
	      						var event = {
	          							id:id,
	          							title:title,
	          							start:startD[0],
	          							end:endDate.format("yyyy-MM-dd"),
	          							color:color,
	          							classNames:[type, "수정불가"]
	          					}
	      					}else{
	      						endDate.setDate(endDate.getDate());
	      						var event = {
	          							id:id,
	          							title:title,
	          							start:startD[0] + "T" + startT,
	          							end:endDate.format("yyyy-MM-dd") + "T" + endT,
	          							color:color,
	          							classNames:[type, "수정불가"]
	          					}
	      					}
      						
      						console.log(event);
          					calendar.addEvent(event);
          					
      					}else{
      						if(startT == null){
	      						endDate.setDate(endDate.getDate() + 1);
	      						var event = {
	          							id:id,
	          							title:title,
	          							start:startD[0],
	          							end:endDate.format("yyyy-MM-dd"),
	          							color:color,
	          							classNames:[type]
	          					}
	      					}else{
	      						endDate.setDate(endDate.getDate());
	      						var event = {
	          							id:id,
	          							title:title,
	          							start:startD[0] + "T" + startT,
	          							end:endDate.format("yyyy-MM-dd") + "T" + endT,
	          							color:color,
	          							classNames:[type]
	          					}
	      					}
      						
      						console.log(event);
          					calendar.addEvent(event);
      					}
      					
      					
      				}
      				
      				
      			}
      		});
      	});
      	
      
	</script>
	
	
</body>
</html>









































