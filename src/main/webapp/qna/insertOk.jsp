<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.* " %>
    
<%
	MemberT login = (MemberT)session.getAttribute("loginUser");

	request.setCharacterEncoding("UTF-8");
	
	String qtitle = request.getParameter("qtitle");
	String qcontent = request.getParameter("qcontent");
	String midx = request.getParameter("midx");
		
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs =null;
			
	try{
		conn = DBManager.getConnection();
		
		String sql = " insert into qna(qidx,qtitle,qdate,qcontent,midx) "
					+" values(qna_sequence.nextval,?,sysdate,?,?) ";
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,qtitle);
		psmt.setString(2,qcontent);
		psmt.setInt(3,login.getMidx());
		
		rs=psmt.executeQuery();
		
						
		response.sendRedirect("qnalist.jsp");		
		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
	}






%>
    