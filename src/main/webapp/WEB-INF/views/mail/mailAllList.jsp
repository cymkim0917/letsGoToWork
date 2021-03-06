<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>  
<head>                   
<meta charset="UTF-8">
<link rel="shortcut icon" href="${ contextPath }/resources/images/favicon.ico">
<title>LetsGoToWork</title>
<style>
	.listTable [type="checkbox"]{
		width: 15px;
		height : 15px;
	}
	.bottomBtn{
		margin-right: 7%;
	}
	.bottomBtn button{
		padding: 5px 17px;
		margin-left: 15px;
		border: 3px solid rgba(191, 191, 191, 1.0);
		background : rgba(191, 191, 191, 1.0);
		color: white;
		font-weight: bold;
		border-radius: 5px;
	}
	.bottomBtn button:hover{
		background : white;
		color: black;
	}
	.searchArea{
		height : 50px;
		margin-left: 3%;
		margin-bottom : 20px;
	}
	.searchArea *{
		height : 35px !important;;
		margin-right : 10px;
		width : 15% !important;
	}
	.searchArea .serarhValue{
		width: 30% !important;
	}
	.searchArea .searchBtn{
		border: 3px solid lightgray ;
		background : lightgray;
		font-weight : bold;
	}
	.searchBtn:hover{
		background : white;
		font-weight : bold;
		color : black;
	}
	.form-control{
		display: inline-block;
		float : left;
	}
</style>
</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	<c:set var="listType" value="${ listType }"/>
	<input type="hidden" id="listType" value="${ listType }"/>
	<c:set var="mappingUrl" value="allList.ma"/>

	<div class="row wrap">
		<jsp:include page="../common/sideMenu/mail.jsp"/>
		
		<section class="col-sm-10">
		<%-- <button onclick="location.href='${contextPath}/mail/sendFin'">보내기완료 페이지</button> --%><br>
			<div class="content" align="center">
				<form class="searchArea form-group" align="left" action="${ contextPath }/mail/search">
					<input type="hidden" name="listType" value="${ listType }"/>
					<select class="searchType form-control" >
						<option value="sName">이름</option>
						<option value="sEmail">이메일</option>
						<option value="sTitle">제목</option>
						<option value="sContent">내용</option>
					</select> &nbsp;&nbsp;&nbsp;
					<input type="text" name="sName" class="form-control serarhValue"/>&nbsp;
					<input type="submit" value="검색하기" class="form-control searchBtn"/>
				</form>
				<div class="tableArea" align="center">
					<table class="listTable">
						<tr>
							<th width="3%"><input type="checkbox" id="wholeCheck"/></th>
							<th width="8%">읽음여부</th>
							<th width="23%">이름</th>
							<th width="10%">메일종류</th>
							<th>제목</th>
							<th width="12%">날짜</th>
						</tr>
						<c:forEach items="${ list }" var="mail">
							<tr>
								<td><input type="checkbox" name="check"/>
									<input type="hidden" name="mailNo" value="${ mail.mailNo }"/>
								</td>
								<td>
									<c:if test="${ mail.rStatus == 'Y' }">
										<img src="${ contextPath }/resources/images/mail/readMailY.PNG" width="40px">
									</c:if>
									<c:if test="${ mail.rStatus == 'N' }">
										<img src="${ contextPath }/resources/images/mail/readMailN.PNG" width="50px">
									</c:if>
								</td>
								<td>
									<c:if test="${ empty mail.empName }">
										<c:if test="${ mail.sendMail eq loginEmp.email }">
											<!-- 보낸메일일때 받는사람을 나타냄 -->
											<c:out value="${ mail.reciveMail }"/>
										</c:if>
										<c:if test="${ mail.reciveMail  eq loginEmp.email }">
											<!-- 받은 메일일때 보낸 메일을  나타냄 -->
											<c:out value="${ mail.sendMail }"/>
										</c:if>
									</c:if>
									<c:if test="${ !empty mail.empName }">
										<c:out value="${ mail.empName } ${ mail.jobName }/${ mail.deptName }"/><br>
										<c:if test="${ mail.sendMail eq loginEmp.email }">
											(<c:out value="${ mail.reciveMail }"/>)
										</c:if>
										<c:if test="${ mail.reciveMail  eq loginEmp.email }">
											(<c:out value="${ mail.sendMail }"/>)
										</c:if>
									</c:if>
								</td>
								<td>
									<c:if test="${ mail.sendMail eq loginEmp.email }">
										보낸메일
									</c:if>
									<c:if test="${ mail.reciveMail eq loginEmp.email }">
										받은메일
									</c:if>
								</td>
								<td>
									<c:if test="${ !empty mail.mailAtt }"> 
										<span stype="text-align:center">
											<img src="${ contextPath }/resources/images/mail/attachment.png" width="40px;">
										</span>
									</c:if>
									<c:out value="${ mail.mTitle }"/>
								</td>
								<td><c:out value="${ mail.sendDate }"/></td>							
							</tr>
						</c:forEach>
					</table>
					<br>
					<div class="bottomBtn" align="right"> 
						<button onclick="changeStatus('read');">읽음</button>
						<button onclick="changeStatus('delete');">삭제</button>
					</div>
					<button onclick="location.href='${ contextPath }/mail/s3'">s3테스트</button>
					<div class="paging">
						<ul class="pagination">
							<c:if test="${ !empty pi }">
								<c:if test="${ pi.startPage > 1 }">
									<li><a href="${ contextPath }/${ mappingUrl }?listType=${ listType }&currentPage=${ pi.startPage - pi.buttonCount }"><<</a></li>
								</c:if>
								<c:if test="${ pi.startPage <= 1 }">
									<li><a href="#"><<</a></li>
								</c:if>
								<c:if test="${ 1 != pi.currentPage }">
									<li><a href="${ contextPath }/${ mappingUrl }?listType=${ listType }&currentPage=${ pi.currentPage - 1}"><</a></li>
								</c:if>
								<c:if test="${ 1 == pi.currentPage }">
									<li><a href="#"><</a></li>
								</c:if>
								<c:forEach var="pageNum" begin="${ pi.startPage }" end="${ pi.endPage }" step="1">
									<c:if test="${ pageNum == pi.currentPage }">
										<li class="active"><a>${ pageNum }</a></li>
									</c:if>
									<c:if test="${ pageNum != pi.currentPage }">
										<li><a href="${ contextPath }/${ mappingUrl }?listType=${ listType }&currentPage=${ pageNum }">${ pageNum }</a></li>
									</c:if>
								</c:forEach>
								<c:if test="${ pi.currentPage != pi.maxPage }">
									<li><a href="${ contextPath }/${ mappingUrl }?listType=${ listType }&currentPage=${ pi.currentPage + 1 }">></a></li>
								</c:if>
								<c:if test="${ pi.currentPage == pi.maxPage }">
									<li><a href="#">></a></li>
								</c:if>
								<c:if test="${ pi.endPage != pi.maxPage }">
									<li><a href="${ contextPath }/${ mappingUrl }?listType=${ listType }&currentPage=${ pi.endPage + 1 }">>></a></li>
								</c:if>
								<c:if test="${ pi.endPage == pi.maxPage }">
									<li><a href="#">>></a></li>
								</c:if>
							</c:if>
						</ul>
					</div>
				</div>
			</div>
		</section>
	</div>
	<script>
		// 메일 상세 페이지 이동
		$(".listTable").find("tr:not(:nth-child(1)) td:not(:nth-child(1))").click(function(){
			var mailNo = $(this).parent().find("td:nth-child(1) > [name=mailNo]").val();
			location.href='${ contextPath }/mail/detail.ma?mailNo=' + mailNo;
			
			$.ajax({
				url : '${contextPath}/mail/readDetail.ma?mailNo=' + mailNo,
				success :function(data){
					console.log("성공, 결과 : " + data);
				}, complete : function(){
					console.log("complete ");
				}
			});
		});
		
		// 체크박스 전체 선택 및 해제 
		$("#wholeCheck").click(function(){
			if($(this).prop("checked")){
				$("[name=check]").prop("checked", true);
			}else{
				$("[name=check]").prop("checked", false);
			}
		});
		
		// 체크박스 값 변경 
		function changeStatus(type){
			console.log(type);
			checkList = [];
			
			$("input[name=check]:checked").each(function(){
				checkList.push($(this).siblings("[name=mailNo]").val());
			});
			
			var data = {checkList: checkList, type:type};
			console.log(JSON.stringify(data));
			
			console.log("checkList : " + checkList);
			$.ajax({
				url : "${ contextPath }/mail/updateStatus",
				data :  JSON.stringify(data), 
				contentType : "application/json; charset=utf-8",
				type:"POST",
				dataType: "text", // 서버에서 보내줄 타입	
				success:function(data, status, request){
					console.log(request);
					location.href="${contextPath}/${ mappingUrl }?currentPage=${ pi.currentPage }";
				}, error: function(data){
					alert("수정이 실패하셨습니다.");
				}
			});
		}
		
		// searchType name속성값을 상태에 따라 수정 
		$(".searchType").change(function(){
			var optionVal = $(".searchType > option:selected").attr("value");
			// console.log(optionVal);
			$(this).siblings("[type=text]").attr("name", optionVal);
			// console.log($(this).siblings("[type=text]").attr("name"));
		})
		
		// 사이드메뉴 active 설정  
		$(function(){
			$(".sidenav > ul *").removeClass("sidebar-active");
			
			var listType = $("#listType").val();
			console.log(listType);
			if(listType == 'all' || listType == ''){
				$("#all").addClass('sidebar-active');
				$("#all").children("a").addClass("sidebar-active");
			}else if(listType == 'receive'){
				$("#receive").addClass('sidebar-active');
				$("#receive").children("a").addClass("sidebar-active");
			}else if(listType == 'send'){
				$("#send").addClass('sidebar-active');
				$("#send").children("a").addClass("sidebar-active");
			}else if(listType == 'outbox'){
				$("#outbox").addClass('sidebar-active');
				$("#outbox").children("a").addClass("sidebar-active");
			}else if(listType == 'trash'){
				$("#trash").addClass('sidebar-active');
				$("#trash").children("a").addClass("sidebar-active");
			}
		})
		
	</script>
	
	<jsp:include page="../common/footer.jsp" />
</body>
</html>