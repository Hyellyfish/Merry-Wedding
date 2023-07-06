<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/h_header.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(document).ready(function() {
	// 좋아요 하트(비동기)
	$(".likeHeart").click(function(e) {
		e.preventDefault();
		var likeHeart = $(this);
		var heart_icon = $(this).children();
		var heart_num = $(this).parent().next().children();
		likeHeart.attr("data-clicked", "yes"); // 좋아요인지 모달창인지 구분하기 위함
		var mode = likeHeart.attr("data-mode");
		if (mode == "preview") { // 미리보기에서는 좋아요 불가능
			alert("미리보기에서는 좋아요 기능이 적용되지 않습니다.");
		} else {
			var heart_mno = likeHeart.attr("data-mno");
			console.log("heart_mno: ", heart_mno);
			var islike = likeHeart.attr("data-islike");
			console.log("islike: ", islike);
	 		if (islike == "false") { // 좋아요 누르지 않은 상태
	 			sendurl = "/hMessage/like";
	 		} else {
	 			sendurl = "/hMessage/likeCancel";
	 		}
	 		// 비동기 처리
	 		var sData = {"mno" : heart_mno};
	 		$.get(sendurl, sData, function(rData) {
	 			console.log("rData: ", rData);
	 			if (rData == "true") {
	 				var strCount = heart_num.text();
	 				if (islike == "false") {
	 					var count = parseInt(strCount) + 1;
	 					heart_icon.css("color", "red");
	 					heart_num.text(count);
	 					likeHeart.attr("data-islike", "true");
	 				} else { // islike == true
	 					var count = parseInt(strCount) - 1;
	 					heart_icon.css("color", "rgba(0,0,0,0.7)");
	 					heart_num.text(count);
	 					likeHeart.attr("data-islike", "false");
	 				}
	 			} //if (rData == "true")
	 		}); //$.get
		}
	});
	
	// 메세지 클릭 시 모달창 활성화
	$(".msgBox").click(function() {
		var heart = $(this).find(".likeHeart");
		var clicked = heart.attr("data-clicked");
		var mno = heart.attr("data-mno");
		var mname = $(this).attr("data-mname");
		var mtext = $(this).attr("data-mtext");
		var mpw = $(this).attr("data-mpw");
		var mode = $(this).attr("data-mode");
		if (clicked == "yes") { // 하트 클릭한 경우일 때
			heart.attr("data-clicked", "no");
		} else { // 메세지 클릭한 경우일 때
			$("#modalTitle").text(mname);
			$("#btnEdit").attr("data-mode", mtext); // 수정버튼에 메세지 내용 데이터 저장해놓기
			$("#btnEdit").attr("data-mpw", mpw); // 수정버튼에 비밀번호 데이터 저장해놓기
			$("#btnEdit").attr("data-mno", mno); // 수정버튼에 mno 데이터 저장해놓기
			$("#mimno").val(mno);
			$("#min").val(mname);
			if (mode == "preview") { // 미리보기에서는 수정, 삭제 불가능
				$("#modal_p").text(mtext);
				$("#btnEdit").attr("data-mode", "preview");
				$("#btnDelete").attr("data-mode", "preview");
			} else {
				// 메세지 개행문자 처리
				mtext = $(this).find(".ta_mtext").val();
				var txtresult = mtext.replace(/(\n|\r\n)/g, '<br>');
				$("#modal_p").text("");
				$("#modal_p").append(txtresult);
			}
			$("#openModal").trigger("click");		
		}
	});
	
	// 모달창 닫기버튼 클릭 시
	$("#btnPause").click(function() {
		reset();
	});
	
	// 모달창 수정버튼 클릭 시
	$("#btnEdit").click(function() {
		var mode = $(this).attr("data-mode");
		if (mode == "preview") {
			alert("미리보기에서는 지원되지 않는 기능입니다.");
		} else {
			var pw = $(this).attr("data-mpw");
			console.log("pw: ", pw);
			var inputPw = prompt("비밀번호를 입력하세요.");
			console.log("inputPw: ", inputPw);
			if (inputPw != null && inputPw != pw) {
				alert("비밀번호가 일치하지 않습니다.");
			} else if (inputPw != null && inputPw == pw) {
				var mtext = $(this).attr("data-mode");
				$("#modal_textarea").text(mtext);
				$("#modal_p").hide();
				$("#div_edit").show();
				$(this).hide();
				$("#btnClose").hide();
				$("#btnDelete").hide();
				$("#btnCancel").show();
				$("#btnEditOk").show();
			}
		}
	});
	
	// 수정 - 파일 선택 버튼
	$("#btnMif").click(function () {
		$("#mif").trigger("click");
	});
	
	// 수정 - 파일 선택시
	$("#mif").change(function(e) {
		var fileName = $(this).val().split("\\").pop();
		var file = this.files[0];
		if (isImage(file)) {
			$("#fname").text(fileName);
			$("#fname").attr("data-file", "selected");
		} else {
			alert("해당 파일은 이미지 파일이 아닙니다. 이미지 파일을 등록해주세요.");
		}
	});
	
	// 수정 - 비밀번호 일치여부 확인메세지 출력
	$("#mip").keyup(function() {
		var pw = $(this).val();
		var pwc = $("#mipc").val();
		if (pw=="" && pwc=="") { // 입력하지 않은 경우
			$("#pwNo").hide();
			$("#pwOk").hide();
			$("#pwNeed").show();	
		} else if (pw!="" && pwc!="" && pw == pwc) { // 일치할 경우
			$("#pwNeed").hide();
			$("#pwNo").hide();
			$("#pwOk").show();			
		} else if (pw != pwc) { // 불일치할 경우
			$("#pwNeed").hide();
			$("#pwOk").hide();
			$("#pwNo").show();
		}
	});
	
	$("#mipc").keyup(function() {
		var pw = $("#mip").val();
		var pwc = $(this).val();
		if (pw=="" && pwc=="") { // 입력하지 않은 경우
			$("#pwNo").hide();
			$("#pwOk").hide();
			$("#pwNeed").show();	
		} else if (pw!="" && pwc!="" && pw==pwc) { // 일치할 경우
			$("#pwNeed").hide();
			$("#pwNo").hide();
			$("#pwOk").show();			
		} else if (pw != pwc) { // 불일치할 경우
			$("#pwNeed").hide();
			$("#pwOk").hide();
			$("#pwNo").show();
		}
	});
	
	// 모달창 취소버튼 클릭 시
	$("#btnCancel").click(function() {
		reset();
	});
	
	// 모달창 수정완료버튼 클릭 시
	$("#btnEditOk").click(function(e) {
		// 비밀번호가 일치하지 않을 경우
 		var inputCont = $("#modal_textarea").val();
 		var inputName = $("#min").val();
 		var inputPw = $("#mip").val();
 		var inputPwc = $("#mipc").val();
 		if (inputPw != "" && inputPwc !="" &&
 				inputPw != inputPwc) {
 			alert("비밀번호가 일치하지 않습니다.");
 			e.preventDefault(); // 취소시 submit하지 않음
 		} else if (inputCont != "" && inputName != "" &&
 				inputPw != "" && inputPwc != "" &&
 				inputPw == inputPwc) {
 			// 이미지 선택하지 않았을 경우
	 		if ($("#fname").attr("data-file") == "none") {
	 			if (confirm("이미지를 선택하지 않을 경우 등록된 이미지가 유지됩니다. 계속 진행하시겠습니까?") == false) {
					e.preventDefault(); // 취소시 submit하지 않음
				} else {
					reset();
				}
	 		}
 		}
	});
	
	// 모달창 삭제버튼 클릭 시
	$("#btnDelete").click(function() {
		var mode = $(this).attr("data-mode");
		if (mode == "preview") {
			alert("미리보기에서는 지원되지 않는 기능입니다.");
		} else {
			var pw = $("#btnEdit").attr("data-mpw");
			console.log("pw: ", pw);
			var inputPw = prompt("비밀번호를 입력하세요.");
			console.log("inputPw: ", inputPw);
			if (inputPw != null && inputPw != pw) {
				alert("비밀번호가 일치하지 않습니다.");
			} else if (inputPw != null && inputPw == pw) {
				if (confirm("삭제하시겠습니까?") == true) {
					var mno = $("#btnEdit").attr("data-mno");
					location.href="/hMessage/delete?mno="+mno;
				}
			}
		}
	});
	
	// 모달창 세팅 초기화
	function reset() {
		$("#div_edit").hide();
		$("#modal_p").show();
		$("#btnCancel").hide();
		$("#btnEditOk").hide();
		$("#btnClose").show();
		$("#btnEdit").show();
		$("#btnDelete").show();
	}
});
</script>
	<header id="fh5co-header" class="fh5co-cover fh5co-cover-sm" role="banner" 
	<c:choose>
		<c:when test="${tpVo.tp_titlepic ne null}">
			style="background-image:url(/tempH/displayImage?pic=${tpVo.tp_titlepic});"
		</c:when>
		<c:otherwise>
			style="background-image:url(/create_tempH/images/sample_home.jpg);"
		</c:otherwise>
	</c:choose>
	>
		<div class="overlay"></div>
		<div class="fh5co-container">
			<%@ include file="/WEB-INF/views/include/h_header_title.jsp"%>
		</div>
	</header>

	<div id="fh5co-gallery">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-offset-2 text-center fh5co-heading animate-box">
					<span>MESSAGES</span>
					<h2>축복의 메세지</h2><hr>
				</div>
			</div>
			<div class="row row-bottom-padded-md">
				<div class="col-md-12">
					<input id="openModal" type="hidden" data-toggle="modal" data-target="#msgModal">
					<ul id="fh5co-gallery-list">
						<c:choose>
						<c:when test="${list_mVo ne null}">
							<c:forEach items="${list_mVo}" var="mVo" varStatus="status">
							<li class="one-third animate-box" data-animate-effect="fadeIn" 
							<c:choose>
								<c:when test="${!empty mVo.m_pic}">
								style="background-image: url(/tempH/displayImage?pic=${mVo.m_pic});"
								</c:when>
								<c:otherwise>
								style="background-image: url(/create_tempH/images/messageDefault.jpg);"							
								</c:otherwise>
							</c:choose>
							> 
							<a class="msgBox" href="javascript:void(0);" 
								data-mname="${mVo.m_name}"
								data-mtext="${mVo.m_text}"
								data-mpw="${mVo.m_pw}">
								<textarea class="ta_mtext" style="display:none;">${mVo.m_text}</textarea>
								<div class="case-studies-summary" style="bottom:21.5em; right: 1em;">
									<div class="likeHeart" 
										data-clicked="no"
										data-mno="${mVo.m_no}"
										data-islike="false"
									>
										<i class="fa fa-heart" aria-hidden="true" style="font-size:40px; float:right;
											color:rgba(0,0,0,0.7);"></i>
									</div>
								</div>
								<div class="case-studies-summary" style="width:40px; bottom:19.3em; left:20.1em;">
									<p class="likeCnt" style="color:white; font-size:20px; font-family:'gothic'; margin-bottom:0px; text-align:center;"
										>${mVo.m_likecnt}</p>
								</div>
								<div class="case-studies-summary">
									<h2 style="font-size: 20px; color: rgba(255, 255, 255, 0.8);"
										>${mVo.m_name}</h2>
									<span>${mVo.m_time}</span>
									<h2 style="margin-top:5px; font-family: 'SimKyungha';"
										><c:choose>
									        <c:when test="${fn:length(mVo.m_text) gt 15}"
									        >${fn:substring(mVo.m_text, 0, 15)}...</c:when>
									        <c:otherwise
									        >${mVo.m_text}</c:otherwise>
									</c:choose></h2>
								</div>
							</a>
							</li>
							</c:forEach>
						</c:when>
						
						<c:otherwise>
							<c:if test="${empty mode}">
							<c:forEach var="i" begin="1" end="9">
							<li class="one-third animate-box" data-animate-effect="fadeIn" style="background-image: url(/create_tempH/images/messageDefault.jpg); "> 
								<a class="msgBox" href="javascript:void(0);"
									data-mname="작성자 이름${i}"
									data-mtext="메세지 내용입니다.(${i})"
									data-mode="preview"
								>
									<div class="case-studies-summary" style="bottom:21.5em; right: 1em;">
										<div class="likeHeart"
											data-clicked="no"
											data-mno="preview"
											data-mode="preview"
										>
										<i class="fa fa-heart" aria-hidden="true" style="font-size:40px; float:right;
											color:rgba(0,0,0,0.7);"></i>
										</div>
									</div>
									<div class="case-studies-summary" style="width:40px; bottom:19.3em; left:20.1em;">
										<p style="color:white; font-size:20px; font-family:'gothic'; margin-bottom:0px; text-align:center;"
											>0</p>
									</div>
									<div class="case-studies-summary">
										<h2 style="font-size: 20px; color: rgba(255, 255, 255, 0.8);"
										>작성자 이름${i}</h2>
										<span>0000년 00월 00일, 00:00</span>
										<h2 style="margin-top:5px; font-family: 'SimKyungha';"
										>메세지 제목입니다.(${i})</h2>
									</div>
								</a>
							</li>
							</c:forEach>
							</c:if>
						</c:otherwise>
						</c:choose>
					</ul>
				</div>
				
				<!-- 하단 페이지 버튼 -->
				<div class="col-md-12" style="text-align:center; margin-top: 5em;">
					<ul class="pagination justify-content-center">
						<c:choose>
							<c:when test="${empty pagingDto}">
								<li class="page-item">
									<a class="page-link" href="javascript:void(0);">이전</a>
								</li>
								<li class="page-item active">
									<a class="page-link" href="javascript:void(0);">1</a>
								</li>
								<li class="page-item">
									<a class="page-link" href="javascript:void(0);">다음</a>
								</li>
							</c:when>
							<c:otherwise>
								<c:if test="${pagingDto.startPage ne 1}">
									<li class="page-item">
										<a class="page-link" href="/url/${userVo.url}/messages?page=${pagingDto.startPage-1}">이전</a>
									</li>
								</c:if>
								<c:forEach var="v" begin="${pagingDto.startPage}" end="${pagingDto.endPage}">
								<li
									<c:choose>
										<c:when test="${pagingDto.page eq v}">
											class="page-item active"
										</c:when>
										<c:otherwise>
											class="page-item" 
										</c:otherwise>
									</c:choose>
								>
									<a class = "page-link active" href="/url/${userVo.url}/messages?page=${v}">${v}</a>
								</li>
								</c:forEach>
							    <c:if test="${pagingDto.endPage lt pagingDto.totalPage}">
									<li class="page-item">
										<a class="page-link" href="/url/${userVo.url}/messages?page=${pagingDto.endPage+1}">다음</a>
									</li>
								</c:if>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 메세지 클릭시 상세보기 Modal-->
	<div class="modal fade" id="msgModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
	    aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <p id="modalTitle" class="modal-title" id="exampleModalLabel" style="display:inline; font-size:20px;">
	                	(작성자 이름)님이 남긴 메세지입니다.
	                </p>
	                <button id="btnPause" class="close" type="button" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true" style="font-size:30px;">&times;</span>
	                </button>
	            </div>
	            <form action="/hMessage/editMsg" method="post" enctype="multipart/form-data">
	            <div class="modal-body" style="padding:10px 30px 25px 30px">
	            	<input id="mimno" type="hidden" name="m_no">
	            	<h1 id="modal_p" style="font-family:'SimKyungha'; font-size:20px; margin:0px;"
		            	>메세지 내용입니다.</h1>
		            <div id="div_edit" style="display:none;">
			            <textarea id="modal_textarea" name="m_text" class="form-control" style="font-family:'SimKyungha'; font-size:20px; padding:5px; margin-bottom:10px; resize:none; height:200px;" required
		             	>메세지 내용입니다.</textarea>
		             	<input id="min" name="m_name" type="text" class="form-control" style="font-family:'SimKyungha'; font-size:16px; padding:5px; margin-bottom:10px; height:35px;" 
		             		placeholder="이름을 입력하세요." maxlength="16" required>
		             	<input id="mip" name="m_pw" type="password" class="form-control noSpace" style="font-family:'SimKyungha'; font-size:16px; padding:5px; margin-bottom:10px; height:35px; width:49.5%; display:inline;"
		             		placeholder="비밀번호(최대 20자)" maxlength="20" required>
		             	<input id="mipc" type="password" class="form-control noSpace" style="font-family:'SimKyungha'; font-size:16px; padding:5px; margin-bottom:10px; height:35px; width:49.5%; display:inline;"
		             		placeholder="비밀번호 확인" maxlength="20" required>
		             	<p id="pwOk" style="font-family:'SimKyungha'; font-size:14px; margin:0px; display:none;"
		             		>※ 비밀번호가 일치합니다.</p>
		             	<p id="pwNo" style="color:red; font-family:'SimKyungha'; font-size:14px; margin:0px; display:none;"
		             		>※ 비밀번호가 일치하지 않습니다.</p>
		             	<p id="pwNeed" style="color:red; font-family:'SimKyungha'; font-size:14px; margin:0px; display:none;"
		             		>※ 비밀번호를 입력해 주세요.</p>
	             		<h2 id="fname" style="margin:15px 0px 15px; width:80%; display:inline-block; font-size:16px;"
							data-file="none">파일명.jpg</h2>
	             		<button id="btnMif" type="button" class="btn btn-default btn-block" style="display:inline-block; float:right; margin:5px 0px 5px; font-size:14px;"
	             			>파일 선택</button>
						<input id="mif" name="mpic" type="file" class="form-control" style="display:none;">
					</div>
	            </div>
	            <div class="modal-footer" style="padding:0px 15px 15px">
	                <button id="btnClose" class="btn btn-secondary" type="button" data-dismiss="modal"
	                	>확인</button>
	                <button id="btnEdit" class="btn btn-primary" type="button"
	                	>수정</button>
	                <button id="btnCancel" class="btn btn-secondary" type="button" style="display:none"
	                	>취소</button>
	                <button id="btnEditOk" class="btn btn-primary" type="submit" style="display:none"
	                	>수정완료</button>
	                <button id="btnDelete" class="btn btn-primary" type="button"
	                	>삭제</button>
	            </div>
	            </form>
	        </div>
	    </div>
	</div>

<%@ include file="/WEB-INF/views/include/h_footer.jsp"%>