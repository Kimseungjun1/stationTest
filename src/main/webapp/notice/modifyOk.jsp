<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="boardWeb.util.*" %>
<%@ page import="boardWeb.vo.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	String ntidx = request.getParameter("ntidx");
	String nttitle = request.getParameter("nttitle");
	String ntcontent = request.getParameter("ntcontent");
	String ntdate = request.getParameter("ntdate");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = " update noticeT set "
					+" nttitle = '"+nttitle+"', "
					+" ntcontent = '"+ntcontent+"', "
					+" ntdate = '"+ntdate+"' "
					+" where ntidx="+ntidx;
		
		psmt = conn.prepareStatement(sql);
		
		//카운트 반환
		int result = psmt.executeUpdate();
		
		if(result>0){
			
			response.sendRedirect("view.jsp?ntidx="+ntidx);
			
		}else{
			
			response.sendRedirect("noticeView.jsp");
		}
		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
	}


%>