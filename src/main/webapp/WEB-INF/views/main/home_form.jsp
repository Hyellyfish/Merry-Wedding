<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/m_header.jsp" %>
<script>
$(document).ready(function() {
	// 탈퇴 성공시
	if ("${delete_result}" == "success") {
		alert("탈퇴되었습니다.");
	} else if ("${delete_result}" == "fail") {
		alert("탈퇴에 실패하였습니다.");		
	}
	
	// 회원정보 수정 성공시
	if ("${update_result}" == "success") {
		alert("회원정보 수정이 완료되었습니다. 다시 로그인해 주세요.");
	}
	
	// hover시 글자색 변화
	$(".choose_box").hover(function() {
		$(this).find("h3").css("color", "#e76f64");
	}, function() {
		$(this).find("h3").css("color", "#161615");
	});
	
	// 서비스 선택
	$(".choose_box").click(function() {
		var id = $(this).attr("id");
		switch (id) {
			case "wedplanner":
				$(location).attr('href', '/main/planner');
				break;
			case "wedcreate":
				$(location).attr('href', '/main/create');
				break;
			case "wedguest":
				$(location).attr('href', '/guest/guestlist');
				break;
		}
	});
});
</script>
		 <!-- end header inner -->
         <!-- end header -->
         <!-- banner -->
         <section class="banner_main">
            <div id="myCarousel" class="carousel slide banner" data-ride="carousel">
               <div class="carousel-inner">
                  <div class="carousel-item active">
                     <div class="container">
                        <div class="carousel-caption banner_po">
                           <div class="row">
                              <div class="col-lg-8 col-md-9 ">
                                 <div class="build_box">
                                    <h1>
										<span class="orang">Merry</span>
										<span class="orang">
											Wedding</span>
									</h1>
									<p id="p_home">
									행복한 결혼에는 애정 위에 언젠가는 아름다운 우정이 접목되게 마련이다. 이 우정은 마음과 육체가 서로 결부되어 있기 때문에 한층 견고한 것이다. -앙드레 모루아-<br><br>
									결혼이란 가을 나뭇잎의 색깔이 변하는 것을 보는 것과 같다. 하루 하루 시간이 지나며 그것은 계속 변화하고 더 아름다워지는 것이다. - 폰 위버 -
									</p>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </section>
      </header>
	<!-- end banner -->
	<!-- play -->
	<div class="row" style="padding:200px 200px 100px">
		<div class="col-md-12 text_align_center">
			<h1 class="home_title">Service</h1>
		</div>
		<div class="col-md-4">
			<div class="plan_bax text_align_center">
				<figure>
					<img class="home_tn" src="/main_temp/images/WeddingPlanner.jpg" style="height:334px;"/>
				</figure>
				<div id="wedplanner" class="plan_text choose_box">
                   <h3>웨딩플래너</h3>
                   <p>스튜디오, 드레스, 메이크업, 예식장 등<br>필요한 정보를 다양하게 제공하며,<br>결혼식을 꼼꼼하고 편리하게 준비할 수 있도록<br>도와드립니다.</p>
                </div>
			</div>
		</div>
		<div class="col-md-4">
			<div class="plan_bax text_align_center">
				<figure>
					<img class="home_tn" src="/main_temp/images/CoupleViewingLaptop.jpg" style="height:334px;"/>
				</figure>
				<div id="wedcreate" class="plan_text choose_box">
                   <h3>나만의 웨딩 사이트 제작</h3>
                   <p>마음에 드는 템플릿을 골라 쉽고 편하게<br>나만의 웨딩 사이트를 만들 수 있습니다.<br>특별한 청첩장으로 우리들의 이야기를 전하고,<br>바래지 않는 추억을 남겨보세요.</p>
                </div>
			</div>
		</div>
		<div class="col-md-4">
			<div class="plan_bax text_align_center">
				<figure>
					<img class="home_tn" src="/main_temp/images/CreateTemplate.jpg" style="height:334px;"/>
				</figure>
				<div id="wedguest" class="plan_text choose_box">
                   <h3>하객 관리</h3>
                   <p>하객 정보를 손쉽게 관리할 수 있고,<br>SMS를 통해 청첩장을 보낼 수 있습니다.<br>소중한 사람들에게 아름다운 추억이 담긴<br>특별한 청첩장을 전해보세요.</p>
                </div>
			</div>
		</div>
	</div>
	<hr>
	<!-- says -->
	<div class="says" style="padding-top:200px; padding-bottom:80px;">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-12">
					<div class="col-md-12 text_align_center">
						<h1 class="home_title">Review</h1>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<div id="proj" class="carousel slide says_ban" data-ride="carousel">
						<ol class="carousel-indicators">
							<li data-target="#proj" data-slide-to="0" class="active"></li>
							<li data-target="#proj" data-slide-to="1"></li>
							<li data-target="#proj" data-slide-to="2"></li>
							<li data-target="#proj" data-slide-to="3"></li>
						</ol>
						<div class="carousel-inner">
						
							<div class="carousel-item active">
								<div class="container">
									<div class="carousel-caption relative3">
										<div class="row">
											<div class="col-md-12">
												<div class="readert">
													<div class="readert_img text_align_center">
														<figure>
															<img src="/main_temp/images/rv2.jpg" class="home_rvimg" style="height: 500px;"/>
														</figure>
													</div>
													<div class="readert_text">
														<h3>직접 만들어 더욱 소중하고 특별한 사이트!</h3>
														<p>보통 결혼식에서 두 사람의 시간이 담긴 이야기는 영상으로 짧게 지나가는데,<br>둘 만의 서사를 더 깊이있게 사람들에게 보여줄 수 있다는 점이 큰 장점인 것 같아요.<br>마음에 드는 템플릿을 직접 고를 수 있다는 점도 좋았어요.<br>사이트를 만들면서 자연스레 저희의 시간을 되돌아보며 지나온 추억들을 떠올릴 수 있었어요.<br>결혼식이 끝나고도 언제든 볼 수 있도록 사이트를 남겨둘 수 있어서 참 좋네요.
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="carousel-item">
								<div class="container">
									<div class="carousel-caption relative3">
										<div class="row">
											<div class="col-md-12">
												<div class="readert">
													<div class="readert_img text_align_center">
														<figure>
															<img src="/main_temp/images/rv1.jpg" class="home_rvimg" style="height: 500px;"/>
														</figure>
													</div>
													<div class="readert_text">
														<h3>너무 마음에 들어요.</h3>
														<p>덕분에 결혼식이 더욱 특별해진 느낌이에요.<br>주위에서 다들 좋아해 주시고, 많은 사람들에게<br>저희의 소중한 추억과 이야기를 전할 수 있어서 기분이 좋았어요.<br>저희가 만든 사이트를 보고 결혼예정인 친구들 뿐만 아니라<br>아직 결혼 생각이 없는 커플들도 만들어 보고 싶대요ㅎㅎ<br>만드는 것도 어렵지 않고 재밌어요. 여러분도 꼭 만들어보세요!!</p>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="carousel-item">
								<div class="container">
									<div class="carousel-caption relative3">
										<div class="row">
											<div class="col-md-12">
												<div class="readert">
													<div class="readert_img text_align_center">
														<figure>
															<img src="/main_temp/images/rv3.jpg" class="home_rvimg" style="height: 500px;"/>
														</figure>
													</div>
													<div class="readert_text">
														<h3>결혼준비에 최고에요~</h3>
														<p>스드메부터 체크리스트까지 너무 편리하네요ㅎㅎ<br>귀차니즘도 심하고 덜렁대는 저에게 MW는 큰 도움이 되었어요.<br>여러모로 결혼준비에 유용한 기능이 정말 많아요!!<br>사용해보고 너무 만족해서 주위에 MW추천하고 다닙니다ㅎㅎㅎ<br>사이트 열심히 만들고 있는데 빨리 완성해보고 싶네요. 벌써부터 엄청 멋진 느낌..!<br>결혼을 앞둔 당신에게 MW를 강추합니다~~</p>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="carousel-item">
								<div class="container">
									<div class="carousel-caption relative3">
										<div class="row">
											<div class="col-md-12">
												<div class="readert">
													<div class="readert_img text_align_center">
														<figure>
															<img src="/main_temp/images/rv4.jpg" class="home_rvimg" style="height: 500px;"/>
														</figure>
													</div>
													<div class="readert_text">
														<h3>와 정말 편하고 유용하네요</h3>
														<p>다른 서비스들도 진짜 좋지만, 특히 저는 하객이 많아서 힘들었는데<br>하객 관리 기능 완전 대박입니다.<br>컴퓨터 잘 못 다루는 아내도 이용하기 쉽고 편리합니다.<br>빠르게 하객 정보를 관리할 수 있어서 정말 많은 도움이 되었습니다.<br>제가 만든 사이트 링크도 바로 문자로 보낼 수 있어요.<br>MW 최고입니다~~</p>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end says -->
<%@ include file="../include/m_footer.jsp" %>