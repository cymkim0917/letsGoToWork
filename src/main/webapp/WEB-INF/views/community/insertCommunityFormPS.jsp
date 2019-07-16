<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LetsGoToWork</title>
	<style>
		/* .content{font-size:150%; } */
	
	</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 <link rel="shortcut icon" href="${ contextPath }/resources/images/favicon.ico">
</head>
<body>
	<script type="text/javascript" src="${ contextPath }/resources/ckeditor/ckeditor.js"></script>
	<jsp:include page="../common/menubar.jsp"/>	
	<div class="row wrap">
		<jsp:include page="../common/sideMenu/community.jsp"/>
		
		<section class="col-sm-10">
			<h3 class="title">글작성</h3> 
		
			<div class="content">
					
					
					
					<form method="post" action=""  id="insertPost" encType="multipart/form-data">
							
						
						<label>&nbsp;게시판 종류 :</label>
								
								
								<select id="selectBoard" name="bno">
								<c:forEach var="b" items="${ requestScope.list}">
								   	     <option value='${ b.bno}' selected>${b.boardName}</option>
								   	     
								   	
					   	
					   			
					   			
					   			</c:forEach>
					   			</select>
					   			
					   					<!-- <input type="hidden" name="bno"> --> 

							<table class="table table-striped" >

								<tbody>
													
	
									<tr>
	
										<td colspan="2"><input type="text" class="form-control" placeholder="글 제목" name="btitle" id="selectbtitle" maxlength="50" /></td>
	
								  </tr> 
								  
								  <tr>
										<th width="10%;">첨부파일:</th>
								  		<td><input type="file" name="files"></td>
	  
								  </tr>
								   		
								  	
								</tbody>

							
							</table>
					<div id="signFormArea">
			
					</div>
		
					<div id="area">
						<label>&nbsp;상세 내용</label>
					    <div class="form-group">
					        <div class="form-group">
					            <div class="col-lg-12">
				 	                <textarea name="bcontent" id="ckeditor"></textarea>
					            </div>
					        </div>
					        <div class="form-group">
					            <div class="col-lg-12" align="center">
					            	<button type="button" class="btn btn-md btn-default" name="btn" onclick="temporay()">임시저장</button>
					                <button type="button" class="btn btn-md btn-primary" onclick="insert()">저장</button>
					            </div>
					        </div>
					    </div>
		 		
					</div>
			</form>




			
			
				
			</div>
		</section>
	</div>
	<script>
	$(function(){
		$("#dcmType").change(function(){
			console.log($(this).val());
			console.log($("#area").css("visibility"));
			$("#area").attr('style','visibility:visible');
		});
	});

    $(function(){
        CKEDITOR.replace( 'ckeditor', {//해당 이름으로 된 textarea에 에디터를 적용
            width:'100%',
            height:'400px',
            filebrowserImageUploadUrl: '${ contextPath }/reources/images', //여기 경로로 파일을 전달하여 업로드 시킨다.
            defaultLanguage:'kor'
        });
         
        CKEDITOR.on('dialogDefinition', function( ev ){
            var dialogName = ev.data.name;
            var dialogDefinition = ev.data.definition;
          
            switch (dialogName) {
                case 'image': //Image Properties dialog
                    //dialogDefinition.removeContents('info');
                    dialogDefinition.removeContents('Link');
                    dialogDefinition.removeContents('advanced');
                    break;
            }
        });
         
    }); 
    	
 /* 게시글  Insert  */  
    function insert(){
    	 $("#insertPost").attr("action" ,"${contextPath }/communityPostInsert.co");
    	 $("#insertPost").submit();    	 
    	};
  /* 게시글 임시 저장  Insert    */	
     function temporay(){
    	$("#insertPost").attr("action","${contextPath}/temporayInsert.co"); 
    	$("#insertPost").submit();
     }	
    	
  
    
		
	
	</script>
	
	<jsp:include page="../common/footer.jsp" />
</body>
</html>