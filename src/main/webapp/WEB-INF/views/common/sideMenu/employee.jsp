<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
 
<style>
	.accordionBtn:hover{
		background:rgba(0, 60, 179, .8) !important;
	}
	
	.list{
		font-size:15px !important;
		cursor:pointer;
	}
	.accordionBtn{
		margin-top:5px;
	}
	
</style>

<div id="accordion" class="col-sm-2 sidenav visible-sm visible-md visible-lg">
	<ul>
		<li>
			<button onclick="myFunction('Demo1')" class="accordionBtn">
				인사정보
			</button>
			<div id="Demo1" class="w3-container w3-hide w3-animate-opacity contentSelectArea">
				<ul>
					<li class="list" onclick="location.href='${contextPath}/employee.em'">조직도</li>
					<li class="list" onclick="location.href='${contextPath}/showEmployeeList.em'">직원목록</li>
					<li class="list" onclick="location.href='${contextPath}/showMyPage.em'">내 정보 관리</li>
				</ul>
			</div>
			<button onclick="myFunction('Demo2')" class="accordionBtn">
				휴가/근태
			</button>
			<div id="Demo2" class="w3-container w3-hide w3-animate-opacity contentSelectArea">
				<ul>
					<li class="list" onclick="location.href='${contextPath}/showHolidayApply.em'">휴가 신청</li>
					<li class="list" onclick="location.href='${contextPath}/showHolidayList.em'">휴가 현황</li>
					<li class="list" onclick="location.href='${contextPath}/showAttendStatus.em'">근태 현황</li>
				</ul>
			</div>
			<c:if test="${ sessionScope.loginEmp != null && sessionScope.loginEmp.managerType.equals('인사관리자')}">
			<button onclick="myFunction('Demo3')" class="accordionBtn">
				인사관리
			</button>
			<div id="Demo3" class="w3-container w3-hide w3-animate-opacity contentSelectArea">
				<ul>
					<li class="list" onclick="location.href='${contextPath}/showdeptGroupAdmin.em'">조직관리</li>
					<li class="list" onclick="location.href='${contextPath}/showEmployeeAdmin.em'">사용자 관리</li>
					<li class="list" onclick="location.href='${contextPath}/showlevelCaptain.em'">부서장 관리</li>
					<li class="list" onclick="location.href='${contextPath}/showPrsnlManager.em'">인사관리자</li>
					<li class="list" onclick="location.href='${contextPath}/showLeaveEmpAdmin.em'">휴직자 관리</li>
					<li class="list" onclick="location.href='${contextPath}/showLeaveEmpAdmin.em'">휴직자 관리</li>
				</ul>
			</div>
			<button onclick="myFunction('Demo4')" class="accordionBtn">
				휴가관리
			</button>
			<div id="Demo4" class="w3-container w3-hide w3-animate-opacity contentSelectArea">
				<ul>
					<li class="list" onclick="location.href='${contextPath}/showHolidayApplyAdmin.em'">휴가 생성</li>
					<%-- <li class="list" onclick="location.href='${contextPath}/showHolidayTotal.em'">휴가 관리</li> --%>
				</ul>
			</div>
			<%-- <button onclick="myFunction('Demo5')" class="accordionBtn">
				근태관리
			</button>
			<div id="Demo5" class="w3-container w3-hide w3-animate-opacity contentSelectArea">
				<ul>
					<li class="list" onclick="location.href='${contextPath}/showLeaveEmpAdmin.em'">휴직자 관리</li>
				</ul>
			</div> --%>
			</c:if>
		</li>
	</ul>
	
</div>

<script>
	function myFunction(id) {
		  var x = document.getElementById(id);
		  if (x.className.indexOf("w3-show") == -1) {
		    x.className += " w3-show";
		  } else { 
		    x.className = x.className.replace(" w3-show", "");
		  }
		}
	
</script>