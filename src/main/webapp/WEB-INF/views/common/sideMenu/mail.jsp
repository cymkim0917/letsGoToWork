<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    

<div class="col-sm-2 sidenav visible-sm visible-md visible-lg">
	<ul>
		<li>
			<button onclick="location.href='${ contextPath }/mail/writeForm'" style="height : 100%;">메일작성하기</button>
		</li><hr>
		<li id="all"><a href="${ contextPath }/allList.ma?listType=all">전체보관함</a></li><hr>
		<li id="receive"><a href="${ contextPath }/allList.ma?listType=receive">받은메일함</a></li><hr>
		<li id="send"><a href="${ contextPath }/allList.ma?listType=send">보낸메일함</a></li><hr>
		<li id="outbox"><a href="${ contextPath }/allList.ma?listType=outbox">임시보관함</a></li><hr><br>
		<li id="trash"><button class="grayBtn" style="height : 100%;" 
					onclick="location.href='${ contextPath }/allList.ma?listType=trash'">휴지통</button></li><br>
		<li id="setting"><a href="setting.ma">환경설정</a></li>
		<!-- 환경설정에 공용메일 관리 추가하기  -->	
	</ul>
</div>
<script>
	$(function(){
		$('.sidenav > ul > li:not(.chidren(button)).click(function(){
			location.href= $(this).children("a").attr('href');
		});		
	})
</script>