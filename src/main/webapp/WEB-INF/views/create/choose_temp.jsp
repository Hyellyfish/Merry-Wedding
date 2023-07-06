<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/m_header.jsp" %>
<script>
$(document).ready(function() {
	// 템플릿 미리보기
	$(".wrapdiv_dark").click(function () {
		var id = $(this).attr("id");
		switch (id) {
			case "preview_tempY":
		 		alert("서비스 준비중입니다.");
				break;
			case "preview_tempH":
		 		window.open("/create/preview_tempH");
				break;
		}
	});
	
	// 템플릿 선택
	$(".template_box").click(function() {
		var id = $(this).attr("id");
		switch (id) {
			case "temp_y":
				alert("서비스 준비중입니다.");
				break;
			case "temp_h":
				$(location).attr('href', '/tempH/insert_info');
				break;
		}
	});
	
	// 미리보기 - hover시 미리보기 문구 출력
	$(".imgdiv_dark").hover(function() {
		$(this).children().first().css("filter", "brightness(0.45)");
		$(this).children().last().show();
		
	}, function() {
		$(this).children().first().css("filter", "brightness(1)");
		$(this).children().last().hide();
	});
	
	// 템플릿 선택 - hover시 글자색 변화
	$(".template_box").hover(function() {
		$(this).find("h3").css("color", "#e76f64");
	}, function() {
		$(this).find("h3").css("color", "#161615");
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
                     <h2>페이지 템플릿 선택</h2>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- our plane -->
      <div class="plane" style="padding-top: 120px; padding-bottom: 90px;">
         <div class="container">
            <div class="row">
               <div class="col-sm-12">
                  <div class="titlepage" style="margin-bottom:50px">
                     <h1 class="home_title" style="padding:0px 0px 10px 0px">Templates</h1>
                     <h3>아래의 두 가지 템플릿 중에서 마음에 드는 템플릿을 선택해주세요.</h3>
                  </div>
               </div>
            </div>
            <div class="row">
               <div class="col-md-6" style="padding-right: 50px; padding-left: 50px;">
                  <div class="plan_bax text_align_center">
                  	 <div id="preview_tempY" class="wrapdiv_dark" style="cursor:pointer;">
	                  	 <div class="imgdiv_dark">
	                  	 	<img class="img_dark" src="/main_temp/images/plan_img.jpg" style="height:400px; object-fit: cover;">
	                  	 	<p class="text_dark" style="color: white; display:none; font-family: 'JSDongkang-Regular';  font-size:18px;"
	                  	 		>템플릿 미리보기</p>
	                  	 </div>
                  	 </div>
                  	 <div id="temp_y" class="plan_text template_box">
                        <h3>미니멀 클래식</h3>
                        <p style="padding:0px">Design by Y<br>골드와 핑크가 잔잔히 녹아있는<br>미니멀 스타일 템플릿입니다.<br>선택하려면 클릭하세요.</p>
                     </div>
                  </div>
               </div>
               
               <div class="col-md-6" style="padding-right: 50px; padding-left: 50px;">
                  <div class="plan_bax text_align_center">
                  	 <div id="preview_tempH" class="wrapdiv_dark" style="cursor:pointer;">
	                  	 <div class="imgdiv_dark">
	                  	 	<img class="img_dark" src="/main_temp/images/tpH.jpg" style="height:400px; object-fit: cover;">
	                  	 	<p class="text_dark" style="color: white; display:none; font-family: 'JSDongkang-Regular'; font-size:18px;"
	                  	 		>템플릿 미리보기</p>
	                  	 </div>
                  	 </div>
                     <div id="temp_h" class="plan_text template_box">
                        <h3>모던 내추럴</h3>
                        <p style="padding:0px">Design by H<br>감성적인 디자인이 어우러진<br>모던 내추럴 스타일 템플릿입니다.<br>선택하려면 클릭하세요.</p>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- our plane -->
<%@ include file="../include/m_footer.jsp" %>