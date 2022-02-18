<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>


<%
	
	MemberT login = (MemberT)session.getAttribute("loginUser");

	String mname = "";
	String mgrade = "";

	if(login != null){
		mname = login.getMname();
		mgrade = login.getMgrade();
	}
	
	String midx = request.getParameter("midx");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	String mid_ = "";
	String mpwd_ = "";
	String mname_ = "";
	String mbirth_ = "";
	String mphone_ = "";
	String memail_ = "";
	
	try{
		conn = DBManager.getConnection();
		
		String sql = " Select * from memberT where midx= "+midx;
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		if(rs.next()){
			mid_ = rs.getString("mid");
			mpwd_ = rs.getString("mpwd");
			mname_ = rs.getString("mname");
			mbirth_ = rs.getString("mbirth");
			mphone_ = rs.getString("mphone");
			memail_ = rs.getString("memail");
						
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
			
		<h2><%=mname%> 수정</h2>
		
		<form action = "mymodifyOk.jsp" method="post">
			<input type="hidden" name="midx" value="<%=midx%>">
				
				<div class="createtitle">아이디<span class="red">*</span></div>
				<div>
					<%=mid_%>					
				</div>
				<div class="createtitle">비밀번호<span class="red">*</span></div>
				<div>
					<input type="password" name="mpwd">
					<span class="check"></span>
				</div>
				<div class="createtitle">이름<span class="red">*</span></div>
				<div>
					<%=mname_ %>				
				</div>
				<div class="createtitle">생년월일<span class="red">*</span></div>
				<div>
					<input type="text" name="mbirth" placeholder="<%=mbirth_%>">
					<span class="check"></span>
				</div>
				<div class="createtitle">핸드폰 번호<span class="red">*</span></div>
				<div>
					<input type="text" name="mphone" placeholder="<%=mphone_%>">
					<span class="check"></span>
				</div>
				<div class="createtitle">이메일<span class="red">*</span></div>
				<div>
					<input type="text" name="memail" placeholder="<%=memail_%>">
					<span class="check"></span>
				</div>
		
			<input type="button" value="취소" onclick="location.href='mylist.jsp?midx=<%=midx %>'">
			<input type="submit" value="저장">
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