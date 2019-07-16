<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LetsGoToWork</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
   
   
   
<!--    <style>
      .content{font-size:150%; }
   
   </style> -->


</head>
<body>
   <jsp:include page="../common/menubar.jsp"/>   
   <div class="row wrap">
      <jsp:include page="../common/sideMenu/community.jsp"/>
      
      <section class="col-sm-10">
         <h1 class="title"></h1>
         
         <div class="content">
            
               <%-- <c:if test="${c.status eq 'N'}">  --%>
               <button type="button" class="btn btn-default btn-md" data-toggle="modal" style="float:right; margin-left:5px; margin-bottom:15px;"  data-target="#myModal">삭제</button>
               <button type="button" class="btn btn-primary btn-md" style="float:right;" name="updateBtn" >수정</button>
               <%-- </c:if> --%>
            <div>   
                  <table class="table table-striped" style="margin-top:15px;">   
                              
                     <c:forEach var="c" items="${list }">  
                             <input id="bnohidden" type="hidden" name="bno" value="${c.bno }">     
                             <input id="contentNOHidden" type="hidden" name="bno" value="${c.contentNO }">  
                      <thead>
                           <tr>
                              <th><h4><label>제목 : </label>${c.btitle}</h4></th>       
                           </tr>
                                      
                             <tr>
                          	    <td width="10%;"><label>첨부파일:</label> <a href="${ contextPath }/communityDownloadFile.co?contentNO=${ c.contentNO }"> ${ ca.originName }</a></td>
                             </tr>
                            
                           <tr>
                  				
                              <td height="500px">
                              	<h5><label>내용 : </label></h5>
                                    <div style="margin-left:10px; ">
                                          ${c.bcontent}
                                    </div>
                              </td>
                
                            </tr> 
                                 
                        </thead>
                        
                        
                        </c:forEach>
                      </table>
                     
                     
                     
                     
                     
                     
                                                
                     
                    </div>
               
                
                <br>
                <div>
                <c:forEach var="c" items="${list }">  
                   <%-- <c:if test="${c.status eq 'N'}"> --%> 
                   <table class="table table-striped"  >
                    <thead>
                      <tr> 
                         <th>작성자</th>
                         <th>댓글 내용</th>
                         <th></th>
                         <!-- <th></th>  -->   
                      </tr> 
                      <%-- <c:forEach var="cc" items="${commentlist }"> --%>
                      <tr> 
                      <c:if test="${!empty sessionScope.loginEmp.empNo}">
               
                      
                         <td>${sessionScope.loginEmp.empName}</td>
                         <td><textarea id="ccontent" style="width:100%; height:auto; resize:none"></textarea></td>
                         <td><button type="button" class="btn btn-info btn-md" id="addReply">생성</button></td>
                      
                      </c:if>
                      </tr>
                      <%-- </c:forEach> --%>
                   
                      
               <%--        
                      <tr><th>댓글</th></tr>
                      <tr>  
                      <c:forEach var="cc" items="${commentlist }">
                      <c:if test="${empty sessionScope.loginEmp || !empty sessionScope.loginEmp.empNo}"> 
                         <tr id="replyTr">  
                         <td width=10%><input type="hidden" value="${cc.cwriter }">${cc.empname}</td>
                               
           
                         <td  id="replyList" > ${cc.ccontent} </td>
                         
         
                         <td  id="updateReply" style="display:none"><input type="text" value="${cc.ccontent}"> </td>
                        
                          
                         <c:if test="${sessionScope.loginEmp.empNo eq cc.cwriter}">
                         <td><input type="hidden" value="${cc.cno}">
                            <button type="button" class="btn btn-info btn-lg" onclick="updateBtn(this)" id="updateBtn">수정</button>
                            <button type="button" class="btn btn-info btn-lg" name="deleteReply" onclick="sendAndDelete(this)">삭제</button> 
                            <!-- <button type="button" class="btn btn-info btn-lg" style="display:none" onclick="">취소</button> --> 
                            
                         </td>
                         </c:if>
                         
                         </tr>
                      
                      </c:if>
                         
                        
                         <c:if test="${sessionScope.loginEmp.empNo eq cc.cwriter }"> 
                         <tr><th>댓글 수정</th></tr>
                         <tr>
                         <td>${sessionScope.loginEmp.empName}</td> 
                         <td><input type="text" value="${cc.ccontent}"></td> 
                         
                         <td>
                            <input type="hidden" value="${cc.cno}">
                            <button type="button" class="btn btn-info btn-lg" name="updateReply">수정</button>
                            <button type="button" class="btn btn-info btn-lg" name="deleteReply">삭제</button>
                         </td>
                         </tr>
                         </c:if> 
                         
                       
                       </c:forEach>
                       </tr>  --%>  
                        
                </thead>   
            </table>
           <%--  </c:if> --%>
           			 </c:forEach> 
            
            
            <table id="replyTable" class="table table-striped">
            
            
            </table>
           </div>
           
           
           <div class="modal fade" id="myModal" role="dialog">
                     <div class="modal-dialog">
                      <div class="modal-content">
                          <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">게시판 삭제</h4>
                          </div>
                          <div class="modal-body">
                            <p>게시글을 삭제 할까요 ?</p>
                          </div>
                          <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal" name="deleteBtn">확인</button>
                             <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                        </div>
                     </div>
                                       
                  </div>
               </div>
              
           
            
        	 </div>
     		 <div class="paging"   align="center" >
						<ul class="pagination">
							<li><a href="#"><</a></li>
							<li><a href="#">1</a></li>
							<li><a href="#">2</a></li>
							<li><a href="#">3</a></li>
							<li><a href="#">4</a></li>
							<li><a href="#">5</a></li>
							<li><a href="#">></a></li>
						</ul>
			</div>
      	</section>
   </div>
   
   <jsp:include page="../common/footer.jsp"/>
  
 
 
 
 <script>
 
 	$(document).ready(function(){
 		listReply("1");
 	})
 	 
 	function listReply(num){
 		var contentno =$("#contentNOHidden").val(); 
 		
 		/* console.log (num);  */
 		console.log(contentno); 
 		
 		$.ajax({
 			type:"get",
 			url:"${contextPath}/commentList.co",
 			data:{curPage:num,contentno:contentno},		
 			success:function(data){ 
 			console.log(data); 
 			
 			createCommentList(data.list);
 			createPaging(data.pi);
 			
 			
 				
 			}
 		
 		}); 
 		
	
 		
 	} 
 	
 	function createCommentList(commentInfo){
 	console.log(commentInfo);
 	
 	var $replyTable = $("#replyTable");
 	
 	$("#replyTable").children().remove();
 		for (var i= 0 ; i<commentInfo.length; i++){
 							
 			var $replyTd = $("<tr>");
 			var $nameTd = $("<td>").text(commentInfo[i].empname);
 			var $contentTd = $("<td>").text(commentInfo[i].ccontent).attr({"id":"replyList"});
 			var $hiddencontent = $("<input>").attr({"type":"hidden"}).val(commentInfo[i].ccontent);
 			var $hiddencno = $("<input>").attr({"type":"hidden"}).val(commentInfo[i].cno);
 			var loginEmpno =${sessionScope.loginEmp.empNo} 
 			
 			var $updateBtn = $("<button>").text("수정")
 								.attr({"class":"btn btn-primary btn-md","onclick":"updateBtn(this)","id":"updateBtn"});
 			var $deleteBtn = $("<button>").text("삭제")
 			                   .attr({"class":"btn btn-default btn-md","onclick":"sendAndDelete(this)","name":"deleteReply"});
 			
 	
 			var $updateBtnTd = $("<td>").append($hiddencno).append($hiddencontent).append($updateBtn).append($deleteBtn); 
 		   
 			
 			
 			
 		
 			
 		
 			
 			if(loginEmpno == commentInfo[i].cwriter){
 				
		 			console.log($updateBtnTd); 
		 			
		 			$replyTd.append($nameTd);
		 			$replyTd.append($contentTd);
		 			
		 			$replyTd.append($updateBtnTd);
		 			/* $replyTd.append($deleteBtnTd); */
		 			$replyTable.append($replyTd);
 			}
 			else
 			{
	 				/* console.log($updateBtnTd); */ 
	 	 			$replyTd.append($nameTd);
	 	 			$replyTd.append($contentTd);
	 	 			$replyTable.append($replyTd);	
 			}
 			
 				
 			
 			
 			
 			 
 			
 			
 			
 		}
 	}
 	
 	
function createPaging(pageInfo){
		
		var $pagination = $(".pagination");
		$pagination.empty();
		
		var currentPage = pageInfo.currentPage;
		var startPage = pageInfo.startPage;
		var endPage = pageInfo.endPage;
		var limit = pageInfo.limit;
		var maxPage = pageInfo.maxPage;
		
			$pagination.append($("<li>").append($("<a>").text("<<")).css("cursor","pointer").click(function(){	
				listReply(1);
			}));
		   	   
			if(currentPage <= 1) { 
				$pagination.append($("<li>").append($("<a>").text("<")).attr("disabled",true).css("cursor","pointer"));
			}else{ 
				$pagination.append($("<li>").append($("<a>").text("<")).css("cursor","pointer").click(function(){
					listReply(currentPage - 1);
				}));

			 } 
			 for(var p= startPage; p <= endPage; p++){
				if(p == currentPage){
				$pagination.append($("<li>").append($("<a>").text(p)).attr("disabled",true));
			 }else{ 
				$pagination.append($("<li>").append($("<a>").text(p)).css("cursor","pointer").click(function(){
					listReply($(this).children().text());
				}));
			 }
				
			 } 
			 if(currentPage >= maxPage){ 
				 $pagination.append($("<li>").append($("<a>").text(">")).attr("disabled",true).css("cursor","pointer"));					
			 }else {
				 $pagination.append($("<li>").append($("<a>").text(">")).css("cursor","pointer").click(function(){
					 viewMessage(currentPage + 1,messageType,startDate,endDate,searchValue,searchCondition);
				 }));
			 } 
			 	$pagination.append($("<li>").append($("<a>").text(">>")).css("cursor","pointer").click(function(){
			 		viewMessage(endPage,messageType,startDate,endDate,searchValue,searchCondition);
			 	}));
		
	}

 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 
 
 
 
 </script>  
 
  
   <script>
   // 게시판 수정
         $("button[name='updateBtn']").click(function(){
            var contentno = $("#contentNOHidden").val();
            
            console.log(contentno);
            
             location.href= "communityPostUpdateForm.co?contentno="+contentno;  
         }); 
         
        
   //게시판 삭제
    $("button[name='deleteBtn']").click(function(){
            var contentno = $("#contentNOHidden").val();
            var bno = $("#bnohidden").val();
            console.log(contentno);
            
            location.href ="communityPostDelete.co?contentno="+contentno+"&bno="+bno;
         });
         
         
         
       /* 댓글생성  */
         $(function(){
           $("#addReply").click(function(){
              var writer = ${sessionScope.loginEmp.empNo}; 
              var contentno = $("#contentNOHidden").val(); 
               /*  console.log(contentno); */
               /*  console.log(writer); */ 
                var ccontent  = $("#ccontent").val();
                
               /* console.log(ccontent); */ 
               
               $.ajax({
                  url:"insertComment.co" ,  
                   data:{writer:writer,contentno:contentno ,ccontent:ccontent},
                   type:"post",
                   success:function(date){
                      if(date == "ok"){
                         alert("댓글 작성이 완료 되었습니다.");
                         location.href='communityPostDetails.co?contentNO='+contentno;
                      }else{
                         console.log("FAIL");
                      }
                   }
               
               })
               
               
               
           })   
            
            
         }) ;
         $("button[name='updateReply']").click(function(){
            var cno = $(this).parent().children().eq(0).val();
             var ccontent = $(this).parents().prev().children().val();
             var contentno = $("#contentNOHidden").val();
             
             console.log(cno);
             console.log(ccontent);
            
               $.ajax({
                  url:"updateComment.co", 
                  data:{cno:cno,ccontent:ccontent ,contentno:contentno} , 
                  type:"post",
                  success:function(date){
                     if(date="ok"){
                        alert("댓글 수정 완료 되었습니다"); 
                        location.href='communityPostDetails.co?contentNO='+contentno; 
                     }
                     
                  }
                     
               })
            
         });
         
           
            
            
         //수정 폼
         function updateBtn(updateBtn){
        	var inputArea = $(updateBtn).parent().siblings("#replyList");
        	console.log(inputArea);
        	
        	
        	
        	 if($(updateBtn).text() == '수정'){ 
        		 inputArea.text(""); 
        		 inputArea.append($("<textarea>").css({"width":"100%","height":"auto","resize":"none"}).val(inputArea.next().children().eq(1).val()));
        		 $(updateBtn).text("취소");
        		 $(updateBtn).next().text("전송");
        	} else{
        		inputArea.empty();
        		inputArea.text(inputArea.next().children().eq(1).val());
        		$(updateBtn).text("수정");
        		$(updateBtn).next().text("삭제");
        	}
        	 
         };
         
         function sendAndDelete(sendAndDelete){
        	 
        	 if($(sendAndDelete).text() == '전송'){
        	  var cno =$(sendAndDelete).parent().children("input").val(); 
        	  var writer = $(sendAndDelete).parents("tr").children("td").eq(0).children("input").val();
        	  var ccontent = $(sendAndDelete).parent().siblings("#replyList").children().val();
        	  var contentno = $("#contentNOHidden").val();
        	  /* console.log(writer); */
        	  	/* console.log(contentno); */ 
        	  console.log('수정 : ' + cno);
        	  	 $.ajax({
                    url:"updateComment.co", 
                    data:{cno:cno,ccontent:ccontent,contentno:contentno} , 
                    type:"post",
                    success:function(date){
                       if(date="ok"){
                          alert("댓글 수정 완료 되었습니다"); 
                			 location.href='communityPostDetails.co?contentNO='+contentno;  
                       }
                       
                    }
                       
                 });
              	 
        	 }else{
        		 delReply(); 
        	 }
        	 
         }
      	function delReply(){
      		 var cno = $("button[name='deleteReply']").parent().children().eq(0).val(); 
             var contentno = $("#contentNOHidden").val();
             
             
              console.log('삭제 : ' + cno);
             /*  console.log(contentno); */ 
             
             $.ajax({
                url:"deleteReply.co",
                data:{cno:cno,contentno:contentno} ,
                type:"post",
                success:function(data){
                   if(data="ok"){
                      alert("댓글 삭제 완료 되었습니다"); 
                         location.href='communityPostDetails.co?contentNO='+contentno; 
                   }
                }
                
                
             })
      	}
         
      
         
         
         
         
      </script>
 
 
 
 

</body>
</html>