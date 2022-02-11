<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%@ page import="java.sql.*" %>
    <%@ page import="boardWeb.util.*" %>
    <%@ page import="boardWeb.vo.*" %>
    
<%	
	MemberT login = (MemberT)session.getAttribute("loginUser");
	
    String mid = request.getParameter("mid");
	String mpwd = request.getParameter("mpwd");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	
	try{
		conn = DBManager.getConnection();
		
		String sql = " select * from memberT where mid =? and mpwd =? ";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,mid);
		psmt.setString(2,mpwd);
							 
		//카운트 반환
		boolean Rs_ = psmt.execute();
		
		if(Rs_==true){
				
				response.sendRedirect("mylist.jsp?midx="+login.getMidx());
				
		}else{
			
				response.sendRedirect("/stationTest/index.jsp");
			
			}
		
	}catch(Exception e){
		e.printStackTrace();
		
	}finally{
		DBManager.close(psmt,conn,rs);
	}
	
%>
			
