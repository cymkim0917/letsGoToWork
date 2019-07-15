<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<title>LetsGoToWork</title>
<style>
/* 	.boardArea {font-size:150%;} */



</style>

</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>	
	<div class="row wrap">
		<jsp:include page="../common/sideMenu/community.jsp"/>
		
		<section class="col-sm-10">
			<h3 class="title">게시판 만들기</h3>
			
			<div class="content"> 
				<form action="communityInsert.co" method="post"> 
					<table align="center" class="boardArea table" >
						<tr> 
							<td style="background:lightgray;">게시판 종류</td>
							<td>
								<label class="radio-inline"><input type="radio" name="boardType" class="radio" value="공지">공지</label>
								<label class="radio-inline"><input type="radio" name="boardType" class="radio" value="일반">일반</label>
							</td>
						
						</tr>
						<tr height=50px;>
							<td style="background:lightgray;">게시판 이름</td> 
							<td><input type="text" name="boardName" class="form-control"></td>
						</tr>
						<tr>
							<td style="background:lightgray;">게시판 기본 권한</td>
							
							<td>
								<label class="radio-inline"><input type="radio" name="boardAuthority" value="R">읽기</label>
								<label class="radio-inline"><input type="radio" name="boardAuthority" value="W">읽기/쓰기</label>
						 	</td>
						</tr>
						  
							
					
					</table> 
					<div align="center">
						<button type="reset" class="btn btn-default" onclick="location.href='communityInsertCansel.co'">취소</button>
						<button type="submit" class="btn btn-primary">생성</button>
					
					</div>
							
				
				</form>	
			
			
				
			</div>
		</section>
	</div> 

	
	
	
	<jsp:include page="../common/footer.jsp" />
</body>
</html>