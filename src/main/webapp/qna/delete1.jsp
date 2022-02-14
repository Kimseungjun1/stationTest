<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="boardWeb.util.*" %>
<%@ page import="boardWeb.vo.*" %>

<%
	String qidx = request.getParameter("qidx");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = " delete from qna where qidx= "+qidx;
				
		psmt = conn.prepareStatement(sql);
		
		//카운트 반환
		int result = psmt.executeUpdate();
		
		if(result>0){
			
			response.sendRedirect("qnalist.jsp");
			
		}else{
			
			response.sendRedirect("view.jsp?qidx="+qidx);
		}
		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
	}


%>