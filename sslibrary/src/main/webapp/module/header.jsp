<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="sslibrary.frontweb.vo.Customer"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<!-- Start: Header Section -->
<header id="header-v1" class="navbar-wrapper inner-navbar-wrapper">
	<div class="container">
		<div class="row">
			<nav class="navbar navbar-default">
				<div class="row">
					<div class="col-md-3">
						<div class="navbar-header">
							<div class="navbar-brand">
								<h1>
									<a href="${path}/Main_SSH/SSHindex.jsp"> <img
										src="${path}/com/images/logo2.png" alt="SSLIBRRY" />
									</a>
								</h1>
							</div>
						</div>
					</div>
					<div class="col-md-9">
						<!-- Header Topbar -->
						<div class="header-topbar hidden-sm hidden-xs">
							<div class="row">
								<div class="col-sm-6"></div>
								<div class="col-sm-6">
									<div class="topbar-links">
										<%
										HttpSession sess = request.getSession();
										Customer customer = (Customer) session.getAttribute("customer");
										if (customer != null) {
										%>
										<span class="login-info">${customer.getName()}님 접속중입니다.</span>
										<form action="${path}/Main_SSH/logoutAction.jsp" method="post"
											style="display: inline;">
											<button type="submit" class="btn btn-primary">로그아웃</button>
										</form>
										<%
										} else {
										%>
										<a href="${path}/Main_SSH/loginPage.jsp"><i
											class="fa fa-lock"></i>로그인</a> | <a
											href="${path}/Main_SSH/register.jsp">회원가입</a>
										<%
										}
										%>
										<div class="header-cart dropdown">
											<a data-toggle="dropdown" class="dropdown-toggle" href="#">
											</a>

										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="navbar-collapse hidden-sm hidden-xs">
							<ul class="nav navbar-nav">

								<li class="dropdown active"><a data-toggle="dropdown"
									class="dropdown-toggle disabled"
									href="${path}/Main_SSH/SSHindex.jsp">Home</a></li>

								<li class="dropdown"><a data-toggle="dropdown"
									class="dropdown-toggle disabled"
									href="${path}/User01_jsr/search.jsp">도서 검색</a></li>

								<li class="dropdown"><a id="myPageLink"
									data-toggle="dropdown" class="dropdown-toggle disabled"
									href="${path}/MyLibaray_MS/a01_myl_000.jsp">마이페이지</a>
									<ul class="dropdown-menu">
										<li><a id="loanLink"
											href="${path}/MyLibaray_MS/a01_myl_000.jsp">대출조회</a></li>
										<li><a id="preLoanLink"
											href="${path}/MyLibaray_MS/a02_myl_blon_000.jsp">이전대출조회</a></li>
										<li><a id="showReviewLink"
											href="${path}/MyLibaray_MS/review_inquiry.jsp">작성리뷰조회</a></li>
										<li><a id="memberInfoLink"
											href="${path}/MyLibaray_MS/a03_myl-minfo-000.jsp">회원정보조회</a></li>
										<li><a id="withdrawLink"
											href="${path}/MyLibaray_MS/a04_myl-with-000.jsp">회원탈퇴</a></li>
									</ul></li>
								<script>
									// 로그인 안되면 마이페이지 접속하지 못하도록 처리
									var myPageLink = document
											.getElementById("myPageLink");
									var loanLink = document
											.getElementById("loanLink");
									var previousLoanLink = document
											.getElementById("preLoanLink");
									var showReviewLink = document
										.getElementById("showReviewLink");
									var memberInfoLink = document
											.getElementById("memberInfoLink");
									var withdrawalLink = document
											.getElementById("withdrawLink");

									// JSP에서 Java 변수를 JavaScript로 전달
									var isCustomerNull =
								<%=customer == null%>
									;

									if (isCustomerNull) { // 로그인 되지 않은 상태이면
										myPageLink.onclick = function() {
											alert("로그인이 필요합니다.");
											return false; // 이벤트 전파 및 기본 동작 막음
										}
										loanLink.onclick = function() {
											alert("로그인이 필요합니다.");
											return false; // 이벤트 전파 및 기본 동작 막음
										}
										previousLoanLink.onclick = function() {
											alert("로그인이 필요합니다.");
											return false; // 이벤트 전파 및 기본 동작 막음
										}
										showReviewLink.onclick=function(){
											alert("로그인이 필요합니다.");
											return false; // 이벤트 전파 및 기본 동작 막음
										}
										memberInfoLink.onclick = function() {
											alert("로그인이 필요합니다.");
											return false; // 이벤트 전파 및 기본 동작 막음
										}
										withdrawalLink.onclick = function() {
											alert("로그인이 필요합니다.");
											return false; // 이벤트 전파 및 기본 동작 막음
										}
									}
								</script>
								<%
								if (customer != null && "admin".equals(customer.getId())) {
								%>
								<li><a href="${path}/Admin_okw/adm_index.jsp">관리자페이지</a></li>
								<%
								}
								%>
							</ul>
						</div>
					</div>
				</div>
				<div class="mobile-menu hidden-lg hidden-md">
					<a href="#mobile-menu"><i class="fa fa-navicon"></i></a>
					<div id="mobile-menu">
						<ul>
							<li class="mobile-title">
								<h4>Navigation</h4> <a href="#" class="close"></a>
							</li>
							<li><a href="${path}/Main_SSH/SSHindex.jsp">Home</a></li>
							<li><a href="${path}/User01_jsr/search.jsp">도서검색</a></li>
							<li><a id="myPageLink2"
								href="${path}/MyLibaray_MS/a01_myl_000.jsp">마이페이지</a>
								<ul>
									<li><a id="loanLink2"
										href="${path}/MyLibaray_MS/a01_myl_000.jsp">대출조회</a></li>
									<li><a id="preLoanLink2"
										href="${path}/MyLibaray_MS/a02_myl_blon_000.jsp">이전대출조회</a></li>
									<li><a id="showReviewLink2"
											href="${path}/MyLibaray_MS/review_inquiry.jsp">작성리뷰조회</a></li>
									<li><a id="memberInfoLink2"
										href="${path}/MyLibaray_MS/a03_myl-minfo-000.jsp">회원정보조회</a></li>
									<li><a id="withdrawLink2"
										href="${path}/MyLibaray_MS/a04_myl-with-000.jsp">회원탈퇴</a></li>

									<script>
										// 로그인 안되면 마이페이지 접속하지 못하도록 처리
										var myPageLink2 = document
												.getElementById("myPageLink2");
										var loanLink2 = document
												.getElementById("loanLink2");
										var previousLoanLink2 = document
												.getElementById("preLoanLink2");
										var showReviewLink2 = document
											.getElementById("showReviewLink2");
										var memberInfoLink2 = document
												.getElementById("memberInfoLink2");
										var withdrawLink2 = document
												.getElementById("withdrawLink2");

										// JSP에서 Java 변수를 JavaScript로 전달
										var isCustomerNull2 =
									<%=customer == null%>
										;

										if (isCustomerNull2) { // 로그인 되지 않은 상태이면
											myPageLink2.onclick = function() {
												alert("로그인이 필요합니다.");
												return false; // 이벤트 전파 및 기본 동작 막음
											}
											loanLink2.onclick = function() {
												alert("로그인이 필요합니다.");
												return false; // 이벤트 전파 및 기본 동작 막음
											}
											previousLoanLink2.onclick = function() {
												alert("로그인이 필요합니다.");
												return false; // 이벤트 전파 및 기본 동작 막음
											}
											showReviewLink2.onclick = function() {
												alert("로그인이 필요합니다.");
												return false; // 이벤트 전파 및 기본 동작 막음
											}
											memberInfoLink2.onclick = function() {
												alert("로그인이 필요합니다.");
												return false; // 이벤트 전파 및 기본 동작 막음
											}
											withdrawLink2.onclick = function() {
												alert("로그인이 필요합니다.");
												return false; // 이벤트 전파 및 기본 동작 막음
											}
										}
									</script>
								</ul></li>
							<%
							if (customer != null && "admin".equals(customer.getId())) {
							%>
							<li><a href="${path}/Admin_okw/adm_index.jsp">관리자페이지</a></li>
							<%
							}
							%>
						</ul>
					</div>
				</div>
			</nav>
		</div>
	</div>
</header>
<!-- End: Header Section -->
