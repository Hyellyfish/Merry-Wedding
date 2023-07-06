<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/m_header.jsp" %>
<script>
$(document).ready(function() {
	// 회원가입 성공시
	if ("${register_result}" == "success") {
		alert("회원가입이 완료되었습니다.");
	}
  
	// 로그인 실패시
	if ("${loginResult}" == "fail") {
		alert("아이디가 존재하지 않거나 비밀번호가 일치하지 않습니다.");
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
                     <h2>로그인</h2>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!--  contact -->
      <div class="contact" style="padding: 150px 200px 100px;">
      	<div class="text-center">
			<h1 class="mp_titleh1">Log in</h1>
		</div>
        <div class="container" style="padding: 0 300px;">
             <div>
                <form id="request" class="main_form" action="/user/login" method="post">
                   <div class="row">
                      <div class="col-md-12 ">
                         <input class="login_idpw noSpace" placeholder="아이디" 
                         	value="${cookie.userid.value}" type="text" name="userid" required>
                      </div>
                      <div class="col-md-12">
                         <input class="login_idpw noSpace" placeholder="비밀번호" required
                         		type="password" name="userpw" style="font-family: 'Raleway', sans-serif;">                          
                      </div>
                      <div class="col-md-12" style="margin-bottom:5px;">
	                      <div class="custom-control custom-checkbox small">
	                           <input type="checkbox" class="custom-control-input" id="customCheck"
	                           	 name="saveId"
	                           	 <c:if test="${not empty cookie.userid}">
	                           	 	checked
	                           	 </c:if>
	                           >
	                           <label class="custom-control-label" for="customCheck"
	                           		>아이디 저장</label>
	                       </div>
                       </div>
	                   	<div class="col-md-12 text-center" style="margin-top:30px;">
	                   		<button type="submit" class="send_btn" style="display:inline; margin-right:5px;"
	                   			>로그인</button>
	                   		<a type="button" class="send_btn" style="text-align:center; display:inline;" 
	                   			href="/user/register">회원가입</a>
	                   	</div>
                   </div>
                </form>
             </div>
         </div>
      </div>
      <!-- end contact -->
<%@ include file="../include/m_footer.jsp" %>