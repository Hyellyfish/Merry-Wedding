<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/mp_header.jsp" %>
<script>
$(document).ready(function() {
	$("#mptitle_h2").text("비밀번호 입력");
	var tl = "${pw_targetLocation}";
	console.log("tl: ", tl);
	switch (tl) {
		case "/user/edit_form":
			$("#edit_a").css("color", "#BBAEA0");
			$("#edit_a").attr("id", "welcome");
			break;
		case "/user/delete_run":
			$("#deleteUser").css("color", "#BBAEA0");
			$("#deleteUser").attr("id", "welcome");
			break;
	}
	
	// 비밀번호 불일치
	if ("${checkPw}" == "wrong"){
		alert("비밀번호가 일치하지 않습니다.");
	}
});
</script>
<div class="text-center">
	<div class="text-center">
		<h1 class="mp_titleh1">Password</h1>
	</div>
	<h3 class="mp_titleh3">회원님의 개인정보 보호를 위해 비밀번호를 한 번 더 입력해 주세요.</h3>
	<form action="/user/input_password_run" method="post">
		<div style="margin-top:50px;">
			<input type="password" class="inputs noSpace" style="font-family:'Raleway', sans-serif; display:inline; width: 35%;"
				id="inputPw" name="inputPw" placeholder="비밀번호"  required>
			<button type="submit" class="btn btn-brown" style="margin-left: 5px;"
				id="btnsubmit">확인</button>
		</div>
	</form>
</div>
<%@ include file="../include/mp_footer.jsp" %>