<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%@ page import= "java.util.*" %>

<%
	
	MemberT login = (MemberT)session.getAttribute("loginUser");

	String mgrade = "";
	

	if(login != null){
		mgrade =  login.getMgrade();
		
	}
	
	String qidx = request.getParameter("qidx");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	PreparedStatement psmtReply = null;
	ResultSet rsReply = null;
	
	String qtitle_ = "";
	String qcontent_ = "";
	String mname_ = "";
	String qdate_ = "";
	int qidx_ = 0;
	int midx_ = 0;
	
	ArrayList<Reply> rList = new ArrayList<>();
	
	try{
		conn = DBManager.getConnection();
		
		String sql = " SELECT a.Mname, b.Qidx, b.Qtitle, "
				   + " b.Qcontent, b.Qdate, TO_char(b.qdate,'YYYY-MM-DD'), "
				   + " a.midx "
				   + " FROM memberT a "
				   + " right JOIN qna b ON a.midx=b.midx "
				   + " where b.qidx="+qidx;
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		if(rs.next()){
			qtitle_ = rs.getString("qtitle");
			qcontent_ = rs.getString("qcontent");
			mname_ = rs.getString("mname");
			qdate_ = rs.getString("TO_CHAR(b.qdate,'YYYY-MM-DD')");
			qidx_ = rs.getInt("qidx");
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
<link href="<%=request.getContextPath() %>/css/base.css" rel="stylesheet">
</head>
<body>
	<%@ include file = "../header.jsp" %>
	
	
	<section>
	
	<div class="divright">
	
		<form action = "modify.jsp" method="post">
			<input type="hidden" name="qidx" value="<%=qidx_ %>">
				<table border="1" style="width:1000px;" >
				<thead>
					<tr>
						<th>제목</th>
						<td><%=qtitle_ %></td>
						<th>작성자</th>
						<td><%=mname_ %></td>					
					</tr>			
				</thead>
				<tbody>
					<tr>
						<th>내용</th>
						<td><%=qcontent_ %></td>
						<th>작성일</th>
						<td><%=qdate_ %></td>
					</tr>
													
				</tbody>
					
			</table>
						
				<input type="button" value="목록" onclick="location.href='qnalist.jsp'">
				<%
					
					if(login != null && login.getMidx() == midx_){
				%>
					<input type="submit" value="수정" onclick="goModify()">
					<input type="button" value="삭제" onclick="goDelete()">
				<%}
				%>		
			</form>
			
			<%-- <div class="replayArea">
				<div class="replyList">
				<table border="1" id="reply"> 
					<tbody>
						<% for(Reply r : rList){ %>
								<tr>
									<td><%=r.getMembername()%><input type='hidden' name='ridx' value='"<%=r.getRidx()%>"'></td>
									<td><%=r.getRcontent()%></td>
									
									<% if(login != null && (login.getMidx() == r.getMidx())){ %>
									<td>
										<input type="button" value="수정" onclick='modifyFn(this)'>
										<input type="button" value="삭제" onclick='deleteFnReply(this)'>
									</td>
									<%} %>
									
								</tr>
						
						<%} %>
					</tbody>
				</table>
				</div>
				<div class="replyInput">
					<form name= "reply">
					<input type="hidden" name="bidx" value="<%=bidx%>">
						<p>
							<label>
								내용 : <input type="text" size="50" name="rcontent">
							</label>
						</p>
						<p>
							<input type="button" value="저장" onclick="loginFn()">
						</p>
					
					</form>
				</div> --%>
		
	
		
		
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
	 			<td><a>전라북도</a></td>
	 		</tr>
	 		<tr>
	 			<td><a  href="/stationTest/qna/qnalist.jsp">Q&A</a></td>
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
		if(login != 'null' && login.getMidx() == midx_){
			location.href = 'modify.jsp?qidx=<%=qidx_%>';
		}
	}
	
	function goDelete(){
		
			location.href = 'delete1.jsp?qidx=<%=qidx_%>';
		
	}
	</script>
	

</body>
</html>