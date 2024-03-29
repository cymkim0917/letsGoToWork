<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="${ contextPath }/resources/images/favicon.ico">
<style>
#mailTable {
	width: 85%;
	border-collapse: collapse;
	border-top: 2px solid black;
	border-bottom: 2px solid black;
	font-size: 1.2em; 
}
#mailTable tr {
	border-bottom: 1px solid #ddd;
	width : 100%;
}
#mailTable tr:nth-child(4) {
	min-height: 300px;
	
}
#mailTable td {
	padding: 10px;
	text-align: left;
}
#mailTable th {
	text-align:center;
	padding-left: 13px;
	width : 20%;
}
#mailTable td {
	min-width: 10%;
}
input[type=file] {
	display: inline-block !important;
	height: 40px !important;
	width: 350px !important;
	margin-bottom: 8px;
}
.fileSize {
	text-align: right;
}
.btnArea {
	margin-top: 10px;
	margin-bottom: 20px;
	margin-left : 10%;
	font-size : .8em;
}
#detailInfoArea h3 {
	max-width: 80%;
	text-align: center;
	margin: 0 auto 20px;;
}
pre{
	display : block;
	background-color : white !important;
	font-family: 'Noto Sans KR', sans-serif !important;
	font-size : 1em !important;
	max-width : 750px;
	overflow : scroll;
}
#contextArea > *{
	text-align:center;
}
@media (max-width: 1100px) {
	pre{
		max-width : 520px;
		margin : 0;
	}
	.reciveDate{
		width : 80px;
	}
	th{
		width : 30%;
	}
	#mailTable *{
		font-size : 95%;
	}
}
</style>
<title>LetsGoToWork</title>
</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	
	<div class="row wrap">
		<jsp:include page="../common/sideMenu/mail.jsp"/>

		<section class="col-sm-10">
			<div class="content">
				<div class="btnArea" align="left">
					<button class="btn btn-md">답장</button>
					<button class="btn btn-md">전달</button>
					<button class="btn btn-md">삭제</button>
				</div>
				<div id="detailInfoArea">
					<h3 align="center">
						<c:out value="${ mail.mTitle }"/>
						<input type="hidden" name="mailNo" value="${ mail.mailNo }"/>
					</h3>
					<table id="mailTable" align="center">
						<tr>
							<!-- 받은 메일이나 보낸 메일에 따라 다르다. -->
								<th>보낸사람</th>
								<td><c:out value="${ mail.sendMail }"/></td>
								<th rowspan="2" style="border-left: 1px solid #ddd" class="reciveDate">받은날짜</th>
								<td rowspan="2"><c:out value="${ mail.sendDate }"/></td>
						</tr>
						<tr>
							<th>받는사람</th>
							<td><c:out value="${ mail.reciveMail }"/></td>
						</tr>
						<c:if test="${ !empty mail.mailAtt }">
							<tr>
								<th>첨부파일</th>
								<td colspan="3">
									<span onclick="downloadAtt();"	style="cursor:pointer;">
										<c:out value="${ mail.mailAtt.originName }"/>
										<c:out value="${ mail.mSize }"/>
										<input type="hidden" name="attNo" value='<c:out value="${ mail.mailAtt.attNo }"/>'/>
									</span>
	 								<span class="fileSize">
	 								</span>
								</td>
							</tr>
						</c:if>
						<tr>
							<th>내용</th>
							<td colspan="3" id="contentArea">
								<pre>
								${ mail.mContent }
								</pre>
							</td>
						</tr>
					</table>
				</div>
				<div id="reserveArea">		
					<ul class="pager">
					  <li><a href="">이전</a></li>
					  <li sylte="cursor:pointer"><a onclick="goList();">목록으로</a></li>
					  <li><a href="">다음</a></li>
					</ul>
				</div>
			</div>
		</section>
	</div>
	<script>
		// 다운로드 ajax
		function downloadAtt(){
			var attNo = $("[name=attNo]").val();
			console.log("attNo : " + attNo);
			
			$.ajax({
				url : "${ contextPath }/mail/attDownload",
				data : {no : attNo},
				success:function(data){
					console.log(data);
					console.log("성공!");
				}, error:function(data){
					console.dir("error : " + data);
				}
			});
		}
		function goList(){
			window.history.back(location.reload());
		}
		// 시간남으면 뒤로가기 버튼 클릭시  리다이렉트 시키는 처리하기
		// https://blog.urusa.cf/14
	</script>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>