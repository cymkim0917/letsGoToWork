<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LetsGoToWork</title>

<style>
	.head{
		background:lightgray;
		text-align:center;
	}
	#gotoWork{
		background:#b0e3ff !important;
	}
	#gotoWork:hover{
		background:white !important;
		border:1px solid #6b9cff;
		color:#6b9cff;
	}
	
	#dontWork{
		background:orangered !important;
	}
	
	#dontWork:hover{
		background:white !important;
		color:red;
	}
	
	.page{
	  width: 300px
	  display: flex;
	  justify-content: center;
	  margin-left:80%;
	}
	/* add default color for animation start  */
	/* toggle this class */
	.color-bg-start {
	  background-color: salmon;
	}
	
	/* toggle class bg-animate-color */
	
	.bg-animate-color {
	  animation: random-bg .5s linear infinite;
	}
	
	
	/* add animation to bg color  */
	
	@keyframes random-bg {
	  from {
	    filter: hue-rotate(0);
	  }
	  to {
	    filter: hue-rotate(360deg);
	  }
	}
	
	.fun-btn {
	  /* change bg color to get different hues    */
	  background-color: salmon;
	  color: white;
	  padding: 2em 3em;
	  border: none;
	  transition: all .3s ease;
	  border-radius: 5px;
	  letter-spacing: 2px;
	  text-transform: uppercase;
	  outline: none;
	  align-self: center;
	  cursor: pointer;
	  font-weight: bold;
	}
	
	.fun-btn:hover {
	  animation: random-bg .5s linear infinite, grow 1300ms ease infinite;
	}
	
	.start-fun {
	  background-color: #fff !important;
	  /* change color of button text when fun is started   */
	  color: salmon !important;
	}
	
		/* pulsating effect on button */
		@keyframes grow {
		  0% {
		    transform: scale(1);
		  }
		  14% {
		    transform: scale(1.3);
		  }
		  28% {
		    transform: scale(1);
		  }
		  42% {
		    transform: scale(1.3);
		  }
		  70% {
		    transform: scale(1);
		  }
		}
		
		#loginInfoArea{
			float:left;
		}
		input{
			margin:3px;
		}
</style>
</head>
<body>
	<container>
		<c:if test="${ empty loginEmp }">
		<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application" />
		<div align="center" style="padding:120px;">
			<!-- <h1 class="title">LGTW</h1> -->
			<img src="${ contextPath }/resources/images/mainImg.png" width="50%" height="50%">
			<div class="formArea" style="width:500px;">
			<form id="loginForm" action="login.em" method="post">
				<table id="loginTable">
					<tr>
						<td><input type="text" name="empId" placeholder="아이디를 입력하주세요" class="form-control input-lg" value="gora7"/></td>
					</tr>			
					<tr>
						<td><input type="password" name="empPwd" placeholder="비밀번호를 입력해주세요" class="form-control input-lg" value="1234"/><br></td>
					</tr>
					<tr align="center">
						<td><button id="loginBtn" class="btn btn-info btn-lg" type="submit" style="width:100%;">로그인</button></td>
					</tr>
				</table>
				
			</form>
			</div>
		</div>
			
			
			
			<!-- <script>
				$(function(){
					$("#loginBtn").click();
				});
			</script> -->
		</c:if>
		<c:if test="${ !empty loginEmp }">
		<jsp:include page="../common/menubar.jsp" />
			<div class="row">
			<div class="col-sm-1"></div>
				<div class="col-sm-5" align="center" style="margin-right:10px; margin-top:20px;">
				<br>
					<h4>공지사항</h4>
					<table class="table" >
				    <thead>
				      <tr>
				        <th>번호</th>
				        <th>제목</th>
				        <th>작성자</th>
				        <th>작성일자</th>
				      </tr>
				    </thead>
				    <tbody id="boardArea">
				     
				   	 </tbody>
				  </table>
				</div>
				
				<div class="col-sm-5" align="center" style="margin-left:10px; margin-top:20px;">
					<jsp:include page="../scheduler/schedulerInclude.jsp" />
				</div>
				<div class="col-sm-1"></div>
			</div>
			<div class="row" style="margin-top:80px;">
			<div class="col-sm-1"></div>
				<div class="col-sm-5" align="center">
					<label>금일업무</label>
					<table class="table-bordered" style="text-align:center;">
						<tr>
							<th width="100px" height="50px" class="head">결재 대기</th>
							<td width="100px"><a href="${ contextPath }/showWaitDcm.ap" id="wait"></a>건</td>
							<th width="100px" height="50px" class="head">수신 대기</th>
							<td width="100px"><a href="${ contextPath }/showWaitReceptionDcm.ap" id="reception"></a>건</td>
						</tr>
						<tr>
							<th width="100px" height="50px" class="head">회람 대기</th>
							<td width="100px"><a href="${ contextPath }/showWaitCirculationDcm.ap" id="circle"></a>건</td>
							<th width="100px" height="50px" class="head">새메일</th>
							<td width="100px">0건</td>
						</tr>
					</table>
				</div>
				
				<div class="col-sm-5" style="margin-top:30px;" align="center">
				<h4>출/퇴근 합시다</h4>
				<button id="gotoWork" class="btn btn-lg" onclick="goToWork();">출근합시다</button>
			  	<button id="dontWork" class="btn btn-danger btn-lg" onclick="offWork();">퇴근합시다</button>
				</div>
				<div class="col-sm-1"></div>
			</div>
			<%-- <div id="loginInfoArea">
				<h1 align="center">${ loginEmp.empName }님이 로그인한 상태</h1>
			</div>
			<!-- 로그인 적용할때 이거 주석 풀고 main에 include제거하기 -->
			<jsp:forward page="index.jsp"/> 
			<div class="page">
				
			</div> --%>
			
		</c:if>		
	</container>
	
	<script>
		
		var xmlHttp;
	     
		function srvTime(){
	         if (window.XMLHttpRequest) {
	          xmlHttp = new XMLHttpRequest();
	          xmlHttp.open('HEAD',window.location.href.toString(),false);
	          xmlHttp.setRequestHeader("Content-Type", "text/html");
	          xmlHttp.send('');
	          return xmlHttp.getResponseHeader("Date");
	    
	         }else if (window.ActiveXObject) {
	         xmlHttp = new ActiveXObject('Msxml2.XMLHTTP');
	         xmlHttp.open('HEAD', window.location.href.toString(), false);
	         xmlHttp.setRequestHeader("Content-Type", "text/html");
	         xmlHttp.send('');
	         return xmlHttp.getResponseHeader("Date");
	        
	         }
	      }
	      
	      var st = srvTime();
	      var date = new Date(st);
		
	      function goToWork(){
	    	  var empNo = ${loginEmp.empNo};
	    	  var hours = date.getHours();
	    	  var minutes = date.getMinutes();
	    	  var year = date.getFullYear();
	    	    var month = date.getMonth()+1
	    	    var day = date.getDate();
	    	    if(month < 10){
	    	        month = "0"+month;
	    	    }
	    	    if(day < 10){
	    	        day = "0"+day;
	    	    }
	    	 
	    	    var today = year+"-"+month+"-"+day;
	    	    
	    	    console.log(today)
	    	  
	    	  var workTime = hours+":"+minutes;
	    	  
	    	  var workArr = new Array();
	    	  
	    	  workArr.push(empNo);
	    	  workArr.push(workTime);
	    	  workArr.push(today);
	    	  
	    	  var object = {
	    			  workArr:workArr
				}
	    	  $.ajax({
	    		  url:"${contextPath}/employee/goToWork",
	    		  type:"post",
	    		  contentType: 'application/json; charset=utf-8',
	    		  data:JSON.stringify(object),
	    		  success:function(data){
	    			  console.log("성공");
	    			  alert(data);
	    			  window.location.reload();
	    		  },
	    		  error:function(data){
	    			  alert("실패");
	    		  }
	    	  });
	      }
	      
	      function offWork(){
	    	  var empNo = ${loginEmp.empNo};
	    	  var hours = date.getHours();
	    	  var minutes = date.getMinutes();
	    	  var year = date.getFullYear();
	    	    var month = date.getMonth()+1
	    	    var day = date.getDate();
	    	    if(month < 10){
	    	        month = "0"+month;
	    	    }
	    	    if(day < 10){
	    	        day = "0"+day;
	    	    }
	    	 
	    	    var today = year+"-"+month+"-"+day;
	    	    
	    	    console.log('퇴근'+today);
	    	  
	    	  var workTime = hours+":"+minutes;
	    	  var workArr = new Array();
	    	  
	    	  workArr.push(empNo);
	    	  workArr.push(workTime);
	    	  workArr.push(today);
	    	  
	    	  var object = {
	    			  workArr:workArr
				}
	    	  
	    	  $.ajax({
	    		  url:"${contextPath}/employee/offWork",
	    		  type:"post",
	    		  contentType: 'application/json; charset=utf-8',
	    		  data:JSON.stringify(object),
	    		  success:function(data){
	    			  console.log("성공");
	    			  alert(data);
	    			  window.location.reload();
	    		  },
	    		  error:function(data){
	    			  alert("실패");
	    		  }
	    	  });
	    	  
	      }
	      
	      $(function(){
	  		var empNo = ${sessionScope.loginEmp.empNo};
	  		$.ajax({
	  			url:"${contextPath}/approval/selectDcmCount",
	  			type:"get",
	  			data:{empNo:empNo},
	  			success:function(data){
	  				
	  				if(data.wait != null){
	  					$("#wait").append(data.wait);
	  				}
	  				if(data.reception != null){
	  					$("#reception").append(data.reception);
	  				}
	  				if(data.circle != null){
	  					/* var $span6 = $("<span class='badge pull-right badge-pill' style='width:30px; margin-left:-28px; margin-top:17px;'>").append(data.circle); */
	  					$("#circle").append(data.circle);
	  				}

	  				
	  			}
	  		});
	  		
	  		var bno = 1;
	  		$.ajax({
	  			url:"${contextPath}/community/selectBoardContent",
	  			type:"get",
	  			data:{bno:bno},
	  			success:function(data){
	  				for(var i = 0; i < data.length; i++) {
		  				var $tr = $("<tr>");
		  				var $cNoTd = $("<td>" + data[i].contentNO + "</td>");
		  				var $btitleTd = $("<td>" + data[i].btitle + "</td>");
		  				var $createUserNameTd = $("<td>" + data[i].createUserName + "</td>");
		  				var $createDateTd = $("<td>" + data[i].createDate.substring(0, 10) + "</td>");
		  				
		  				$tr.append($cNoTd);
		  				$tr.append($btitleTd);
		  				$tr.append($createUserNameTd);
		  				$tr.append($createDateTd);
		  				
		  				$("#boardArea").append($tr);
	  				}
	  				
	  			}
	  		});

	  		
	  		$.ajax({
				url : "allSelectSchedule/sc",
				type : "get",
				success : function(data) {
					console.log(data.scList);

					for ( var key in data.scList) {
						var id = data.scList[key].scheduleNo;
						
						if (data.scList[key].schedulerList[0].schedulerType == "개인") {
							var title = data.scList[key].scheduleName;
						} else {
							var title = "[GS] " + data.scList[key].scheduleName;
						}
						var startD = data.scList[key].startDate.split(" ");
						var endD = data.scList[key].endDate.split(" ");
						var color = data.scList[key].schedulerList[0].schedulerColor;
						var startT = data.scList[key].startTime;
						var endT = data.scList[key].endTime;
						var type = data.scList[key].schedulerList[0].schedulerType;
						var endDate = new Date(endD[0]);

						if (data.scList[key].schedulerList[0].schedulerType == "공용"
								&& data.scList[key].groupList[0].gmStatus == "N") {

						} else if (data.scList[key].schedulerList[0].schedulerType == "공용"
								&& data.scList[key].groupList[0].authority == "N") {
							if (startT == null) {
								endDate.setDate(endDate.getDate() + 1);
								var event = {
									id : id,
									title : title,
									start : startD[0],
									end : endDate.format("yyyy-MM-dd"),
									color : color,
									classNames : [ type, "수정불가" ]
								}
							} else {
								endDate.setDate(endDate.getDate());
								var event = {
									id : id,
									title : title,
									start : startD[0] + "T" + startT,
									end : endDate.format("yyyy-MM-dd")
											+ "T" + endT,
									color : color,
									classNames : [ type, "수정불가" ]
								}
							}

							console.log(event);
							calendar.addEvent(event);

						} else {
							if (startT == null) {
								endDate.setDate(endDate.getDate() + 1);
								var event = {
									id : id,
									title : title,
									start : startD[0],
									end : endDate.format("yyyy-MM-dd"),
									color : color,
									classNames : [ type ]
								}
							} else {
								endDate.setDate(endDate.getDate());
								var event = {
									id : id,
									title : title,
									start : startD[0] + "T" + startT,
									end : endDate.format("yyyy-MM-dd")
											+ "T" + endT,
									color : color,
									classNames : [ type ]
								}
							}

							console.log(event);
							calendar.addEvent(event);
						}

					}

				}
			});
	  	});
	      Date.prototype.format = function(f) {
	      	    if (!this.valueOf()) return " ";
	      	 
	      	    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
	      	    var d = this;
	      	     
	      	    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
	      	        switch ($1) {
	      	            case "yyyy": return d.getFullYear();
	      	            case "yy": return (d.getFullYear() % 1000).zf(2);
	      	            case "MM": return (d.getMonth() + 1).zf(2);
	      	            case "dd": return d.getDate().zf(2);
	      	            case "E": return weekName[d.getDay()];
	      	            case "HH": return d.getHours().zf(2);
	      	            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
	      	            case "mm": return d.getMinutes().zf(2);
	      	            case "ss": return d.getSeconds().zf(2);
	      	            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
	      	            default: return $1;
	      	        }
	      	    });
	      	};
	      	 
	      	String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
	      	String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
	      	Number.prototype.zf = function(len){return this.toString().zf(len);
	     };
	</script>
</body>
</html>