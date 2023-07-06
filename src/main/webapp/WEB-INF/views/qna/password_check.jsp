<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/m_header.jsp" %>
<%@ include file="../include/vendor_list_css.jsp" %>
<script>
$(document).ready(function() {
	// 비번확인 버튼
	$("#btnSubmit").click(function(){
		var c_no = $("#c_no").val();
		console.log(c_no);
		$("#c_no").attr("value", c_no);
		var c_password=$("#c_password").val();
		console.log(c_password);
		
		var url = "/qna/password";
		var sData = {
				"c_password" : c_password,
				"c_no" : c_no
		};
		$.post(url, sData, function(rData){
			console.log(rData.c_password);
			if(rData.c_password == c_password){
				console.log("success");
				location.href="detail?c_no="+c_no;
			}
			else if(rData.c_password != c_password){
				console.log("fail");
				alert("비밀번호가 일치하지 않습니다.");
			}
		});
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
	               <h2>비밀글입니다</h2>
	            </div>
	         </div>
	      </div>
	   </div>
	</div>
	
	<div style="padding:100px; min-height:650px;">
		<div class="text-center">
			<h1 class="home_title">Password</h1>
		</div>
		 <div class="container-fluid" style="padding: 30px 300px 0px">
		 	<div class="text-center">
		 		<p class="mp_titleh3" style="font-size:24px; padding: 0px 0px 10px;"
		 			>비밀글 기능으로 보호된 게시글입니다.</p>
		 		<h3 class="mp_titleh3" style="font-size:24px; font-weight:bold;"
		 			>게시글 비밀번호를 입력해 주세요.</h3>
<!-- 				<form action="/user/input_password_run" method="post"> -->
					<input type="hidden" id="c_no" name="c_no" value="${c_no }"/>
					<div style="margin-top:50px;">
						<input type="password" class="inputs noSpace" style="font-family:'Raleway', sans-serif; display:inline; width: 35%;"
							id="c_password" name="c_password" placeholder="비밀번호"  required>
						<button id="btnSubmit" type="button" class="btn btn-brown" style="margin-left: 5px;"
							>확인</button>
					</div>
					<div style="margin-top:100px;">
						<a href="/qna/qnaList">
			       			<button type="button" class="btn btn-gray" style="margin-right:5px;"
			       				>목록으로</button>
			       		</a>
					</div>
<!-- 				</form> -->
		 	</div>
		 </div>
	</div>
<%@ include file="../include/m_footer.jsp" %>