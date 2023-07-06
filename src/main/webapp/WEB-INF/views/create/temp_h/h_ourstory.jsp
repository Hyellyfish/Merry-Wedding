<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/h_header.jsp"%>
<script>
$(document).ready(function() {
  // ourstory 개행문자 처리 -> <br>로 바꾸기
  if ($("#ta_ocontent").length != 0) {
	  var txt = $("#ta_ocontent").val();
  	  var txtresult = txt.replace(/(\n|\r\n)/g, '<br>');
  	  console.log("txtresult: ", txtresult);
  	  $("#homeIntro_vo").append(txtresult);
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
	
	<div id="fh5co-couple-story">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-offset-2 text-center fh5co-heading animate-box">
					<span>Our Story</span>
					<h2>우리의 이야기</h2><hr>
				</div>
				
				<div class="col-md-8 col-md-offset-2 text-center fh5co-heading animate-box">
					<figure><img class="rborder_img" style="margin-bottom:20px; height:500px;" 
					<c:choose>
						<c:when test="${oVo.o_pic ne null}">
							src="/tempH/displayImage?pic=${oVo.o_pic}"
						</c:when>
						<c:otherwise>
							src="/create_tempH/images/sample_our.jpg"
						</c:otherwise>
					</c:choose>
					></figure>
					<c:choose>
						<c:when test="${oVo ne null}">
							<h2 style="font-size:30px">${oVo.o_title}</h2>
							<br>
							<textarea id="ta_ocontent" style="display:none;">${oVo.o_content}</textarea>
							<p id="homeIntro_vo"></p>
						</c:when>
						<c:otherwise>
							<h2 style="font-size:30px">예) 우리들의 사랑이야기</h2>
							<br>
							<p id="homeIntro">예) 사랑시 고백구 행복동 그대를 만나고 내가 사는 이곳<br>라라라라 랄라 라라라<br>oh my sunshine<br>사랑에 빠진 한 소녀는 밤새도록 잠도 못이루고<br>라랄라라 노래만 부르네<br>그대를 생각하네<br>사랑에 빠진 그 소녀는 밤새도록 전화기만 붙잡아<br>미소짓는 그 한소녀가 나란걸 모르지<br>사랑시 고백구 행복동 그대를 만나고 내가 사는 이곳<br>별빛보다 더 아름다워 그대는 그런 사람<br>그댄 나만의 사랑 사랑은 오직 한사람<br>그대가 다녀간 나의 마음에 사랑이란 꽃이 피어나네<br>라라랄라 라랄라 라라랄라 랄라 랄 라라 라라 랄라라라라<br>내 심장이 자꾸만 뛰어 너를 볼때마다 진동을 느껴<br>스르르륵 두 눈을 감아도 자꾸만 니가 보여<br>초코 바닐라 향기가 나 니가 내옆을 지나갈때마다<br>너무 좋아 넌 이런 내맘 바보라 모르지</p><br>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>

<%@ include file="/WEB-INF/views/include/h_footer.jsp"%>