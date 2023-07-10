<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/m_header.jsp" %>
<script>
	$(document).ready(function() {
		// ID 중복 확인 버튼
		$("#btncheckId").click(function() {
			var inputId = $("#userid").val();
			console.log("입력한 아이디 값: ", inputId);
			if (inputId != "") {
				var url = "/user/isExistId"
				var sData = {
					"inputId" : inputId
				}
				$.get(url, sData, function(rData) {
					if (inputId != "" && rData == "false") {
						alert("사용할 수 있는 아이디입니다.");
						$("#btncheckId").attr("value", inputId);
					} else {
						alert("사용할 수 없는 아이디입니다.");
						$("#userid").val("");
					}
				});
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
						$("#userurl").val("");
					}
				});
			}
		});
		
		// 이전으로 버튼
		$("#btnBack").click(function(e) {
			$(location).attr('href', '/main/login');
		});
		
		
		// 가입하기 버튼
		$("#btnsignin").click(function(e) {
			var userid = $("#userid").val();
			var userpw = $("#userpw").val();
			var chkuserpw = $("#chkuserpw").val();
			var username = $("#username").val();
			var email = $("#email").val();
			var phonenum = $("#phonenum").val();
			var userurl = $("#userurl").val();
			if (userid!=""&&userpw!=""&&chkuserpw!=""&&userurl!=""&&
					username!=""&&email!=""&&phonenum!="") { // 공백란이 없을 때
				// ID, URL 중복확인 여부 체크
				var checkId = $("#btncheckId").val();
				var inputId = userid;
				var checkUrl = $("#btncheckUrl").val();
				var inputUrl = $("#userurl").val();
				if (checkId == inputId) {
					if (checkUrl != inputUrl) {
						e.preventDefault();
						alert("url 중복 확인을 해주세요");
					} else { // 중복확인 모두 완료한 경우
						// 비밀번호 일치할 때 가입완료 처리
						var pw = userpw;
						var pwc = chkuserpw;
						if (pw != "" && pwc != "" && pw != pwc) {
							e.preventDefault();
							alert("비밀번호가 일치하지 않습니다.");
						}
					}
				} else {
					e.preventDefault();
					console.log("false");
					alert("아이디 중복 확인을 해주세요");
				}
			} else { // 공백란이 있을 때
				e.preventDefault();
				alert("입력란을 작성해 주세요");
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
 	
 	<!-- banner -->
	</header>
	<!-- end banner -->

	<div class="back_re">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="title">
						<h2>회원가입</h2>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--  contact -->

	<!-- new template -->
	<div class="container-fluid" style="padding: 90px 700px">
		<div class="row">
			<div class="col-md-12">
				<form id="frmRegister" action="/user/register_run" method="post">
					<div class="form-group rg_div">
						<label for="userid" class="rg_lbl">아이디</label>
						<input type="text" class="inputs noSpace"
							id="userid" placeholder="아이디" name="userid" required>
						<button type="button" class="btn btn-beige btn-sm" style="margin-top:10px;"
							id="btncheckId">아이디 중복 확인</button>
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
						<input type="text" class="inputs noSpace" 
							id="username" placeholder="이름" name="username" required>
					</div>
					<div class="form-group rg_div">
						<label for="email" class="rg_lbl">이메일</label>
						<input type="email" class="inputs noSpace" 
							id="email" placeholder="이메일" name="email" required>
					</div>
					<div class="form-group rg_div">
						<label for="phonenum" class="rg_lbl">전화번호</label>
						<input type="tel" class="inputs noSpace"
							id="phonenum" name="phonenum" placeholder="'&nbsp;-&nbsp;'&nbsp;제외하고 숫자만 입력해주세요." required>
					</div>
					<div class="form-group rg_div">
						<label for="userurl" class="rg_lbl">홈페이지 주소 입력</label><br>
						localhost/url/
						<input type="text" class="inputs noSpace" id="userurl" name="url"
							placeholder="※영문으로 입력해 주세요. 예) merry-wedding" required>
						<button type="button" class="btn btn-beige btn-sm" style="margin-top:10px;"
							id="btncheckUrl">url 중복 확인</button>
					</div>
					<div class="text-center">
						<button type="button" id="btnBack" class="btn btn-gray btn-lg"
							>이전으로</button>
						<button type="submit" id="btnsignin" class="btn btn-brown btn-lg"
							>가입하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- //new template -->
	<!-- end contact -->
<%@ include file="../include/m_footer.jsp" %>
