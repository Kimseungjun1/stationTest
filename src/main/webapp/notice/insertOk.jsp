<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.* " %>
    
<%
	MemberT login = (MemberT)session.getAttribute("loginUser");

	request.setCharacterEncoding("UTF-8");
	
	String nttitle = request.getParameter("nttitle");
	String ntcontent = request.getParameter("ntcontent");
		
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs =null;
			
	try{
		conn = DBManager.getConnection();
		
		String sql = " insert into noticeT(ntidx,nttitle,nthit,ntdate,ntcontent,ntwriter,midx) "
					+" values(noticeT_ntidx_SEQ.nextval,?,0,sysdate,?,'관리자',?) ";
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,nttitle);
		psmt.setString(2,ntcontent);
		psmt.setInt(3,1);
		
		rs=psmt.executeQuery();
		
						
		response.sendRedirect("noticeView.jsp");		
		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
	}






%>
    