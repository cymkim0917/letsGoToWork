<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LetsGoToWork</title>
<style>
	#sel1{
		width:15%;
		height:10%;
		font-size:150%;
	}
	#sel2{
		width:10%;
	}
	.cancle {
		color:#00BFFF;
	}
	
	.all_absence .month.ta_l{
		font-size: 22px;
	}
	
	.Clearfix{
		zoom:1;
	}
	
	.all_absence .month button, .conduct .month button{
		display: inline;
		margin-right: 6px;
		vertical-align: middle;
	}
	
	.icon.directleft{
		width: 25px;
	    height: 25px;
	    background-position: -297px -38px;
	}
	
	.all_absence .month p, .conduct .month p{
		display: inline;
	    margin-right: 6px;
	    vertical-align: middle;
	}
	
	.icon.directright{
		width: 25px;
	    height: 25px;
	    background-position: -324px -38px;
	}
	
	.icon{
		background: url(${contextPath}/resources/images/employee/insa_icon.png) 0 0 no-repeat;
	}
	button{
		border : 0 none;
	}
	
	.pdb_0{
		padding-bottom: 0!important;
	}
	
	.pdt_10{
		padding-top: 10px!important;
	}
	
	.select_u_insa{
		float: left;
	    color: #2985db;
	    padding-bottom: 10px;
	}
	
	.fr{
		float: right!important;
	}
	
	.select_u_insa>a{
		color: #2985db;
	}
	
	a{
		text-decoration:none;
	}
	
	.dropdown{
		position: relative;
    	color: #676767;
	}
	
	.cont_hidden:after{
		content: "";
	    display: block;
	    visibility: hidden;
	    clear: both;
	}
	
	.Clearfix:after {
	    display: block;
	    visibility: hidden;
	    clear: both;
	    content: '';
	}
	
	.Fl{
		float: left !important;
	}
	
	.hide {
    	display: none;
	}
	
	.insa_search .search {
	    position: relative;
	    width: 250px;
	    height: 30px;
	    border: 1px #c0c5ca solid;
	    border-radius: 15px;
	}
	
	fieldset, img{
		border:0 none !important; 
	}
	
	.insa_search .search input[type="text"] {
	    float: left;
	    width: 170px;
	    border: 0;
	    margin: 1px 1px 1px 9px;
	    padding: 4px 4px 4px 0;
	    color: #999;
	    vertical-align: top;
	    line-height: 19px;
	    height: 19px;
	    outline: none;
	    color: #000;
	}
	
	.insa_search .btn_search {
	    float: right;
	    margin: 0px 8px 0 0;
	}
	
	.icon.src {
	    display: inline-block;
	    width: 14px;
	    height: 14px;
	    background-position: -233px -20px;
	}
	
	.blind {
	    display: block;
	    overflow: hidden;
	    position: absolute;
	    top: 0;
	    left: 0;
	    width: 0;
	    height: 0;
	    border: 0;
	    background: 0;
	    font-size: 0;
	    line-height: 0;
	}
	
	.mgr_10 {
	    margin-right: 10px;
	}
	
	.dropdown-menu {
	    position: absolute;
	    top: 100%;
	    left: 0;
	    float: left;
	    min-width: 130px;
	    padding: 12px 0;
	    margin: 6px 0 0;
	    font-size: 14px;
	    background-color: #fff;
	    border: 1px solid #999;
	    z-index: 110;
	}
	.dropdown {
	    position: relative;
	}
	
	ul {
	    display: block;
	    list-style-type: disc;
	    margin-block-start: 1em;
	    margin-block-end: 1em;
	    margin-inline-start: 0px;
	    margin-inline-end: 0px;
	    padding-inline-start: 40px;
	}
	
	.dropdown-menu .active>a{
		background-color: #e8ecee !important;
	}
	
	.dropdown-menu>li>a{
		position: relative;
	    display: block;
	    padding: 5px 15px;
	    clear: both;
	    font-weight: 400;
	    line-height: 1.428571429;
	    white-space: nowrap;
	}

	.table>thead>tr.info>th{
		background-color:#f3f3f3 !important;
	}
	
	.tabType1 {
	    width: 100%;
	    overflow: hidden;
	    background: #f3f3f3;
	}
	
	ul{
		list-style:none;
	}
	
	.tabType1 li{
		float: left;
	    margin: 5px 8px 0;
	    padding: 4px 12px;
	    text-align: center;
	}
	
	.tabType-tax li.on a, .tabType1 li.on a {
   		font-weight: 700;
    }
    
    .tabType-tax li.on, .tabType1 li.on {
    	background: #fff;
	}
	
	.setting_title {
	    position: relative;
	    padding: 20px 25px 0 23px;
	    min-width: 733px;
	    height: 60px;
	    border-bottom:1px solid #f2f4f3;
	}
	
	.setting_title h3 {
	    color: #333;
	    font-size: 16px;
	}
	
	.setting_field {
    	padding: 30px 25px 0;
	}

	.pdb_20 {
    	padding-bottom: 20px!important;	
	}
	
	.tableType02 {
	    width: 100%;
	    border-top: 1px solid #cdcdcd;
	}
	
	.layer_box table caption {
    	display: none;
	}
	
	.tableType02 th.bdr_1 {
    	border-right: 1px solid #dedede;
	}
	
	.tableType02 th {
	    padding: 14px 14px;
	    border-bottom: 1px solid #dedede;
	    background: #f9f9f9;
	    color: #333;
	    font-weight: 400;
	}
	
	.tableType02 .center {
	    padding-left: 0;
	    text-align: center;
	}
	
	.tableType02 td {
	    padding: 12px 0 12px 14px;
	    border-bottom: 1px solid #dedede;
	}
	
	.tblf {
	    table-layout: fixed;
	}
	
	.ta_c {
	    text-align: center!important;
	}
	
	.layer_button {
    	margin-top: 70px;
     	line-height: 19px; 
   		text-align: center;
	}
	.layer_button button {
	    padding: 5px 27px 6px;
	    color: #444;
	    letter-spacing: -1px;
	    border: 1px solid #dadada;
	    background: #dadada;
	}
	
	.icon.btn_closelayer {
	    position: absolute;
	    top: 10px;
	    right: 10px;
	    width: 17px;
	    height: 16px;
	    background-position: -281px 0;
	}
	
	.tableType02 td.bdr_1 {
	    border-right: 1px solid #dedede;
	}
	
	.layer_box {
	    position: fixed;
	    top: 50%;
	    left: 50%;
	    z-index: 1010;
	    border: 1px solid #8d8d8d;
	    background: #fff;
	}
	
	caption {
	    overflow: hidden;
	    width: 0;
	    height: 0;
	    font-size: 0;
	    line-height: 0;
	}
	
	body, button, input, select, td, textarea, th {
	    font-size: 14px;
	    font-family: '맑은 고딕','Malgun Gothic',dotum,sans-serif;
	    color: #676767;
	}
	a{
		text-decoration:none !important;
	}

</style>
</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	<div class="row wrap">
		<jsp:include page="../common/sideMenu/employee.jsp"/>
		
		<section class="col-sm-10">
			<div class="setting_title">
				<h3>휴가 현황</h3>
			</div>
			
			<div class="setting_field">
			<ul class="tabType1">
                    <li>
                        <a href="javascript:void(0)" onclick="location.href='showHolidayList.em'">내 휴가</a>
                    </li>
                    <li class="on">
                    	<a href="javascript:void(0)" onclick="location.href='showHolidayAdmin.em'">휴가신청관리</a>
                    </li>
            </ul>
            
			<!-- <button type="button" class="btn btn-primary" onclick="location.href='showHolidayList.em'">내 휴가</button> -->
			<!-- <button type="button" class="btn btn-primary" onclick="location.href='showHoliCalender.em'">휴가 캘린더</button> -->
			<!-- <button type="button" class="btn btn-primary" onclick="location.href='showHolidayAdmin.em'">휴가 신청관리</button> -->
			<div class="content">
				<div class="all_absence after pdt_0 Clearfix">
                        <div class="month pdb_30 ta_l Fl">
                            <!-- <button title="연도 이동" class="icon monthTo1" type="button"></button> -->
                            <button title="월 이동" class="icon directleft" type="button" onclick="changeDate('L')"></button>
                            <p id="tab3_date"></p>
                            <button title="월 이동" class="icon directright" type="button" onclick="changeDate('R')"></button>
                            <!-- <button title="연도 이동" class="icon monthTo4" type="button"></button> -->
                        </div>
                    </div>
				<br>
					<div class="pdt_10 pdb_0 cont_hidden">
						<div class="select_u_insa">
							보기:
                        </div>
						<div class="select_u_insa">
							<a href="javascript:void(0)" class="layerShow"><span id="filter_type_name">전체</span> <img src="${contextPath}/resources/images/employee/btn_drop.gif" alt="모두보기" class="open_drop mgr_20"></a>
                            <div class="dropdown" style="display: none">
                                <ul class="dropdown-menu block" style="top:4px;left:inherit">
                                	<li class="active"><a href="javascript:void(0)" onclick="changeholiType('전체')">전체</a></li>
                                	                                	<li><a href="javascript:void(0)" onclick="changeholiType('연차')">연차</a></li>
                                	                                	<li><a href="javascript:void(0)" onclick="changeholiType('훈련')">훈련</a></li>
                                	                                	<li><a href="javascript:void(0)" onclick="changeholiType('교육')">교육</a></li>
                                	                                	<li><a href="javascript:void(0)" onclick="changeholiType('경조사')">경조사</a></li>
                                	                                	<li><a href="javascript:void(0)" onclick="changeholiType('병가')">병가</a></li>
                                	                                	<li><a href="javascript:void(0)" onclick="changeholiType('출산')">출산</a></li>
                                	                                	<li><a href="javascript:void(0)" onclick="changeholiType('무급')">무급</a></li>
                                	                                </ul>
                            </div>
                        </div>

						<div class="fr">
							<a href="javascript:void(0)" id="btn_search_undo" class="search_bt Fl hide" style="margin:6px 10px 0 0;" onclick="vRegistManage.cancelSearchName()"><span class="sp_menu searchCancel"></span>검색 취소</a>
							<div class="insa_search Fl pdb_10 mgr_10">
								<div class="search" style="background-position: 0px 0px;">
									<fieldset>
										<input type="text" id="txtSearch" maxlength="30" name="txtSearch" value="" placeholder="이름 검색">
										<span class="btn_search"><span class="icon src" onclick="HolidayAdminList()"><em class="blind">검색</em></span></span>
									</fieldset>
								</div>
							</div>
						</div>
					</div>
				<br>
				<table class="table">
					    <thead>
						      <tr class="info">
						        <th>신청자</th>
						        <th>소속</th>
						        <th>휴가 종류</th>
						        <th>신청일</th>
						        <th>일수</th>
						        <th>기간</th>
						        <th>상태</th>
						        <th>상세</th>
						        <th>휴가신청취소</th>
						      </tr>
					    </thead>
					    <tbody id="holidayEmpTable">
					      	<tr>
					      		<td>김규형</td>
					      		<td>개발1팀</td>
					      		<td>연차</td>
					      		<td>04.06</td>
					      		<td>5일</td>
					      		<td>05.01~05.06</td>
					      		<td>결재</td>
					      		<td>연차휴가</td>
					      		<td><a class="cancle">취소</a></td>
					      	</tr>
					    </tbody>
				 	 </table>
				</div>
			</div>
		</section>
	</div>
	
	<button type="button" class="btn btn-info btn-lg detailModal" data-toggle="modal" data-target="#myModal" style="display:none">Open Modal</button>

	<!-- Modal -->
	<div id="myModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div class="modal-content" style="width: 700px !important;
	    								  padding: 25px 30px 32px !important;
	    								  display: block !important;
	    								  height:auto !important">
	    								  
	    	<div class="modal-header" style="border-bottom:none">
	        	<button type="button" class="close" data-dismiss="modal">&times;</button>
	        	<div class="title_layer text_variables" style=" font-size: 16px; color: #2985db;">휴가 신청 상세</div>
	      	</div>
	      	<div class="modal-body" style="height:100%;">
	        	<div class="approve_scroll" style=" height:auto;">
        			<div class="pdb_20">
						<table class="tableType02 tblf">
							<caption>휴가 결재선</caption>
								<colgroup>
									<col width="120">
									<col width="80">
									<col width="">
									<col width="">
									<col width="">
									<col width="">
								</colgroup>
								<tbody>
									<tr>
										<th scope="row" rowspan="2" class="bdr_1">결재 진행</th>
										<th class="bdr_1" rowspan="2">신청</th>
										<td class="center bdr_1">어드민</td>
										<td class="center bdr_1"></td>
										<td class="center bdr_1"></td>
										<td class="center"></td>
									</tr>
									<tr>
										<td class="center bdr_1"><div class="insa-stamp"><img src="${contextPath}/resources/images/employee/approval.png" alt="결재"></div></td>
										<td class="center bdr_1"><div class="insa-stamp"></div></td>
										<td class="center bdr_1"><div class="insa-stamp"></div></td>
										<td class="center"><div class="insa-stamp"></div></td>
									</tr>
								</tbody>
						</table>
					</div>
					<div>
						<table class="tableType02 tblf">
							<caption>휴가 상세내용</caption>
							<colgroup>
								<col width="120">
								<col width="">
								<col width="120">
								<col width="">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row" class="ta_c body_bold">신청 일시</th>
									<td>2019-07-15 04:56</td>
									<th scope="row" class="ta_c body_bold">상태</th>
									<td>결재 완료</td>
								</tr>
								<tr>
									<th scope="row" class="ta_c body_bold">사용자</th>
									<td>어드민</td>
									<th scope="row" class="ta_c body_bold">신청자</th>
									<td>어드민</td>
								</tr>
								<tr>
									<th scope="row" class="ta_c body_bold">소속</th>
									<td colspan="3">남궁욱컴퍼니</td>
								</tr>
								<tr>
									<th scope="row" class="ta_c body_bold">종류</th>
									<td>연차</td>
									<th scope="row" class="ta_c body_bold">일수</th>
									<td>2.0</td>
								</tr>
								<tr>
									<th scope="row" class="ta_c body_bold">기간</th>
									<td colspan="3"><p>2019-07-16 [일차]</p><p>2019-07-26 [일차]</p></td>
								</tr>
								<tr>
									<th scope="row" class="ta_c body_bold">사유</th>
									<td colspan="3">12</td>
								</tr>
								<tr>
									<th scope="row" class="ta_c body_bold">의견</th>
									<td colspan="3"></td>
								</tr>
							</tbody>
						</table>
					</div>
    			</div>
    		
	      </div>
	      <div class="modal-footer" style="border-top:none;">
	        <div class="layer_button">
	        	<button id="applyCheckBtn" type="button" onclick="delHoliday(this,'결제승인')" style="display:none">결제승인</button>
				<button id="applyBtn" type="button" onclick="delHoliday(this)">휴가신청취소</button>
				<button type="button" onclick="$('.detailModal').click()">닫기</button>
			</div>
	      </div>
	    </div>
	
	  </div>
	</div>
	
	<jsp:include page="../common/footer.jsp" />
	<script>
	
		var date;
	
		$(".layerShow").click(function(){
			$(".dropdown").toggle();
			$(".dropdown-menu").css("display","block");
			
		});
		
		$(function(){
			//HolidayAdminList();
			console.log($("#txtSearch").val() == '');
			date = new Date();
			
			$("#tab3_date").text(date.format('yyyy .MM')).attr("class",date.format('yyyyMM01'));
			HolidayAdminList();
			
		});
		
		function HolidayAdminList(holidayType){
			console.log($("#tab3_date").prop("class"));
			if(holidayType == undefined){
				holidayType = '전체';
			}
			var textSearch;
			if($("#txtSearch").val() == ""){
				textSearch = 'empty';
			}else{
				textSearch = $("#txtSearch").val();
			}
			//empNo/이름서치/휴가타입/휴가날짜
			 $.ajax({
				url:"holiday/getAdminHoliday/" + '${sessionScope.loginEmp.empNo}' + "/" + textSearch + "/" + holidayType + "/" + $("#tab3_date").prop("class") ,
				type:"get",
				success:function(data){
					console.log(data);
					showHolidayTable(data);
					
				},
				error:function(status){
					console.log(status);
				}
				
			}); 
		}
		
		function changeholiType(value){
			$("#filter_type_name").text(value);
			$(".dropdown").toggle();
			$(".dropdown-menu").css("display","none");
			HolidayAdminList(value);
		}
		
		function changeDate(move){
			if(move == 'L'){
				date.setMonth(date.getMonth() - 1);
			}else{
				date.setMonth(date.getMonth() + 1);
			}
			$("#tab3_date").text(date.format('yyyy .MM')).attr("class",date.format('yyyyMM01'));
			
			HolidayAdminList();
		}
		
		function showHolidayTable(data){
			$("#holidayEmpTable").empty();
			
			if(data.length == 0){
				$("#holidayEmpTable").append($("<tr>").append($("<td colspan='9'>").text('조회된 결과가 없습니다.')));
			}else{
				for(var i=0; i<data.length; i++){
					var $holidayTr = $("<tr>").attr("id",data[i].empNo);
					var $nameTd =  $("<td>").text(data[i].empName);
					var $deptTd = $("<td>").text(data[i].deptName);
					var $typeTd = $("<td>").text(data[i].holidayType);
					var $applyTd = $("<td>").text(new Date(data[i].HP_APPLY_DATE).format('MM.dd'));
					var $holiCountTd = $("<td>").text(data[i].holiCount + '일');
					var $flDayTd = $("<td>").text(new Date(data[i].firstDate).format('MM.dd')+ "~" + new Date(data[i].lastDate).format('MM.dd'))
					var $statusTd = $("<td>");
					if(data[i].hcStatus == null){
						$statusTd.text('결제 대기');
					}else{
						$statusTd.text(data[i].hcStatus);
					}
					
					var $hihTypeTd = $("<td>").text("상세").css({"color":"#779ec0","cursor":"pointer"})
										.attr({"onclick":"holidayDetail(this)","id":data[i].rhRequestNo});
					
					var $approvalTd = $("<td>").text('휴가신청취소').css({"color":"#779ec0","cursor":"pointer"})
										.attr({"onclick":"delHoliday(this)","class":data[i].rhRequestNo});
					
					$holidayTr.append($nameTd);
					$holidayTr.append($deptTd);
					$holidayTr.append($typeTd);
					$holidayTr.append($applyTd);
					$holidayTr.append($holiCountTd);
					$holidayTr.append($flDayTd);
					$holidayTr.append($statusTd);
					$holidayTr.append($hihTypeTd);
					$holidayTr.append($approvalTd);
					$("#holidayEmpTable").append($holidayTr);
					
				}
			}
			
		}
		
		function delHoliday(rhNum,value){
			
			var $checkTd = $("#" + $(rhNum).prop("class"));
			var empNo = $("#" + $(rhNum).prop("class")).parent().prop("id");
			console.log($("#" + $(rhNum).prop("class")));
			console.log("empNo : " + empNo);
			console.log($checkTd.prev().text());
			var rhNum = $(rhNum).prop("class");
			
			if(value == '결제승인'){
				appHoliday(empNo, rhNum, 'apply');
			}else if($checkTd.prev().text() == '반려'){
				alert("이미 반려된 결제 건입니다");
			}else if($checkTd.prev().text() == '결제 대기'){
				if(confirm("휴가문서를 반려 하시겠습니까? 취소 시 사용자의 휴가가 환원(반려)됩니다.")){
					appHoliday(empNo, rhNum, 'cancle');
				}
			}else if($checkTd.prev().text() == '승인'){
				if(confirm("결재된 휴가문서를 신청 취소하시겠습니까? 취소 시 사용자의 휴가가 환원(반려)됩니다.")){
				appHoliday(empNo, rhNum, 'reCancle');
				}
			}
			
			
		}
		
		function appHoliday(empNo, rhNum, status){
			
			var holidayInfo = {
								'empNo':empNo,
								'rhNum':rhNum,
								'status':status
								}
			
			$.ajax({
				url:"holiday/appHoliday",
				type:"post",
				data:JSON.stringify(holidayInfo),
				 dataType : "json",
				 contentType:"application/json",
				 success:function(data){
					 console.log(data);
					 if(data > 0){
						 HolidayAdminList();
						 if($("#myModal").css("display") == block){
							 $('.detailModal').click();
						 }
						 
						 
					 }
				 },
				 error:function(status){
					 console.log(status);
				 }
				
			});
		}
		
		function holidayDetail(rhNum){
			console.log(rhNum.id);
			
			$.ajax({
				url:"holiday/holidayDetail/" + rhNum.id + "/" + '${sessionScope.loginEmp.empNo}',
				type:"get",
				success:function(data){
					console.log(data);
					
					$(".center.bdr_1:first").text(data[0].managerName);
					
					$(".insa-stamp:first").empty();
					
					if(data[0].hcStatus == '승인'){
						$(".insa-stamp:first").append($("<img>").attr("src","/lgtw/resources/images/employee/approval.png"));
						$(".insa-stamp:first").append($("<p>").text(new Date(data[0].hcDate).format('yyyy-MM-dd')));
					}else if(data[0].hcStatus == '반려'){
						$(".insa-stamp:first").append($("<img>").attr("src","/lgtw/resources/images/approval/cancel.png").css("max-width","30px"));
						$(".insa-stamp:first").append($("<p>").text(new Date(data[0].hcDate).format('yyyy-MM-dd')));
					}
					
					var $body = $(".body_bold");
					
					for(var i=0; i<$body.length; i++){
						if(i == 0){
							$body.eq(i).next().text(new Date(data[0].HP_APPLY_DATE).format("yyyy-MM-dd HH:mm"));
						}else if(i == 1){
							if(data[0].hcStatus == null){
								$body.eq(i).next().text("결제 대기");	
							}else{
							$body.eq(i).next().text(data[0].hcStatus);
							}
						}else if(i == 2 || i == 3){
							$body.eq(i).next().text(data[0].empName);
						}else if(i == 4){
							$body.eq(i).next().text(data[0].deptName);
						}else if(i == 5){
							$body.eq(i).next().text(data[0].HIH_TYPE);
						}else if(i == 6){
							var count = 0;
							for(var v=0; v<data.length; v++){
								if(data[v].hdhType == '일차'){
									count = count + 1;
								}else if(data[v].hdhType == '오전반차' || data[v].hdhType == '오후반차'){
									count = count + 0.5;
								}
							}
							$body.eq(i).next().text(count + "일");
							
						}else if(i == 7){
							$body.eq(i).next().empty();
							for(var j=0; j<data.length; j++){
								var $dateP = $("<p>").text(new Date(data[j].hdhDate).format("yyyy-MM-dd") + "[" + data[j].hdhType + "]");
								$body.eq(i).next().append($dateP);
							}
						}else if(i == 8){
							$body.eq(i).next().text(data[0].holidayReason);
						}
					}
					
					
					$("#applyBtn").attr("class",data[0].rhRequestNo);
					$("#applyCheckBtn").attr("class",data[0].rhRequestNo);
					if(data[0].hcStatus == null){
						$("#applyCheckBtn").css("display","inline");
					}else{
						$("#applyCheckBtn").css("display","none");
					}
					
					$(".detailModal").click();
					
					
				},
				error:function(status){
					console.log(status);
				}
			});
			
			
			
		}
		
		
		Date.prototype.format = function (f) {
		    if (!this.valueOf()) return " ";

		    var weekKorName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];

		    var weekKorShortName = ["일", "월", "화", "수", "목", "금", "토"];

		    var weekEngName = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

		    var weekEngShortName = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

		    var d = this;

		    return f.replace(/(yyyy|yy|MM|dd|KS|KL|ES|EL|HH|hh|mm|ss|a\/p)/gi, function ($1) {

		        switch ($1) {

		            case "yyyy": return d.getFullYear(); // 년 (4자리)

		            case "yy": return (d.getFullYear() % 1000).zf(2); // 년 (2자리)

		            case "MM": return (d.getMonth() + 1).zf(2); // 월 (2자리)

		            case "dd": return d.getDate().zf(2); // 일 (2자리)

		            case "KS": return weekKorShortName[d.getDay()]; // 요일 (짧은 한글)

		            case "KL": return weekKorName[d.getDay()]; // 요일 (긴 한글)

		            case "ES": return weekEngShortName[d.getDay()]; // 요일 (짧은 영어)

		            case "EL": return weekEngName[d.getDay()]; // 요일 (긴 영어)

		            case "HH": return d.getHours().zf(2); // 시간 (24시간 기준, 2자리)

		            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2); // 시간 (12시간 기준, 2자리)

		            case "mm": return d.getMinutes().zf(2); // 분 (2자리)

		            case "ss": return d.getSeconds().zf(2); // 초 (2자리)

		            case "a/p": return d.getHours() < 12 ? "오전" : "오후"; // 오전/오후 구분

		            default: return $1;

		        }

		    });

		};

		String.prototype.string = function (len) { var s = '', i = 0; while (i++ < len) { s += this; } return s; };

		String.prototype.zf = function (len) { return "0".string(len - this.length) + this; };
		Number.prototype.zf = function (len) { return this.toString().zf(len); };
	
	
	</script>
</body>
</html>