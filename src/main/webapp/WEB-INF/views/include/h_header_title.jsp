<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="row">
	<div class="col-md-8 col-md-offset-2 text-center">
		<div class="display-t">
			<div class="display-tc animate-box" data-animate-effect="fadeIn">
				<c:choose>
					<c:when test="${hVo ne null}">
						<h1>${hVo.h_gname} &amp; ${hVo.h_bname}</h1>
						<h2>${hVo.h_weddate},<br>결혼합니다.</h2>
					</c:when>
					<c:otherwise>
						<h1>신랑이름 &amp; 신부이름</h1>
						<h2>0000년 00월 00일,<br>결혼합니다.</h2>
					</c:otherwise>
				</c:choose>
				<a id="msgicon" href="#sendMsg"><i class="fa fa-envelope" aria-hidden="true" style="margin-right:10px;"></i
					>축하 메세지 남기기</a>
			</div>
		</div>
	</div>
</div>