<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.util.*" %>
<%@ page import= "java.util.*" %>
<%@ page import = "org.json.simple.*" %>
<%@ page import="boardWeb.vo.*" %>

<%
	request.setCharacterEncoding("UTF-8");	
	
	String qidx = request.getParameter("qidx");
		
	String qrcontent = request.getParameter("qrcontent");
	
	MemberT login = (MemberT)session.getAttribute("loginUser");
	
	int midx = login.getMidx();
		
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "insert into qnareply(qridx,qidx,qrcontent,midx,qrdate)"
					+"values(qnareply_sequence.nextval,?,?,?,sysdate)";
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setInt(1,Integer.parseInt(qidx));
		psmt.setString(2,qrcontent);
		psmt.setInt(3,midx);
		
		psmt.executeUpdate();
		
		
		sql =  "SELECT * FROM qnareply r, memberT m where r.midx=m.midx and qridx = (select max(qridx) from qnareply)";
		
		
		psmt = conn.prepareStatement(sql);
		
		rs = psmt.executeQuery();
		
		JSONArray list = new JSONArray();
		
		if(rs.next()){
			JSONObject obj = new JSONObject();
			
			obj.put("qidx",rs.getInt("qidx"));
			obj.put("midx",rs.getInt("midx"));
			obj.put("qridx",rs.getInt("qridx"));
			obj.put("mname",rs.getString("mname"));
			obj.put("qrcontent",rs.getString("qrcontent"));
			
			list.add(obj);
			
		}
	
		out.print(list.toJSONString());
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}
	
%>