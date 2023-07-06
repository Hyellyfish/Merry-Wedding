<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/main_temp/js/hscript.js"></script>
<script>
$(document).ready(function() {
	// 메세지 보내기 버튼 클릭 시
	$("#btnSendMsg").click(function(e) {
		if ($(this).attr("type") == "button") {
	 		alert("미리보기에서는 메세지 남기기 기능이 적용되지 않습니다.");  
	 	} else {
	 		// 비밀번호가 일치하지 않을 경우
	 		var inputCont = $("#mcontent").val();
	 		var inputName = $("#mname").val();
	 		var inputPw = $("#mpw").val();
	 		var inputPwc = $("#mpwConfirm").val();
	 		console.log("비밀번호: ", inputPw);
	 		console.log("비밀번호 확인: ", inputPwc);
	 		if (inputPw != "" && inputPwc !="" &&
	 				inputPw != inputPwc) {
	 			alert("비밀번호가 일치하지 않습니다.");
	 			e.preventDefault(); // 취소시 submit하지 않음
	 		} else if (inputCont != "" && inputName != "" &&
	 				inputPw != "" && inputPwc != "" &&
	 				inputPw == inputPwc) {
	 			// 이미지 선택하지 않았을 경우
		 		if ($("#filename").attr("data-file") == "none") {
		 			if (confirm("이미지를 선택하지 않을 경우 기본 이미지로 등록됩니다. 계속 진행하시겠습니까?") == false) {
						e.preventDefault(); // 취소시 submit하지 않음
					}
		 		}
	 		}
		}
	});
	
	// 파일 선택 버튼
	$("#btnInputFile").click(function () {
		$("#inputFile").trigger("click");
	});
	
	// 파일 선택시
	$("#inputFile").change(function(e) {
		var fileName = $(this).val().split("\\").pop();
		var file = this.files[0];
		if (isImage(file)) {
			$("#filename").text(fileName);
			$("#filename").attr("data-file", "selected");
		} else {
			alert("해당 파일은 이미지 파일이 아닙니다. 이미지 파일을 등록해주세요.");
		}
	});
});
</script>
    <!-- 축하 메세지 남기기 -->
	<div id="fh5co-started" class="fh5co-bg" 
	<c:choose>
			<c:when test="${tpVo.tp_mpic ne null}"
			>style="background-image:url(/tempH/displayImage?pic=${tpVo.tp_mpic});"</c:when>
			<c:otherwise>style="background-image:url(/create_tempH/images/sample_msg.jpg);"</c:otherwise>
		</c:choose>>
		<div id="sendMsg" class="overlay"></div>
		<div class="container">
			<div class="row animate-box">
				<div class="col-md-8 col-md-offset-2 text-center fh5co-heading">
					<h2>축복해 주세요</h2>
					<p style="margin:20px 0px 20px;">축복의 말을 전하고 싶으시다면 축하 메세지를 남겨주세요.
						<br>(※ 비밀번호를 잊어버린 경우, 신랑 또는 신부에게 요청하시면 비밀번호를 찾아드립니다.)
					</p>
				</div>
			</div>
			<div class="row animate-box">
				<div class="col-md-5 col-md-offset-1" style="margin-left: 29.3%;">
					<form action="/hMessage/insertMsg" method="post" enctype="multipart/form-data">
						<div class="col-md-12 col-sm-4">
							<div class="form-group">
								<textarea class="form-control" id="mcontent" name="m_text" placeholder="내용을 입력하세요." 
									style="font-family: 'SimKyungha'; resize:none; height:200px;"
									required></textarea>
							</div>
						</div>
						<div class="col-md-12 col-sm-4">
							<div class="form-group">
								<input type="text" class="form-control" id="mname" name="m_name"
									placeholder="이름을 입력하세요." maxlength="16" style="font-family:'SimKyungha';" required>
							</div>
						</div>
						<div class="col-md-6 col-sm-2">
							<div class="form-group" style="margin-right:10px;">
								<input type="password" class="input_mpw form-control noSpace" 
									id="mpw" name="m_pw" placeholder="비밀번호(최대 20자)" maxlength="20" required>
							</div>
						</div>
						<div class="col-md-6 col-sm-2">
							<div class="form-group">
								<input type="password" class="input_mpw form-control noSpace" id="mpwConfirm" 
									placeholder="비밀번호 확인" maxlength="20" required>
							</div>
						</div>
						<div class="col-md-7 col-sm-4">
							<h2 id="filename" style="margin-top:15px; margin-left:10px; font-size:16px; color:white;"
								data-file="none">파일명.jpg</h2>
						</div>
						<div class="col-md-3 col-sm-4">
							<button id="btnInputFile" type="button" class="btn btn-default btn-block">파일 선택</button>
							<input id="inputFile" name="mpic" type="file" style="display:none;">
						</div>
						<div class="col-md-2 col-sm-4">
							<button id="btnSendMsg" class="btn btn-default btn-block"
								type="submit">남기기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
</div>

		<div class="gototop js-top">
			<a href="#" class="js-gotop"><i class="icon-arrow-up"></i></a>
		</div>
	</body>
</html>    