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
				
	request.setCharacterEncoding("UTF-8");
	
	//searchValue가 null 이면 검색버튼을 누르지 않고 화면으로 들어옴.
	String searchValue = request.getParameter("searchValue");
	String searchType = request.getParameter("searchType");
	
	String nowPage = request.getParameter("nowPage");
	int nowPageI = 1;
	if(nowPage != null){
		nowPageI = Integer.parseInt(nowPage);
	}
	
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "system";
	String pass = "1234";
	
	Connection conn =null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	PagingUtil paging = null;
	
	try{
		
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url,user,pass);
	String sql = "";
		
	sql = "select count(*) as total from noticeT ";
		
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
		
		//널체크는 반드시 앞에서
		if(searchValue != null && !searchValue.equals("") && !searchValue.equals("null")){
			
			if(searchType.equals("nttitle")){
				sql += " where nttitle like '%"+searchValue+"%'";	
			}
			
			
			
		}
		
		sql += " ORDER BY ntidx DESC ) b) ";
		sql += " where r>= "+paging.getStart()+" and r<= "+paging.getEnd();
		
		psmt = conn.prepareStatement(sql);
		
		rs = psmt.executeQuery();	
	
  
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
	
		<div class="searchArea">
			<form action="noticeView.jsp">
				<select name = "searchType">
				   
					<option value="nttitle" <%if(searchType != null && searchType.equals("nttitle")) out.print("selected"); %>>글제목</option>
					<option value="ntwriter" <%if(searchType != null && searchType.equals("ntwriter")) out.print("selected"); %>>작성자</option>	
								
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
					<td><%= rs.getInt("ntidx") %></td>
					<td><a href="javascript:void(0);" onclick="goNtView(this)"><%= rs.getString("nttitle") %></a></td>
					<td><%= rs.getString("ntwriter") %></td>
				</tr>
			<%
			}
			%>
			
			</tbody>
				
		</table>
			
			<%
				
				if(mgrade.equals("A")){ 
			%>
								
			<input type="button" value="등록" onclick="location.href='insert.jsp'">
			<br>
			<%
			}
			%>
		
		<%
			if(paging.getStartPage() > 1){
		%>
		
			<a href="noticeView.jsp?nowPage=<%=paging.getStartPage()-1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">&lt;</a>
		
		<%
			}
		
		for(int i= paging.getStartPage(); i<=paging.getEndPage(); i++){
			 
			if(i == paging.getNowPage()){
		%>
			<b><%= i %></b>		
		<%
			}else{
		%>
			
			<a href="noticeView.jsp?nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%=i %></a>
		
		<%
			}
		}
			if(paging.getEndPage() != paging.getLastPage()){
		%>
		
			<a href="noticeView.jsp?nowPage=<%=paging.getStartPage()+1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">&gt;</a>
		
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
	function goNtView(obj){
		var A = $(obj).parent().prev().text();
		
		location.href='view.jsp?ntidx='+A;
				
		
	}
	
	</script>

</body>
</html>

<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null){
			conn.close();
		}
		if(psmt != null){
			psmt.close();
		}	
		if(rs != null){
			rs.close();
		}
		
	}
%>