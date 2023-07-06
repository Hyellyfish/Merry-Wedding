<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/m_header.jsp" %>
<%@ include file="../include/vendor_list_css.jsp" %>
<script src="/main_temp/js/hscript.js"></script>
<script>
$(document).ready(function() {
	
	// 목록버튼 클릭시
	$("#btnList").click(function(e) {
		e.preventDefault();
		location.href = "/planner/vendor_list_admin";
	})
	
	// 셀렉트박스 선택시 해당 값 입력
	$("#v_tcode").change(function () {
		$("#input_tcode").val($(this).val());
	});
	
	$("#v_rcode").change(function () {
		$("#input_rcode").val($(this).val());
	});
	
	// 파일선택 input버튼 클릭
	$(".custom-file-input").change(function(e) {
		var fileName = $(this).val().split("\\").pop();
		var file = this.files[0];
		var dpimg = $("#dpimg");
		
		if (isImage(file)) {
			$(this).siblings(".custom-file-label").addClass("selected").html(fileName);
			displayImg(dpimg, file);
		} else {
			alert("해당 파일은 이미지 파일이 아닙니다. 이미지 파일을 등록해주세요.");
		};
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
	               <h2>웨딩업체 등록</h2>
	            </div>
	         </div>
	      </div>
	   </div>
	</div>
	
	<div style="padding:100px; min-height:650px;">
		<div class="text-center">
			<h1 class="home_title">New Vendor</h1>
		</div>
		
		<!-- 상세정보 -->
		<div class="container-fluid" style="padding: 0px 350px">
			<div class="row">
				<div class="col-md-12" style="padding: 0px 200px;">
					<form id="frmRegister" action="/planner/vendor_register_run" method="post" enctype="multipart/form-data">
						<div class="form-group rg_div">
							<label for="category" class="rg_lbl">카테고리</label>
							<div class="input-group" id="category">
								<select class="inputs-s" id="v_tcode" style="width:49.5%; margin-right:5px;">
									<option value="21" selected>Wedding Hall</option>
									<option value="22">Wedding Dress</option>
									<option value="23">Beauty</option>
								</select>
								<select class="inputs-s" id="v_rcode" style="width:49.5%;">
									<option value="1" selected>서울특별시</option>
									<option value="2">인천광역시</option>
									<option value="3">부산광역시</option>
									<option value="4">울산광역시</option>
									<option value="5">대전광역시</option>
									<option value="6">광주광역시</option>
									<option value="7">경상남도</option>
									<option value="8">경상북도</option>
									<option value="9">충청남도</option>
									<option value="10">충청북도</option>
									<option value="11">세종특별자치시</option>
									<option value="12">제주특별자치시</option>
								</select>	
							</div>
							<input type="hidden" class="input" name="v_tcode" 
								id="input_tcode" value="21" style="margin-top: 15px"/>	
							<input type="hidden" class="input" name="v_rcode" 
								id="input_rcode" value="1" style="margin-top: 15px"/>	
						</div>
						
						<div class="form-group rg_div">
							<label for="username" class="rg_lbl">업체명</label>
							<input type="text" class="inputs"
								id="v_name" placeholder="업체명" name="v_name" required>
						</div>
						
						<div class="form-group rg_div">
							<div class="form-group-title">
								<label for="v_address" class="rg_lbl">주소</label>
								<input type="text" class="inputs"
									id="v_address" placeholder="주소" name="v_address" required>
							</div>
						</div>
						
						<div class="form-group rg_div">
							<div class="form-group-title">
								<label for="v_tel" class="rg_lbl">전화번호</label>
								<input type="text" class="inputs"
									id="v_tel" placeholder="전화번호" name="v_tel" required>
							</div>
						</div>
						
						<div class="form-group rg_div">
							<div class="form-group-title">
								<label for="v_link" class="rg_lbl">홈페이지 주소</label>
								<input type="text" class="inputs"
									id="v_link" placeholder="홈페이지 주소" name="v_link" required>
							</div>
						</div>
						
						<div class="form-group rg_div">
							<div class="form-group-title">
								<label for="v_detail" class="rg_lbl">상세정보</label>
								<input type="text" class="inputs"
									id="v_detail" placeholder="상세정보" name="v_detail">
							</div>
						</div>
						
						<div class="form-group rg_div">
							<div class="form-group-title">
								<label for="v_score" class="rg_lbl">별점</label>
								<input type="text" class="inputs"
									id="v_score" placeholder="별점" name="v_score">
							</div>
						</div>
						
						<div class="form-group rg_div">
							<div class="form-group-title">
								<div class="text-center">
									<img id="dpimg" style="max-height:300px; object-fit:cover; margin:40px auto 20px;"
										src="/main_temp/images/default.jpg">
								</div>
								<label for="v_pic" class="rg_lbl">사진</label>
								<div class="custom-file" id="home">
									<input type="file" id="v_pic" name="file" class="custom-file-input">
									<label class="custom-file-label" for="v_pic">파일을 선택하세요.</label>
								</div>
							</div>
						</div>
					
					<div class="text-center" style="margin-top:90px;">
						<button id="btnList" class="btn btn-gray">목록으로</button>
						<button type="submit" id="btnRegister" class="btn btn-brown">등록하기</button>
					</div>
				</form>
					
				</div>
			</div>
		</div>
		<!-- 상세정보 끝 -->
		
	</div>
<%@ include file="../include/m_footer.jsp" %>