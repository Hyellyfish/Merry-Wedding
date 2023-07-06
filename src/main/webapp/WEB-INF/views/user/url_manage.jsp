<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/mp_header.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/clipboard@2.0.6/dist/clipboard.min.js"></script>
<script>
$(document).ready(function() {
	$("#mptitle_h2").text("나만의 웨딩 사이트 관리");
	$("#manage_a").css("color", "#BBAEA0");
	$("#manage_a").attr("id", "welcome");
	$("#mp_menudiv").css("height", "auto");
	
	// 검색 키워드 유지
	if (${pagingDto.searchName != null}) {
		$("#searchName").val("${pagingDto.searchName}");
	}
	
	// 링크 복사
	var strurl= "localhost/url/${loginInfo.url}";
	$("#inputUrl").val(strurl);
	var clipboard = new ClipboardJS("#btnUrlcopy"); // 클립보드에 복사
	$("#inputUrl").click(function() {
		location.href = "/url/${loginInfo.url}";
	});
	
	// sms 버튼 클릭 시
	$("#btnSms").click(function () {
		location.href= "/guest/guestlist";
	});
	
	// 메세지 삭제 처리 결과
	var msg_result = "${msg_result}"
	var msg_sNum = "${msg_sNum}"
    console.log("msg_result: ", msg_result);
	if (msg_result != null && msg_result != "") {
		switch (msg_result) {
			case "delete_success":
				alert(msg_sNum);
				break;
	  	  	case "delete_fail":
	  		  	alert("메세지 삭제에 실패하였습니다.");
	  		  	break;
		}
	}
	
	// 모두선택 체크박스
	$("#checkAll").change(function() {
		var isChecked = $(this).prop("checked");
		$(".checkMno").prop("checked", isChecked);
	});
	
	// 선택한 메세지 삭제
	$("#btnDelete").click(function(e) {
		e.preventDefault();
		var sNum = 0;
		$(".checkMno").each(function() {
			var checked = $(this).is(":checked");
			if (checked) {
				$(this).next().attr("name", "mnos");
				sNum++;
				console.log("this mno: ", $(this).next().val());
			}
		});
		$("#sNum").val(sNum);
		if (confirm("선택한 "+sNum+"개의 메세지를 삭제하시겠습니까?")) {
			$("#frmDelete").submit();
		}
	});
});
</script>
<div class="text-center">
	<h1 class="mp_titleh1">My Wedding Site</h1>
	<div class="mp_managediv" style="margin-top: 0px;">
		<h3 class="mp_titleh3">관리자 정보</h3>
		<p class="mp_titlep">[ ID(이름) ]</p>
		<p style="padding:6px; font-size:17px;"
		>${loginInfo.userid}(${loginInfo.username})</p>	
	</div>
	<hr>
	<div class="mp_managediv">
		<h3 class="mp_titleh3">나만의 웨딩 사이트 관리</h3>
		<c:choose>
			<c:when test="${1 eq loginInfo.pjnum}">
				<!-- 만들던 프로젝트가 있는 경우 -->
				<p class="mp_titlep">[ 사이트 URL ]<br>
					<input id="inputUrl" type="text" class="inputs" style="text-align:center; color:#F6AE99; font-size: 17px; border: transparent; cursor:pointer;" readonly>
					<button id="btnUrlcopy" class="btn btn-pink btn-sm" type="button" 
					data-clipboard-target="#inputUrl"
					>URL 복사</button>
				</p>
				<br><br>
				<p class="mp_titlep" style="color: #666666;" 
					>[ SMS(문자서비스)로 URL 보내기 ]</p>
				<button id="btnSms" class="btn btn-light btn-sm" type="button" style="margin:10px;"
					>SMS 서비스로 이동</button>
			</c:when>
			<c:otherwise>
				<!-- 만들던 프로젝트가 없는 경우 -->
				<p class="mp_titlep" style="padding:6px;"
					>[ 사이트 URL ]</p>
				<p class="mp_titlep">localhost/url/${loginInfo.url}</p>
				<br>
				<p class="mp_titlep">※ 진행중인 프로젝트가 존재하지 않습니다.</p>
				<p class="mp_titlep">사이트를 활성화하려면 프로젝트 생성 및 저장을 완료해주세요.</p>
				<br>
				<p class="mp_titlep"><a id="a_newproject" style="color: #F6AE99;"
					href="/create/choose_temp">[ 프로젝트 생성하기 ]</a></p>
			</c:otherwise>
		</c:choose>
	</div>
	<hr>
	<c:if test="${1 eq loginInfo.pjnum}">
		<div class="mp_managediv">
			<h3 class="mp_titleh3">메세지 관리</h3>
			
			<div class="row">
		     	<div class="col-sm-12" style="padding:0px 150px 0px">
			     	<!-- 검색 -->
				    <form id="frmSearch" class="d-none d-sm-inline-block form-inline mr-auto my-2 my-md-0 mw-100 navbar-search" style="float:left;"
				    	action="/user/url_manage" method="get">
				        <div class="input-group" style="margin-bottom:20px;">
				            <input type="text" class="form-control bg-light border-1 small noSpace" placeholder="이름 검색"
				                aria-label="Search" aria-describedby="basic-addon2"
				                name="searchName" id="searchName">
				            <div class="input-group-append">
				                <button id="btnSearch" class="btn btn-brown" type="submit">
				                    <i class="fa fa-search fa-sm"></i>
				                </button>
				            </div>
				        </div>
				    </form>
				    
				    <form id="frmDelete" action="/hMessage/deleteMsgs" method="post">
				    <button type="submit" id="btnDelete" class="btn btn-red" style="float:right"
			  			>삭제</button>
			  		<input type="hidden" style="display:none;" id="sNum" name="sNum">
					<table class="table">
					    <thead style="background: #F9F7F5;">
					    <tr>
							<th>
								<input type="checkBox" style="margin:5px" id="checkAll">
							</th>
					        <th style="font-weight:normal; font-family:'GyeonggiTitleM';"
					        	>번호</th>
					        <th style="font-weight:normal; font-family:'GyeonggiTitleM';"
					        	>이름</th>
					        <th style="font-weight:normal; font-family:'GyeonggiTitleM';"
					        	>비밀번호</th>
					        <th style="font-weight:normal; font-family:'GyeonggiTitleM';"
					        	>내용</th>
					        <th style="font-weight:normal; font-family:'GyeonggiTitleM';"
					        	>작성일</th>
					    </tr>
					    </thead>
					    
					    <tbody id="guestList">
					    <c:forEach items="${list_mVo}" var="mVo" varStatus="status">
							<tr class="tr">
								<td>
									<input type="checkBox" style="margin:5px" class="checkMno">
									<input type="hidden" style="display:none;" value="${mVo.m_no}">
								</td>
								<td>${mVo.m_no}</td>
								<td>${mVo.m_name}</td>
								<td>${mVo.m_pw}</td>
								<td>
									<c:choose>
								        <c:when test="${fn:length(mVo.m_text) gt 30}"
								        >${fn:substring(mVo.m_text, 0, 30)}...</c:when>
								        <c:otherwise
								        >${mVo.m_text}</c:otherwise>
									</c:choose>
								</td>
								<td>${mVo.m_time}</td>
							</tr>
						</c:forEach>
					    </tbody>
					</table>
					
					</form>
					
					<!-- 하단 페이지 버튼 -->
					<div class="col-md-12" style="text-align:center; margin-top: 3em;">
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
											<a class="page-link" href="/user/url_manage?page=${pagingDto.startPage-1}">이전</a>
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
										<a class = "page-link active" href="/user/url_manage?page=${v}">${v}</a>
									</li>
									</c:forEach>
								    <c:if test="${pagingDto.endPage lt pagingDto.totalPage}">
										<li class="page-item">
											<a class="page-link" href="/user/url_manage?page=${pagingDto.endPage+1}">다음</a>
										</li>
									</c:if>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
			
		         </div>
		      </div>
			
		</div>
	</c:if>
</div>
<%@ include file="../include/mp_footer.jsp" %>