<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/m_header.jsp"%>
<script src="/main_temp/js/hscript.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1df65d7dc7e43db74dd4d188e6782f91&libraries=services"></script>
<script>
$(document).ready(function() {
	// ip
	var ip = location.host;
	$("#inputUrl").val(ip + "/url/${loginInfo.url}");
	
	// 지도 api
	<c:if test="${!empty tVo.t_wedloc}">
   	$("#map").css("display", "block");
   	$("#timg_div").css("display", "none");
	var container = $("#map")[0]; //지도를 담을 영역
	var options = { // 지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표.
		level: 3 // 지도의 레벨(확대, 축소 정도)
	};
	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	var geocoder = new kakao.maps.services.Geocoder(); // 주소-좌표 변환 객체 생성
	geocoder.addressSearch("${tVo.t_wedloc}", function(result, status) {
		// 정상적으로 검색 완료된 경우
		if (status == kakao.maps.services.Status.OK) {
// 			console.log("검색성공");
			var coords = new kakao.maps.LatLng(result[0].y, result[0].x); // 결과값으로 받은 위치
			var marker = new kakao.maps.Marker({ // 위치를 마커로 표시
				map : map,
				position : coords
			});
			map.setCenter(coords); // 지도의 중심을 받은 위치로 이동
		}
	});
	</c:if>
	
	// 도로명주소 검색 api
	$("#tvl_wedloc").click(function() {
		new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    $("#tvl_wedlocDetail").val(extraAddr);
                }
                // 주소 정보를 해당 필드에 넣는다.
                $("#tvl_wedloc").val(addr);
                
                // Home의 wedLoc에 주소+상세주소 넣기
                var wedLocs = addr +", "+extraAddr;
				$("#wedLoc").text(wedLocs);
                
                // 커서를 상세주소 필드로 이동한다.
                $("#tvl_wedlocDetail").focus();
                
             	// 입력한 주소로 지도 출력
             	$("#map").css("display", "block");
             	$("#timg_div").css("display", "none");
        		var container = $("#map")[0]; //지도를 담을 영역
        		var options = { // 지도를 생성할 때 필요한 기본 옵션
        			center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표.
        			level: 3 // 지도의 레벨(확대, 축소 정도)
        		};
        		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
        		var geocoder = new kakao.maps.services.Geocoder(); // 주소-좌표 변환 객체 생성
        		geocoder.addressSearch($("#tvl_wedloc").val(), function(result, status) {
        			// 정상적으로 검색 완료된 경우
        			if (status == kakao.maps.services.Status.OK) {
        				console.log("검색성공");
        				var coords = new kakao.maps.LatLng(result[0].y, result[0].x); // 결과값으로 받은 위치
        				var marker = new kakao.maps.Marker({ // 위치를 마커로 표시
        					map : map,
        					position : coords
        				});
        				map.setCenter(coords); // 지도의 중심을 받은 위치로 이동
        			}
        		});
            }
        }).open();
	});
	
	// 프로젝트 삭제 버튼
	$("#btnDelete").click(function () {
		var d_answer = confirm("프로젝트를 삭제하시겠습니까?");
		if (d_answer == true) {
			location.href = "/tempH/remove";
		};
	});
	
	// 링크 복사 버튼
	var clipboard = new ClipboardJS("#btnUrlcopy"); // 클립보드에 복사
    $("#btnUrlcopy").click(function () { // 툴팁 show
    	$("#tooltip_div").css("visibility", "visible");
		$("#tooltip_div").animate({opacity: "1"}, 500, function () {
			$(this).animate({opacity: "0"}, 2000, function () {
				$("#tooltip_div").css("visibility", "hidden");
			});
		});
	});
	
	// 미리보기 버튼
	$("#btnPreview").click(function () {
		console.log("미리보기 클릭함");
		var input = $("#i_action");
	    var form = $("#form");
	    var target = "미리보기 페이지";
	    window.open("", target);

	    input.attr("value", "preview");
	    form.attr("target", target); // window.open 타이틀과 매칭 되어야 함
		form.submit();
		input.attr("value", "insert");
	    form.removeAttr("target");
	});
	
	// 리모컨 기능(우측 메뉴별 스크롤이동 버튼)
	$(".btnScrl").click(function () {
		var btnid = $(this).attr("id");
		switch (btnid) {
		case "btnScrlUp":
			location.href = "#";
			break;
		case "btnScrlPreview":
			location.href = "#btnPreview";
			break;
		case "btnScrlTempPhotos":
			location.href = "#scrlTempPhotos";
			break;
		case "btnScrlHome":
			location.href = "#scrlHome";
			break;
		case "btnScrlOurstory":
			location.href = "#scrlOurStory";
			break;
		case "btnScrlPhotos":
			location.href = "#scrlPhotos";
			break;
		case "btnScrlQna":
			location.href = "#scrlQna";
			break;
		case "btnScrlTravel":
			location.href = "#scrlTravel";
			break;
		case "btnScrlSave":
			location.href = "#btnSave";
			break;
		case "btnScrlDown":
			location.href = "#scrlDown";
			break;
		}
		
	});
		
	// 카테고리 접기(펴기)
	$(".fa-angle-double-down").click(function() {
		var fold_state = $(this).attr("data-foldstate");
		var targets = $(this).parents(".prev_div_fold").siblings();
		
		if(fold_state == "false") {
			targets.each(function () {
				$(this).slideUp(500);
			});
			$(this).attr("data-foldstate", "true");
		} else {
			targets.each(function () {
				$(this).slideDown(500);
			});
			$(this).attr("data-foldstate", "false");
		}
	});
	
	// Home의 결혼 장소 input 클릭시 Travel의 input으로 이동
	$("#wedLoc").on("click", function(e) {
		location.href = "#tvl_wedloc";
	})
	
	// Travel의 wedLoc과 wedLocd를 Home의 wedLoc에 출력
	$("#tvl_wedlocDetail").keyup(function() {
		var wedLoc = $("#tvl_wedloc").val()+",\n"+$(this).val();
		console.log("wedLoc: ", wedLoc);
		$("#wedLoc").text(wedLoc);
	});
	
	// 추가(Home - 일정, Q+A) a태그 눌렀을때 실행할 함수
	$(".add").on("click", function(e) {
		e.preventDefault();
		var target = $(this).parent().prev(); // 복사해서 붙일 영역 div
		var copy = $(this).parents(".form-group2").children(".copyTarget").clone(true); // 복사할 내용 - div
		copy.find("a").css("display", "block");
		copy.find(".inputCopy").val("");
		target.append(copy);
	});
	
	// 추가(Photos) a태그 눌렀을때 실행할 함수
	$(".addPhotos").on("click", function(e) {
		e.preventDefault();
		var target = $(this).parents(".targetDiv"); // 복사해서 붙일 영역 div
		var copies = target.children(".copyPhotos").clone(true); // 복사할 내용 - divs
		copies.each(function () {
			$(this).removeClass("copyPhotos");
		});
		copies.find("hr").show();
		copies.find("a[class='pts_remove']").show(); // 삭제 a 태그
		copies.find(".inputCopy").val("");
		copies.find(".input_pdno").val(0);
		copies.find("img").attr("src", "/main_temp/images/dragdrop.png");
		
		copies.find(".newInputFile").show();
		copies.find(".newInputFile").attr("disabled", false);
		copies.find(".prevInputFile").remove();
		copies.find(".custom-file-label").html("파일을 선택하세요.");
		target.append(copies);
		
		var addPhotos = target.find(".addPhotos")
		addPhotos.hide();
		addPhotos.last().show(); // 마지막 부분에만 추가 a태그 붙이기
	});
	
	// 삭제(Home, Q+A) a태그 눌렀을때 실행할 함수
	$(".a_remove").on("click", function(e) {
		e.preventDefault();
		var target = $(this).parent().parent(); // 삭제할 div
		target.remove();
	});
	
	// 삭제(Photos) a태그 눌렀을때 실행할 함수
	$(".pts_remove").on("click", function(e) {
		e.preventDefault();
		var target1 = $(this).parent().parent().parent();
		var target2 = target1.prev();
		var target3 = target2.prev();
		target1.remove();
		target2.remove();
		target3.remove();
		
		var index = ($(".addPhotos").length)-1;
		var addPhotos = $(".addPhotos")[index];
		addPhotos.style.display = "block"; // 마지막 부분(삭제부분 앞쪽)에만 추가 a태그 붙이기
		
	});
		
	// 파일선택 input버튼 클릭
	$(".custom-file-input").change(function(e) {
		var dpimg = $(this).parents().siblings(".dpDiv").find("img").last(); // 이미지 미리보기 영역
		console.log("prevInput 클래스 포함여부: ", $(this).attr("class").endsWith("prevInputFile"));
		console.log("newInput 클래스 포함여부: ", $(this).attr("class").endsWith("newInputFile"));
		
		if ($(this).attr("class").endsWith("prevInputFile")) { // 클래스명이 "prevInputFile"로 끝나는 경우
			dpimg = $(this).parents().siblings(".dpDiv").find("img").first();
		} else if ($(this).attr("class").endsWith("newInputFile")) { // 클래스명이 "newInputFile"로 끝나는 경우
			dpimg = $(this).parent().parent().parent().parent()
				.prev().find("img");
		} else if ($(this).attr("class").endsWith("temp_photos")) {
			dpimg = $(this).parent().parent().prev().prev().find("img");
		}
		console.log("이미지 미리보기 영역: ", dpimg);
		var fileName = $(this).val().split("\\").pop();
		var file = this.files[0];
		
		if (isImage(file)) {
			$(this).siblings(".custom-file-label").addClass("selected").html(fileName);
			displayImg(dpimg, file);
		} else {
			alert("해당 파일은 이미지 파일이 아닙니다. 이미지 파일을 등록해주세요.");
		};
	});
		
	// 이미지 미리보기 영역(클릭)
	$(".fileDrop").click(function() {
		var pickFile = $(this).parents(".d_flex").find(".custom-file-input");
		if (pickFile.length > 2) { // Photos인 경우 복사시 다중 선택됨 -> 해당하는 1개 input 구하기
			pickFile = $(this).parent().parent().parent().next().find(".custom-file-input");
		}
		console.log("new pickFile: ", pickFile);
		pickFile.trigger("click");
	});
	
	// TempPhotos 이미지 미리보기 영역(클릭)
	$(".fileDrop_tp").click(function() {
		var pickFile = $(this).parent().parent().next().next().find(".custom-file-input");
		console.log("new pickFile: ", pickFile);
		pickFile.trigger("click");
	});
	
	// pjnum=1인 경우 이전 데이터 불러오기 - select부분, 반복추가부분
	// 		(home, homeschedule, ourstory, photos, qna)
	if (${loginInfo.pjnum} == 1) {
		console.log("프로젝트가 존재합니다. 데이터를 불러옵니다.");
		// home
		var strweddate = "${hVo.h_weddate}";
		var wedy = strweddate.split(" ")[0];
		wedy = wedy.substr(0, wedy.length-1);
		var wedm = strweddate.split(" ")[1];
		wedm = wedm.substr(0, wedm.length-1);
		var wedd = strweddate.split(" ")[2];
		wedd = wedd.substr(0, wedd.length-1);
		for (var i=0; i<$("#h_year").find("option").length; i++) {
			if($("#h_year").find("option")[i].value == wedy){
				$("#h_year").find("option")[i].selected = true;
			}
		}
		for (var i=0; i<$("#h_month").find("option").length; i++) {
			if($("#h_month").find("option")[i].value == wedm){
				$("#h_month").find("option")[i].selected = true;
			}
		}
		for (var i=0; i<$("#h_date").find("option").length; i++) {
			if($("#h_date").find("option")[i].value == wedd){
				$("#h_date").find("option")[i].selected = true;
			}
		}
		
		// homeschedule
		var list_start_ampm = new Array();
		var list_start_time = new Array();
		var list_end_ampm = new Array();
		var list_end_time = new Array();
		var list_event = new Array();
		<c:forEach items="${list_hsVo}" var="hsVo">
			var start_ampm = "${fn:substringBefore(hsVo.hs_starttime, ' ')}";
			list_start_ampm.push(start_ampm);
			var start_time = "${fn:substringAfter(hsVo.hs_starttime, ' ')}";
			list_start_time.push(start_time);
			var end_ampm = "${fn:substringBefore(hsVo.hs_endtime, ' ')}";
			list_end_ampm.push(end_ampm);
			var end_time = "${fn:substringAfter(hsVo.hs_endtime, ' ')}";
			list_end_time.push(end_time);
			list_event.push("${hsVo.hs_event}");
		</c:forEach>
		
		var cnt_hsVo = ${fn:length(list_hsVo)};
		var add_schedule = $("#div_addSchedule").find("a");
		
		var start_ampm = $(".slct_sampm").last();
		var start_time = $(".slct_stime").last();
		var end_ampm = $(".slct_eampm").last();
		var end_time = $(".slct_etime").last();
		var event = $(".input_event").last();
		
		for (var i=0; i<start_ampm.find("option").length; i++) {
			if(start_ampm.find("option")[i].value == list_start_ampm[0]){
				start_ampm.find("option")[i].selected = true;
			}
			if(end_ampm.find("option")[i].value == list_end_ampm[0]){
				end_ampm.find("option")[i].selected = true;
			}
		}
		
		for (var i=0; i<start_time.find("option").length; i++) {
			if(start_time.find("option")[i].value == list_start_time[0]){
				start_time.find("option")[i].selected = true;
			}
			if(end_time.find("option")[i].value == list_end_time[0]){
				end_time.find("option")[i].selected = true;
			}
		}
		event.val(list_event[0]);
		
		for (var i=1; i<(cnt_hsVo); i++) {
			add_schedule.trigger("click");
			
			var start_ampm = $(".slct_sampm").last();
			var start_time = $(".slct_stime").last();
			var end_ampm = $(".slct_eampm").last();
			var end_time = $(".slct_etime").last();
			
			for (var v=0; v<2; v++) {
				if(start_ampm.find("option")[v].value == list_start_ampm[i]){
					start_ampm.find("option")[v].selected = true;
				}
				if(end_ampm.find("option")[v].value == list_end_ampm[i]){
					end_ampm.find("option")[v].selected = true;
				}
			}
			for (var w=0; w<start_time.find("option").length; w++) {
				if(start_time.find("option")[w].value == list_start_time[i]){
					start_time.find("option")[w].selected = true;
				}
				if(end_time.find("option")[w].value == list_end_time[i]){
					end_time.find("option")[w].selected = true;
				}
			}
			event = $(".input_event").last();
			event.val(list_event[i]);
		}
		
		// photos
		var list_pdpic = new Array();
		var list_pdy = new Array();
		var list_pdm = new Array();
		var list_pdd = new Array();
		var list_pdtitle = new Array();
		var list_pdtext = new Array();
		var list_pdno = new Array();
		<c:forEach items="${list_pdVo}" var="pdVo">
			var pdpic = "${pdVo.pd_pic}";
			list_pdpic.push(pdpic);
			var strpdate = "${pdVo.pd_pdate}";
		 	var pdy = strpdate.split(" ")[0];
		 	pdy = pdy.substr(0, pdy.length-1);
		 	list_pdy.push(pdy);
		 	
		 	var pdm = strpdate.split(" ")[1];
		 	pdm = pdm.substr(0, pdm.length-1);
		 	list_pdm.push(pdm);
		 	
		 	var pdd = strpdate.split(" ")[2];
		 	pdd = pdd.substr(0, pdd.length-1);
		 	list_pdd.push(pdd);
		 	
		 	var pdtext_br = "${pdVo.pd_text}";
		 	// 정규식(/<br>/g) -> 모든 <br>을 치환(replaceAll 효과)
		 	var pdtext = pdtext_br.replace(/<br>/g, "\r\n");
		 	pdtext = pdtext.replace(/<ttaompyo>/g, "\"");
		 	list_pdtext.push(pdtext);
		 	
		 	var pdtitle = "${pdVo.pd_title}";
		 	pdtitle = pdtitle.replace(/<ttaompyo>/g, "\"");
		 	list_pdtitle.push(pdtitle);
		 	
		 	var pdno = "${pdVo.pd_no}";
		 	list_pdno.push(pdno);
		</c:forEach>
		
		var cnt_pdVo = ${fn:length(list_pdVo)};
		var add_photos = $(".addPhotos").last();
		var img_pdpic = $(".img_pdpic").last();
		// 0번째 세팅 -> 이후 1번째부터는 trigger("click")
		if (list_pdpic[0] != null && list_pdpic[0] != "") {
			img_pdpic.attr("src", "/tempH/displayImage?pic="+list_pdpic[0]);		
		} else { console.log("이미지가 null임!"); }
		for (var i=0; i<$(".p_year").last().find("option").length; i++) {
			if($(".p_year").last().find("option")[i].value == list_pdy[0]){
				$(".p_year").last().find("option")[i].selected = true;
			}
		}
		for (var i=0; i<$(".p_month").last().find("option").length; i++) {
			if($(".p_month").last().find("option")[i].value == list_pdm[0]){
				$(".p_month").last().find("option")[i].selected = true;
			}
		}
		for (var i=0; i<$(".p_date").last().find("option").length; i++) {
			if($(".p_date").last().find("option")[i].value == list_pdd[0]){
				$(".p_date").last().find("option")[i].selected = true;
			}
		}
		var ptext = $(".input_ptext").last();
		ptext.val(list_pdtext[0]);
		var ptitle = $(".input_ptitle").last();
		ptitle.val(list_pdtitle[0]);
		var ipdno = $(".input_pdno").last();
		ipdno.val(list_pdno[0]);
		
		// 1번째 ~ n번쨰 세팅 -> trigger("click")
		for (var i=1; i<(cnt_pdVo); i++) {
			add_photos.trigger("click");
			img_pdpic = $(".img_pdpic").last();
			if (list_pdpic[i] != null && list_pdpic[i] != "") {
				img_pdpic.attr("src", "/tempH/displayImage?pic="+list_pdpic[i]);
			} else { console.log("이미지가 null임!"); }
			for (var v=0; v<$(".p_year").last().find("option").length; v++) {
				if($(".p_year").last().find("option")[v].value == list_pdy[i]){
					$(".p_year").last().find("option")[v].selected = true;
				}
			}
			for (var w=0; w<$(".p_month").last().find("option").length; w++) {
				if($(".p_month").last().find("option")[w].value == list_pdm[i]){
					$(".p_month").last().find("option")[w].selected = true;
				}
			}
			for (var z=0; z<$(".p_date").last().find("option").length; z++) {
				if($(".p_date").last().find("option")[z].value == list_pdd[i]){
					$(".p_date").last().find("option")[z].selected = true;
				}
			}
			ptext = $(".input_ptext").last();
			ptext.val(list_pdtext[i]);
			ptitle = $(".input_ptitle").last();
			ptitle.val(list_pdtitle[i]);
			ipdno = $(".input_pdno").last();
			ipdno.val(list_pdno[i]);
		}
		
		// qna
		var list_q = new Array();
		var list_a = new Array();
		<c:forEach items="${list_qdVo}" var="qdVo">
			list_q.push("${qdVo.qd_q}");
			list_a.push("${qdVo.qd_a}");
		</c:forEach>
		
		var cnt_qdVo = ${fn:length(list_qdVo)};
		var add_qna = $("#div_addqna").find("a");
		
		var q = $(".input_q").last();
		q.val(list_q[0]);
		var a = $(".input_a").last();
		a.text(list_a[0]);
		for (var i=1; i<(cnt_qdVo); i++) {
			add_qna.trigger("click");
			q = $(".input_q").last();
			a = $(".input_a").last();
			q.val(list_q[i]);
			a.val(list_a[i]);
		}
		
		// travel
		var tvltext_br = $("#tvl_content").val();
	 	// 정규식(/<br>/g) -> 모든 <br>을 치환(replaceAll 효과)
	 	var tvltext = tvltext_br.replace(/<br>/g, "\r\n");
	 	$("#tvl_content").val(tvltext);
	 	
	} // if
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
                     <h2>나의 프로젝트</h2>
                  </div>
               </div>
            </div>
         </div>
      </div>
      
      <!-- blog -->
      <div class="blog" style="padding:0px">
      	 <!-- 링크복사 툴팁 -->
      	 <div id="tooltip_div" class="text-center" style="height: 90px; padding-top: 75px; opacity:0; visibility:hidden;">
      	 	<span id="tooltiptext" style="margin-left:500px;">링크가 복사되었습니다.</span><br>
      	 	<div style="padding-top:0.5px; margin-left: 500px;">
      	 		<span id="tooltiptext2" style="border-width:7px;"></span>
      	 	</div>
      	 </div>
      	 
      	 <!-- 리모컨 기능 -->
      	 <div class="col-sm-12 text-lg-start text-right">
         	<div id="moveScroll" class="btn-group-vertical">
			    <button type="button" class="btn btn-beigeline text-dark btnScrl" style="border: 1px solid #BBAEA0;"
			    	id="btnScrlUp"><i class="fa fa-angle-double-up" aria-hidden="true"></i></button>
			    <button type="button" class="btn btn-beigeline text-dark btnScrl" style="border: 1px solid #BBAEA0;"
			    	id="btnScrlPreview">미리보기</button>
			    <button type="button" class="btn btn-beigeline text-dark btnScrl" style="border: 1px solid #BBAEA0;"
			    	id="btnScrlTempPhotos">TempPhotos</button>
			    <button type="button" class="btn btn-beigeline text-dark btnScrl" style="border: 1px solid #BBAEA0;"
			    	id="btnScrlHome">Home</button>
			    <button type="button" class="btn btn-beigeline text-dark btnScrl" style="border: 1px solid #BBAEA0;"
			    	id="btnScrlOurstory">Our Story</button>
			    <button type="button" class="btn btn-beigeline text-dark btnScrl" style="border: 1px solid #BBAEA0;"
			    	id="btnScrlPhotos">Photos</button>
			    <button type="button" class="btn btn-beigeline text-dark btnScrl" style="border: 1px solid #BBAEA0;"
			    	id="btnScrlQna">Q + A</button>
			    <button type="button" class="btn btn-beigeline text-dark btnScrl" style="border: 1px solid #BBAEA0;"
			    	id="btnScrlTravel">Travel</button>
			    <button type="button" class="btn btn-beigeline text-dark btnScrl" style="border: 1px solid #BBAEA0;"
			    	id="btnScrlSave">저장하기</button>
			    <button type="button" class="btn btn-beigeline text-dark btnScrl" style="border: 1px solid #BBAEA0;"
			    	id="btnScrlDown"><i class="fa fa-angle-double-down" aria-hidden="true"></i></button>
  		 	</div>
         </div>
         <div class="container" style="margin-bottom:150px;">
         	<!-- 미리보기 버튼 -->
	        <div class="row" style="padding:15px">
		        <div class="col-sm-12 text-lg-start text-center" style="padding:0px">
		        	<input id="inputUrl" type="text" class="inputs" style="margin-left:80px; display:inline; width:500px;" readonly>
	    			<button id="btnUrlcopy" type="button" class="btn btn-brown"
	    				data-clipboard-target="#inputUrl"
	    				>링크 복사</button>
	    			<button id="btnPreview" type="button" class="btn btn-beige" style="float:right;"
	    				>미리보기</button>
	  			</div>
	        </div>
	        
	        <form id="form" action="/tempH/insert_run" method="post" enctype="multipart/form-data">
	        <input id="i_action" type="hidden" name="action" value="insert">
	        <!-- HTempPhotos 영역 -->
            <div class="row">
               <div class="col-sm-12">
                  <div class="blog_bg margin_bottom30">
                     <div class="row d_flex">
                     
                     	<div id="scrlTempPhotos" class="col-md-12 prev_div_fold">
                     		<div class="marriage_text" style="margin-left:20px; padding-bottom:0px;">
                           		<h3 style="padding-bottom:0px">
                           			<a href="javascript:;" style="color:black">
                           				<i class="fa fa-angle-double-down" data-foldstate="false" aria-hidden="true"
                           					style="margin-right:20px"></i></a>
                           			<strong>TempPhotos</strong>
                           		</h3>
                           		<hr>
                           	</div>
                     	</div>
                     	
                     	<!-- 폴딩 기준 -->
                        <div class="col-md-6 div_fold dpDiv" style="padding:40px">
                           <div class="blog_img" style="cursor:pointer;">
                              <div class="text-center dpimg_div">
                              	<img class="dpimg fileDrop_tp" alt="#"
	                              	<c:choose>
									    <c:when test="${empty tpVo.tp_htitlepic}">
											src="/main_temp/images/dragdrop.png"
									    </c:when>
									    <c:otherwise>
											src="/tempH/displayImage?pic=${tpVo.tp_htitlepic}"
									    </c:otherwise>
									</c:choose>
                              	/>
                              </div>
                           </div>
                           <div style="margin-top:20px;">
	                           <h2 class="insert_h2">Home의 타이틀사진 미리보기입니다.</h2>
	                           <p>파일을 업로드하시려면 위 영역을 클릭하세요.</p><br>
                           </div>
                           <div class="form-group2">
							  <label for="home">Home의 타이틀사진을 올려주세요.</label>
							  <div class="custom-file" id="home">
								  <input type="file" name="files_tempphotos" class="custom-file-input temp_photos">
								  <label class="custom-file-label" for="customFile">파일을 선택하세요.</label>
							  </div>
						   </div>
                        </div>
                        
                        <div class="col-md-6 div_fold dpDiv"  style="padding:40px">
                           <div class="blog_img" style="cursor:pointer;">
                              <div class="text-center dpimg_div">
                              	<img class="dpimg fileDrop_tp" alt="#"
	                              <c:choose>
									    <c:when test="${empty tpVo.tp_hspic}">
											src="/main_temp/images/dragdrop.png"
									    </c:when>
									    <c:otherwise>
											src="/tempH/displayImage?pic=${tpVo.tp_hspic}"
									    </c:otherwise>
									</c:choose>
                              	/>
                              </div>
                           </div>
                           <div style="margin-top:20px;">
	                           <h2 class="insert_h2">Home의 결혼식 일정 배경 사진 미리보기입니다.</h2>
	                           <p>파일을 업로드하시려면 위 영역을 클릭하세요.</p><br>
                           </div>
                           <div class="form-group2">
							  <label for="home">Home의 결혼식 일정 배경 사진을 올려주세요.</label>
							  <div class="custom-file" id="home">
								  <input type="file" name="files_tempphotos" class="custom-file-input temp_photos">
								  <label class="custom-file-label" for="customFile">파일을 선택하세요.</label>
							  </div>
						   </div>
                        </div>
                        
                        <div class="col-md-6 div_fold dpDiv"  style="padding:40px">
                           <div class="blog_img" style="cursor:pointer;">
                              <div class="text-center dpimg_div">
                              	<img class="dpimg fileDrop_tp" alt="#" 
                              		<c:choose>
									    <c:when test="${empty tpVo.tp_mpic}">
											src="/main_temp/images/dragdrop.png"
									    </c:when>
									    <c:otherwise>
											src="/tempH/displayImage?pic=${tpVo.tp_mpic}"
									    </c:otherwise>
									</c:choose>
                              	/>
                              </div>
                           </div>
                           <div style="margin-top:20px;">
	                           <h2 class="insert_h2">메세지 배경 사진 미리보기입니다.</h2>
	                           <p>파일을 업로드하시려면 위 영역을 클릭하세요.</p><br>
                           </div>
                           <div class="form-group2">
							  <label for="home">메세지 배경 사진을 올려주세요.</label>
							  <div class="custom-file" id="home">
								  <input type="file" name="files_tempphotos" class="custom-file-input temp_photos">
								  <label class="custom-file-label" for="customFile">파일을 선택하세요.</label>
							  </div>
						   </div>
                        </div>
                        
                        <div class="col-md-6 div_fold dpDiv"  style="padding:40px">
                           <div class="blog_img" style="cursor:pointer;">
                              <div class="text-center dpimg_div">
                              	<img class="dpimg fileDrop_tp" alt="#" 
                              		<c:choose>
									    <c:when test="${empty tpVo.tp_titlepic}">
											src="/main_temp/images/dragdrop.png"
									    </c:when>
									    <c:otherwise>
											src="/tempH/displayImage?pic=${tpVo.tp_titlepic}"
									    </c:otherwise>
									</c:choose>
								/>
                              </div>
                           </div>
                           <div style="margin-top:20px;">
	                           <h2 class="insert_h2">타이틀사진 미리보기입니다.</h2>
	                           <p>파일을 업로드하시려면 위 영역을 클릭하세요.</p><br>
                           </div>
                           <div class="form-group2">
							  <label for="home">타이틀 사진을 올려주세요.</label>
							  <div class="custom-file" id="home">
								  <input type="file" name="files_tempphotos" class="custom-file-input temp_photos">
								  <label class="custom-file-label" for="customFile">파일을 선택하세요.</label>
							  </div>
						   </div>
                        </div>
                     <!-- 폴딩 기준 끝-->
                     
                  </div>
               </div>
            </div>
         </div>
         <!-- HTempPhotos 영역 끝 -->
	        
	        <!-- Home 영역 -->
            <div class="row">
               <div class="col-sm-12">
                  <div class="blog_bg margin_bottom30">
                     <div class="row d_flex">
                     
                     	<div id="scrlHome" class="col-md-12 prev_div_fold">
                     		<div class="marriage_text" style="margin-left:20px; padding-bottom:0px;">
                           		<h3 style="padding-bottom:0px">
                           			<a href="javascript:;" style="color:black">
                           				<i class="fa fa-angle-double-down" data-foldstate="false" aria-hidden="true"
                           					style="margin-right:20px"></i></a>
                           			<strong>Home</strong>
                           		</h3>
                           		<hr>
                           	</div>
                     	</div>
                     	
                     	<!-- 폴딩 기준 -->
                        <div class="col-md-6 div_fold dpDiv">
                           <div class="blog_img" style="cursor:pointer;">
                              <div class="text-center dpimg_div2">
                              	<img class="dpimg2 fileDrop" alt="#"
                              		<c:choose>
									    <c:when test="${empty hVo.h_pic}">
											src="/main_temp/images/dragdrop.png"
									    </c:when>
									    <c:otherwise>
											src="/tempH/displayImage?pic=${hVo.h_pic}"
									    </c:otherwise>
									</c:choose>
                              	/>
                              </div>
                           </div>
                           <div style="padding:20px">
	                           <h2 class="insert_h2">Home의 메인사진 미리보기입니다.</h2>
	                           <p>파일을 업로드하시려면 위 영역을 클릭하세요.</p><br>
                           </div>
                        </div>
                        
                        <div class="col-md-6 div_fold photoDiv">
                           <div class="marriage_text">
                           		<div class="form-group2">
								  <label for="home">Home의 메인사진을 올려주세요.</label>
								  <div class="custom-file" id="home">
								    <input type="file" name="file_home" class="custom-file-input">
								    <label class="custom-file-label" for="customFile">파일을 선택하세요.</label>
								  </div>
								</div>
								
                           		<div class="form-group2">
								  <label for="wedDate">결혼 날짜를 입력해주세요.</label>
								  <div id="weddate">
									  <div style="margin-right:5px; display:inline;">
										  <select id="h_year" class="inputs-s" name="h_year"
										  		style="width:25%; margin-right:5px;">
										  	<c:forEach var="year" begin="2023" end="2033">
										      <option>${year}</option>
										    </c:forEach>
										  </select>년
										  
										  <select id="h_month" class="inputs-s" name="h_month"
										  		style="width:25%; margin-right:5px; margin-left:20px;">
										  	<c:forEach var="month" begin="1" end="12">
										      <option>${month}</option>
										    </c:forEach>
										  </select>월
										  
										  <select id="h_date" class="inputs-s" name="h_date"
										  		style="width:25%; margin-right:5px; margin-left:20px;">
										  	<c:forEach var="date" begin="1" end="31">
										      <option>${date}</option>
										    </c:forEach>
										  </select>일
									   </div>
								   </div>
								</div>
								
								<div class="form-group2">
								  <label for="wedLoc">결혼 장소를 입력해주세요.</label>
								  <textarea name="h_wedloc" class="inputs" id="wedLoc" maxlength="62" rows="2" style="resize:none" readonly
								  	><c:if test="${!empty hVo.h_wedloc}">${hVo.h_wedloc}</c:if></textarea>
								</div>
								<div class="form-group2">
								  <label for="inputDiv">신랑 신부의 이름을 입력해주세요.</label>
								  <div id="inputDiv">
									  <input type="text" name="h_gname" maxlength="6" class="inputs-m" id="grName" placeholder="신랑"
									  	<c:if test="${!empty hVo.h_gname}">
											value="${hVo.h_gname}"
										</c:if>
									  >
									  <input type="text" name="h_bname" maxlength="6" class="inputs-m" id="brName" placeholder="신부"
									  	<c:if test="${!empty hVo.h_bname}">
											value="${hVo.h_bname}"
										</c:if>
									  >
								  </div>
								</div>
								
								<div class="form-group2">
								  <label for="wedevent">시간과 일정 내용을 입력해주세요.</label>
								  <div id="wedevent" class="copyTarget">
								  		<div class="text-right">
									  		<a class="a_remove" href="#" style="color:#A7B0B8; display:none;">
												<i class="fa fa-trash-o" aria-hidden="true">
													<small style="text-align:right; font-size:12px;">
													일정 삭제</small></i>
											</a>
										</div>
								  		<div style="margin-right:5px; display: inline;">
										  <select class="inputs-s slct_sampm" name="start_ampm">
										      <option>오전</option>
										      <option>오후</option>
										  </select>
										  <select class="inputs-s slct_stime" name="start_time"
										  		style="width:25%; margin-right:5px;">
										  	<c:forEach var="h" begin="1" end="12">
										      <option>${h}시</option>
										      <option>${h}시 15분</option>
										      <option>${h}시 30분</option>
										      <option>${h}시 45분</option>
										    </c:forEach>
										  </select>부터
									  </div>
									  
									  <select class="inputs-s slct_eampm" name="end_ampm" style="margin-left:20px;">
									      <option>오전</option>
									      <option>오후</option>
									  </select>
									  <select class="inputs-s slct_etime" name="end_time" 
									  		style="width:25%; margin-right:5px;">
									  	<c:forEach var="h" begin="1" end="12">
									      <option>${h}시</option>
									      <option>${h}시 15분</option>
									      <option>${h}시 30분</option>
									      <option>${h}시 45분</option>
									    </c:forEach>
									  </select>까지
									  <input type="text" name="wedevent" maxlength="31" class="inputs inputCopy input_event" style="margin:5px 0px 25px"
										  	placeholder="일정 내용을 입력하세요.">
								  </div> <!-- div id="wedevent" -->
								  
								  <!-- 일정 추가 양식 복제할 공간 -->
								  <div></div>
								  
								  <div id="div_addSchedule">
									<a class="add" href="#" style="color:#E76F64">
										<i class="fa fa-plus" aria-hidden="true">
											<small class="smtext" class="smtext" style="padding-left:5px; font-size:12px;">
											일정을 추가하려면 클릭하세요.</small></i>
									</a>
								  </div>
                           </div>
                           
                        </div>
                     </div>
                     <!-- 폴딩 기준 끝-->
                     
                  </div>
               </div>
            </div>
         </div>
         <!-- Home 영역 끝 -->
         
         <!-- Our Story 영역 -->
            <div class="row">
               <div class="col-sm-12">
                  <div class="blog_bg margin_bottom30">
                     <div class="row d_flex">
                     
                     	<div id="scrlOurStory" class="col-md-12 prev_div_fold">
                     		<div class="marriage_text" style="margin-left:20px; padding-bottom:0px;">
                           		<h3 style="padding-bottom:0px">
                           			<a href="javascript:;" style="color:black">
                           				<i class="fa fa-angle-double-down" data-foldstate="false" aria-hidden="true"
                           					style="margin-right:20px"></i></a>
                           			<strong>Our Story</strong>
                           		</h3>
                           		<hr>
                           	</div>
                     	</div>
                     	
                     	<!-- 폴딩 기준 -->
                        <div class="col-md-6 div_fold dpDiv">
                           <div class="blog_img" style="cursor:pointer;">
                              <div class="text-center dpimg_div2">
                              	<img class="dpimg2 fileDrop" alt="#" 
                              		<c:choose>
									    <c:when test="${empty oVo.o_pic}">
											src="/main_temp/images/dragdrop.png"
									    </c:when>
									    <c:otherwise>
											src="/tempH/displayImage?pic=${oVo.o_pic}"	
									    </c:otherwise>
									</c:choose>
                              	/>
                              </div>
                           </div>
                           
                           <div style="padding:20px">
	                           <h2 class="insert_h2">Our Story의 메인사진 미리보기입니다.</h2>
	                           <p>파일을 업로드하시려면 위 영역을 클릭하세요.</p><br>
                           </div>
                        </div>
                        
                        <div class="col-md-6 div_fold photoDiv">
                           <div class="marriage_text">
                           		<div class="form-group2">
								  <label for="ourstory">Our Story의 메인사진을 올려주세요.</label>
									  <div class="custom-file" id="ourstory">
									    <input type="file" name="file_ourstory" class="custom-file-input">
									    <label class="custom-file-label" for="customFile">파일을 선택하세요.</label>
									  </div>
								</div>
								
								<div class="form-group2">
								  <label for="o_title">글 제목을 입력해주세요.</label>
								  <input type="text" id="o_title" name="o_title" maxlength="31" class="inputs"
								  	<c:if test="${!empty oVo.o_title}">
											value="${oVo.o_title}"
									</c:if>
								  >
								</div>
								
								<div class="form-group2">
								  <label for="o_content">글 내용을 입력해주세요.</label>
								  <textarea class="inputs" id="o_content" name="o_content" rows="20" style="resize:none"
								  ><c:if test="${!empty oVo.o_content}">${oVo.o_content}</c:if></textarea>
								</div>
								
                           </div>
                        </div>
                     <!-- 폴딩 기준 끝-->
                     </div>
                  </div>
               </div>
            </div>
         <!-- Our Story 영역 끝 -->
         
         <!-- Photos 영역 -->
            <div class="row">
               <div class="col-sm-12">
                  <div class="blog_bg margin_bottom30">
                     <div class="row d_flex targetDiv">
                     
                     	<div id="scrlPhotos" class="col-md-12 prev_div_fold">
                     		<div class="marriage_text" style="margin-left:20px; padding-bottom:0px;">
                           		<h3 style="padding-bottom:0px">
                           			<a href="javascript:;" style="color:black">
                           				<i class="fa fa-angle-double-down" data-foldstate="false" aria-hidden="true"
                           					style="margin-right:20px"></i></a>
                           			<strong>Photos</strong>
                           		</h3>
                           		<hr>
                           	</div>
                     	</div>
                     	
                     	<!-- 폴딩 기준 -->
                     	<!-- 복사 기준 -->
                     	<div class="col-md-12 div_fold copyPhotos">
                     		<div class="text-right">
	                           	<hr style="margin:0px 0px 16px; display:none;">
                           	</div>
	                    </div>
                        <div class="col-md-6 div_fold copyPhotos dpDiv">
                           <div class="blog_img" style="cursor:pointer;">
                              <div class="text-center dpimg_div2">
                              	<img class="dpimg2 fileDrop img_pdpic" alt="#"
                              		src="/main_temp/images/dragdrop.png"/>
                              </div>
                           </div>
                           
                           <div style="padding:20px 20px 0px">
	                           <h2 class="insert_h2">Photos의 사진 미리보기입니다.</h2>
	                           <p>파일을 업로드하시려면 위 영역을 클릭하세요.</p><br>
                           </div>
                        </div>
                        
                        <div class="col-md-6 div_fold copyPhotos photoDiv">
                       		 <div class="marriage_text">
                       		 	<div class="text-right">
                       		 		<a class="pts_remove" href="#" style="display:none; color:#A7B0B8; font-size:14px">
									<i class="fa fa-trash-o" aria-hidden="true">
										<small style="text-align:right; font-size:14px;">
										삭제</small></i>
								  	</a>
                       		 	</div>
		                      	<div class="form-group2">
								  <label for="photos">Photos의 사진을 올려주세요.</label>
								  <div class="custom-file" id="photos">
								  	<input type="file" name="files_photos" class="custom-file-input newInputFile" style="display:none;" disabled>
								    <input type="file" name="files_photos" class="custom-file-input prevInputFile">
								    <label class="custom-file-label" for="customFile">파일을 선택하세요.</label>
								  </div>
								</div>
								
								<div class="form-group2">
									  <label for="pts_date">사진 날짜를 입력해주세요.</label>
									  <div id="pts_date">
										  <div style="margin-right:5px; display:inline;">
											  <select class="inputs-s p_year" name="pyear"
											  		style="width:25%; margin-right:5px;">
											  	<c:forEach var="year" begin="1970" end="2023">
											      <option>${year}</option>
											    </c:forEach>
											  </select>년
											  
											  <select class="inputs-s p_month" name="pmonth"
											  		style="width:23%; margin-right:5px; margin-left:20px;">
											  	<c:forEach var="month" begin="1" end="12">
											      <option>${month}</option>
											    </c:forEach>
											  </select>월
											  
											  <select class="inputs-s p_date" name="pdate"
											  		style="width:23%; margin-right:5px; margin-left:20px;">
											  	<c:forEach var="date" begin="1" end="31">
											      <option>${date}</option>
											    </c:forEach>
											  </select>일
										   </div>
									   </div>
									</div>
								
								<div class="form-group2">
								  <label for="ptitle">사진 제목을 입력해주세요.</label>
								  <input type="text" id="ptitle" name="ptitle" maxlength="31" class="inputs inputCopy input_ptitle">
								  <input type="number" name="pdno" value="0" class="input_pdno" style="display:none">
								</div>
								
								<div class="form-group2">
								  <label for="ptext">사진 설명을 입력해주세요.</label>
								  <textarea id="ptext" name="ptext" class="inputs inputCopy input_ptext" maxlength="93" rows="3" style="resize:none"></textarea>
								</div>
								<a class="addPhotos" href="#" style="color:#E76F64">
									<i class="fa fa-plus" aria-hidden="true">
										<small class="smtext" style="padding-left:5px; font-size:12px;">
										사진을 추가하려면 클릭하세요.</small></i>
								</a>
							</div>
                        </div>
	                    <!-- 복사 내용 끝 -->
	                    
                     <!-- 폴딩 기준 끝-->
                     </div> <!-- div "row d_flex" -->
                     
                  </div>
               </div>
            </div>
         <!-- Photos 영역 끝 -->
         
         <!-- Q+A 영역 -->
            <div class="row">
               <div class="col-sm-12">
                  <div class="blog_bg margin_bottom30">
                     <div class="row d_flex">
                     
                     	<div id="scrlQna" class="col-md-12 prev_div_fold">
                     		<div class="marriage_text" style="margin-left:20px; padding-bottom:0px;">
                           		<h3 style="padding-bottom:0px">
                           			<a href="javascript:;" style="color:black">
                           				<i class="fa fa-angle-double-down" data-foldstate="false" aria-hidden="true"
                           					style="margin-right:20px"></i></a>
                           			<strong>Q + A</strong>
                           		</h3>
                           		<hr>
                           	</div>
                     	</div>
                     	
                     	<!-- 폴딩 기준 -->
                        <div class="col-md-12 div_fold">
                           <div class="marriage_text" style="padding:25px 150px 25px">
								<div class="form-group2">
								  <label for="wedqna">질문과 답변을 입력해주세요.</label>
									  <div id="wedqna" class="copyTarget">
									  		<div class="text-right">
										  		<a class="a_remove" href="#" style="color:#A7B0B8; display:none;">
													<i class="fa fa-trash-o" aria-hidden="true">
														<small style="text-align:right; font-size:12px;">
														Q + A 삭제</small></i>
												</a>
											</div>
										  	<input type="text" name="q" maxlength="50" class="inputs inputCopy input_q" style="margin:5px 0px"
											  	placeholder="질문 내용을 입력하세요.">
											<textarea class="inputs inputCopy input_a" name="a" maxlength="150" rows="3"
												placeholder="답변 내용을 입력하세요." style="resize:none; margin:5px 0px 25px;"></textarea>
									  </div> <!-- div id="wedqna" -->
								  
								  <!-- 질문 답변 추가 양식 복제할 공간 -->
								  <div></div>
								  
								  <div id="div_addqna">
									<a class="add" href="#" style="color:#E76F64">
										<i class="fa fa-plus" aria-hidden="true">
											<small class="smtext" style="padding-left:5px; font-size:12px;">
											질문과 답변을 추가하려면 클릭하세요.</small></i>
									</a>
								  </div>
                           </div>
                        </div>
                     </div>
                     <!-- 폴딩 기준 끝-->
                     
                  </div>
               </div>
            </div>
         </div>
         <!-- Q+A 영역 끝 -->
         
         <!-- Travel 영역 -->
            <div class="row">
               <div class="col-sm-12">
                  <div class="blog_bg margin_bottom30">
                     <div class="row d_flex">
                     
                     	<div id="scrlTravel" class="col-md-12 prev_div_fold">
                     		<div class="marriage_text" style="margin-left:20px; padding-bottom:0px;">
                           		<h3 style="padding-bottom:0px">
                           			<a href="javascript:;" style="color:black">
                           				<i class="fa fa-angle-double-down" data-foldstate="false" aria-hidden="true"
                           					style="margin-right:20px"></i></a>
                           			<strong>Travel</strong>
                           		</h3>
                           		<hr>
                           	</div>
                     	</div>
                     	
                     	<!-- 폴딩 기준 -->
                        <div class="col-md-6 div_fold dpDiv">
                           <div id="map" style="height:325px; display:none;"></div>
                           <div id="timg_div" class="blog_img">
                              <div class="text-center dpimg_div2">
                              	<img alt="#" src="/main_temp/images/mapimg.png"/>
                              </div>
                           </div>
                           <div style="padding:20px">
	                           <h2 class="insert_h2">Travel의 지도 미리보기입니다.</h2>
                           </div>
                        </div>
                        
                        <div class="col-md-6 div_fold photoDiv">
                           <div class="marriage_text">
                           		<div class="form-group2">
								  <label for="tvl_wedloc">결혼 장소를 입력해주세요.</label>
								  <textarea class="inputs" id="tvl_wedloc" name="t_wedloc" maxlength="62" rows="1" style="resize:none" placeholder="주소" readonly
								  ><c:if test="${!empty tVo.t_wedloc}">${tVo.t_wedloc}</c:if></textarea>
								  <textarea class="inputs" id="tvl_wedlocDetail" name="t_wedlocd" maxlength="62" rows="1" placeholder="상세주소" style="resize:none; margin-top:5px;"
								  ><c:if test="${!empty tVo.t_wedlocd}">${tVo.t_wedlocd}</c:if></textarea>
								</div>
								
								<div class="form-group2">
								  <label for="tvl_content">Travel의 내용을 입력해주세요.</label>
								  <textarea class="inputs" id="tvl_content" name="t_text" maxlength="155" rows="5" style="resize:none" 
								  	placeholder="오시는 길에 대한 세부 내용을 입력해주세요. (예: 교통, 주차, 식권 등)"
								  	><c:if test="${!empty tVo.t_text}">${tVo.t_text}</c:if></textarea>
								</div>
								
                           </div>
                        </div>
                     <!-- 폴딩 기준 끝-->
                     </div>
                  </div>
               </div>
            </div>
         <!-- Travel 영역 끝 -->
         
         <div class="row">
	        <div class="col-sm-12 text-lg-start text-center" style="padding:0px">
    			<c:if test="${0 ne loginInfo.pjnum}">
    			<button id ="btnDelete" type="button" class="btn btn-red btn-lg">
    				프로젝트 삭제</button>
    			</c:if>
    			<button id ="btnSave" type="submit" class="btn btn-brown btn-lg" style="color:white">
    				저장하기</button>
  			</div>
	     </div>
         </form>
      </div>
     </div>
     <!-- end blog -->
<script src="https://cdn.jsdelivr.net/npm/clipboard@2.0.6/dist/clipboard.min.js"></script>      
<%@ include file="../include/m_footer.jsp"%>