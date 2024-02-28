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
		// dao 생성
		MyLibraryDao dao = new MyLibraryDao();
		// 로그인한 회원 session값 가져오기
		Customer c01 = (Customer) session.getAttribute("customer");
		// 로그인한 회원 객체의 회원번호가 있으면 회원번로 int cno 할당
		int cno = (c01 != null) ? c01.getCno() : 0;
		// 회원번호 확인하기
		System.out.println("회원번호"+cno);
		// rlist에는 회원번호를 통해서 대여목록 불러오기 
		request.setAttribute("rlist", dao.getRentalInfoByCno(cno));
		// 클릭한 행의 책 번호값 받아오기
		String isbnStr = request.getParameter("isbn");
		log(isbnStr);
		int isbn = 0;
		int isDelay = 0; // 반납연기 여부 
		if(isbnStr!=null) isbn = Integer.parseInt(isbnStr);
		if(isbn!=0){ // 클릭이 되었을 때
			isDelay = dao.delayReturnDate(cno, isbn);
		}
		System.out.println(isDelay);
		
		
	%>
	<script>
		let isbn = <%=isbn%>
		let isDelay = <%=isDelay%>
		if(isbn!=0){
			if(isDelay==1){ // 반납연기 성공
				alert("반납연기 성공!")
				// 대여목록조회 화면 다시 띄우기
				location.href="a01_myl_000.jsp";
			}else alert("반납 연기 실패..")
		}
		function goReturnBookPage(isbn, title){ // 책번호랑 책 제목 받아오기
			if(confirm("''"+title+"' 책을 반납하시겠습니까?")){
				var newWindow = window.open("returnBook.jsp?isbn="+isbn, "_blank", "width=300, height=300" ) // 책 번호를 returnBook.jsp에 보낸다.
				// ReturnBook.jsp에서는 책 반납 dao실행
			}else altert("책 반납을 취소하셨습니다.") 
		}
		
		
	</script>
	
	<div id="content" class="site-content">
		<label id="title" class="col-sm-2 col-form-label">${customer.name}님 대출내역<br>
														 5권 중 ${rlist.size()}권 대출 중
		</label>
		<div>
			<table class="table">
				<thead style="background:#b39273; font-weight:bold;">
					<tr>
						<td>책 번호</td>
						<td>책 제목</td>
						<td>출판사</td>
						<td>출판년도</td>
						<td>작가명</td>
						<td>대출일자</td>
						<td>반납예정일</td>
						<td>반납연기</td>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="ren" items="${rlist}" varStatus="sts">
					<tr ondblclick="goReturnBookPage('${ren.isbn}', '${ren.title}')">
						<td>${ren.isbn}</td>
						<td>${ren.title}</td>
						<td>${ren.publisher}</td>
						<td>${ren.year}</td>
						<td>${ren.name}</td>
						<td>${ren.rental_date}</td>
						<td name="returnDate">${ren.return_date}</td>
						<form name="form2">
							<input type="hidden" name="isbn" value="${ren.isbn}">
							<td><button id="delayBtn" type="submit">반납연기</button></td> <%-- 반납연기 버튼을 누르면 isbn전송 --%>
						</form>
					</c:forEach>
					</tr>
				</tbody>
			</table>
			<label style="color:red">반납을 원하시면 해당 책의 행을 더블클릭하십시오.</label>
			
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