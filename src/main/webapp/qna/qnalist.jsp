<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ page import="java.sql.*" %>
    <%@ page import="boardWeb.vo.*" %>
    <%@ page import="boardWeb.util.*" %>
    <%@ page import="java.util.*" %>

<%
	
	MemberT login = (MemberT)session.getAttribute("loginUser");

	String mgrade = "";

	if(login != null){
		mgrade =  login.getMgrade();
		
	}
	
	String searchValue = request.getParameter("searchValue");
	String searchType = request.getParameter("searchType");
	
	String nowPage = request.getParameter("nowPage");
	int nowPageI = 1;
	if(nowPage != null){
		nowPageI = Integer.parseInt(nowPage);
	}
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	PagingUtil paging = null;
	
	String mname_ = "";
	int qidx_ = 0;
	String qtitle_ = "";
	String qcontent_ = "";
	String qdate_ = "";
	
	
	
	try{
		conn = DBManager.getConnection();
		String sql = "";
		
		sql = "select count(*) as total from qna ";
		
			if(searchValue != null && !searchValue.equals("") && !searchValue.equals("null")){
			
			if(searchType.equals("qtitle")){
				sql += " where qtitle like '%"+searchValue+"%'";	
			}
			
				    			
			}
			
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		int total = 0;
		
		if(rs.next()){
			total = rs.getInt("total");
		}
			
		
		paging = new PagingUtil(total,nowPageI,5);
		
		sql = " select d.* from "
		   + " (select rownum r, c.* from "
		   + " (SELECT a.Mname, b.Qidx, b.Qtitle, "
		   + " b.Qcontent, b.Qdate FROM memberT a "
		   + " right JOIN qna b ON a.midx=b.midx ";
		
				if(searchValue != null && !searchValue.equals("") && !searchValue.equals("null")){
					
					if(searchType.equals("qtitle")){
						sql += " where qtitle like '%"+searchValue+"%'";	
					}
															
				}
		sql += " order by qidx desc ) c) d ";
		sql += " where d.r>= "+paging.getStart()+" and d.r<= "+paging.getEnd();
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath() %>/css/base.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<%@ include file = "../header.jsp" %>
	
	
	<section>
	
	<div class="divright">
	
		<h2>QnA</h2>
		
		<div class="searchArea">
			<form action="qnalist.jsp">
				<select name = "searchType">
				   
					<option value="qtitle" <%if(searchType != null && searchType.equals("qtitle")) out.print("selected"); %>>글제목</option>
					<option value="mname" <%if(searchType != null && searchType.equals("mname")) out.print("selected"); %>>작성자</option>	
								
				</select>
			
				<input type="text" name="searchValue" 
				<%if(searchValue != null && !searchValue.equals("") && !searchValue.equals("null"))
					out.print("value='"+searchValue+"'"); %>>  <!-- 검색어 유지 추가 -->
			
				<input type="submit" value="검색">
							
			</form>
		</div>
		
		<table border="1" style="width:1000px;" >
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
				</tr>			
			</thead>
			<tbody>
			
			<%			
				while(rs.next()){					
			%>
				<tr>
					<td><%= rs.getInt("qidx") %></td>
					<td><a href="javascript:void(0);" onclick="goqna(this)"><%= rs.getString("qtitle") %></a></td>
					<td><%= rs.getString("Mname") %></td>
				</tr>
			<%
			}
			%>
			
			</tbody>
				
		</table>
			
			<%
				
				if(login != null){ 
			%>
								
			<input type="button" value="등록" onclick="location.href='insert.jsp'">
			<br>
			<%
			}
			%>
		
		<%
			if(paging.getStartPage() > 1){
		%>
		
			<a href="list.jsp?nowPage=<%=paging.getStartPage()-1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">&lt;</a>
		
		<%
			}
		
		for(int i= paging.getStartPage(); i<=paging.getEndPage(); i++){
			 
			if(i == paging.getNowPage()){
		%>
			<b><%= i %></b>		
		<%
			}else{
		%>
			
			<a href="list.jsp?nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%=i %></a>
		
		<%
			}
		}
			if(paging.getEndPage() != paging.getLastPage()){
		%>
		
			<a href="list.jsp?nowPage=<%=paging.getStartPage()+1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">&gt;</a>
		
		<%
			}
		%>
		
		
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
	function goqna(obj){
		var B = $(obj).parent().prev().text();
		
			location.href="view.jsp?qidx="+B;
	}
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
