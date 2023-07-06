<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/m_header.jsp" %>
<%@ include file="../include/vendor_list_css.jsp" %>
<style>
.table td {
	vertical-align: middle;
	font-size: 16px;
	font-weight: normal;
}

.table th {
	font-family: 'GyeonggiTitleM';
	font-size: 18px;
	font-weight: normal;
}
</style>
<script>
$(document).ready(function() {
	if (${pagingDto.orderby != null}) {
		switch ("${pagingDto.orderby}") {
		case "v_score": // 별점순인 경우
			$("#highNumber").removeClass("hv");
			$("#highNumber").css("color", "#e76f64");
			$("#orderby").val("v_score");
			break;
		case "v_no": // 최신순인 경우
			$("#neweastDate").removeClass("hv");
			$("#neweastDate").css("color", "#e76f64");
			$("#orderby").val("v_no");
			break;
		case "v_name": // 이름순인 경우
			$("#byName").removeClass("hv");
			$("#byName").css("color", "#e76f64");
			$("#orderby").val("v_name");
			break;
		}
	}
	
	// 등록, 삭제 처리 결과
 	var register_result = "${register_result}"
	if (register_result == "register_success") {
		alert("등록되었습니다.");
	} else if (register_result == "register_fail") {
		alert("등록에 실패하였습니다.");
	}
 	
 	var delete_result = "${delete_result}"
	if (delete_result == "delete_success") {
		alert("삭제되었습니다.");
	} else if (delete_result == "delete_fail") {
		alert("삭제에 실패하였습니다.");
	}
	
	// 사용자 모드 버튼 클릭시
	$("#btnUser").click(function(e) {
		location.href = "/planner/vendor_list";
	});
	
	// 신규 업체 등록 버튼 클릭시
	$("#btnNew").click(function(e) {
		location.href = "/planner/vendor_register";
	});
	
	// 삭제 버튼 클릭시
	$(".btnDelete").click(function(e) {
		if (confirm("삭제하시겠습니까?") == false) {
			e.preventDefault();
		}
	});
	
	// hover시 글자색 변화
	$(".hv").hover(function() {
		$(this).css("color", "#e76f64");
	}, function() {
		$(this).css("color", "#666666");
	});
	
	// 페이지 번호
	$(".page-link").click(function(e) {
		e.preventDefault();
		var page = $(this).attr("href");
		var orderby = $("#orderby").val();
		var path = "/planner/vendor_list_admin?page="+page+"&orderby="+orderby;
		if (${pagingDto.search_type != null}) {
			path = path + 
				"&search_type=${pagingDto.search_type}&search_region=${pagingDto.search_region}";
		}
		location.href = path;
	});
	
	//별점순 클릭시
	$("#highNumber").click(function(e) {
		e.preventDefault();
		$("#orderby").val("v_score");
		$("#frmSearch").submit();
	});
	
	//최신순 클릭시
	$("#neweastDate").click(function(e) {
		e.preventDefault();
		$("#orderby").val("v_no");
		$("#frmSearch").submit();
	});
	
	//제목순 클릭시
	$("#byName").click(function(e) {
		e.preventDefault();
		$("#orderby").val("v_name");
		$("#frmSearch").submit();
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
	               <h2>웨딩업체 목록 관리</h2>
	            </div>
	         </div>
	      </div>
	   </div>
	</div>
	
	<div style="padding:100px; min-height:650px;">
		<div class="text-center">
			<h1 class="home_title">Vendor List</h1>
		</div>
		
		<!-- 리스트 -->
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-12">
					<div class="row">
					
						<div class="col-md-12">
							<div class="row">
							
								<div class="col-md-6">
									<!-- 카테고리 -->
									<div id="searchBox" style="margin-left: 80px">
										<form id="frmSearch" action="/planner/vendor_list_admin" method="get">
											<input type="hidden" id="orderby" name="orderby" value="v_no">
											<div class="input-group" style="margin: 50px">
												<!-- 유형 카테고리 -->
												<select class="inputs-s" name="search_type" style="width:25%; margin-right:5px;">
													<option value="21"
														<c:if test="${pagingDto.search_type == '21'}">selected</c:if>
													>Wedding Hall</option>
													
													<option value="22"
														<c:if test="${pagingDto.search_type == '22'}">selected</c:if>
													>Wedding Dress</option>
													
													<option value="23"
														<c:if test="${pagingDto.search_type == '23'}">selected</c:if>
													>Beauty</option>
												</select>
												
												<!-- 지역 카테고리 -->
												<select class="inputs-s" name="search_region" style="width:20%; margin-right:5px;">
													<option value="1"
														<c:if test="${pagingDto.search_region == '1'}">
															selected
														</c:if>
													>서울특별시
													</option>
													
													<option value="2"
														<c:if test="${pagingDto.search_region == '2'}">
															selected
														</c:if>
													>인천광역시
													</option>
													
													<option value="3"
														<c:if test="${pagingDto.search_region == '3'}">
															selected
														</c:if>
													>부산광역시
													</option>
													
													<option value="4"
														<c:if test="${pagingDto.search_region == '4'}">
															selected
														</c:if>
													>울산광역시
													</option>
													
													<option value="5"
														<c:if test="${pagingDto.search_region == '5'}">
															selected
														</c:if>
													>대전광역시
													</option>
													
													<option value="6"
														<c:if test="${pagingDto.search_region == '6'}">
															selected
														</c:if>
													>광주광역시
													</option>
													
													<option value="7"
														<c:if test="${pagingDto.search_region == '7'}">
															selected
														</c:if>
													>경상남도
													</option>
													
													<option value="8"
														<c:if test="${pagingDto.search_region == '8'}">
															selected
														</c:if>
													>경상북도
													</option>
													
													<option value="9"
														<c:if test="${pagingDto.search_region == '9'}">
															selected
														</c:if>
													>충청남도
													</option>
													
													<option value="10"
														<c:if test="${pagingDto.search_region == '10'}">
															selected
														</c:if>
													>충청북도
													</option>
													
													<option value="11"
														<c:if test="${pagingDto.search_region == '11'}">
															selected
														</c:if>
													>세종특별자치시
													</option>
													
													<option value="12"
														<c:if test="${pagingDto.search_region == '12'}">
															selected
														</c:if>
													>제주특별자치시
													</option>
												</select>
												
												<button id="btnSearch" class="btn btn-brown" style="margin-right:5px;"
													type="submit">검색</button>
												<button id="btnUser" class="btn btn-beige" style="margin-right:5px;"
													type="button">사용자 모드</button>
											</div>
										</form>
									</div>
								</div>
	
								<!-- 카테고리 옆에 작은 메뉴들 -->
								<div class="col-md-6" id="smallMenu">
									<div style="margin-left: 400px; margin-top: 60px;">
										<a href="#" id="neweastDate" class="hideMenu hv">최신순</a> 
										<a style="padding-left: 20px; padding-right: 20px;" class="hideMenu">|</a> 
										<a href="#" id="highNumber" class="hideMenu hv">별점순</a>
										<a style="padding-left: 20px; padding-right: 20px;" class="hideMenu">|</a> 
										<a href="#" id="byName" class="hideMenu hv">이름순</a>
									</div>
								</div>
							</div>
							<!-- 테이블 -->
							<div class="row">
								<div class="col-md-12"
									style="padding-top: 10px; padding-left: 160px; padding-right: 160px;">
									<button id="btnNew" class="btn btn-brown" style="margin-bottom:10px;"
										type="button">신규 업체 등록</button>
									<table class="table table-striped">
										<thead>
											<tr>
												<th>업체번호</th>
												<th>업체명</th>
												<th>유형/지역</th>
												<th>삭제</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${list}" var="vendorVo" varStatus="status">
												<c:set var="tcode" value="${vendorVo.v_tcode}" />
												<c:set var="rcode" value="${vendorVo.v_rcode}" />
												<tr <c:if test="${status.index %2 eq 0}">
														style="background:#F9F7F5;"
													</c:if>
												>
													<td>${vendorVo.v_no}</td>
													<td>
														<a href="/planner/vendor_detail?v_no=${vendorVo.v_no}" class="hv" style="cursor:pointer;"
															data-number="${vendorVo.v_tel}"
															data-name="${vendorVo.v_name}"
														>${vendorVo.v_name}</a>
													</td>
													<td>
														<c:if test="${tcode eq 21}"
														>웨딩홀 /</c:if>
														<c:if test="${tcode eq 22}"
														>드레스 /</c:if>
														<c:if test="${tcode eq 23}"
														>메이크업 /</c:if>
														
														<c:if test="${rcode eq 1}"
														>서울특별시</c:if>
														<c:if test="${rcode eq 2}"
														>인천광역시</c:if>
														<c:if test="${rcode eq 3}"
														>부산광역시</c:if>
														<c:if test="${rcode eq 4}"
														>울산광역시</c:if>
														<c:if test="${rcode eq 5}"
														>대전광역시</c:if>
														<c:if test="${rcode eq 6}"
														>광주광역시</c:if>
														<c:if test="${rcode eq 7}"
														>경상남도</c:if>
														<c:if test="${rcode eq 8}"
														>경상북도</c:if>
														<c:if test="${rcode eq 9}"
														>충청남도</c:if>
														<c:if test="${rcode eq 10}"
														>충청북도</c:if>
														<c:if test="${rcode eq 11}"
														>세종특별자치시</c:if>
														<c:if test="${rcode eq 12}"
														>제주특별자치시</c:if>
													</td>
													<td><a href="/planner/vendor_delete?v_no=${vendorVo.v_no}" class="btn btn-beige btnDelete"
														data-vno="${vendorVo.v_no}">삭제</a></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
	
						</div>
					</div>
				</div>
			</div>
			
			<!-- 페이지이동 -->
			<div class="row" style="margin-top:40px;">
				<div class="col-md-12">
					<nav>
						<ul class="pagination justify-content-center">
						<c:if test="${pagingDto.startPage ne 1}">
							<li class="page-item">
								<a class="page-link" href="${pagingDto.startPage - 1}">이전</a>
							</li>
						</c:if>
						<c:forEach var="p" begin="${pagingDto.startPage}" end="${pagingDto.endPage}">
							<li 
								<c:choose>
									<c:when test="${pagingDto.page eq p}">
										class="page-item active"
									</c:when>
									<c:otherwise>
										class="page-item"
									</c:otherwise>
								</c:choose>
							>
								<a class="page-link" href="${p}">${p}</a>
							</li>
						</c:forEach>
						
						<c:if test="${pagingDto.endPage lt pagingDto.totalPage}">	
							<li class="page-item">
								<a class="page-link" href="${pagingDto.endPage + 1}">다음</a>
							</li>
						</c:if>	
						</ul>
					</nav>
				</div>
			</div>
			
		</div>
	</div>
<%@ include file="../include/m_footer.jsp" %>