<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/m_header.jsp" %>
<%@ include file="../include/vendor_list_css.jsp" %>
<script src="/main_temp/js/hscript.js"></script>
<script>
$(document).ready(function() {
	// 수정 처리 결과
 	var edit_result = "${edit_result}"
	if (edit_result == "edit_success") {
		alert("수정되었습니다.");
	} else if (edit_result == "edit_fail") {
		alert("수정에 실패하였습니다.");
	}
	
	// 사용자 모드 버튼 클릭시
	$("#btnUser").click(function(e) {
		location.href = "/planner/vendor_list";
	});
	
	// 목록버튼 클릭시
	$("#btnList").click(function(e) {
		e.preventDefault();
		var tcode = "${vendorVo.v_tcode}";
		var rcode = "${vendorVo.v_rcode}";
		var path = "/planner/vendor_list_admin?search_type="+tcode
				+"&search_region="+rcode;
		location.href = path;
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
	               <h2>웨딩업체 상세정보</h2>
	            </div>
	         </div>
	      </div>
	   </div>
	</div>
	
	<div style="padding:100px; min-height:650px;">
		<div class="text-center">
			<h1 class="home_title">Vendor Info</h1>
		</div>
		
		<!-- 상세정보 -->
		<div class="container-fluid" style="padding: 0px 350px">
			<div class="row">
				<div class="col-md-12" style="padding: 0px 200px;">
					<form id="frmEdit" action="/planner/vendor_edit" method="post" enctype="multipart/form-data">
						<div class="form-group rg_div">
							<label for="userid" class="rg_lbl">업체 번호</label>
							<input value="${vendorVo.v_no}" type="text" class="inputs"
								id="v_no" name="v_no" readonly style="background:#E3E7EA">
						</div>
						
						<div class="form-group rg_div">
							<label for="category" class="rg_lbl">카테고리</label>
							<div class="input-group" id="category">
								<select class="inputs-s" id="v_tcode" style="width:49.5%; margin-right:5px;">
									<option value="21"
										<c:if test="${vendorVo.v_tcode == '21'}">selected</c:if>
									>Wedding Hall</option>
									<option value="22"
										<c:if test="${vendorVo.v_tcode == '22'}">selected</c:if>
									>Wedding Dress</option>
									<option value="23"
										<c:if test="${vendorVo.v_tcode == '23'}">selected</c:if>
									>Beauty</option>
								</select>
								<select class="inputs-s" id="v_rcode" style="width:49.5%;">
									<option value="1"
										<c:if test="${vendorVo.v_rcode == '1'}">selected</c:if>
									>서울특별시</option>
									<option value="2"
										<c:if test="${vendorVo.v_rcode == '2'}">selected</c:if>
									>인천광역시
									</option>
									<option value="3"
										<c:if test="${vendorVo.v_rcode == '3'}">selected</c:if>
									>부산광역시
									</option>
									<option value="4"
										<c:if test="${vendorVo.v_rcode == '4'}">selected</c:if>
									>울산광역시
									</option>
									<option value="5"
										<c:if test="${vendorVo.v_rcode == '5'}">selected</c:if>
									>대전광역시
									</option>
									<option value="6"
										<c:if test="${vendorVo.v_rcode == '6'}">selected</c:if>
									>광주광역시
									</option>
									<option value="7"
										<c:if test="${vendorVo.v_rcode == '7'}">selected</c:if>
									>경상남도
									</option>
									<option value="8"
										<c:if test="${vendorVo.v_rcode == '8'}">selected</c:if>
									>경상북도
									</option>
									<option value="9"
										<c:if test="${vendorVo.v_rcode == '9'}">selected</c:if>
									>충청남도
									</option>
									<option value="10"
										<c:if test="${vendorVo.v_rcode == '10'}">selected</c:if>
									>충청북도
									</option>
									<option value="11"
										<c:if test="${vendorVo.v_rcode == '11'}">selected</c:if>
									>세종특별자치시
									</option>
									<option value="12"
										<c:if test="${vendorVo.v_rcode == '12'}">selected</c:if>
									>제주특별자치시
									</option>
								</select>	
							</div>
							<input type="hidden" class="input" name="v_tcode" 
								id="input_tcode" value="${vendorVo.v_tcode}" style="margin-top: 15px"/>	
							<input type="hidden" class="input" name="v_rcode" 
								id="input_rcode" value="${vendorVo.v_rcode}" style="margin-top: 15px"/>	
						</div>
						
						<div class="form-group rg_div">
							<label for="username" class="rg_lbl">업체명</label>
							<input type="text" class="inputs" value="${vendorVo.v_name}"
								id="v_name" placeholder="업체명" name="v_name" required>
						</div>
						
						<div class="form-group rg_div">
							<div class="form-group-title">
								<label for="v_address" class="rg_lbl">주소</label>
								<input type="text" class="inputs" value="${vendorVo.v_address}"
									id="v_address" placeholder="주소" name="v_address" required>
							</div>
						</div>
						
						<div class="form-group rg_div">
							<div class="form-group-title">
								<label for="v_tel" class="rg_lbl">전화번호</label>
								<input type="text" class="inputs" value="${vendorVo.v_tel}"
									id="v_tel" placeholder="전화번호" name="v_tel" required>
							</div>
						</div>
						
						<div class="form-group rg_div">
							<div class="form-group-title">
								<label for="v_link" class="rg_lbl">홈페이지 주소</label>
								<input type="text" class="inputs" value="${vendorVo.v_link}"
									id="v_link" placeholder="홈페이지 주소" name="v_link" required>
							</div>
						</div>
						
						<div class="form-group rg_div">
							<div class="form-group-title">
								<label for="v_detail" class="rg_lbl">상세정보</label>
								<input type="text" class="inputs" value="${vendorVo.v_detail}"
									id="v_detail" placeholder="상세정보" name="v_detail">
							</div>
						</div>
						
						<div class="form-group rg_div">
							<div class="form-group-title">
								<label for="v_score" class="rg_lbl">별점</label>
								<input type="text" class="inputs" value="${vendorVo.v_score}"
									id="v_score" placeholder="별점" name="v_score">
							</div>
						</div>
						
						<div class="form-group rg_div">
							<div class="form-group-title">
								<div class="text-center">
									<img id="dpimg" style="max-height:300px; object-fit:cover; margin:40px auto 20px;"
										<c:choose>
										    <c:when test="${empty vendorVo.v_pic}">
												src="/main_temp/images/default.jpg"
										    </c:when>
										    <c:otherwise>
												src="/planner/displayImage?pic=${vendorVo.v_pic}"
										    </c:otherwise>
										</c:choose>
									 >
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
						<button type="submit" id="btnEdit" class="btn btn-brown">수정 완료</button>
					</div>
				</form>
					
				</div>
			</div>
		</div>
		<!-- 상세정보 끝 -->
		
	</div>
<%@ include file="../include/m_footer.jsp" %>