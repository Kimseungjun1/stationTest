<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="boardWeb.util.*" %>
<%@ page import="boardWeb.vo.*" %>

<%
	String midx = request.getParameter("midx");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = " delete from memberT where midx= "+midx;
				
		psmt = conn.prepareStatement(sql);
		
		//카운트 반환
		int result = psmt.executeUpdate();
		
		if(result>0){
			
			response.sendRedirect("/stationTest/index.jsp");
			session.invalidate();
			response.sendRedirect(request.getContextPath());
			
		}else{
			
			response.sendRedirect("mycheck.jsp");
		}
		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
	}


%>