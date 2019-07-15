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

</style>
</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	<div class="row wrap">
		<jsp:include page="../common/sideMenu/employee.jsp"/>
		
		<section class="col-sm-10">
			<h1 class="title">휴가 신청관리</h1>
			<button type="button" class="btn btn-primary" onclick="location.href='showHolidayList.em'">내 휴가</button>
			<!-- <button type="button" class="btn btn-primary" onclick="location.href='showHoliCalender.em'">휴가 캘린더</button> -->
			<button type="button" class="btn btn-primary" onclick="location.href='showHolidayAdmin.em'">휴가 신청관리</button>
			<hr>
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
						        <td>상태</td>
						        <td>상세</td>
						        <td>휴가신청취소</td>
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
		</section>
	</div>
	
	<button type="button" class="btn btn-info btn-lg detailModal" data-toggle="modal" data-target="#myModal" style="display:none">Open Modal</button>

	<!-- Modal -->
	<div id="myModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      <div class="modal-body">
	        <p>Some text in the modal.</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
					var $holidayTr = $("<tr>");
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
										.attr({"onclick":"holidayDetail(this)","id":data[i].rhRequestNo});;
					
					var $approvalTd = $("<td>").text('휴가신청취소').css({"color":"#779ec0","cursor":"pointer"})
										.attr({"onclick":"delHoliday(this)","id":data[i].rhRequestNo});
					
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
		
		function delHoliday(rhNum){
			console.log(rhNum.id);
		}
		
		function holidayDetail(rhNum){
			console.log(rhNum.id);
			
			$(".detailModal").click();
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