<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%@ page import="java.sql.*" %>
    <%@ page import="boardWeb.util.*" %>
    <%@ page import="boardWeb.vo.*" %>
    
<%
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
		
		rs = psmt.executeQuery();
		MemberT m = null;
		
		if(rs.next()){
			 m = new MemberT();
			 
			 m.setMid(rs.getString("mid"));
			 m.setMidx(rs.getInt("midx"));
			 m.setMname(rs.getString("mname"));
			 m.setMgrade(rs.getString("mgrade"));
			 m.setMemail(rs.getString("memail"));
			 m.setDelyn(rs.getString("mdelyn"));
			 
			 
			 session.setAttribute("loginUser",m);
			 
			
			 
		}
		
		
		if(m != null){
			response.sendRedirect(request.getContextPath());
		}else{
			
			response.sendRedirect("login.jsp");
			
		}
		
	}catch(Exception e){
		e.printStackTrace();
		
	}finally{
		DBManager.close(psmt,conn,rs);
	}
	
%>
			
