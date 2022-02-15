<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<link href="<%=request.getContextPath() %>/css/base.css" rel="stylesheet">
</head>
<body>
	<%@ include file = "../header.jsp" %>
	
	<section>
	
	<div class="divright">
		<form action = "createOk.jsp" method="post" id="frm">
				<div class="createheader">회원가입</div>
				<div class="createtitle">아이디<span class="red">*</span></div>
				<div>
					<input type="text" name="mid" id="mid" placeholder="아이디를 입력하세요.">
					<input type="button" value="id 중복확인">
					<span class="check"></span>
				</div>
				<div class="createtitle">비밀번호<span class="red">*</span></div>
				<div>
					<input type="password" name="mpwd" id="mpwd" placeholder="비밀번호를 입력하세요.">
					<span class="check"></span>
				</div>
				<div class="createtitle">비밀번호 확인<span class="red">*</span></div>
				<div>
					<input type="password" name="mpwdcheck" id="mpwdcheck" placeholder="비밀번호 확인">
					<span class="check"></span>
				</div>
				<div class="createtitle">이름<span class="red">*</span></div>
				<div>
					<input type="text" name="mname" id="mname" placeholder="이름을 입력하세요">
					<span class="check"></span>						
				</div>
				<div class="createtitle">생년월일<span class="red">*</span></div>
				<div>
					<input type="text" name="mbirth" id="mbirth" placeholder="ex) 20220127">
					<span class="check"></span>
				</div>
				<div class="createtitle">핸드폰 번호<span class="red">*</span></div>
				<div>
					<input type="text" name="mphone" id="mphone" placeholder="ex) 010-0000-0000">
					<span class="check"></span>
				</div>
				<div class="createtitle">이메일<span class="red">*</span></div>
				<div>
					<input type="text" name="memail" id="memail" placeholder="ex) sample@sample.com">
					<span class="check"></span>
				</div>
		
			<input type="button" value="회원가입" onclick="goMake(this)">
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
	<script>
	var createCount = false;
	
	
		/* var frm = document.getElementById('frm').submit(); */
		
		$(document).ready(function(){
			$("#mid").blur(function(){
				
				var value = $(this).val();
				var checkId = /^[a-z]+[a-z0-9]{4,15}/g;
				
				if(value==""){
					$(this).parent().children(".check").css("display","inline").html("*필수").css("color","red");

				}else if(!checkId.test(value)){
					$(this).next().next().css("display","inline").html("*형식 오류").css("color","red");

				}
				else{
					
					$(this).next().next().css("display","none");
				}
			});

			$("#mpwd").blur(function(){
				var value = $(this).val();
				var checkPs = /^.*(?=^.{6,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/g;
				if(value==""){
					$(this).next().css("display","inline").html("*필수").css("color","red");
				}
				else if(!checkPs.test(value)){
					$(this).next().css("display","inline").html("*형식 오류").css("color","red");
				}
				else{
					$(this).next().css("display","none");
				}

			});

			$("#mpwdcheck").blur(function(){
				var value = $(this).val();
				var value1 = $("input[type='password']").val();
				if(value==""){
					$(this).next().css("display","inline").html("*필수").css("color","red");
				}
				else if(value != value1){
					$(this).next().css("display","inline").html("*비밀 번호 불일치").css("color","red");
				}

				else{
					$(this).next().css("display","none");
				}
			});

			$("#mname").blur(function(){
				var value = $(this).val();
				var checkName = /^[가-힣]$/g;
				if(value ==""){
					$(this).next().css("display","inline").html("*필수").css("color","red");
				}
				else if(!checkName.test(value)){
					$(this).next().css("display","inline").html("*형식 오류").css("color","red");
				}
				else{
					$(this).next().css("display","none");
				}
			});

			$("#memail").blur(function(){
				var value = $(this).val();
				var checkEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/g;
				if(value ==""){
					$(this).next().css("display","inline").html("*필수").css("color","red");
				}
				else if(!checkEmail.test(value)){
					$(this).next().css("display","inline").html("*형식 오류").css("color","red");
				}
				else{
					$(this).next().css("display","none");
				}

			});

			$("#mphone").blur(function(){
				var mphoneCheck = /^[0-9]{3,4}/g;	
				var value = $(this).val();
				if(value ==""){
					$(this).next().css("display","inline").html("*필수").css("color","red");
				}
				else if(!mphoneCheck.test(value)){
					$(this).next().css("display","inline").html("*형식 오류").css("color","red");
				}
				else{
					$(this).next().css("display","none");
				}
			
			});

			$("#mbirth").blur(function(){
				var checkMbirth = /^[0-9]{8}/g;	
				var value = $(this).val();
				if(value ==""){
					$(this).next().css("display","inline").html("*필수").css("color","red");
				}
				else if(!checkMbirth.test(value)){
					$(this).next().css("display","inline").html("*형식 오류").css("color","red");
				}
				else{
					$(this).next().css("display","none");
				}
			
			});
			


		});
		
		function goMake(){
			
			if(){
								
			}
			
		}
		
	
	</script>

</body>
</html>