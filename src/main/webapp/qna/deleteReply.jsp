<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.util.*" %>

<%
	String qridx = request.getParameter("qridx");

	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		
		conn = DBManager.getConnection();
		
		String sql = "delete from qnareply where qridx ="+qridx;
		
		psmt = conn.prepareStatement(sql);
		
		psmt.executeUpdate();
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn);
	}



%>