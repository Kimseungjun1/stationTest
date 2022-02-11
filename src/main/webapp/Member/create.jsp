<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath() %>/css/base.css" rel="stylesheet">
</head>
<body>
	<%@ include file = "../header.jsp" %>
	
	<section>
	
	<div class="divright">
		<form action = "createOk.jsp" method="post">
				<div class="createheader">회원가입</div>
				<div class="createtitle">아이디<span class="red">*</span></div>
				<div>
					<input type="text" name="mid" placeholder="아이디를 입력하세요.">
					<input type="button" value="id 중복확인">
					<span class="check"></span>
				</div>
				<div class="createtitle">비밀번호<span class="red">*</span></div>
				<div>
					<input type="password" name="mpwd" placeholder="비밀번호를 입력하세요.">
					<span class="check"></span>
				</div>
				<div class="createtitle">비밀번호 확인<span class="red">*</span></div>
				<div>
					<input type="password" name="mpwdcheck" placeholder="비밀번호 확인">
					<span class="check"></span>
				</div>
				<div class="createtitle">이름<span class="red">*</span></div>
				<div>
					<input type="text" name="mname" placeholder="이름을 입력하세요">
					<span class="check"></span>						
				</div>
				<div class="createtitle">생년월일<span class="red">*</span></div>
				<div>
					<input type="text" name="mbirth" placeholder="ex) 20220127">
					<span class="check"></span>
				</div>
				<div class="createtitle">핸드폰 번호<span class="red">*</span></div>
				<div>
					<input type="text" name="mphone" placeholder="ex) 010-0000-0000">
					<span class="check"></span>
				</div>
				<div class="createtitle">이메일<span class="red">*</span></div>
				<div>
					<input type="text" name="memail" placeholder="ex) sample@sample.com">
					<span class="check"></span>
				</div>
		
			<input type="submit" value="회원가입">
		</form>
		
	</div>
	<div class="divleft">
		
			<a href="../login/login.jsp">로그인</a>
			<a href="create.jsp">회원가입</a>			
		
	 	<table class="menuleft">
	 		<tr>
	 			<td><a href="../notice/noticeView.jsp">공지사항</a></td>
	 		</tr>
	 		<tr>
	 			<td><a>전라북도</a></td>
	 		</tr>
	 		<tr>
	 			<td><a href="/stationTest/qna/qnalist.jsp">Q&A</a></td>
	 		</tr>
	 		
	 	</table>
	 	
	</div>
		
	
	</section>
	
	<%@ include file = "../footer.jsp" %>

</body>
</html>