<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import ="java.sql.*" %>
    <%@ page import="boardWeb.vo.*" %>
	<%@ page import="boardWeb.util.*" %>
    
<%
	request.setCharacterEncoding("UTF-8");

	String qidx = request.getParameter("qidx");
	String qtitle = request.getParameter("qtitle");
	String qcontent = request.getParameter("qcontent");


	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();
		
		
		String sql = " update qna set "
					+" qtitle = '"+qtitle+"' "
					+", qcontent = '"+qcontent+"' "
					+", qdate = sysdate "
					+" where qidx="+qidx;
		
				
		psmt = conn.prepareStatement(sql);
		
		//카운트 반환
		int result = psmt.executeUpdate();
		
		if(result>0){
	
			response.sendRedirect("view.jsp?qidx="+qidx);
			
		}else{
			
			response.sendRedirect("qnalist.jsp");
		}
		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
		
	}


%>