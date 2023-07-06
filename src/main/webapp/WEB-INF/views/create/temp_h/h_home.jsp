<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/h_header.jsp"%>
<script>
$(document).ready(function() {
	// 결혼장소 개행문자 처리 -> <br>로 바꾸기
  	if ($("#ta_wedloc").length != 0) {
  		var txt = $("#ta_wedloc").val();
  	    var txtresult = txt.replace(/(\n|\r\n)/g, '<br>');
  	    console.log("txtresult: ", txtresult);
  	    $("#p_wedloc").append(txtresult);
  	}
	
	// 메세지 개행문자 처리
	var items = $(".owl-item"); // cloned가 생성되는 현상때문에, cloned 걸러내기 작업
	for (var i=0; i<items.length; i++) {
		var target = $(".owl-item").eq(i); 
		if (target.hasClass("cloned") == false) { // cloned 아닌 것만 골라내기
			var ta = target.find(".ta_mtext");
			if (ta.length != 0) {
				var txt = ta.val();
				if (txt.length > 15) {
					txt = txt.substring(0, 15)+"..."
				}
				var txtresult = txt.replace(/(\n|\r\n)/g, '<br>');
	 		    var p_mtext = target.find(".p_mtext");
	 			p_mtext.append("\""+txtresult+"\"");
			}
		}
	}
});
</script>
	<header id="fh5co-header" class="fh5co-cover" role="banner" 
		<c:choose>
			<c:when test="${tpVo.tp_htitlepic ne null}"
				>style="background-image:url(/tempH/displayImage?pic=${tpVo.tp_htitlepic});"</c:when>
			<c:otherwise
				>style="background-image:url(/create_tempH/images/sample_home.jpg);"</c:otherwise>
		</c:choose>
		>
		<div class="overlay"></div>
		<div class="container">
			<%@ include file="/WEB-INF/views/include/h_header_title.jsp"%>
		</div>
	</header>

	<div id="fh5co-couple">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-offset-2 text-center fh5co-heading animate-box">
					<figure><img class="rborder_img" style="margin-bottom:20px; height:500px;" 
						<c:choose>
							<c:when test="${hVo.h_pic ne null}">src="/tempH/displayImage?pic=${hVo.h_pic}"</c:when>
							<c:otherwise>src="/create_tempH/images/sample_home.jpg"</c:otherwise>
						</c:choose>
						></figure>
					<h2 style="font-size:60px;">
						<c:choose>
							<c:when test="${hVo ne null}">${hVo.h_gname} &amp; ${hVo.h_bname}</c:when>
							<c:otherwise>신랑이름 &amp; 신부이름</c:otherwise>
						</c:choose>
					</h2>
					<p id="homeIntro">함께 키워온 두 사람의 사랑이 결실을 맺게 되었습니다.<br>
						저희의 결혼식에 소중한 인연이 되어주신 당신을 초대합니다.<br>
						바쁘시더라도 귀한 걸음으로 축복해 주시면<br>
						더 없는 기쁨으로 간직하겠습니다.</p>
					<div style="width:50%; border:1px solid #8E806A; padding:30px 50px; margin:50px auto;">
					<h3 style="font-size:18px; color:#8E806A;">
						<c:choose>
							<c:when test="${hVo ne null}">날짜 : ${hVo.h_weddate}</c:when>
							<c:otherwise>날짜 : 0000년 00월 00일</c:otherwise>
						</c:choose>
					</h3>
					<c:choose>
						<c:when test="${hVo ne null}">
							<textarea id="ta_wedloc" style="display:none;">장소 : ${hVo.h_wedloc}</textarea>
							<h3 id="p_wedloc" style="color:#8E806A; margin:0px; font-size:14px;"
							></h3>
						</c:when>
						<c:otherwise>
							<h3 style="color:#8E806A; margin:0px; font-size:14px;"
							>장소 : 예) 서울특별시 행복구 행복로 1234,<br>MW 웨딩홀 1층</h3>
						</c:otherwise>
					</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 결혼식 행사 일정 -->
	<div id="fh5co-event" class="fh5co-bg" 
		<c:choose>
			<c:when test="${tpVo.tp_hspic ne null}"
			>style="background-image:url(/tempH/displayImage?pic=${tpVo.tp_hspic});"</c:when>
			<c:otherwise>style="background-image:url(/create_tempH/images/title.jpg);"</c:otherwise>
		</c:choose>>
		<div class="overlay"></div>
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-offset-2 text-center fh5co-heading animate-box">
					<span>WEDDING EVENTS</span>
					<h2>결혼식 일정 안내</h2>
				</div>
			</div>
			<div class="row">
				<div class="display-t">
					<div class="display-tc">
						<div class="col-md-12 col-sm-6 text-center">
							<div style="padding:0px 100px;">
							<div class="event-wrap animate-box" style="width:100%;">
								<h3>진행 순서</h3>
								<div class="event-col">
									<div style="margin:10px 0px 20px;">
										<i class="icon-clock"></i>
									</div>
									<c:choose>
										<c:when test="${list_hsVo ne null}">
											<c:forEach items="${list_hsVo}" var="hsVo">
												<span style="font-size: 18px; margin-bottom:10px;">${hsVo.hs_starttime} ~ ${hsVo.hs_endtime}</span>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<span style="font-size: 18px; margin-bottom:10px;">(시작시간 ~ 종료시간)</span>
											<span style="font-size: 18px; margin-bottom:10px;">예) 오전 00시 00분 ~ 오후 00시 00분</span>
											<span style="font-size: 18px; margin-bottom:10px;">. . .</span>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="event-col">
									<div style="margin:10px 0px 20px;">
										<i class="icon-calendar"></i>
									</div>
									<c:choose>
										<c:when test="${list_hsVo ne null}">
											<c:forEach items="${list_hsVo}" var="hsVo">
												<span style="font-size: 18px; margin-bottom:10px;">${hsVo.hs_event}</span>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<span style="font-size: 18px; margin-bottom:10px;">(행사명)</span>
											<span style="font-size: 18px; margin-bottom:10px;">예) 결혼식 진행</span>
											<span style="font-size: 18px; margin-bottom:10px;">. . .</span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 지인 댓글 미리보기(최신순 top5) -->
	<div id="fh5co-testimonial">
		<div class="container">
			<div class="row">
				<div class="row animate-box">
					<div class="col-md-8 col-md-offset-2 text-center fh5co-heading"
						style="margin-bottom: 2em;">
						<span>MESSAGES</span>
						<h2>축복의 메세지</h2>
						<p style="margin:20px 0px 20px; font-size:14px;"
						>※ 최근 작성된 5개의 메세지만 표시됩니다.<br
							>더 많은 메세지를 보시려면 <a style="text-decoration: underline; color:#3F4E4F;" 
							<c:choose>
								<c:when test="${userVo ne null}">
								href="/url/${userVo.url}/messages" 
								</c:when>
								<c:otherwise>
								href="/preview/h_messages"
								</c:otherwise>
							</c:choose>
							>여기</a>를 클릭하세요.
						</p>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 animate-box">
						<div class="wrap-testimony">
							<div class="owl-carousel-fullwidth">
								<c:choose>
									<c:when test="${list_mVo ne null}">
										<c:forEach items="${list_mVo}" var="mVo">
											<div class="item">
												<div class="testimony-slide active text-center">
													<div>
														<img 
														<c:choose>
															<c:when test="${mVo.m_pic ne null}">
																src="/tempH/displayImage?pic=${mVo.m_pic}" alt="user"
															</c:when>
															<c:otherwise>
																src="/create_tempH/images/messageDefault.jpg" alt="user"
															</c:otherwise>
														</c:choose>
														>
													</div>
													<span style="margin-top:30px; font-size:23px;">${mVo.m_name}</span>
													<span>${mVo.m_time}</span>
													<blockquote>
														<textarea class="ta_mtext" style="display:none;">${mVo.m_text}</textarea>
														<p class="p_mtext" style="font-size:26px; font-family:SimKyungha;"></p>
													</blockquote>
												</div>
											</div>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<c:forEach var="i" begin="1" end="5">
											<div class="item">
												<div class="testimony-slide active text-center">
													<div>
														<img src="/create_tempH/images/messageDefault.jpg" alt="user">
													</div>
													<span style="margin-top:30px; font-size:23px;">이름${i}</span>
													<span>0000년 00월 00일, 00:00</span>
													<blockquote>
														<textarea class="ta_mtext" style="display:none;">메세지 내용입니다.(${i})</textarea>
														<p class="p_mtext" style="font-size:26px; font-family:SimKyungha;"></p>
													</blockquote>
												</div>
											</div>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<% session.removeAttribute("message"); %>
<%@ include file="/WEB-INF/views/include/h_footer.jsp"%>