<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/m_header.jsp" %>
<script>
$(document).ready(function() {
	$(".template_box").click(function() {
		$(location).attr('href', '/create/insert_info');
	});
});
</script>
      <div class="back_re">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="title">
                     <h2>나만의 웨딩 사이트 만들기</h2>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- about -->
      <div class="about">
         <div class="container">
            <div class="row d_flex">
            	
            	<div class="container">
            		<div class="row">
		               <div class="col-md-9">
		                  <div class="titlepage" style="padding-left:80px">
		                     <h2>나만의 웨딩 사이트 만들기</h2>
		                     <span>2가지 템플릿 중 하나를 선택하여 나만의 웨딩 사이트를 만들 수 있습니다.
		                     </span>
		                     <c:choose>
								<c:when test="${empty loginInfo}">
									<!-- 로그인하지 않은 경우 -->
									<a class="read_more" href="/create/newproject"
										>새 프로젝트 만들기</a>
								</c:when>
								<c:otherwise>
									<!-- 로그인한 경우 -->
									<c:choose>
										<c:when test="${1 eq loginInfo.pjnum}">
											<!-- 만들던 프로젝트가 있는 경우 -->
											<a class="read_more" href="/tempH/insert_info"
												>프로젝트로 이동</a>
										</c:when>
										<c:otherwise>
											<!-- 만들던 프로젝트가 없는 경우 -->
											<a class="read_more" href="/create/choose_temp"
												>새 프로젝트 만들기</a>
										</c:otherwise>
									 </c:choose>
								</c:otherwise>
							 </c:choose>
		                  </div>
		               </div>
		               
		               <div class="col-md-3" style="padding:20px">
		                  <img class="create_roundimg" src="/main_temp/images/CoupleViewingLaptop.jpg"/>
		               </div>
	             	</div>
	             	
	             	<hr style="margin-top: 2rem; margin-bottom: 2rem;">
	             	
	             	<div class="row">
		               <div class="col-md-9">
		                  <div class="titlepage" style="padding-left:80px">
		                     <h2>하객 목록 관리</h2>
		                     <span>하객 목록을 관리할 수 있습니다.</span>
		                     <a class="read_more" href="/guest/guestlist"
		                     >하객 목록으로 이동</a>
		                  </div>
		               </div>
		               
		               <div class="col-md-3" style="padding:20px">
		               	  <img class="create_roundimg" src="/main_temp/images/CreateTemplate.jpg"/>
		               </div>
		            </div>
               </div>
               
            </div>
         </div>
      </div>
      <!-- end about -->
<%@ include file="../include/m_footer.jsp" %>