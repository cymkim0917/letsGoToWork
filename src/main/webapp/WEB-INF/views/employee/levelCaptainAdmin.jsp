<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LetsGoToWork</title>
<style>
	p{
		font-size:150%;
	    font-weight:bold;
	}
	.img-button{
		background:url(resources/images/employee/plus.png) no-repeat;
		border:none;
		width:20px;
		height:20px;
		cursor:pointer;
	}
	.aBtn{
		color:#00BFFF;
	}
	
</style>
</head>
<link rel="shortcut icon" href="${ contextPath }/resources/images/favicon.ico">
<body>
	<jsp:include page="../common/menubar.jsp"/>
	
	<c:set var="deptList" value="${hmap.deptList }"/>
	<c:set var="jobList" value="${hmap.jobList }"/>
	<c:set var="empList" value="${hmap.empList }"/>
	
	<div class="row wrap">
		<jsp:include page="../common/sideMenu/employee.jsp"/>
		
		<section class="col-sm-10">
			<h1 class="title">부서장 관리</h1>
			<hr>
			<div class="content">
				<p>부서장 관리</p>
				<form>
					<table class="table">
						<tr>
							<th>부서</th>
							<th>부서장</th>
							<th>직급</th>
						</tr>
						
						<c:forEach var="dept" items="${deptList }">
								<tr>
									<td><c:out value="${dept.deptName }"></c:out></td>
									<td>
										<c:if test="${dept.managerEmpNo ne 0 }">
											<c:forEach var="emp" items="${empList }">
												<c:if test="${dept.managerEmpNo eq emp.empNo }">
													<strong><c:out value="${emp.empName }"></c:out></strong><a class="aBtn" href="#" onclick="showModal()">(변경)</a>
												</c:if>
											</c:forEach>
										</c:if>
										<c:if test="${dept.managerEmpNo eq 0 }">
											공석   <a class="aBtn" href="#" onclick="showModal()">(부서장 추가)</a>
										</c:if>
									</td>
									<td>
										<c:if test="${dept.managerEmpNo ne 0 }">
											<c:forEach var="emp" items="${empList }">
												<c:if test="${dept.managerEmpNo eq emp.empNo }">
													<c:out value="${emp.jobName }"></c:out>
												</c:if>
											</c:forEach>
										</c:if>
										<c:if test="${dept.managerEmpNo eq 0 }">
											공석 
										</c:if>
									</td>
								</tr>
						</c:forEach>
					</table>
				
				</form>
				
			</div>
				<!-- 모달 -->
					<button type="button" class="btn btn-info btn-lg modalBtn" data-toggle="modal" data-target="#myModal" onclick="selectEmp();" style="display:none">Open Modal</button>
					<div id="myModal" class="modal fade" role="dialog">
					  <div class="modal-dialog">			
					    <!-- Modal content-->
					    <div class="modal-content" style="width:800px;">
					      <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal">&times;</button>
					        <h4 class="modal-title">사원 선택</h4>
					      </div>
					      <div class="modal-body" style="height:500px; width:100%;">
					      	<div id="deptList" class="treeview col-sm-3" style="overflow:auto; height:450px; border:1px solid black">		      
						      <span id="all" onclick="underEmp(this, event);">전체보기</span>			   
					      	</div>
					      	<div class="col-sm-4 form-group">
					      		<select class="form-control" name="empList" size="10" style="overflow: auto; width:100%; height:450px;" multiple>
					      			
					      		</select>
					      	</div>
					
					      	<!-- 수신자 -->
					      	<div class="col-sm-5 signForm" id="circle">
					      		<div class="row">
						      		<div>
						      			<div class="col-sm-2" style="padding-top:170px;">
								      		<button class="btn inout" name="inputCircle" type="button">></button>
								      		<button class="btn inout" name="outputCircle" type="button" style="margin-top:20px"><</button>
						      			</div>
						      			<div class="col-sm-10">
						      				<label class="col-sm-12">사원</label>
								      		<select class="form-control list circleList" name="circleList" size="10" style="width:100%; height:420px;" multiple>
								      			
								      		</select>					      			
						      			</div>		      		
						      		</div>						      	
						      	</div>
					      	</div>
					     </div>
						     <div class="modal-footer">
						     	<button type="button" class="btn btn-default" onclick="insertDeptHead();" data-dismiss="modal">추가하기</button>
			          			<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			          			
			       			 </div>
					  </div>
					      	
		        </div>
		        
		      </div>
			
		</section>
	</div>
	
	<jsp:include page="../common/footer.jsp" />
	
	<script>
	//사원조회
	function selectEmp(){
		$(".signArea").children("input[type='hidden']").remove();
		$(".lab").remove();
		
	    /* $(".signForm").find("select").children().remove(); */
		$("#deptList").children().remove();
		$.ajax({
			url:"${contextPath}/approval/selectEmp",
			type:"get",
			success:function(data){
				console.log("성공");
				var $ul = $("<ul style='padding-left:5px;'>");
				
				for(var i = 0; i < data.deptList.length; i++) {
					if(data.deptList[i].topDept == null){
						var $li = $("<li style='list-style:none' class='dept'><span onclick='underEmp(this, event);' id='" + data.deptList[i].deptCode + "'>" + data.deptList[i].deptName + "</span></li>");
						if(data.deptList[i].stat == 'Y') {
							var $img = $("<img id='" + data.deptList[i].deptCode + "' onclick='underDept(this);' style='width:12px; height:12px;' src='${contextPath}/resources/images/approval/plus.gif'>");					
							$li.prepend($img);
						}
						$ul.append($li);
					} 
				}
				$("#deptList").append($ul);
			}
		});
	}
	
	//팀별 조회
	function underDept(img){
		console.log(img.id);
		
		var deptCode = img.id;
		
		if($("#" + img.id).parent().children().length <= 2) {
			$("#" + img.id).attr("src", "${contextPath}/resources/images/approval/minus.gif");
			$.ajax({
				url:"${contextPath}/approval/selectUnderDept",
				data:{deptCode:deptCode},
				type:"get",
				success:function(data){		
					console.log(data);
					
					var $ul = $("<ul>");
					
					for(var i = 0; i < data.deptList.length; i++) {
						var $li = $("<li style='list-style:none' class='dept'><span onclick='underEmp(this, event);' id='" + data.deptList[i].deptCode + "'>" + data.deptList[i].deptName + "</span></li>");
						if(data.deptList[i].stat == 'Y') {
							var $img = $("<img id='" + data.deptList[i].deptCode + "' onclick='underDept(this);' style='width:12px; height:12px;' src='${contextPath}/resources/images/approval/plus.gif'>");					
							$li.prepend($img);
						}
						$ul.append($li);
					}
					console.log($("#" + img.id).parent());
					$("#" + img.id).parent().append($ul);
				}
			});
			
		}else {
			$("#" + img.id).attr("src", "${contextPath}/resources/images/approval/plus.gif");
			$("#" + img.id).parent().children("ul").remove();
	
		} 
	
		
		
	}
	
	//팀내 사원 조회
	function underEmp(span, event){
		/* event.stopPropagation(); */
		console.log(span.id);
		var deptCode = span.id;
		if(deptCode != 'D') {
			$.ajax({
				url:"${contextPath}/approval/selectUnderDept",
				data:{deptCode:deptCode},
				type:"get",
				success:function(data){		
					console.log(data);
					
					$("select[name='empList']").children().remove();
					
					for(var i = 0; i < data.empList.length; i++) {
						if('${sessionScope.loginEmp.empNo}' != data.empList[i].empNo){
							console.log(data.empList[i].empName);
							var $option = $("<option id='" + data.empList[i].empNo + "' value='" + data.empList[i].empNo + "'>");
							$option.append($("<label>" + data.empList[i].empName + "(" + data.empList[i].deptName + "/ " + data.empList[i].jobName + " )" + "</label>"));
							
							$("select[name='empList']").append($option);
							
						}
					}
				}
			});
			
		}else {
			$.ajax({
				url:"${contextPath}/approval/selectEmp",
				type:"get",
				success:function(data){
					console.log("성공");
					
					for(var i = 0; i < data.empList.length; i++) {
						if('${sessionScope.loginEmp.empNo}' != data.empList[i].empNo){
							console.log(data.empList[i].empName);
							var $option = $("<option id='" + data.empList[i].empNo + "' value='" + data.empList[i].empNo + "'>");
							$option.append($("<label>" + data.empList[i].empName + "(" + data.empList[i].deptName + "/ " + data.empList[i].jobName + " )" + "</label>"));
							
							$("select[name='empList']").append($option);
							
						}
					} 
					
				}
			});
		}

	}
	
	//수신자 영역 추가
	$(".inout").click(function(){
		
		var selectEmp = $("select[name='empList']").val();
		
		console.log($("select[name='empList']").val());

		console.log($(this).text());
		
		var cnt = 0;
		if($(this).text() == '>') {
			$(this).parent().parent().parent().parent().find("select").find("option").each(function(){
				console.log($(this).val());
				for(var i = 0; i < selectEmp.length; i++) {
					if($(this).val() == selectEmp[i]) {
						cnt++;
					}
				}
			});
		}
		
		
		if(cnt <= 0) {
			if($(this).attr("name") == "inputCircle"){
				var circleList = $(this).parent().parent().find("select[name='circleList']");
				console.log($(this).parent().parent().find("select[name='circleList']"));
				
				for(var i = 0; i < selectEmp.length; i++) {
					
					var emp = $("#" + selectEmp[i]).clone();
					
					console.log("들어는 오냐??");
					circleList.append(emp);
				}
				
			}else if($(this).attr("name") == "outputCircle"){
				var deleteEmp = $("select[name='circleList']").val();
				for(var i = 0; i < deleteEmp.length; i++) {
					$("select[name='circleList']").find("option#" + deleteEmp[i]).remove();
				}
			}
		}else {
			alert("중복된 사용자는 추가할 수 없습니다.");
		}
		
		
		
	});
	
	//부서장 추가
	function insertDeptHead(){
		var empArr = new Array();
		var dept = new Array();
		$(".circleList").children().each(function(){
			empArr.push($(this).val());
			dept.push(prompt('부서 이름을 한번 더 입력해주세요'));
		});
			
		var object = {
				empArr:empArr,
				dept:dept
		}
		
		$.ajax({
			url:"${contextPath}/employee/insertDeptHead",
			type:"post",
		    contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(object),
			success:function(data){
				alert("부서장이 추가되었습니다.");
				window.location.reload();
			},
			error:function(data){
				alert("실패");
			}
		});
	}
	
	
	function showModal(){
		$(".modalBtn").click();
	}
	
	function deleteUSer(icon){
		$(icon).parent().remove();
	};
	
	function deleteLeaveEmp(){
		if(confirm("정말로 삭제하시겠습니까?")){
			var empArr = new Array();
			$("input[name='check']").each(function(){
				if($(this).is(":checked") == true) {
					empArr.push($(this).val());
				}
			});
			
			var object = {
					empArr:empArr
			}
			
			$.ajax({
				url:"${contextPath}/employee/deleteLeaveEmp",
				type:"post",
			    contentType: 'application/json; charset=utf-8',
	            data: JSON.stringify(object),
				success:function(data){
					alert(data + "명의 휴직자가 복귀 되었습니다.");
					window.location.reload();
				},
				error:function(data){
					alert("뭐지");
				}
			});
			
								
		}else{
			alert("취소되었습니다.");
		}
	}
	</script>
	
	
	
</body>
</html>

