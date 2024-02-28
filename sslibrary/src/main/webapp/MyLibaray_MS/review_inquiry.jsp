<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" 
	import="java.util.*"
	import="sslibrary.frontweb.database.*"
	import="sslibrary.frontweb.vo.*"
	%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<%--
 대출 내역 조회 화면

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

</style>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script
	src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api"
	type="text/javascript"></script>



<body>
	
	 <%@ include file= "/module/header.jsp"%>
	<%@ include file="/module/search_bar_ml.jsp"%>
	

	<!-- Start: Products Section -->
	<hr>
	<%
		MyLibraryDao dao = new MyLibraryDao();
		Customer c01 = (Customer) session.getAttribute("customer");
		int cno = (c01 != null) ? c01.getCno() : 0;
		System.out.println("회원번호"+cno);
		// 리뷰 가져오기
		request.setAttribute("rlist", dao.getReviewByCno(cno));
		
		
		
	%>
	
	
	<div id="content" class="site-content">
		<label id="title" class="col-sm-2 col-form-label">${customer.name}님 리뷰내역<br>
														 ${rlist.size()}개 리뷰 작성 완료
		</label>
		<div>
			<table class="table" style="word-break: break-all">
			<col width="15%">
			<col width="10%">
			<col width="10%">
			<col width="40%">
			<col width="15%">
			<col width="10%">
				<thead style="background:#b39273; font-weight:bold;">
					<tr>
						<td>책 제목</td>
						<td>출판사</td>
						<td>작가명</td>
						<td>리뷰 내용</td>
						<td>평점</td>
						<td>리뷰작성일</td>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="ren" items="${rlist}" varStatus="sts">
					<tr>
						<td>${ren.title}</td>
						<td>${ren.publisher}</td>
						<td>${ren.name}</td>
						<td>${ren.content}</td>
						<td>${ren.rating}</td>
						<td> ${ren.review_date}</td>
					</c:forEach>
					</tr>
				</tbody>
			</table>
			
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