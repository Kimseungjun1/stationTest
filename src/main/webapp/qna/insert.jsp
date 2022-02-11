<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%
	MemberT login = (MemberT)session.getAttribute("loginUser");

	String Mname = "";
	
	if(login != null){
		Mname = login.getMname();
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
	<%@ include file="/header.jsp" %>
	
	<section>
	<div class="divright">
		<form action = "insertOk.jsp" method="post">
			<table border="1" style="width:1000px;" >
			<thead>
				<tr>
					<th>제목</th>
					<td><input type="text" name="nttitle"></td>					
					
				</tr>			
			</thead>
			<tbody>
				<tr>
					<th>내용</th>
					<td><textarea name="ntcontent" rows="15"></textarea></td>
				</tr>
							
			</tbody>
				
		</table>
		
			<input type="submit" value="등록">		
		</form>
	</div>
	<div class="divleft">
							 
			<div>
				관리자 : <%=login.getMid() %>
						
				<a href="/stationTest/login/logout.jsp">로그아웃</a>
			</div>
		
	 			
	 	<table class="menuleft">
	 		<tr>
	 			<td><a href="../notice/noticeView.jsp">공지사항</a></td>
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
	
	<%@ include file = "../footer.jsp" %>

</body>
</html>