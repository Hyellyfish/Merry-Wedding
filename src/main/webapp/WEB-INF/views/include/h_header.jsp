<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<c:choose>
		<c:when test="${hVo ne null}">
			<title>결혼합니다. &mdash; ${hVo.h_gname} &amp; ${hVo.h_bname} </title>
		</c:when>
		<c:otherwise>
			<title>결혼합니다. &mdash; 신랑이름 &amp; 신부이름 </title>
		</c:otherwise>
	</c:choose>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free HTML5 Template by FREEHTML5.CO" />
	<meta name="keywords" content="free html5, free template, free bootstrap, html5, css3, mobile first, responsive" />
	<meta name="author" content="FREEHTML5.CO" />
	
	<!-- Animate.css -->
	<link rel="stylesheet" href="/create_tempH/css/animate.css">
	<!-- Icomoon Icon Fonts-->
	<link rel="stylesheet" href="/create_tempH/css/icomoon.css">
	<!-- Bootstrap  -->
	<link rel="stylesheet" href="/create_tempH/css/bootstrap.css">

	<!-- Magnific Popup -->
	<link rel="stylesheet" href="/create_tempH/css/magnific-popup.css">

	<!-- Owl Carousel  -->
	<link rel="stylesheet" href="/create_tempH/css/owl.carousel.min.css">
	<link rel="stylesheet" href="/create_tempH/css/owl.theme.default.min.css">

	<!-- Theme style  -->
	<link rel="stylesheet" href="/create_tempH/css/style.css">

	<!-- Modernizr JS -->
	<script src="/create_tempH/js/modernizr-2.6.2.min.js"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->
	<!-- jQuery -->
	<script src="/create_tempH/js/jquery.min.js"></script>
	<!-- jQuery Easing -->
	<script src="/create_tempH/js/jquery.easing.1.3.js"></script>
	<!-- Bootstrap -->
	<script src="/create_tempH/js/bootstrap.min.js"></script>
	<!-- Waypoints -->
	<script src="/create_tempH/js/jquery.waypoints.min.js"></script>
	<!-- Carousel -->
	<script src="/create_tempH/js/owl.carousel.min.js"></script>
	<!-- countTo -->
	<script src="/create_tempH/js/jquery.countTo.js"></script>

	<!-- Stellar -->
	<script src="/create_tempH/js/jquery.stellar.min.js"></script>
	<!-- Magnific Popup -->
	<script src="/create_tempH/js/jquery.magnific-popup.min.js"></script>
	<script src="/create_tempH/js/magnific-popup-options.js"></script>

	<!-- // <script src="https://cdnjs.cloudflare.com/ajax/libs/prism/0.0.1/prism.min.js"></script> -->
	<script src="/create_tempH/js/simplyCountdown.js"></script>
	<!-- Main -->
	<script src="/create_tempH/js/main.js"></script>
	<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
	
	<script>
      $(document).ready(function() {
    	  // 유효하지 않은 url일 때
   		  var message = "${message}";
   		  console.log("message: ", message);
   		  if (message != null && message != "") {
   		  	  alert("${message}");
   	  	  };
   	  	  
   	  	  // 메세지 처리 결과(입력, 수정, 삭제)
   	  	  var msg_result = "${msg_result}"
   	      console.log("msg_result: ", msg_result);
   		  if (msg_result != null && msg_result != "") {
   		  	  switch (msg_result) {
   		  	  case "insert_success":
   		  		  alert("메세지가 저장되었습니다.");
   		  		  break;
   		  	  case "insert_fail":
 		  		  alert("메세지 저장에 실패하였습니다.");
 		  		  break;
   		  	  case "delete_success":
 		  		  alert("메세지가 삭제되었습니다.");
 		  		  break;
 		  	  case "delete_fail":
		  		  alert("메세지 삭제에 실패하였습니다.");
		  		  break;
 		  	  case "edit_success":
 		  		  alert("메세지가 수정되었습니다.");
 		  		  break;
 		  	  case "edit_fail":
		  		  alert("메세지 수정에 실패하였습니다.");
		  		  break;
   		  	  }
   	  	  };
    		
    	  // 상단 메뉴 active
    	  var path = window.location.href;
    	  var slashIndex = path.lastIndexOf("/");
    	  var category = path.substring(slashIndex+1);
    	  if (path.includes("url")) { // url일 때
    		  $("#btnSendMsg").attr("type", "submit"); // 메세지 보내기 버튼 submit으로 바꾸기
    		  var bool_o = path.includes("ourstory");
    		  var bool_p = path.includes("photos");
    		  var bool_q = path.includes("qna");
    		  var bool_t = path.includes("travel");
    		  var bool_m = path.includes("messages");
    		  if (bool_o == false && bool_p == false && 
    				bool_q == false && bool_t == false && 
    				  bool_m == false) {
    			  category = "home";
    		  }
    	  } else { // preview일 때 메세지 보내기 버튼 비활성화
    		  $("#btnSendMsg").attr("type", "button");
    	  };
    	  
    	  if (category.includes("#")) { // 새로고침 눌렀을 때 #...이 붙음
    		  var sharpIndex = category.lastIndexOf("#");
    		  category = category.substring(0, sharpIndex);
    	  } else if (category.includes("?page=")) { // 메세지 페이지 버튼 클릭
    		  var questIndex = category.lastIndexOf("?");
    		  category = category.substring(0, questIndex);
    	  };
    	  console.log("category: ", category);
    	  var nowCtg;
    	  switch (category) {
    	  case "h_home": 
    		  nowCtg = $("#nav").find("#ctgHome");
    		  break;
    	  case "h_ourstory":
    		  nowCtg = $("#nav").find("#ctgOurstory");
    		  break;
    	  case "h_photos":
    		  nowCtg = $("#nav").find("#ctgPhotos");
    		  break;
    	  case "h_qna":
    		  nowCtg = $("#nav").find("#ctgQna");
    		  break;
    	  case "h_travel":
    		  nowCtg = $("#nav").find("#ctgTravel");
    		  break;
    	  case "h_messages":
    		  nowCtg = $("#nav").find("#ctgMessages");
    		  break;
    	  case "home": 
    		  nowCtg = $("#nav").find("#ctgHome");
    		  break;
    	  case "ourstory":
    		  nowCtg = $("#nav").find("#ctgOurstory");
    		  break;
    	  case "photos":
    		  nowCtg = $("#nav").find("#ctgPhotos");
    		  break;
    	  case "qna":
    		  nowCtg = $("#nav").find("#ctgQna");
    		  break;
    	  case "travel":
    		  nowCtg = $("#nav").find("#ctgTravel");
    		  break;
    	  case "messages":
    		  nowCtg = $("#nav").find("#ctgMessages");
    		  break;
    	  }
    	  var activeCtg = $(".ctg.active");
    	  if (activeCtg.length == 1) {
    		  activeCtg.removeClass("active");
    	  }
    	  nowCtg.addClass("active");
    	  
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
	<body>
		<div id="page">
			<nav id="nav" class="fh5co-nav" role="navigation">
				<div class="container">
					<div class="row">
						<div class="col-xs-12 text-right menu-1">
							<ul>
								<li id="ctgHome"><a 
								<c:choose>
									<c:when test="${userVo ne null}">href="/url/${userVo.url}"</c:when>
									<c:otherwise>href="/preview/h_home"</c:otherwise>
								</c:choose>
								>Home</a></li>
								
								<li id="ctgOurstory"><a 
								<c:choose>
									<c:when test="${userVo ne null}">href="/url/${userVo.url}/ourstory"</c:when>
									<c:otherwise>href="/preview/h_ourstory"</c:otherwise>
								</c:choose>
								>Our Story</a></li>
								
								<li id="ctgPhotos"><a 
								<c:choose>
									<c:when test="${userVo ne null}">href="/url/${userVo.url}/photos"</c:when>
									<c:otherwise>href="/preview/h_photos"</c:otherwise>
								</c:choose>
								>Photos</a></li>
								
								<li id="ctgQna"><a 
								<c:choose>
									<c:when test="${userVo ne null}">href="/url/${userVo.url}/qna"</c:when>
									<c:otherwise>href="/preview/h_qna"</c:otherwise>
								</c:choose>
								>Q + A</a></li>
								
								<li id="ctgTravel"><a 
								<c:choose>
									<c:when test="${userVo ne null}">href="/url/${userVo.url}/travel"</c:when>
									<c:otherwise>href="/preview/h_travel"</c:otherwise>
								</c:choose>
								>Travel</a></li>
								
								<li id="ctgMessages"><a 
								<c:choose>
									<c:when test="${userVo ne null}">href="/url/${userVo.url}/messages"</c:when>
									<c:otherwise>href="/preview/h_messages"</c:otherwise>
								</c:choose>
								>Messages</a></li>
							</ul>
						</div>
					</div>
					
				</div>
			</nav>