<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "boardWeb.util.*" %>
<%@ page import = "boardWeb.vo.*" %>

<%
	request.setCharacterEncoding("UTF-8");	

	String mid = request.getParameter("mid");
	String mpwd = request.getParameter("mpwd");
	String mname = request.getParameter("mname");
	String mbirth = request.getParameter("mbirth");
	String mphone = request.getParameter("mphone");
	String memail = request.getParameter("memail");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql =" INSERT INTO MEMBERT(MIDX,MID,MPWD,MNAME,MBIRTH,MPHONE,MEMAIL,MGRADE,MDELYN) "
			  		+" VALUES(MEMBERT_MIDX_SEQ.nextval,?,?,?,?,?,?,'M','N') ";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,mid);
		psmt.setString(2,mpwd);
		psmt.setString(3,mname);
		psmt.setInt(4,Integer.parseInt(mbirth));
		psmt.setString(5,mphone);
		psmt.setString(6,memail);
		
		rs = psmt.executeQuery();
		
		response.sendRedirect("../index.jsp");
		
		
		System.out.println("멤버 생성 쿼리문 실행");
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}
	



%>