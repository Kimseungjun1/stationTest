<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.vo.*" %>


<%
	
	MemberT login = (MemberT)session.getAttribute("loginUser");

	String mgrade = "";

	if(login != null){
		mgrade =  login.getMgrade();
		
	}
		
	
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#jeonbuk{
	
	max-width:100%;
	height:auto;
}

.jeonbukArea{
	width: 600px;
	border: 2px solid black;
	margin: 0px;
	
}
#gs{
	position: absolute;
}
</style>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
</head>
<body>
	<%@ include file = "../header.jsp" %>
	
	
	<section>
	
	<div class="divright">
	
		<h2>전라북도</h2>
		
		
		<!-- <div class="jeonbukArea">
			<img src="jeonbuk.jpg" id="jeonbuk" usemap="#image-map">
			<map name="image-map">
			<area target="_top" alt="" title="" href="" coords="133,111,88,114,85,132,89,148,100,157,116,164,131,170,149,177,162,180,175,174,190,177,210,177,233,169,246,166,265,146,279,123,289,108,282,93,274,81,265,64,239,79,211,92,185,108" shape="poly">
			
			</map>
			<img src="check.jpg" id="gs">
		</div>
		 -->
		<div id="map" style="width:100%;height:auto;">
		
		</div>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1bf492b3b57243db00cd7afa296c3471"></script>
		
		<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 2 // 지도의 확대 레벨
		    };
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(33.450701, 126.570667); 
		
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});
		
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
		// marker.setMap(null);    
	</script>
			
			
			
		
		
	</div>
	<div class="divleft">
		<% if(login == null) {%>
			<a href="/stationTest/login/login.jsp">로그인</a>
			<a href="/stationTest/Member/create.jsp">회원가입</a>
		<%} %>	
		
		<% if(login != null && !mgrade.equals("A")) {%>
		
			<div>
				회원 : <%=login.getMid() %>
				
				<a href="/stationTest/login/logout.jsp">로그아웃</a>
			</div>
			
		<%}else if(mgrade.equals("A")){ %>
						 
			<div>
				관리자 : <%=login.getMid() %>
						
				<a href="/stationTest/login/logout.jsp">로그아웃</a>
			</div>
		
		<%} %>
	 	
	 	
	 	<table class="menuleft">
	 		<tr>
	 			<td><a href="/stationTest/notice/noticeView.jsp">공지사항</a></td>
	 		</tr>
	 		<tr>
	 			<td><a href="/stationTest/jeonbuk/list.jsp">전라북도</a></td>
	 		</tr>
	 		<tr>
	 			<td><a href="/stationTest/qna/qnalist.jsp">Q&A</a></td>
	 		</tr>
	 		<% 
	 			if(login != null){
	 		%>
	 		<tr>
	 			<td><a href="/stationTest/my/mycheck.jsp">마이페이지</a></td>
	 		</tr>
	 		 <%
	 		 	}
	 		 %>
	 	</table>
	 	
	</div>
	
	
	
	
	</section>
	
	
	<%@ include file="../footer.jsp" %>
	
	

</body>
</html>