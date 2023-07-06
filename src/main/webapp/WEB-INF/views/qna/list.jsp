<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/m_header.jsp" %>
<%@ include file="../include/vendor_list_css.jsp" %>
<style>
th {
	font-weight:normal;
	font-size:17px;
}

nav {
    display: flex;
    justify-content: center;
}

.page-link{
	color: black;
} 
    
</style>
<script>
$(document).ready(function() {
	// 검색 키워드 유지
	if (${pagingDto.keyword != null}) {
		$("#keyword").val("${pagingDto.keyword}");
	}
	
	// 내용 클릭시 - 비밀글이면 비번확인, 일반글이며 상세페이지
	$(".a_title").click(function(e) {
		e.preventDefault();
		var c_no = $(this).attr("data-cno");
		var c_secret = $(this).attr("data-secret");
		$("#c_no").attr("name", "c_no");
		$("#c_no").val(c_no);
		
		var frm = $("#frmSearch");		
		var src = "";
		if (c_secret == "false") {
			src = "/qna/detail?c_no="+c_no; // 비밀글이 아니면 detail로
		} else if (c_secret == "true"){
			src = "/qna/password_check"; // 비밀글이면 password_check로
			if ("${loginInfo.userid}" == "admin") { // 관리자라면 비밀번호 체크 x
				src = "/qna/detail?c_no="+c_no;
			}
		}
		frm.attr("action", src).submit();
	});
	
	// 페이지
	$(".page-link").click(function(e) {
		e.preventDefault();
		var page = $(this).attr("href");
		$("#page").attr("name", "page");
		$("#page").val(page);
		$("#frmSearch").attr("action", "/qna/qnaList").submit();
	});
	
	// 검색 버튼
	$("#btnSearch").click(function() {
		var searchType = $("#frmSearch").find("[name=searchType]").val();
		var keyword = $("#frmSearch").find("[name=keyword]").val();
		$("#frmSearch").find("[name=searchType]").val(searchType);
		$("#frmSearch").find("[name=keyword]").val(keyword);
		$("#frmSearch").attr("action", "/qna/qnaList");
		$("#frmSearch").submit();
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
	               <h2>고객 문의 게시판</h2>
	            </div>
	         </div>
	      </div>
	   </div>
	</div>
	
	<div style="padding:100px; min-height:650px;">
		<div class="text-center">
			<h1 class="home_title">Q &amp; A</h1>
		</div>
		
		<!-- 게시판 -->
		<div class="blog">
         <div class="container ">
         	<div class="row">
				<div class="col-md-12">
				 	<a href="/qna/register" class="btn btn-md btn-brown" type="button" style="margin-bottom:10px; float:right;">글쓰기</a>
					
				
				<!-- Topbar Search -->
                    <form id="frmSearch" class="d-none d-sm-inline-block form-inline mr-auto my-2 my-md-0 mw-100 navbar-search">
                        <input type="hidden" id="page">
                        <input type="hidden" id="c_no">
                        <input type="hidden" id="c_secret">
                        <div class="input-group" style="margin-bottom:20px">
                            <select class="inputs-s" name="searchType" style="width:40%;">
                            	<option value="t"
                            		<c:if test="${pagingDto.searchType=='t' }">
                            			selected
                            		</c:if>
                            	>제목</option>
                            	<option value="c"
	                            	<c:if test="${pagingDto.searchType=='c' }">
	                            		selected
                            		</c:if>
                            	>내용</option>
                            	<option value="i"
          		       	            <c:if test="${pagingDto.searchType=='i' }">
	                            		selected
                            		</c:if>
                            	>작성자</option>
                            	<option value="tc"
                            		<c:if test="${pagingDto.searchType=='tc' }">
	                            		selected
                            		</c:if>
                            	>제목+내용</option>
                            </select>
                            
                            <input type="text" class="inputs-s" placeholder="검색어 입력" style="width:30%; margin-left:5px;"
                                aria-label="Search" aria-describedby="basic-addon2" id="keyword" name="keyword">
                            <div class="input-group-append">
                                <button id="btnSearch" class="btn btn-brown" type="button">
                                    <i class="fa fa-search fa-sm"></i>
                                </button>
                            </div>
                            <a href="/qna/qnaList"><button type="button" class="btn btn-md btn-brown" style="margin-left:5px;"
                            >전체목록</button></a>
                        </div>
                    </form>
                 <!-- //Topbar Search -->
                 
              </div>      
			</div>
			<table class="table">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>등록일</th>
						<th>작성자</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${list}" var="qnaVo" varStatus="status">
					<tr>
						<td data-no="td_no">${(count - status.index)-((pagingDto.page-1)*10)}</td>
						<td style="padding-Left:${qnaVo.re_level * 20}px"
						><a href="#" class="a_title" data-cno="${qnaVo.c_no}" 
							data-secret="${qnaVo.c_secret}">
						<c:if test="${qnaVo.re_level gt 0}">
						└
						</c:if>
						<c:choose>
							<c:when test="${qnaVo.c_secret eq false}">
								${qnaVo.c_title }
							</c:when>
							<c:otherwise>
								<i class="fa fa-unlock-alt" aria-hidden="true"></i>&nbsp;${qnaVo.c_title}
							</c:otherwise>
						</c:choose>
						</a></td>
						<td>${qnaVo.c_date }</td>
						<td>${qnaVo.c_id }</td>
						<td>${qnaVo.viewcnt}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>

			<!-- pagination -->
			<div class="row" style="margin-top:50px;">
					<div class="col-md-12" style="padding-bottom:100px">
						<nav class="pagination">
							<ul class="pagination">
								<c:if test="${pagingDto.startPage ne 1}">
									<li class="page-item">
										<a class="page-link" href="${pagingDto.startPage - 1}">«</a>
									</li>
								</c:if>
								<c:forEach var="page" begin="${pagingDto.startPage}" end="${pagingDto.endPage}">
									<li 
										<c:choose>
											<c:when test="${pagingDto.page eq page}">
												class="page-item active"
											</c:when>
											<c:otherwise>
												class="page-item"
											</c:otherwise>
										</c:choose>
									>
										<a class="page-link" href="${page}">${page}</a>
									</li>
								</c:forEach>
								<c:if test="${pagingDto.endPage lt pagingDto.totalPage}">
									<li class="page-item">
										<a class="page-link" href="${pagingDto.endPage + 1}">»</a>
									</li>
								</c:if>
							</ul>
						</nav>
					</div>
				</div>
			
			<!-- //pagination -->
         
         </div>
      </div>
		<!-- // 게시판 -->
		
	</div>
<%@ include file="../include/m_footer.jsp" %>