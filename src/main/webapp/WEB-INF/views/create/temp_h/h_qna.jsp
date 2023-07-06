<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/h_header.jsp"%>

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
					<span>Q + A</span>
					<h2>질문과 답변</h2><hr>
				</div>
				<c:choose>
					<c:when test="${qVo ne null}">
					<c:forEach items="${list_qdVo}" var="qdVo" varStatus="status">
						<div class="col-md-8 col-md-offset-2 text-center fh5co-heading animate-box">
							<h2 style="font-size:30px">Q${status.count}. ${qdVo.qd_q}</h2>
							<p style="font-size:16px; color:#8E806A;">A${status.count}. ${qdVo.qd_a}</p>
						</div>
					</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="col-md-8 col-md-offset-2 text-center fh5co-heading animate-box">
							<h2 style="font-size:30px">Q1. 질문 1 입니다?</h2>
							<p style="font-size:16px; color:#8E806A;">A1. 답변 1 입니다.</p>
						</div>
						<div class="col-md-8 col-md-offset-2 text-center fh5co-heading animate-box">
							<h2 style="font-size:30px">Q2. 질문 2 입니다?</h2>
							<p style="font-size:16px; color:#8E806A;">A2. 답변 2 입니다.</p>
						</div>
						<div class="col-md-8 col-md-offset-2 text-center fh5co-heading animate-box">
							<h2 style="font-size:30px">. . .</h2>
							<p style="color:#8E806A;">. . .</p>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>

<%@ include file="/WEB-INF/views/include/h_footer.jsp"%>