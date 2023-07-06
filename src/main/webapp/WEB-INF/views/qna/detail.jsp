<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/m_header.jsp" %>
<%@ include file="../include/vendor_list_css.jsp" %>
<style>
table.table2{
		 font-weight: normal;
         border-collapse: separate;
         border-spacing: 1px;
         text-align: left;
         line-height: 1.5;
         border-top: 1px solid #ced4da;
         margin : 20px 10px;
 }
 table.table2 tr {
/*          width: 50px; */
         padding: 10px;
         font-weight: normal;
         border-bottom: 1px solid #ced4da;
 }
 table.table2 td {
/*           width: 100px; */
          padding: 10px;
          vertical-align: top;
          border-bottom: 1px solid #ced4da;
 }
 table.table2 th{
	text-align: center;
	width: 60px;
	background-color: #413731;
	color: white;
	font-weight: normal;
}

#c_password::placeholder{
	font-family: 'JSDongkang-Regular';
}
</style>
<script>
$(document).ready(function() {
	var modify_result = "${modify_result}";
	if (modify_result == "true") {
		alert("수정되었습니다.");
	}
	
	// 수정 버튼
	$("#btnModify").click(function(){
		$("#tr_pw").show();
		$(this).hide();
		$("#btnModifyRun").show();
		$("#btnDelete").hide();
		$("#c_title").prop("readonly", false);
		$("#c_content").prop("readonly", false);
		$("#c_title").css("border", "1px solid #ced4da");
		$("#c_content").css("border", "1px solid #ced4da");
	});
	
	// 비밀번호 체크 시 비밀번호 입력란 보이기
	var check = "";
	$("#c_secret").click(function() {
		if ($("#c_secret").prop("checked")) {
			console.log("check");
			$("#c_password").show();
			check=true;
		} else if ($("#c_secret").prop("checked") == false) {
			$("#c_password").hide();
			check=false;
		}	
	});
	
	// 수정 완료 버튼
	$("#btnModifyRun").click(function(e) {
		if (check==true) {
			if ($("#c_password").val().trim() == "") {
				alert("비밀번호를 입력해주세요");
				$("#c_password").focus();
				e.preventDefault();
				return false;
			}
	    }
	});
	
	// 삭제 버튼
	$("#btnDelete").click(function(){
		if(confirm("게시글을 삭제하겠습니까?") == true){
			alert("게시글이 삭제되었습니다.");
			location.replace("/qna/delete?c_no=${qnaVo.c_no }&page=${pagingDto.page}&perPage=${pagingDto.perPage}");
		}
	});
	
	if(${qnaVo.re_seq} == 1 && ${userVo.userid}!="admin"){
		$("#btnDelete").hide();
		$("#btnModify").hide();
		$("#btnReply").hide();
	}
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
	               <h2>문의 내용 상세</h2>
	            </div>
	         </div>
	      </div>
	   </div>
	</div>
	
	<div style="padding:100px; min-height:650px;">
		<div class="text-center">
			<h1 class="home_title">Question</h1>
		</div>
		
		<!-- 글 등록 -->
		<div>
	        <div class="container" id="container">
			    <form id="frm" method="post" action="/qna/modify">
			        <table  style="padding-top:50px; margin:auto; width:800px; border:0; cellpadding:2 ">
				        <tr>
					        <td bgcolor=white>
					        <table class="table2">
				                <tr>
				                <th>글 번호</th>
				                <td colspan='3'><input type="text" class="inputs" id="c_no" name="c_no" value="${qnaVo.c_no }" readonly  style="border: none; background: transparent;"></td>
				                </tr>
				                
				                <tr>
				                <th>제목</th>
				                <td colspan='3'><input type="text" class="inputs" id="c_title" name="c_title" value="${qnaVo.c_title }" readonly size=60 style="border: none; background: transparent;"></td>
				                </tr>
				
				                <tr>
				                <th>작성자</th>
				                <td><input type="text" class="inputs" id="c_id" name="c_id" value="${qnaVo.c_id }" readonly size=60 style="border: none; background: transparent;"></td>
				                <th>작성일</th>
				                <td><input type="text" class="inputs" id="c_date" name="c_date" value="${qnaVo.c_date }" readonly size=60 style="border: none; background: transparent;"></td>
				                </tr>
				
				                <tr>
				                <th>내용</th>
				                <td colspan='3'><textarea cols=85 class="inputs" rows=15 id="c_content" name="c_content" readonly style="resize:none; border: none; background: transparent;"
				                	>${qnaVo.c_content }</textarea></td>
				                </tr>
				                
				                <tr id="tr_pw" style="display:none;">
				                <th>비밀<br>번호</th>
				                <td colspan='3'>
				                	<input type="checkbox" id="c_secret" name="c_secret" style="margin-right:10px"
				                		>비밀글 설정<br>
					                <input type="password" class="inputs-s inputpw" size=10 maxlength=10 style="display:none; margin-left:22px; margin-top:5px; width:40%; font-family: 'Raleway', sans-serif;"
					                	name="c_password" id="c_password" placeholder="비밀번호 입력">
				                </td>
				                </tr>
				                
				                </table>
				                <div class="col-sm-12" style="padding-bottom:40px">
							        <div class="row" style="float:right;">
							       		<a href="/qna/qnaList">
							       			<button type="button" class="btn btn-gray" style="margin-right:5px;"
							       				>목록으로</button>
							       		</a>
							       		<c:if test="${qnaVo.c_id eq loginInfo.userid}">
								       		<button id="btnModify" type="button" class="btn btn-brown" style="margin-right:5px;"
								       			>수정</button>
								       		<button id="btnModifyRun" type="submit" class="btn btn-brown" style="display:none; margin-right:5px;"
								       			>수정완료</button>
									    </c:if>
									    <c:if test='${loginInfo.userid eq "admin" && qnaVo.re_level eq 0}'>
									    	<a href="/qna/reply?c_no=${qnaVo.c_no }&page=${pagingDto.page}&perPage=${pagingDto.perPage}">
									    		<button id="btnReply" type="button" class="btn btn-brown" style="float:left; margin-right:5px;"
									    			>답글달기</button>
									    	</a>
									    </c:if>
									    <c:if test="${qnaVo.c_id eq loginInfo.userid || loginInfo.userid eq 'admin'}">
									    	<button id="btnDelete" type="button" class="btn btn-red" style="margin-right:20px;"
								       			>삭제</button>
									    </c:if>
									</div>
								</div>
				        	</td>
				        </tr>
			        </table>
		        </form>
	         </div>
        </div>
		<!-- // 글 등록 -->
		
	</div>
<%@ include file="../include/m_footer.jsp" %>