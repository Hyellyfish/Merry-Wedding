<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/mp_header.jsp" %>
<script>
$(document).ready(function() {
	$("#mptitle_h2").text("내 정보 수정");
	$("#edit_a").css("color", "#BBAEA0");
	$("#edit_a").attr("id", "welcome");
	$("#mp_menudiv").css("height", "auto");
	
	// 수정 실패시
	if ("${update_result}" == "fail") {
		alert("회원정보 수정에 실패하였습니다.");		
	}
		
	// Url 중복 확인 버튼 출력
	$("#userurl").keyup(function() {
		var prevUrl = "${loginInfo.url}";
		var newUrl = $(this).val();
		if (prevUrl == newUrl) { // 같으면 변경x->버튼 필요없음
			$("#btncheckUrl").hide();	
		} else {
			$("#btncheckUrl").show();			
		}
	});
	
	// Url 중복 확인 버튼
	$("#btncheckUrl").click(function() {
		var inputUrl = $("#userurl").val();
		console.log("입력한 url 값: ", inputUrl);
		if (inputUrl != "") {
			var url = "/user/isExistUrl";
			var sData = {
				"inputUrl" : inputUrl
			};
			$.get(url, sData, function(rData) {
				console.log("rData: ", rData);
				if (inputUrl != "" && rData == "false") {
					alert("사용 가능한 url입니다.");
					$("#btncheckUrl").attr("value", inputUrl);
				} else {
					alert("사용할 수 없는 url입니다.");
				}
			});
		}
	});
	
	// 수정하기 버튼
	$("#btnEdit").click(function(e) {
		var prevUrl = "${loginInfo.url}";
		var newUrl = $("#userurl").val();
		if (prevUrl != newUrl) { // url 변경한 경우
			// URL 중복확인 여부 체크
			var checkUrl = $("#btncheckUrl").val();
			var inputUrl = $("#userurl").val();
			console.log("ckurl: ", checkUrl);
			if (checkUrl != inputUrl) {
				e.preventDefault();
				alert("url 중복 확인을 해주세요");
			} else { // 중복확인 완료한 경우
				// 비밀번호 일치할 때 가입완료 처리
				var pw = $("#userpw").val();
				var pwc = $("#chkuserpw").val();
				if (pw != "" && pwc != "" && pw != pwc) {
					e.preventDefault();
					alert("비밀번호가 일치하지 않습니다.");
				}
			}
		}
	});
	
	// 숫자만 입력(전화번호)
	$("#phonenum").keyup(function() {
		var inputNum = $(this).val();
		$(this).val(inputNum.replace(/[^0-9]/gi,''));
	});
	
	// 비밀번호 일치여부 확인메세지 출력(비밀번호 입력란)
	$("#userpw").keyup(function() {
		var pw = $(this).val();
		var pwc = $("#chkuserpw").val();
		if (pw=="" && pwc=="") { // 입력하지 않은 경우
			$("#pwNo").hide();
			$("#pwOk").hide();	
		} else if (pw!="" && pwc!="" && pw == pwc) { // 일치할 경우
			$("#pwNo").hide();
			$("#pwOk").show();			
		} else if (pw != pwc) { // 불일치할 경우
			$("#pwOk").hide();
			$("#pwNo").show();
		}
	});
	
	// 비밀번호 일치여부 확인메세지 출력(비밀번호 확인 입력란)
	$("#chkuserpw").keyup(function() {
		var pw = $("#userpw").val();
		var pwc = $(this).val();
		if (pw=="" && pwc=="") { // 입력하지 않은 경우
			$("#pwNo").hide();
			$("#pwOk").hide();	
		} else if (pw!="" && pwc!="" && pw == pwc) { // 일치할 경우
			$("#pwNo").hide();
			$("#pwOk").show();			
		} else if (pw != pwc) { // 불일치할 경우
			$("#pwOk").hide();
			$("#pwNo").show();
		}
	});
});
</script>
<div class="text-center">
	<h1 class="mp_titleh1">Information</h1>
</div>
<div class="container-fluid" style="padding: 0px 350px">
	<div class="row">
		<div class="col-md-12">
			<form id="frmEdit" action="/user/edit_run" method="post">
				<div class="form-group rg_div">
					<label for="userid" class="rg_lbl">아이디</label>
					<input value="${loginInfo.userid}" type="text" class="inputs noSpace"
						id="userid" placeholder="아이디" name="userid" readonly style="background:#E3E7EA">
				</div>
				<div class="form-group rg_div">
					<label for="userpw" class="rg_lbl">비밀번호</label>
					<input type="password" class="inputs noSpace" style="font-family:'Raleway', sans-serif" 
						id="userpw" placeholder="비밀번호" name="userpw" required>
				</div>
				<div class="form-group rg_div">
					<label for="chkuserpw" class="rg_lbl">비밀번호 확인</label>
					<input type="password" class="inputs noSpace" style="font-family:'Raleway', sans-serif"
						id="chkuserpw" placeholder="비밀번호 확인" required>
					<p style="font-size:12px; color:#413731; display:none;" id="pwOk">비밀번호가 일치합니다.</p>
					<p style="font-size:12px; color:#e76f64; display:none;" id="pwNo">비밀번호가 일치하지 않습니다.</p>
				</div>
				<div class="form-group rg_div">
					<label for="username" class="rg_lbl">이름</label>
					<input type="text" class="inputs noSpace" value="${loginInfo.username}"
						id="username" placeholder="이름" name="username" required>
				</div>
				<div class="form-group rg_div">
					<label for="email" class="rg_lbl">이메일</label>
					<input type="email" class="inputs noSpace" value="${loginInfo.email}"
						id="email" placeholder="이메일" name="email" required>
				</div>
				<div class="form-group rg_div">
					<label for="phonenum" class="rg_lbl">전화번호</label>
					<input type="tel" class="inputs noSpace" value="${loginInfo.phonenum}"
						id="phonenum" name="phonenum" placeholder="'&nbsp;-&nbsp;'&nbsp;제외하고 숫자만 입력해주세요." required>
				</div>
				<div class="form-group rg_div">
					<label for="userurl" class="rg_lbl">홈페이지 주소 입력</label><br>
					localhost/url/
					<input type="text" class="inputs noSpace" id="userurl" name="url" value="${loginInfo.url}"
						placeholder="※영문으로 입력해 주세요. 예) merry-wedding" required>
					<button type="button" class="btn btn-beige btn-sm" style="margin-top:10px; display:none;"
						id="btncheckUrl">url 중복 확인</button>
				</div>
				<div class="text-center" style="margin-top:80px;">
					<button type="submit" id="btnEdit" class="btn btn-brown btn-lg"
						>수정하기</button>
				</div>
			</form>
		</div>
	</div>
</div>
<%@ include file="../include/mp_footer.jsp" %>