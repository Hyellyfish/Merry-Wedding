<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/m_header.jsp" %>
<%@ include file="../include/vendor_list_css.jsp" %>
<style>
body {
	background: #f5f5f5;
}
table {
	border: 1px #a39485 solid;
	font-size: .9em;
	box-shadow: 0 2px 5px rgba(0, 0, 0, .25);
	width: 100%;
	border-collapse: collapse;
	border-radius: 5px;
	overflow: hidden;
}
th {
	text-align: left;
}
thead {
	font-weight: normal;
	font-size: 17px;
	color: #fff;
	background: #413731;
}
td, th {
	padding: 1em .5em;
	vertical-align: middle;
	font-weight: normal;
}
td {
	border-bottom: 1px solid rgba(0, 0, 0, .1);
	background: #fff;
	font-size: 15px;
}
a {
	color: #73685d;
}
@media all and (max-width: 768px) {
	table, thead, tbody, th, td, tr {
		display: block;
	}
	th {
		text-align: right;
	}
	table {
		position: relative;
		padding-bottom: 0;
		border: none;
		box-shadow: 0 0 10px rgba(0, 0, 0, .2);
	}
	thead {
		float: left;
		white-space: nowrap;
	}
	tbody {
		overflow-x: auto;
		overflow-y: hidden;
		position: relative;
		white-space: nowrap;
	}
	tr {
		display: inline-block;
		vertical-align: top;
	}
	th {
		border-bottom: 1px solid #a39485;
	}
	td {
		border-bottom: 1px solid #e5e5e5;
	}
  }
}
</style>
<script>
$(document).ready(function() {
	$("#btnRegister").click(function(e){
		e.preventDefault();	
		$("#modal-694523").trigger("click");
	});
	

	$("#btnModalRegister").click(function(){
		var g_name = $("#g_name").val();
		var g_phonenumber = $("#g_phonenumber").val();
		var userid = "${loginInfo.userid}";
		var sData = {
				"g_name" : g_name,
				"g_phonenumber" : g_phonenumber,
				"userid" : userid 
		};
		console.log("sData", sData);
		var url = "/guest/register";
		$.post(url, sData, function(rData){
			console.log("rData: ", rData);
			if(rData=="true"){
				location.replace("guestlist");
			}
		});
	});

	
	// 삭제
	$("#chkTop").change(function(){
		var isChecked = $(this).prop("checked");
		$(".checkGno").prop("checked", isChecked);
	});
	
	$("#btnDelete").click(function(){
		var deleteEl = [];
		var arr_g_no = [];
		$(".checkGno").each(function(){
			var checked = $(this).is(":checked");
			console.log(checked);
			if(checked){
				var g_no = $(this).attr("data-gno");
				console.log("g_no: ", g_no);
				arr_g_no.push(parseInt(g_no));
				deleteEl.push($(this).parent().parent());
				console.log("deleteEl:" ,deleteEl);
			}
		});
		
		console.log("arr_g_no", arr_g_no);
		var url = "/guest/delete";
		var sData = {"arr_g_no" : arr_g_no};
		$.post(url, sData, function(rData){
// 			console.log(rData);
			if(rData == "true"){
				$.each(deleteEl, function(){
					$(this).fadeOut("fast");
				});
// 				location.replace("list");
			}
		});
	});

	// 수정
	$(".a_gno").click(function(e){
		e.preventDefault();
		$("#modal-556233").trigger("click");
		var g_no = $(this).attr("data-gno");
		console.log(g_no);
		$("#btnModalSave").attr("data-gno", g_no);
		var g_name = $(this).parent().text();
		console.log(g_name);
		$("#update_gname").val(g_name);
		var g_phonenumber = $(this).parent().next().text();
		console.log(g_phonenumber);
		$("#update_gphonenumber").val(g_phonenumber);
	});
	
	$("#btnModalSave").click(function(){
		var g_no = $(this).attr("data-gno");
		var g_name = $("#update_gname").val();
		var g_phonenumber = $("#update_gphonenumber").val();
		console.log(g_no);
		console.log(g_name);
		console.log(g_phonenumber);
		var url = "/guest/modify";
		var sData = {
			"g_no" : g_no,
			"g_name" : g_name,
			"g_phonenumber" : g_phonenumber
		};
		$.post(url, sData, function(rData){
// 			console.log(rData);
			
			if(rData=="true"){
				location.replace("guestlist");
			}
		});
	});
	
	// sms로 청첩장 보내기 버튼
	$("#btnSend").click(function(){
		var sendEl = [];
		var arr_g_no = [];
		$(".checkGno").each(function(){
			var checked = $(this).is(":checked");
			console.log(checked);
			if(checked){
				var g_phonenumber = $(this).attr("data-phone");
				console.log("g_phonenumber: ", g_phonenumber);
				arr_g_no.push(g_phonenumber);
				sendEl.push($(this).parent().parent());
				console.log("sendEl:" ,sendEl);
			}
		});
		
		console.log("arr_g_no", arr_g_no);
		var userid = "${loginInfo.userid}";
		console.log(userid);
		
		var url = "/sms/send";
		var sData = {"arr_g_no" : arr_g_no, "userid" : userid};
		$.post(url, sData, function(rData){
			console.log(sData);
			console.log(rData);
			if(rData == "true"){
				
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
	               <h2>하객 목록</h2>
	            </div>
	         </div>
	      </div>
	   </div>
	</div>
	
	<div style="padding:100px; min-height:650px; background:white;">
		<div class="text-center">
			<h1 class="home_title">Guest List</h1>
		</div>
		
		<!-- 하객 추가 모달창 -->
		<a id="modal-694523" href="#modal-container-694523" role="button" class="btn" data-toggle="modal" style="display:none">Launch demo modal</a>
		<div class="modal fade" id="modal-container-694523" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header" style="border-bottom: 1px solid transparent;">
						<h1 class="modal-title" id="myModalLabel" style="font-size:20px; font-family: 'GyeonggiTitleM'; padding:0px; color:#666666;"
							>하객 추가</h1>
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body" style="padding:10px 100px 20px;">
				        <div style="margin-bottom:20px;">
					        <i class="fa fa-user prefix grey-text"></i>
					        <label for="g_name">이름</label>
				        	<input type="text" id="g_name" name="g_name" class="inputs" placeholder="이름">
				        </div>
				        <div>
				         	<i class="fa fa-phone" aria-hidden="true"></i>
				         	<label for="g_phonenumber">전화번호</label>
							<input type="text" id="g_phonenumber" name="g_phonenumber" class="inputs" placeholder="전화번호">
				        </div>
			      	</div>
					<div class="modal-footer" style="border-top: 1px solid transparent;">
					 	 <button type="button" class="btn btn-brown" id="btnModalRegister">추가</button>
  						 <button type="button" class="btn btn-gray" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- // 하객 추가 모달창 -->
		
		<!-- 하객 정보 수정 모달창 -->
		<a id="modal-556233" href="#modal-container-556233" role="button" class="btn" data-toggle="modal" style="display:none">Launch demo modal</a>
		<div class="modal fade" id="modal-container-556233" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header" style="border-bottom: 1px solid transparent;">
						<h1 class="modal-title" id="myModalLabel" style="font-size:20px; font-family: 'GyeonggiTitleM'; padding:0px; color:#666666;"
							>하객 정보 수정</h1>
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
					</div>
					<div class="modal-body" style="padding:10px 100px 20px;">
				        <div style="margin-bottom:20px;">
					        <i class="fa fa-user prefix grey-text"></i>
					        <label for="update_gname">이름</label>
				        	<input type="text" id="update_gname" name="update_gname" class="inputs" placeholder="이름">
				        </div>
				        <div style="margin-bottom:20px;">
					        <i class="fa fa-phone prefix grey-text"></i>
					        <label for="update_gphonenumber">전화번호</label>
				        	<input type="text" id="update_gphonenumber" name="update_gphonenumber" class="inputs" placeholder="전화번호">
				        </div>
			      	</div>
					<div class="modal-footer" style="border-top: 1px solid transparent;">
						<button type="button" class="btn btn-brown" data-dismiss="modal" id="btnModalSave"
							>저장</button> 
						<button type="button" class="btn btn-gray" data-dismiss="modal"
							>닫기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- // 하객 정보 수정 모달창 -->
		
		<!-- 리스트 -->
<!--    <label>이름 : </label><input type="text" name="g_name" id="g_name"> -->
<!--    <label>전화번호 : </label><input type="text" name="g_phonenumber" id="g_phonenumber"> -->
<!-- 	<form action="/sms/send" method="post"> -->
		<div style="padding:20px 200px 100px">
			<div class="row">
				<div class="col-md-12" style="margin-bottom:10px;">
					<button type="button" id="btnRegister" class="btn btn-brown"
						>하객 추가</button>
					<button type="button" id="btnDelete" class="btn btn-red"
						>하객 삭제</button>
					<button type="submit" id="btnSend" class="btn btn-brown" style="float:right"
						>청첩장보내기</button>
		        </div>
	        </div>
	<!--           </form> -->
	           <div class="row">
	              <div class="col-sm-12">
						<table>
						    <thead>
							    <tr>
									<th><input type="checkBox" style="margin:5px" id="chkTop"></th>
							        <th>#</th>
							        <th>이름</th>
							        <th>전화번호</th>
							
							    </tr>
						    </thead>
						    <tbody id="guestList">
						    <c:forEach items="${list}" var="guestVo" varStatus="status">
								<tr class="tr">
									<td><input type="checkBox" style="margin:5px" class="checkGno" data-gno="${guestVo.g_no}" data-phone="${guestVo.g_phonenumber}"></td>
									<td>${status.count}</td>
									<td><a href="#" class="a_gno hv2" data-gno="${guestVo.g_no}">${guestVo.g_name}</a></td>
									<td>${guestVo.g_phonenumber}</td>
								</tr>
							</c:forEach>
						    </tbody>
						</table>
	              </div>
	           </div>
           </div>
		<!-- // 리스트 -->
		
	</div>
<%@ include file="../include/m_footer.jsp" %>