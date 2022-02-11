<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "boardWeb.vo.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath() %>/css/base.css" rel="stylesheet">
</head>
<body>
<%@ include file = "../header.jsp" %>
	
	
	<section>
	
	<div class="divright">
	
		<% if(loginH != null) {%>		
			<h2><%=loginH.getMid() %>님 정말 탈퇴하실겁니까?</h2>
			
			<button onclick="">예</button>
			
			<button onclick="location.href='../index.jsp'">아니요</button>
			
		<%} %>
		
	</div>
	<div class="divleft">
		<% if(loginH == null) {%>
			<a href="login/login.jsp">로그인</a>
			<a href="Member/create.jsp">회원가입</a>
		<%} %>	
		
		<% if(loginH != null) {%>
		
			<div>
				회원 : <%=loginH.getMid() %>
				
				<a href="login/logout.jsp">로그아웃</a>
			</div>
			
		<%} %>
				
		<%-- <%  //관리자인지 아닌지 체크
		 if(){  %>
			<div>		
				<a href="login/logout.jsp">로그아웃</a>
			</div>
		
		 <%}  %>
	 	--%>
	 	
	 	<table class="menuleft">
	 		<tr>
	 			<td><a href="../notice/noticeView.jsp">공지사항</a></td>
	 		</tr>
	 		<tr>
	 			<td><a>전라북도</a></td>
	 		</tr>
	 		<tr>
	 			<td><a>Q&A</a></td>
	 		</tr>
	 		<tr>
	 			<td><a>마이페이지</a></td>
	 		</tr>
	 		
	 	</table>
	 	
	</div>
	
	
	
	
	</section>
	
	
	<%@ include file="../footer.jsp" %>

</body>
</html>