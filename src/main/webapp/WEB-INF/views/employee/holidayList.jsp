<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LetsGoToWork</title>
<style>
	.holiP{
		font-size:150%;
	    font-weight:bold;
	}

	#sel1{
		width:10%;
	}
	
   .tabType1 li.on a {
    	font-weight: 700;
	}
	
	.tabType-tax, .tabType1 {
	    width: 100%;
	    overflow: hidden;
	    background: #f3f3f3;
	}
	
	.setting_field {
	    padding: 30px 25px 0;
	}
	
	.tabType1 li.on {
	    background: #fff;
	}
	
	.tabType1 li {
	    float: left;
	    margin: 5px 8px 0;
	    padding: 4px 12px;
	    text-align: center;
	}
	
	dl, li, menu, ol, ul {
	    list-style: none;
	}
	
	.setting_title {
	    position: relative;
	    padding: 20px 25px 0 23px;
	    min-width: 733px;
	    height: 60px;
	    border-bottom: 1px solid #f2f4f3;
	}
	
	h1, h2, h3, h4, h5, h6 {
    font-weight: 400;
    margin: 10px 0;
	}
	
	.setting_title h3 {
	    color: #333;
	    font-size: 16px;
	}
	a{
		text-decoration:none !important;
	}
	
	.table>thead>tr.info>th{
		background-color:#f3f3f3 !important;
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
                    <li class="on">
                        <a href="javascript:void(0)" onclick="location.href='showHolidayList.em'">내 휴가</a>
                    </li>
                    <li>
                    	<a href="javascript:void(0)" onclick="location.href='showHolidayAdmin.em'">휴가신청관리</a>
                    </li>
            </ul>
            </div>
			<!-- <button type="button" class="btn btn-primary" onclick="location.href='showHolidayList.em'">내 휴가</button> -->
			<!-- <button type="button" class="btn btn-primary" onclick="location.href='showHoliCalender.em'">휴가 캘린더</button> -->
			<!-- <button type="button" class="btn btn-primary" onclick="location.href='showHolidayAdmin.em'">휴가 신청관리</button> -->
			<hr>
			<div class="content">
				<div id="holidayArea">
					<p class="holiP">휴가 생성 내역 / 입사일 : <c:out value="${ sessionScope.loginEmp.enrollDate }"/></p>
					<table class="table">
					    <thead>
						      <tr class="info">
						        <th>생성일</th>
						        <th>발생일</th>
						        <th>사용일</th>
						        <th>잔여일</th>
						        <th>비고</th>
						      </tr>
					    </thead>
					    <tbody>
					      	<tr>
					      		<td>2019.06.20</td>
					      		<td>2019.07.01</td>
					      		<td>2019.07.17</td>
					      		<td>1차 정기 휴가</td>
					      		<td></td>
					      	</tr>
					    </tbody>
				 	 </table>
			  	</div>
			  	<hr>
			  	<div id="reqHoliArea">
			  		<p class="holiP">휴가 신청 내역</p>
				    <br>
			  		<table class="table">
					    <thead>
						      <tr class="info">
						        <th>신청자</th>
						        <th>휴가 종류</th>
						        <th>일수</th>
						        <th>기간</th>
						        <th>상태</th>
						        <th>상세</th>
						      </tr>
					    </thead>
					    <tbody>
					      	<tr>
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
						<button type="button" onclick="$('.detailModal').click()">닫기</button>
					</div>
		      </div>
	    	</div>
	      </div>
	    </div>
	 
	 
	<jsp:include page="../common/footer.jsp" />
	<script>
	
	$(function(){
		getHolidayList();
	});
	
	function getHolidayList(){
		$.ajax({
			url:"holiday/getHolidayList/" + '${sessionScope.loginEmp.empNo}',
			type:"get",
			success:function(data){
				console.log(data);
				ShowHolidayTable(data.myHoliList);
				ShowapplyTable(data.applyList);
			},
			error:function(status){
				
			}
			
		});
	}
	
	function ShowapplyTable(applyList){
		var $applyTable = $("tbody:first");
		$applyTable.empty();
		
		for(var i=0; i<applyList.length; i++){
			var $tr = $("<tr>");
			
			var $applyTd = $("<td>").text(new Date(applyList[i].hihApplyDate).format('yyyy-MM-dd'));
			var $totalTd = $("<td>").text(applyList[i].hihTotalDate);
			var $useTd = $("<td>").text(applyList[i].DHCOUNT);
			var $empTd = $("<td>").text(Number(applyList[i].hihTotalDate) - Number(applyList[i].DHCOUNT));
			var $contentTd = $("<td>").text(applyList[i].HIH_TYPE);
			
			
			$tr.append($applyTd);
			$tr.append($totalTd);
			$tr.append($useTd);
			$tr.append($empTd);
			$tr.append($contentTd);
			
			$applyTable.append($tr);
		}
	}
	
	function ShowHolidayTable(myHoliList){
		
		var $holiListTable = $("tbody:nth-child(2)");
		$holiListTable.empty();
		
		for(var j=0; j<myHoliList.length; j++){
			var $trd = $("<tr>");
			
			var $nameTd = $("<td>").text(myHoliList[j].empName);
			var $typeTd = $("<td>").text(myHoliList[j].holidayType);
			var $countTd = $("<td>").text(myHoliList[j].HDCOUNT);
			var $dayTd = $("<td>").text(new Date(myHoliList[j].firstDate).format('MM.dd') + " ~ " + new Date(myHoliList[j].lastDate).format('MM.dd'));
			var $statusTd = $("<td>").text(myHoliList[j].hcStatus);
			var $detailTd = $("<td>").text('상세').css({"color":"#779ec0","cursor":"pointer"})
							.attr({"onclick":"holidayDetail(this," +myHoliList[j].managerNo+ ")","id":myHoliList[j].rhRequestNo});
			
			$trd.append($nameTd);
			$trd.append($typeTd);
			$trd.append($countTd);
			$trd.append($dayTd);
			$trd.append($statusTd);
			$trd.append($detailTd);
			
			$holiListTable.append($trd);
		}
		
		}
	
	
	 function holidayDetail(rhNum,managerNo){
		console.log(rhNum.id);
		
		$.ajax({
			url:"holiday/holidayDetail/" + rhNum.id + "/" + managerNo,
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