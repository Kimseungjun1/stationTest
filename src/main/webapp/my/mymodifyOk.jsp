<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="boardWeb.util.*" %>
<%@ page import="boardWeb.vo.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	String midx = request.getParameter("midx");
	String mpwd = request.getParameter("mpwd");
	String mphone = request.getParameter("mphone");
	String mbirth = request.getParameter("mbirth");
	String memail = request.getParameter("memail");
	
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = " update MemberT set "
					+" mpwd = '"+mpwd+"', "
					+" mphone = '"+mphone+"', "
					+" mbirth = '"+mbirth+"', "
					+" memail = '"+memail+"' "
					+" where midx="+midx;
		
		psmt = conn.prepareStatement(sql);
		
		//카운트 반환
		int result = psmt.executeUpdate();
		
		if(result>0){
			
			response.sendRedirect("mylist.jsp?midx="+midx);
			
		}else{
			
			response.sendRedirect("mymodify.jsp");
		}
		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
	}


%>