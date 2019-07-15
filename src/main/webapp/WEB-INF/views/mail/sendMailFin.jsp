<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="${ contextPath }/resources/images/favicon.ico">
<style>
</style>
<title>LetsGoToWork</title>
</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	
	<div class="row wrap">
		<jsp:include page="../common/sideMenu/mail.jsp"/>
		
		<section class="col-sm-10"><br><br>
			<div class="content">
				<div class="sendImg" align="center" width="50%">
					<img src="${ contextPath }/resources/images/mail/sendMail.PNG" width="50%"/>
				</div>
				<h3 class="title" align="center">메일 전송이 완료되었습니다.</h3>
				<table id="sendInfo" align="center" width="50%">
					<tr>
						<th>받는메일</th>
						<td>${ mailDetail.reciveMail }</td>
					</tr>
					<tr>
						<th>보낸 메일</th>
						<td>${ mailDetail.sendMail }</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>${ mailDetail.mTitle }</td>
					</tr>
					<c:if test="${ !empty mailDetail.mailAtt }">
						<tr>
							<th>첨부파일</th>
							<td><c:out value="${ mailDetail.mailAtt.originName }"/></td>
						</tr>
					</c:if>
				</table>
				<div id="btnArea" align="center">
					<button onclick="location.href='${contextPath}/allList.ma'">메일 홈</button>
					<button onclick="location.href='#'">보낸 메일함</button>
				</div>
			</div> <!-- content -->
		</section> 
	</div> <!-- wrap -->
	
	<jsp:include page="../common/footer.jsp" />
</body>
</html>