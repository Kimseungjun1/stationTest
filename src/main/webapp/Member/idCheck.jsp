<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.vo.*" %>
<%@ page import= "java.util.*" %>
<%@ page import="boardWeb.util.*" %>
<%@ page import="java.sql.*" %>
<%

	String mid = request.getParameter("mid");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = " select * from memberT where mid= '"+mid+"' ";
		
		psmt = conn.prepareStatement(sql);
		
		rs = psmt.executeQuery();
		
		if(rs.next()){
			
			out.print(rs.getString("mid"));
		}
		
		
		
		
		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
	}
	
%>