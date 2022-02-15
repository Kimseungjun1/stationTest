<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.util.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	String qridx = request.getParameter("qridx");
	String qrcontent = request.getParameter("qrcontent");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "update qnareply set qrcontent = ? where qridx= "+qridx;
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,"관리자에 의해 삭제되엇습니다.");
		
		psmt.executeUpdate();
		
	}catch(Exception e){
		e.printStackTrace();
		
	}finally{
		DBManager.close(psmt,conn);
	}



%>