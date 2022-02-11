<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="boardWeb.util.*" %>
<%@ page import="boardWeb.vo.*" %>

<%
	String ntidx = request.getParameter("ntidx");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = " delete from noticeT where ntidx= "+ntidx;
				
		psmt = conn.prepareStatement(sql);
		
		//카운트 반환
		int result = psmt.executeUpdate();
		
		if(result>0){
			
			response.sendRedirect("noticeView.jsp");
			
		}else{
			
			response.sendRedirect("view.jsp?ntidx="+ntidx);
		}
		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
	}


%>