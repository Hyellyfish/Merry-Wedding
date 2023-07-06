<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/m_header.jsp" %>
<script>
$(document).ready(function() {
	// hover시 글자색 변화
	$(".mp_menua").hover(function() {
		if ($(this).attr("id") != "welcome") {
			$(this).css("color", "#e76f64");
		}
	}, function() {
		if ($(this).attr("id") != "welcome") {
			$(this).css("color", "#222222");
		}
	});
	
	// 탈퇴 클릭 시
	$("#deleteUser").click(function(e) {
		if (confirm("탈퇴하시겠습니까?") == false) {
			e.preventDefault();
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
                     <h2 id="mptitle_h2">마이페이지</h2>
                  </div>
               </div>
            </div>
         </div>
      </div>
      
      <!-- menu -->
      <div id="mp_menudiv" class="container-fluid">
		<div class="row" style="height:100%; background: #F9F7F5;">
			<div class="col-md-3" style="padding: 80px;">
				<div>
					<div class="row">
						<div class="col-md-12">
							<p id="welcome" class="mp_menua" style="font-size: 20px; margin-bottom:30px;"
								> ${loginInfo.userid}님 반갑습니다.</p>
							<a href="/user/edit" class="mp_menua" id="edit_a"
								>내 정보 수정</a><br>
							<a href="/user/url_manage" class="mp_menua" id="manage_a"
								>나만의 웨딩 사이트 관리</a>
						</div>
					</div>
					<hr>
					<div class="row">
						<div class="col-md-12">
							<a class="mp_menua" href="/planner/checklist"
								>나의 체크리스트</a><br>
							<a class="mp_menua" 
								<c:choose>
									<c:when test="${1 eq loginInfo.pjnum}">
										href="/tempH/insert_info"
									</c:when>
									<c:otherwise>
										href="/create/choose_temp"
									</c:otherwise>
							 </c:choose>
								>나의 프로젝트</a><br>
							<a class="mp_menua" href="/guest/guestlist"
								>나의 주소록</a><br>
						</div>
					</div>
					<hr>
					<div class="row">
						<div class="col-md-12">
							<a id="deleteUser" href="/user/delete_user" class="mp_menua">회원탈퇴</a>
						</div>
						<br>
					</div>
				</div>
			</div>
			<div class="col-md-9" style="background: white; padding: 90px;">