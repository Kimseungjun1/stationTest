<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>

<%
	MemberT login = (MemberT)session.getAttribute("loginUser");	
	
	String mgrade = "";

	if(login != null){
		mgrade = login.getMgrade();
	}

	request.setCharacterEncoding("UTF-8");
	
	String qidx = request.getParameter("qidx");

	
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	String qtitle_ ="";
	String qcontent_ = "";
	String mname_ = "";
	String qdate_ = "";
	int qidx_ = 0;
	
	
	try{
		conn = DBManager.getConnection();
		
		String sql = " SELECT a.Mname, b.Qidx, b.Qtitle, "
					+" b.Qcontent,to_char(b.qdate,'YYYY-MM-DD') "
					+" FROM memberT a right JOIN "
					+" qna b ON a.midx=b.midx "
					+" where b.qidx= "+qidx;
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		if(rs.next()){
			qtitle_ = rs.getString("qtitle");
			qcontent_ = rs.getString("qcontent");
			qidx_ = rs.getInt("qidx");
			mname_ = rs.getString("mname");
			qdate_ = rs.getString("TO_CHAR(b.qdate,'YYYY-MM-DD')");
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
<link href="<%=request.getContextPath() %>/css/base.css" rel="stylesheet">
</head>
<body>
	<%@ include file = "../header.jsp" %>

	<section>
	<div class="divright">
	
		<form action = "modifyOk.jsp" method="post">
			<input type="hidden" name="qidx" value="<%=qidx_ %>">
			<table border="1" style="width:1000px;" >
				<thead>
					<tr>
						<th>제목</th>
						<td><input type="text" name="qtitle" value="<%=qtitle_%>"> </td>
						<th>작성자</th>
						<td><%=mname_ %></td>					
					</tr>			
				</thead>
				<tbody>
					<tr>
						<th>내용</th>
						<td><input type="text" name="qcontent" value="<%=qcontent_ %>"></td>
						<th>작성일</th>
						<td><%=qdate_%></td>
					</tr>
													
				</tbody>
					
			</table>
						
				<input type="button" value="취소" onclick="location.href='view.jsp?qidx=<%=qidx_%>'">
				<input type="submit" value="저장" onclick="location.href='modifyOk.jsp?qidx=<%=qidx_%>'">
			</form>
	
	
	
	</div>	
	
	<div class="divleft">
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