<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.vo.*" %>
<%@ page import= "java.util.*" %>
<%@ page import="boardWeb.util.*" %>
<%@ page import="java.sql.*" %>

<%
	
	MemberT login = (MemberT)session.getAttribute("loginUser");

	String mgrade = "";

	if(login != null){
		mgrade =  login.getMgrade();
		
	}
	
	String nowPage = request.getParameter("nowPage");
	int nowPageI = 1;
	if(nowPage != null){
		nowPageI = Integer.parseInt(nowPage);
	}
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	Connection conn1 = null;
	PreparedStatement psmt1 = null;
	ResultSet rs1 = null;
	
	PreparedStatement psmtindexView = null;
	ResultSet rsindexView = null;
	
	String qtitle_ = "";
	int qidx_ = 0;
	String mname_ = "";
	String nttitle_ = "";
	int ntidx_ = 0;
	String ntwriter ="";
	
	PagingUtil paging = null;
	PagingUtil paging1 = null;
		
	ArrayList<IndexView> iList = new ArrayList<>();
	
	try{
		conn = DBManager.getConnection();
		
		String sql = " select count(*) as total from noticeT order by ntidx desc ";
		
		psmt = conn.prepareStatement(sql);
		
		rs = psmt.executeQuery();
		
		int total = 0;
		
		if(rs.next()){
			total = rs.getInt("total");
		}
		
		paging = new PagingUtil(total,nowPageI,5);
		
		
		
		 sql = " select * from ";
		 sql += " (select ROWNUM r, b.* from ";
		 sql += " (SELECT * FROM noticeT ";
		 sql += " ORDER BY ntidx DESC ) b) ";
		 sql += " where r>= "+paging.getStart()+" and r<= "+paging.getEnd();
			
		psmt = conn.prepareStatement(sql);
			
		rs = psmt.executeQuery();
			
		conn1 = DBManager.getConnection();
		
		paging1 = new PagingUtil(total,nowPageI,5);
			
		String	sql1 = " select d.* from "
					   + " (select rownum r, c.* from "
					   + " (SELECT a.Mname, b.Qidx, b.Qtitle, "
					   + " b.Qcontent, b.Qdate FROM memberT a "
					   + " right JOIN qna b ON a.midx=b.midx "
					   + " order by qidx desc ) c) d "
					   + " where d.r>= "+paging1.getStart()+" and d.r<= "+paging1.getEnd();
		
		psmt1 = conn1.prepareStatement(sql1);
				
		rs1 = psmt1.executeQuery();	
			
	
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
	<%@ include file = "header.jsp" %>
	
	
	<section>
	
	<div class="divright">
	
		<% if(login != null && !mgrade.equals("A")){%>		
			<h2><%=login.getMid() %>님 로그인을 환영합니다.</h2>
		<%}else if(mgrade.equals("A")){ %>
			<h2>관리자님 로그인을 환영합니다.</h2>
		<%}else { %>
			<h2>전라북도</h2>
		
		<%} %>
		
		<div class = "noticeTview">
		<h3>공지사항</h3>
		<input type="button" value="더보기" onclick="location.href='notice/noticeView.jsp'">
		<table border="1" style="width:500px;" >
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
				</tr>			
			</thead>
			<tbody id="notice">
			<%
				while(rs.next()){
			%>
				<tr>
					<td><%= rs.getInt("ntidx") %></td>
					<td><a href="javascript:void(0);" onclick="goNtView(this)"><%= rs.getString("nttitle") %></a></td>
				</tr>
			<%
			}
			%>
		
			</tbody>
				
		</table>
		
		</div>
		
		<div class = "qnaView">
		<h3>Q&A</h3>
		<input type="button" value="더보기" onclick="location.href='qna/qnalist.jsp'">
		<table border="1" style="width:500px;" >
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
				</tr>			
			</thead>
			<tbody id="qna">
			<%
				while(rs1.next()){
			%>
				<tr>
					<td><%= rs1.getInt("qidx") %></td>
					<td><a href="javascript:void(0);" onclick="goNtView(this)"><%= rs1.getString("qtitle") %></a></td>
				</tr>
			<%
			}
			%>
		
			</tbody>
				
		</table>
		
		</div>
		
		
		
		
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
	
	
	<%@ include file="footer.jsp" %>
	
	<script>
	
	
	
	</script>
	
	

</body>
</html>

<%
}catch(Exception e){
		e.printStackTrace();
		
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
	}
%>