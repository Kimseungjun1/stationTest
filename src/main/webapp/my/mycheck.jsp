<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.vo.*" %>

<%
	MemberT login = (MemberT)session.getAttribute("loginUser");

	String mgrade = "";
	String mid_ = "";
	
	
	if(login != null){
		mgrade = login.getMgrade();
		mid_ = login.getMid();	
	}
	
	



%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<link href="<%=request.getContextPath() %>/css/base.css" rel="stylesheet">
</head>
<body>
	<%@ include file = "../header.jsp" %>
	
	
	<section>
	
	<div class="divright">
	
		<% if(login != null && !mgrade.equals("A")){%>		
			<h2><%=login.getMid() %>님의 마이페이지</h2>
		<%}else if(mgrade.equals("A")){ %>
			<h2>관리자님의 마이페이지</h2>
		<%} %>
		
		<form action = "mycheckOk.jsp" method="post">
		<table border = "1" style="width:100px;">
			<input type="hidden" name="mid" value="<%=mid_%>">
			
				<tr>
					<th>비밀번호 확인</th>							
				</tr>
				<tr>
					<td>
						<input type="password" name="password">
						<span style="display:none"></span>
					</td>
					
				</tr>
				
		</table>
	
			<input type="submit" value="비밀번호 확인">
			
		</form>
		
		
		
		
		
	</div>
	<div class="divleft">
		<% if(login == null) {%>
			<a href="login/login.jsp">로그인</a>
			<a href="Member/create.jsp">회원가입</a>
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
	 		<tr>
	 			<td><a href="/stationTest/my/mycheck.jsp">마이페이지</a></td>
	 		</tr>
	 		
	 	</table>
	 	
	</div>
	
	</section>
	
	
	<%@ include file="../footer.jsp" %>
	

</body>
</html>