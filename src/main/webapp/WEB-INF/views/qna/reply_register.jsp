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
</style>
<script>
$(document).ready(function() {
	
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
	               <h2>답변 추가</h2>
	            </div>
	         </div>
	      </div>
	   </div>
	</div>
	
	<div style="padding:100px; min-height:650px;">
		<div class="text-center">
			<h1 class="home_title">Answer</h1>
		</div>
		
		<!-- 답변 등록 -->
		<div>
	        <div class="container" id="container">
			    <form id="frm" method="post" action="/qna/reply?page=${pagingDto.page}&perPage=${pagingDto.perPage}">
			        <input type="hidden" name="re_group" value="${qnaVo.re_group }"/>
					<input type="hidden" name="re_seq" value="${qnaVo.re_seq }"/>
					<input type="hidden" name="re_level" value="${qnaVo.re_level }"/>
					<input type="hidden" name="c_secret" value="${qnaVo.c_secret }"/>
					<input type="hidden" name="c_password" value="${qnaVo.c_password }"/>
			        <table  style="padding-top:50px; margin:auto; width:800px; border:0; cellpadding:2 ">
				        <tr>
					        <td bgcolor=white>
					        <table class="table2">
				                <tr>
				                <th>제목</th>
				                <td><input type="text" class="inputs" id="c_title" name="c_title" value="답변 : ${qnaVo.c_title }" placeholder="제목을 입력하세요." size=60></td>
				                </tr>
				
				                <tr>
				                <th>작성자</th>
				                <td><input type="text" class="inputs" id="c_id" name="c_id" placeholder="이름을 입력하세요." value="${loginInfo.userid }" readonly style="border: none; background: transparent;"></td>
				                </tr>
				
				                <tr>
				                <th>내용</th>
				                <td><textarea cols=85 class="inputs" rows=15 id="c_content" name="c_content" placeholder="내용을 입력하세요." style="resize:none;"
				                	>문의 내용 : ${qnaVo.c_content }&#10;&#10;&#10;답변: </textarea></td>
				                </tr>
				                </table>
				                <div class="col-sm-12" style="padding-bottom:40px">
							        <div class="row" style="float:right;">
							       		<a href="/qna/qnaList">
							       			<button type="button" style="margin-right:5px;" class="btn btn-gray"
							       				>목록으로</button>
							       		</a>
									    <button type="submit" id="btnSubmit" class="btn btn-brown" style="margin-right:20px;"
									    	>작성완료</button>
									</div>
								</div>
				        	</td>
				        </tr>
			        </table>
		        </form>
	         </div>
        </div>
		<!-- // 답변 등록 -->
		
	</div>
<%@ include file="../include/m_footer.jsp" %>