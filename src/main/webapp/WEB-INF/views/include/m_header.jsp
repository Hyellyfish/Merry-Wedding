<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<head>
<style>
#tooltiptext {
  font-size: 10px;
  font-family: 'JSDongkang-Regular';
  margin-left: 405px;
  background-color: #000;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 5px 15px;
}

#tooltiptext2 {
  border-width: 5px;
  border-style: solid;
  border-color: #000 transparent transparent transparent;
}

.inputs {
	display: block;
	width: 100%;
	padding: 0.375rem 0.75rem;
	font-size: 1rem;
	line-height: 1.5;
	color: #495057;
	background-color: #fff;
	background-clip: padding-box;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}

.inputs::placeholder{
	color: #ced4da;
	font-family: 'JSDongkang-Regular';
}

.inputs-m {
	display: inline;
	width: 49.5%;
	padding: 0.375rem 0.75rem;
	font-size: 1rem;
	line-height: 1.5;
	color: #495057;
	background-color: #fff;
	background-clip: padding-box;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}

.inputs-m::placeholder,
.inputs-s::placeholder{
	color: #ced4da;
}
	
.inputs-s {
	display: inline;
	width: 15%;
	padding: 0.375rem 0.75rem;
	font-size: 1rem;
	line-height: 1.5;
	color: #495057;
	background-color: #fff;
	background-clip: padding-box;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}

.form-group2 {
	margin: 0px 0px 25px
}

.btn-brown {
  color: #fff;
  background-color: #413731;
  border-color: #413731;
}

.btn-brown:hover {
     background-color: #F6AE99;
     transition: ease-in all 0.5s;
     color: #fff;
}

.btn-brown2 {
  color: #413731;
  background-color: #F9F7F5;
  border-color: #413731;
}

.btn-pink {
  color: #fff;
  background-color: #F6AE99;
  border-color: #F6AE99;
}

.btn-pink:hover {
     background-color: #fff;
     transition: ease-in all 0.5s;
     color: #F6AE99;
     border-color: #F6AE99;
}

.btn-red {
  color: #fff;
  background-color: #E76F64;
  border-color: #E76F64;
}

.btn-gray {
  color: #fff;
  background-color: #ced4da;
  border-color: #ced4da;
}

.btn-beige {
  color: white;
  background-color: #BBAEA0;
  background-image: none;
  border-color: #BBAEA0;
}

.btn-beige:hover {
  color: white;
  background-color: #BBAEA0;
  background-image: none;
  border-color: #BBAEA0;
}

.btn-beigeline {
  color: #BBAEA0;
  background-color: white;
  background-image: none;
  border-color: #BBAEA0;
}

.btn-beigeline:hover {
  color: #fff;
  background-color: #BBAEA0;
  border-color: #BBAEA0;
}

.img_dark {
	width: 100%;
    margin-bottom: 25px;
    vertical-align: middle;
    filter: brightness(1);
    transition: 1s;
}

.wrapdiv_dark {
	width: 100%;
	position: relative;
}

.text_dark{
	position: absolute;
	top: 50%;
	left: 50%;
	width: 50%;
	transform: translate(-50%, -50%);
	text-align:center;
}

</style>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <!-- mobile metas -->
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="viewport" content="initial-scale=1, maximum-scale=1">
      <!-- site metas -->
      <title>MW</title>
      <meta name="keywords" content="">
      <meta name="description" content="">
      <meta name="author" content="">
      <!-- bootstrap css -->
      <link rel="stylesheet" href="/main_temp/css/bootstrap.min.css">
      <!-- style css -->
      <link rel="stylesheet" href="/main_temp/css/style.css">
      <!-- Responsive-->
      <link rel="stylesheet" href="/main_temp/css/responsive.css">
      <!-- fevicon -->
      <link rel="icon" href="/main_temp/images/fevicon.png" type="image/gif" />
      <!-- Scrollbar Custom CSS -->
      <link rel="stylesheet" href="/main_temp/css/jquery.mCustomScrollbar.min.css">
      <!-- Tweaks for older IEs-->
      <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css" media="screen">
      <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
      <!-- Javascript files-->
      <script src="/main_temp/js/jquery.min.js"></script>
      <script src="/main_temp/js/bootstrap.bundle.min.js"></script>
      <script src="/main_temp/js/jquery-3.0.0.min.js"></script>
      <!-- sidebar -->
<!--       <script src="/main_temp/js/jquery.mCustomScrollbar.concat.min.js"></script> -->
<!--       <script src="/main_temp/js/custom.js"></script> -->
      <script>
      $(document).ready(function() {
    		// hover시 글자색 변화
    		$(".hv").hover(function() {
    			$(this).css("color", "#e76f64");
    		}, function() {
    			$(this).css("color", "#161615");
    		});
    		
    		// hover시 글자색 변화
    		$(".hv2").hover(function() {
    			$(this).css("color", "#e76f64");
    		}, function() {
    			$(this).css("color", "#666666");
    		});
    	
    	  // 상단 메뉴 active
    	  var path = window.location.href;
    	  console.log("Ddddd: ", path);
    	  if (path.includes("user")) { 
    		  $("#btnWelcome").css("color", "white"); // 마이페이지인 경우
    	  }
    	  var slashIndex = path.lastIndexOf("/");
    	  var category = path.substring(slashIndex+1);
    	  if (category.includes("#")) { // 새로고침 눌렀을 때 #...이 붙음
    		  var sharpIndex = category.lastIndexOf("#");
    		  category = category.substring(0, sharpIndex);
    	  };
    	  if (category.includes("vendor_list") || 
    			category.includes("vendor_detail") ||
    			category.includes("vendor_register") ||
    			category.includes("checklist")) {
    		  category = "planner";
    	  }
    	  if (category.includes("guestlist")) {
      		  category = "create";
      	  }
    	  if (category.includes("qnaList") || 
    			  path.includes("/qna/register") || 
    			  path.includes("/qna/detail") || 
    			  path.includes("/qna/reply") || 
    			  path.includes("/qna/password_check")) {
      		  category = "qna";
      	  }
    	  if (path.includes("/user/register")) {
			  category = "login"; // 회원가입인 경우
		  }
    	  
    	  var nowCtg;
    	  switch (category) {
    	  case "home": 
    		  nowCtg = $("#ctgHome");
    		  $("#body").addClass("inner_page");
    		  break;
    	  case "planner":
    		  nowCtg = $("#ctgPlanner");
    		  break;
    	  case "create":
    		  nowCtg = $("#ctgCreate");
    		  break;
    	  case "choose_temp":
    		  nowCtg = $("#ctgCreate");
    		  break;
    	  case "insert_info":
    		  nowCtg = $("#ctgCreate");
    		  break;
    	  case "qna":
    		  nowCtg = $("#ctgQna");
    		  break;
    	  case "login":
    		  nowCtg = $("#ctgLogin");
    		  break;
    	  default :
    		  nowCtg = "none";
    		  break;
    	  }
    	  var activeCtg = $(".nav-item.active");
    	  if (activeCtg.length == 1) {
    		  activeCtg.removeClass("active");
    	  }
    	  if (nowCtg != "none") {
    	  	nowCtg.addClass("active");    		  
    	  }
    	  
    	 // 공백 제거
  		 $(".noSpace").keyup(function() {
  			var str_input = $(this).val();
  			var blank = " ";
  		    if (str_input.includes(" ")) {
  		    	str_input = str_input.replace(" ", "");
  		    	$(this).val(str_input);
  		    }
  		 });
      });
      </script>
   </head>
   <!-- body -->
   <body class="main-layout" id="body">
      <!-- loader  -->
<!--       <div class="loader_bg"> -->
<!--          <div class="loader"><img src="/images/loading.gif" alt="#"/></div> -->
<!--       </div> -->
      <!-- end loader -->
      <!-- header -->
      <header class="full_bg">
         <!-- header inner -->
         <div class="header">
            <div class="container">
               <div class="row">
                  <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col logo_section">
                     <div class="full">
                        <div class="center-desk">
                           <div class="logo">
                              <a href="/main/home" id="mw_logo">MW</a>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="col-xl-9 col-lg-9 col-md-9 col-sm-9">
                     <nav class="navigation navbar navbar-expand-md navbar-dark ">
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample04" aria-controls="navbarsExample04" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarsExample04">
                           <ul class="navbar-nav mr-auto">
                              <li class="nav-item" id="ctgHome">
                                 <a class="nav-link" href="/main/home">Home</a>
                              </li>
                              <li class="nav-item" id="ctgPlanner">
                                 <a class="nav-link" href="/main/planner">Planner</a>
                              </li>
                              <li class="nav-item" id="ctgCreate">
                                 <a class="nav-link" href="/main/create">Create My Wedding Site</a>
                              </li>
                              <li class="nav-item" id="ctgQna">
                                 <a class="nav-link" href="/qna/qnaList">QnA</a>
                              </li>
                              <c:choose>
								<c:when test="${empty loginInfo}">
									<!-- 로그인이 되어 있지 않은 경우 -->
									<li class="nav-item" id="ctgLogin">
										<a class="nav-link" href="/main/login">
											<i id="loginpage" class="fa fa-user" aria-hidden="true" style="padding:0px; padding-right:10px;"
												></i>Log in
										</a>
									</li>
								</c:when>
								<c:otherwise>
									<!-- 로그인이 된 경우 -->
										<c:choose>
											<c:when test="${loginResult eq 'manager'}">
											<!-- 관리자인 경우 -->
												<div class="dropdown">
													<button type="button" id="btnWelcome" class="dropdown-toggle"
														data-toggle="dropdown" style="background:transparent;"
													>관리자님 환영합니다.</button>
													<ul class="dropdown-menu">
														<li><a href="/user/url_manage" class="hv">마이페이지</a></li>
														<li><a href="/user/logout" class="hv">로그아웃</a></li>
													</ul>
												</div>
											</c:when>
											<c:otherwise>
											<!-- 관리자가 아닌 경우 -->
												<div class="dropdown">
													<button type="button" id="btnWelcome" class="dropdown-toggle"
														data-toggle="dropdown" style="background:transparent;"
														>${loginInfo.userid}님 환영합니다.</button>
													<ul class="dropdown-menu">
														<li><a href="/user/url_manage" class="hv">마이페이지</a></li>
														<li><a href="/user/logout" class="hv">로그아웃</a></li>
													</ul>
												</div>
											</c:otherwise>
										</c:choose>
								</c:otherwise>
							  </c:choose>
                           </ul>
                        </div>
                     </nav>
                  </div>
               </div>
            </div>
         </div>