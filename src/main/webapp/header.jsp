<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "boardWeb.vo.*" %>
<%
	MemberT loginH = (MemberT)session.getAttribute("loginUser");

%>


    <header>
    	<h1>게시판 만들기</h1>
		
    	<table class="menubar">
    		<tr>
    			<td><a href="/stationTest/notice/noticeView.jsp">공지사항</a></td>
    			<!-- href = " /" 를 붙이고하면 localhost:8080/에서부터 시작 -->
    			<td><a>전라북도</a></td>
    			<td><a href="/stationTest/qna/qnalist.jsp">Q&A</a></td>
    			<%if(loginH != null) {%>
    			<td><a href="/stationTest/my/mycheck.jsp">마이페이지</a></td>
    			<%} %>
    		</tr>
    	</table>
    	    	

    	<div class="homeArea">
    	<a href="/stationTest/index.jsp">홈으로</a>
    	<%if(loginH != null){  %>
    	<a href="/stationTest/login/logout.jsp">로그아웃</a>
    	<%} %>
    	</div>

    	
    </header>