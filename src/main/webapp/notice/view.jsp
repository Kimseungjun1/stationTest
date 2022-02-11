<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>

<%

	MemberT login = (MemberT)session.getAttribute("loginUser");

	String mgrade = "";

	if(login != null){
		mgrade =  login.getMgrade();
	}
	
	String ntidx = request.getParameter("ntidx");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	String nttitle_ = "";
	String ntcontent_ = "";
	String ntwriter_ = "";
	int ntidx_ = 0;
	int midx_ = 0;
	String ntdate_ ="";
	
	
	
	try{
		conn = DBManager.getConnection();
				
		String sql = " SELECT nttitle, ntcontent, ntwriter, TO_CHAR(ntdate,'YYYY-MM-DD'),ntidx,midx FROM noticeT where ntidx= "+ntidx;
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		if(rs.next()){
			nttitle_ = rs.getString("nttitle");
			ntcontent_ = rs.getString("ntcontent");
			ntwriter_ = rs.getString("ntwriter");
			ntidx_ = rs.getInt("ntidx");
			ntdate_ = rs.getString("TO_CHAR(ntdate,'YYYY-MM-DD')");
			midx_ = rs.getInt("midx");
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
	}


%>
   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
</head>
<body>
	<%@ include file = "../header.jsp" %>

	<section>
	<div class="divright">
	
		<form action = "modify.jsp" method="post">
			<input type="hidden" name="ntidx" value="<%=ntidx_ %>">
				<table border="1" style="width:1000px;" >
				<thead>
					<tr>
						<th>제목</th>
						<td><%=nttitle_ %></td>
						<th>작성자</th>
						<td><%=ntwriter_ %></td>					
					</tr>			
				</thead>
				<tbody>
					<tr>
						<th>내용</th>
						<td><%=ntcontent_ %></td>
						<th>작성일</th>
						<td><%=ntdate_ %></td>
					</tr>
													
				</tbody>
					
			</table>
						
				<input type="button" value="목록" onclick="location.href='noticeView.jsp'">
				<%
					if(login != null && login.getMidx() == midx_){
				%>
					<input type="submit" value="수정" onclick="goModify()">
					<input type="button" value="삭제" onclick="goDelete()">
				<%}
				%>		
			</form>
	
	
	
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
	 			<td><a href="noticeView.jsp">공지사항</a></td>
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
	
	
	<%@ include file="../footer.jsp" %>
	
	<script>
	function goModify(){
		var login = '<%=login%>';
		if(login != 'null' && login.getMgrade.equals('A')){
			location.href = 'modify.jsp?ntidx=<%=ntidx_%>';
		}
	}
	
	function goDelete(){
		
			location.href = 'delete1.jsp?ntidx=<%=ntidx_%>';
		
	}
	</script>

</body>
</html>