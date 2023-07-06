<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/m_header.jsp" %>
<%@ include file="../include/vendor_list_css.jsp" %>
<script>
$(document).ready(function() {
	if (${pagingDto.orderby != null}) {
		switch ("${pagingDto.orderby}") {
		case "v_score": // 별점순인 경우
			console.log("별점순");
			$("#neweastDate").addClass("hv");
			$("#byName").addClass("hv");
			$("#highNumber").css("color", "#e76f64");
			$("#orderby").val("v_score");
			break;
		case "v_no": // 최신순인 경우
			console.log("최신순");
			$("#highNumber").addClass("hv");
			$("#byName").addClass("hv");
			$("#neweastDate").css("color", "#e76f64");
			$("#orderby").val("v_no");
			break;
		case "v_name": // 이름순인 경우
			console.log("이름순");
			$("#highNumber").addClass("hv");
			$("#neweastDate").addClass("hv");
			$("#byName").css("color", "#e76f64");
			$("#orderby").val("v_name");
			break;
		}
	}
	
	// 등록 및 삭제 버튼 클릭시
	$("#btnAdmin").click(function(e) {
		location.href = "/planner/vendor_list_admin";
	});
	
	// hover시 글자색 변화
	$(".hv").hover(function() {
		$(this).css("color", "#e76f64");
	}, function() {
		$(this).css("color", "#161615");
	});
	
	// hover시 이미지 변화
	$(".img_call").hover(function() {
		$(this).attr("src", "/main_temp/images/call_hover.png");
	}, function() {
		$(this).attr("src", "/main_temp/images/call.png");
	});
	
	$(".img_home").hover(function() {
		$(this).attr("src", "/main_temp/images/homepage_hover.png");
	}, function() {
		$(this).attr("src", "/main_temp/images/homepage.png");
	});
	
	// 페이지 번호
	$(".page-link").click(function(e) {
		e.preventDefault();
		var page = $(this).attr("href");
		var orderby = $("#orderby").val();
		var path = "/planner/vendor_list?page="+page+"&orderby="+orderby;
		if (${pagingDto.search_type != null}) {
			path = path + 
				"&search_type=${pagingDto.search_type}&search_region=${pagingDto.search_region}";
		}
		location.href = path;
	});
	
	// 전화 아이콘 클릭시 모달창 띄우기
	$(".callNumber").click(function(){
		console.log("클릭됨");
		var v_name = $(this).attr("data-name");
		var v_number = $(this).attr("data-number");
		
		console.log("v_name:"+v_name);
		console.log("v_number:"+v_number);
		
		$("#modal-828257").trigger("click");
		$("#myModalLabel").text(v_name+"의 연락처");
		$(".modal-body").text(v_number);
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
	               <h2>웨딩업체 목록</h2>
	            </div>
	         </div>
	      </div>
	   </div>
	</div>
	
	<div style="padding:100px; min-height:650px;">
		<div class="text-center">
			<h1 class="home_title">Vendor List</h1>
		</div>
		
		<!-- 모달창 -->
		<a id="modal-828257" href="#modal-container-828257" role="button" class="btn" data-toggle="modal" style="display:none">Launch demo modal</a>
		<div class="modal fade" id="modal-container-828257" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header" style="border-bottom: 1px solid transparent;">
						<h1 class="modal-title" id="myModalLabel" style="font-size:20px; font-family: 'GyeonggiTitleM'; padding:0px; color:#666666;"></h1>
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
					</div>
					<div class="modal-body" style="font-size:20px; padding:16px 16px 0px"></div>				
					<div class="modal-footer" style="border-top: 1px solid transparent;">
						<button type="button" class="btn btn-brown" data-dismiss="modal"
						>닫기</button>
					</div>
				</div>
			</div>
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
										<form id="frmSearch" action="/planner/vendor_list" method="get">
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
												<select class="inputs-s" name="search_region" style="width:24%; margin-right:5px;">
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
												<c:if test="${loginResult eq 'manager'}">
													<button id="btnAdmin" class="btn btn-red" style="margin-right:5px;"
														type="button">관리자 모드</button>
												</c:if>
											</div>
										</form>
									</div>
								</div>
	
								<!-- 카테고리 옆에 작은 메뉴들 -->
								<div class="col-md-6" id="smallMenu">
									<div style="margin-left: 400px; margin-top: 60px;">
										<a href="#" id="neweastDate">최신순</a> 
										<a style="padding-left: 20px; padding-right: 20px;">|</a> 
										<a href="#" id="highNumber">별점순</a>
										<a style="padding-left: 20px; padding-right: 20px;">|</a> 
										<a href="#" id="byName">이름순</a>
									</div>
								</div>
							</div>
	
							<!-- 카테고리 선택시 리스트 출력 -->
							<div class="row" id="cate_list">
								<div class="col-md-12">
									<div class="row">
									<!-- 테이블 양옆에 공간 -->
									<div class="col-md-1"></div>
									<div class="col-md-10">
										<!-- 테이블 -->
										<div class="row">
											<div class="col-md-12">
												<div class="row">
													<section id="content">
														<ul>
															<c:forEach items="${list}" var="vendorVo">
																<li>
																	<div class="categoryImg">
																	<c:choose>
																		<c:when test="${vendorVo.v_pic eq null}">
																		<img src="/main_temp/images/default.jpg" style="object-fit: cover;">                             
																		</c:when>
																		<c:otherwise>
																		<img src="/planner/displayImage?pic=${vendorVo.v_pic}" style="object-fit: cover;">
																		</c:otherwise>
																	</c:choose>	
																	</div>
	
																	<div class="icon">
																		<div class="categoryLink">
																			<a href="${vendorVo.v_link}">
																				<img src="/main_temp/images/homepage.png" style="object-fit:cover;"
																					class="img_home">
																			</a>
																		</div>

																		<div class="categoryNumber">
																			<a class="callNumber"
																				data-number="${vendorVo.v_tel}"
																				data-name="${vendorVo.v_name}">
																				<img src="/main_temp/images/call.png" style="object-fit:cover; cursor:pointer;"
																					class="img_call">
																			</a>
																		</div>
																	</div>
	
																	<div class="categoryAdress">
																		<a style="font-weight: normal;"
																		>${vendorVo.v_address}</a>
																	</div>
																	<div class="categoryName">
																		<a style="font-family:'GyeonggiTitleM'; font-weight: normal;"
																		>${vendorVo.v_name}</a>
																	</div>

																	<div class="categoryType">
																		<a>${vendorVo.v_detail}</a>
																	</div>
	
																	<div class="categoryScore">
																		<img src="/main_temp/images/star.png" style="object-fit:cover;">
																		<a>${vendorVo.v_score}점 / 5점</a>
																	</div>
																</li>
															</c:forEach>
														</ul>
													</section>
													</div>
												</div>
											</div>
										</div>
										
									</div>
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