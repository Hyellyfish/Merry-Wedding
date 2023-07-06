<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/h_header.jsp"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1df65d7dc7e43db74dd4d188e6782f91&libraries=services"></script>
<script>
$(document).ready(function() {
	var container = $("#map")[0]; //지도를 담을 영역
	var options = { // 지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표.
		level: 3 // 지도의 레벨(확대, 축소 정도)
	};
	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	
	<c:if test="${tVo ne null}">
	var geocoder = new kakao.maps.services.Geocoder(); // 주소-좌표 변환 객체 생성
	geocoder.addressSearch("${tVo.t_wedloc}", function(result, status) {
		// 정상적으로 검색 완료된 경우
		if (status == kakao.maps.services.Status.OK) {
			var coords = new kakao.maps.LatLng(result[0].y, result[0].x); // 결과값으로 받은 위치
			var marker = new kakao.maps.Marker({ // 위치를 마커로 표시
				map : map,
				position : coords
			});
			map.setCenter(coords); // 지도의 중심을 받은 위치로 이동
		}
	});
	</c:if>
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
					<span>TRAVEL</span>
					<h2>오시는 길</h2><hr>
				</div>
				
				<div class="col-md-8 col-md-offset-2 text-center fh5co-heading animate-box">
					<div id="map" style="margin:0px auto 50px; width:700px; height:500px; border-radius: 2%;"></div>
					<h2 style="font-size:35px; margin:0px;">
					<c:choose>
						<c:when test="${tVo ne null}">${tVo.t_wedloc},</c:when>
						<c:otherwise>예) 서울특별시 행복구 행복로 1234,</c:otherwise>
					</c:choose>
					</h2>
					<h2 style="font-size:35px">
					<c:choose>
						<c:when test="${tVo.t_wedlocd ne null}">${tVo.t_wedlocd}</c:when>
						<c:otherwise>MW 웨딩홀 1층</c:otherwise>
					</c:choose>
					</h2>
					<p id="homeIntro">
					<c:choose>
						<c:when test="${tVo ne null}">${tVo.t_text}</c:when>
						<c:otherwise>예) 찾아오시는 길에 대한 세부 내용을 입력해 주세요.<br><br>- 지하철 -<br>1호선 사랑역(4번출구) 도보 10분 거리<br><br>- 버스- <br>12번 (MW 웨딩홀 앞 정류장) / 134번, 56번 (행복아파트 앞 정류장, 도보 5분 거리)<br><br>- 주차안내 -<br>MW 웨딩홀 지하주차장(만차시 바로 옆 MW은행 건물 지하주차장 주차 가능)<br><br>기타 문의사항이 있으시면 아래 연락처로 연락주시기 바랍니다.<br>MW 웨딩홀<br>TEL. 02-123-4567
						</c:otherwise>
					</c:choose>
					</p>
				</div>
			</div>
		</div>
	</div>

<%@ include file="/WEB-INF/views/include/h_footer.jsp"%>