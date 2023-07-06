<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/h_header.jsp"%>
<script>
$(document).ready(function() {
	  // photosdata 따옴표 처리 -> <br>로 바꾸기
	 <c:forEach items="${list_pdVo}" var="pdVo" varStatus="status">
	 	var pdtext = "${pdVo.pd_text}";
	 	pdtext = pdtext.replace(/<ttaompyo>/g, "\"");
	 	var target = $(".ptext").eq(${status.index});
	 	target.append(pdtext);
	 	
	 	var pdtitle = "${pdVo.pd_title}";
	 	pdtitle = pdtitle.replace(/<ttaompyo>/g, "\"");
	 	$(".ptext2")[${status.index}].append(pdtitle);
	  </c:forEach>
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
					<span>Photos</span>
					<h2>사랑의 발자취</h2><hr>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 col-md-offset-0">
					<ul class="timeline animate-box">
						
				<c:choose>
					<c:when test="${pVo ne null}">
						<c:forEach items="${list_pdVo}" var="pdVo" varStatus="status">
							<c:choose>
								<c:when test="${status.count mod 2 eq 0}">
									<!-- 오 -->
									<li class="timeline-inverted animate-box">
									<div class="timeline-badge" style="background-image:url(images/couple-2.jpg);"></div>
										<img class="storyimg dpimg" style="margin-left:70px;" 
											<c:choose>
												<c:when test="${pdVo.pd_pic ne null}">
													src="/tempH/displayImage?pic=${pdVo.pd_pic}"
												</c:when>
												<c:otherwise>
													src="/create_tempH/images/bride.jpg"
												</c:otherwise>
											</c:choose>
											>
										<div class="timeline-panel">
											<div class="timeline-heading">
												<h3 class="timeline-title ptext2"></h3>
												<span class="date">${pdVo.pd_pdate}</span>
											</div>
											<div class="timeline-body">
												<p class="ptext"></p>
											</div>
										</div>
									</li>
								</c:when>
								<c:otherwise>
									<!-- 왼 -->
									<li class="animate-box">
									<div class="timeline-badge" style="background-image:url(images/couple-2.jpg);"></div>
										<img class="storyimg dpimg" style="margin-left:120px;" 
											<c:choose>
												<c:when test="${pdVo.pd_pic ne null}">
													src="/tempH/displayImage?pic=${pdVo.pd_pic}"
												</c:when>
												<c:otherwise>
													src="/create_tempH/images/groom.jpg"
												</c:otherwise>
											</c:choose>
											>
										<div class="timeline-panel" style="margin-right:120px;">
											<div class="timeline-heading">
												<h3 class="timeline-title ptext2"></h3>
												<span class="date">${pdVo.pd_pdate}</span>
											</div>
											<div class="timeline-body">
												<p class="ptext"></p>
											</div>
										</div>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:when>
					<c:otherwise>
					<c:forEach var="i" begin="1" end="3" step="2">
				    <!-- 왼 -->
					<li class="animate-box">
					<div class="timeline-badge" style="background-image:url(images/couple-2.jpg);"></div>
						<img class="storyimg" style="margin-left:120px; max-height:500px; object-fit:cover;" src="/create_tempH/images/sample_photos.jpg";>
						<div class="timeline-panel" style="margin-right:120px;">
							<div class="timeline-heading">
								<h3 class="timeline-title ptext2">예) 사진 제목입니다.(${i})</h3>
								<span class="date">0000년 00월 00일</span>
							</div>
							<div class="timeline-body">
								<p class="ptext">사진 설명입니다.(${i})</p>
							</div>
						</div>
					</li>
					
					<!-- 오 -->
					<li class="timeline-inverted animate-box">
					<div class="timeline-badge" style="background-image:url(images/couple-2.jpg);"></div>
						<img class="storyimg" style="margin-left:70px;  max-height:500px; object-fit:cover;"" src="/create_tempH/images/sample_photos.jpg">
						<div class="timeline-panel">
							<div class="timeline-heading">
								<h3 class="timeline-title ptext2">예) 사진 제목입니다.(${i+1})</h3>
								<span class="date">0000년 00월 00일</span>
							</div>
							<div class="timeline-body">
								<p class="ptext">사진 설명입니다.(${i+1})</p>
							</div>
						</div>
					</li>
					</c:forEach>
					</c:otherwise>
				</c:choose>
			    	</ul>
				</div>
			</div>
		</div>
	</div>

<%@ include file="/WEB-INF/views/include/h_footer.jsp"%>