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
<link href="<%=request.getContextPath() %>/css/base.css" rel="stylesheet">
</head>
<body>
	<%@ include file = "header.jsp" %>
	
	
	<section>
	
	<div class="divright">
	
		<% if(login != null && !mgrade.equals("A")){%>		
			<h2><%=login.getMid() %>님 로그인을 환영합니다.</h2>
		<%}else if(mgrade.equals("A")){ %>
			<h2>관리자님 로그인을 환영합니다.</h2>
		<%} %>
		
	</div>
	<div class="divleft">
		<% if(login == null) {%>
			<a href="login/login.jsp">로그인</a>
			<a href="Member/create.jsp">회원가입</a>
		<%} %>	
		
		<% if(login != null && !mgrade.equals("A")) {%>
		
			<div>
				회원 : <%=login.getMid() %>
				
				<a href="login/logout.jsp">로그아웃</a>
			</div>
			
		<%}else if(mgrade.equals("A")){ %>
						 
			<div>
				관리자 : <%=login.getMid() %>
						
				<a href="login/logout.jsp">로그아웃</a>
			</div>
		
		<%} %>
	 	
	 	
	 	<table class="menuleft">
	 		<tr>
	 			<td><a href="notice/noticeView.jsp">공지사항</a></td>
	 		</tr>
	 		<tr>
	 			<td><a>전라북도</a></td>
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
	
	
	<%@ include file="footer.jsp" %>
	
	

</body>
</html>