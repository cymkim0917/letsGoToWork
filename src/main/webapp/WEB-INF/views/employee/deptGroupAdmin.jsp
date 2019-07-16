<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LetsGoToWork</title>
<link rel="shortcut icon" href="${ contextPath }/resources/images/favicon.ico">

<style>
	#download {
		color:#00BFFF;
	}
</style>

</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	<div class="row wrap">
		<jsp:include page="../common/sideMenu/employee.jsp"/>
		
		<section class="col-sm-10">
			<h1 class="title">조직도 관리</h1>
			<hr>
			<div class="content">
				<div style="line-height:2.3em">
						<p>
							오피스에 등록된 조직도 정보를 내려 받아 양식에 맞추어 조직도를 수정 할 수 있습니다. <br>
							양식을 다운로드 받아, 조직도를 편집하세요. 최대 5레벨 까지 만들 수 있습니다.<br>
							<a id="download" href="<c:url value='/deptExcelList.em' />">수정양식(현 조직도)</a> <br>
							 (※ 공백 없이 입력 후 업로드해주세요) 
							<br>
						</p>
					</div>
					
					<form  id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data"method="post" action= "deptUpdateExcelUpload.em">
								<div class="filebox"> 
									<input class="upload-name" type="file" id="excelFile" name="excelFile"> 
								</div>
								<div>
									<button type="submit" id="addExcelImortBtn" class="btn" onclick="check();"><span>추가</span></button> 
								</div>
					</form>
			</div>
		</section>
	</div>
	
	<jsp:include page="../common/footer.jsp" />
	
	<script>
	function check() {

	    var file = $("#excelFile").val();

	    if (file == "" || file == null) {
	    alert("파일을 선택해주세요.");
	    return false;
	    
	    } else if (!checkFileType(file)) {
	    alert("엑셀 파일만 업로드 가능합니다.");

	    return false;
	    }
	    
	  }
	
	</script>
	
</body>
</html>