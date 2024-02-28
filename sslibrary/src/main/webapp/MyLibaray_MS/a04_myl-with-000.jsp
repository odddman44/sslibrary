<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"
	import="sslibrary.frontweb.database.*" import="sslibrary.frontweb.vo.*"
	import="backendweb.z01_vo.*"
	import="javax.servlet.http.HttpSession"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<%--
	회원정보조회 및 수정 페이지

 --%>


<html>
<head>
<!-- Meta -->
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1">

<!-- Title -->
<title>..:: SSLIBRRY ::..</title>

<!-- Favicon -->
<link href="${path}/com/images/logo.png" rel="icon" type="image/x-icon" />

<!-- Fonts -->
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i%7CLato:100,100i,300,300i,400,400i,700,700i,900,900i"
	rel="stylesheet" />
<link href="${path}/com/css/font-awesome.min.css" rel="stylesheet"
	type="text/css" />

<!-- Mobile Menu -->
<link href="${path}/com/css/mmenu.css" rel="stylesheet" type="text/css" />
<link href="${path}/com/css/mmenu.positioning.css" rel="stylesheet"
	type="text/css" />

<!-- Stylesheet -->
<link href="${path}/com/style.css" rel="stylesheet" type="text/css" />

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="js/html5shiv.min.js"></script>
        <script src="js/respond.min.js"></script>
        <![endif]-->
</head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/a00_com/bootstrap.min.css">
<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css">
<style>
td {
	text-align: center;
}
  label {
            width:300px;
            height:30px;
            margin-top :4px;
        }
        input {
            width: 300px;
            height: 40px;
            border : 1px solid #8D6E63;
            border-radius:5px;
            padding: 0 10px;
            margin-bottom: 10px;
        }
</style>

<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>
<script
	src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api"
	type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
<%-- 
		
		--%>
	});
</script>

<script>
	function goMyLibrary() { // 나의 도서관 메인페이지로 이동하는 함수
		if (confirm("메인 화면으로 돌아가시겠습니까?")) {
			location.href = "a01_myl_000.jsp";
		}
	}
	function goWithdraw() {

		var pwd = document.forms["myForm"]["pwd"].value;
		var phone = document.forms["myForm"]["phone"].value;

		if (confirm("회원 탈퇴를 진행하시겠습니까?\n 회원탈퇴를 계속 진행하면 회원정보가 모두 삭제되어서 복구할 수 없습니다.")) {
			// member session값의 비밀번호와 휴대폰번호가 모두 일치하면
			if (pwd.trim() == "${customer.password}"
					&& phone.trim() == "${customer.phone}") {
				return true;
			} else {
				alert("비밀번호와 휴대폰 번호가 일치하지 않습니다.")
				return false;
			}
		}
	}
</script>
<%
String cnoStr = request.getParameter("cno");
int cno = 0;
if (cnoStr != null) {
	cno = Integer.parseInt(cnoStr);
} // 회원번호
String name = request.getParameter("name"); // 회원명
// 사용자 입력값 처리
String pwd = request.getParameter("pwd");
if (pwd == null)
	pwd = "";
log("##pwd:" + pwd);
String phone = request.getParameter("phone");
if (phone == null)
	phone = "";
log("##phone" + phone);
int isDel = 0;
if (cno != 0) {
	MyLibraryDao dao = new MyLibraryDao(); // dao객체 생성
	isDel = dao.deleteCustomerByCno(cno);
	System.out.println("회원탈퇴 여부" + isDel);
}



%>
<script>
let isDel = <%=isDel%>;
	if (isDel == 1) {
		if(confirm("회원탈퇴가 완료되었습니다.")){
			window.location.href = "${path}/Main_SSH/logoutAction.jsp";
		}// 메인 페이지로 리디렉션
	}
		
</script>

<body>

	<%@ include file="/module/header.jsp"%>
	<%@ include file="/module/search_bar_ml.jsp"%>

	<!-- Start: Products Section -->
	<hr>
<div class="container">
	<div id="content" class="site-content">
		<label id="title" class="col-sm-2 col-form-label">회원탈퇴 화면입니다.</label>
		<br>
		<p style="color: red; text-align: left;">회원탈퇴를 진행하시길 원하면 휴대폰번호와
			비밀번호를 입력하십시오.</p>
		<%-- form 태그 --%>
		<form id="myForm" method="post">

			<label class="col-sm-2 col-form-label">회원번호</label>
			<div class="col-sm-10">
				<input type="number" readonly class="form-control-plaintext"
					name="cno" value="${customer.cno}">
			</div>
			<label class="col-sm-2 col-form-label">회원명</label>
			<div class="col-sm-10">
				<input type="text" readonly class="form-control-plaintext"
					name="name" value="${customer.name}">
			</div>
			<label class="col-sm-2 col-form-label">아이디</label>
			<div class="col-sm-10">
				<input type="text" readonly class="form-control-plaintext" name="id"
					value="${customer.id}">
			</div>

			<label class="col-sm-2 col-form-label">비밀번호(*)</label>
			<div class="col-sm-10">
				<input type="password" name="pwd">
			</div>
			<label for="phone" class="col-sm-2 col-form-label">휴대폰 번호(*)</label>

			<div class="col-sm-10">
				<input type="text" class="form-control-plaintext" name="phone">

			</div>
			<div class="button">
				<input onclick="goMyLibrary()" type="button" value="취소"> <input
					onclick=" return goWithdraw()" type="submit" value="회원탈퇴">
			</div>
		</form>
	</div>
</div>
	<!-- End: Products Section -->

	<!-- jQuery Latest Version 1.x -->
	<script type="text/javascript"
		src="${path}/com/js/jquery-1.12.4.min.js"></script>

	<!-- jQuery UI -->
	<script type="text/javascript" src="${path}/com/js/jquery-ui.min.js"></script>

	<!-- jQuery Easing -->
	<script type="text/javascript"
		src="${path}/com/js/jquery.easing.1.3.js"></script>

	<!-- Bootstrap -->
	<script type="text/javascript" src="${path}/com/js/bootstrap.min.js"></script>

	<!-- Mobile Menu -->
	<script type="text/javascript" src="${path}/com/js/mmenu.min.js"></script>

	<!-- Harvey - State manager for media queries -->
	<script type="text/javascript" src="${path}/com/js/harvey.min.js"></script>

	<!-- Waypoints - Load Elements on View -->
	<script type="text/javascript" src="${path}/com/js/waypoints.min.js"></script>

	<!-- Facts Counter -->
	<script type="text/javascript"
		src="${path}/com/js/facts.counter.min.js"></script>

	<!-- MixItUp - Category Filter -->
	<script type="text/javascript" src="${path}/com/js/mixitup.min.js"></script>

	<!-- Owl Carousel -->
	<script type="text/javascript" src="${path}/com/js/owl.carousel.min.js"></script>

	<!-- Accordion -->
	<script type="text/javascript" src="${path}/com/js/accordion.min.js"></script>

	<!-- Responsive Tabs -->
	<script type="text/javascript"
		src="${path}/com/js/responsive.tabs.min.js"></script>

	<!-- Responsive Table -->
	<script type="text/javascript"
		src="${path}/com/js/responsive.table.min.js"></script>

	<!-- Masonry -->
	<script type="text/javascript" src="${path}/com/js/masonry.min.js"></script>

	<!-- Carousel Swipe -->
	<script type="text/javascript"
		src="${path}/com/js/carousel.swipe.min.js"></script>

	<!-- bxSlider -->
	<script type="text/javascript" src="${path}/com/js/bxslider.min.js"></script>

	<!-- Custom Scripts -->
	<script type="text/javascript" src="${path}/com/js/main.js"></script>

</body>


</html>