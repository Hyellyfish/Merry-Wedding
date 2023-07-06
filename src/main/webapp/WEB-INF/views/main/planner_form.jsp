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
                     <h2>웨딩 플래너</h2>
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
		                     <h2>웨딩업체 찾기</h2>
		                     <span>전국의 웨딩 업체 목록과 관련 정보를 제공합니다.<br>이름과 지역별로 검색이 가능합니다. 최신 정보로 업데이트됩니다.
		                     </span>
							<a class="read_more" href="/planner/vendor_list" style="max-width:200px;"
								>웨딩업체 목록으로 이동</a>
		                  </div>
		               </div>
		               
		               <div class="col-md-3" style="padding:20px">
		                  <img class="create_roundimg" src="/main_temp/images/weddinghall.jpg"/>
		               </div>
	             	</div>
	             	
	             	<hr style="margin-top: 2rem; margin-bottom: 2rem;">
	             	
	             	<div class="row">
		               <div class="col-md-9">
		                  <div class="titlepage" style="padding-left:80px">
		                     <h2>웨딩 체크리스트</h2>
		                     <span>결혼 준비에 필요한 기본적인 사항들을 정리한 체크리스트를 제공합니다.<br>더욱 꼼꼼하고 간편하게 결혼 계획을 세울 수 있습니다.</span>
		                     <a class="read_more" href="/planner/checklist"
		                     >체크리스트로 이동</a>
		                  </div>
		               </div>
		               
		               <div class="col-md-3" style="padding:20px">
		               	  <img class="create_roundimg" src="/main_temp/images/WeddingPlanner.jpg"/>
		               </div>
		            </div>
               </div>
               
            </div>
         </div>
      </div>
      <!-- end about -->
<%@ include file="../include/m_footer.jsp" %>